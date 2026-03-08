// lib/features/connectivity/data/discovery_notifier.dart
import 'dart:async';
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'discovery_service.dart';

part 'discovery_notifier.g.dart';

@riverpod
class Discovery extends _$Discovery {
  late final DiscoveryService _service;
  Timer? _pollTimer;

  @override
  String? build() {
    _service = DiscoveryService();
    _init();
    ref.onDispose(() => _pollTimer?.cancel());
    return null;
  }

  Future<void> _init() async {
    // load last known ip or auto discover if enabled
    final auto = await _service.getAutoConnect();
    final last = await _service.lastKnownBaseUrl();
    if (last != null) {
      state = last;
    }

    if (auto) {
      await discoverNow();
      // start periodic background discovery (every 2 minutes)
      _pollTimer?.cancel();
      _pollTimer = Timer.periodic(const Duration(minutes: 2), (_) => discoverNow());
    }
  }

  /// discoverNow with simple retry/backoff + jitter
  Future<void> discoverNow({int retries = 3}) async {
    final rng = Random();
    for (var attempt = 0; attempt < retries; attempt++) {
      try {
        final resolved = await _service.discoverOnce();
        if (resolved != null) {
          state = resolved;
          return;
        }
      } catch (_) {
        // ignore and retry
      }
      if (attempt < retries - 1) {
        final backoffMs = 1000 * (1 << attempt); // 1s, 2s, 4s...
        final jitter = rng.nextInt(400) - 200; // +/-200ms
        await Future.delayed(Duration(milliseconds: backoffMs + jitter));
      }
    }
    // final fallback: keep previous state (which may be last-known)
  }

  Future<void> setManualIp(String ip) async {
    if (ip.isEmpty) {
      // Clear logic
      state = null;
      return;
    }
    await _service.saveManualIp(ip);
    state = 'http://$ip:8000';
  }

  Future<void> setAutoConnect(bool enabled) async {
    await _service.setAutoConnect(enabled);
    if (enabled) {
      await discoverNow();
      _pollTimer ??= Timer.periodic(const Duration(minutes: 2), (_) => discoverNow());
    } else {
      _pollTimer?.cancel();
      _pollTimer = null;
    }
  }

  // Public getters for UI
  Future<bool> getAutoConnect() async => _service.getAutoConnect();
  Future<String?> getLastKnownBaseUrl() async => _service.lastKnownBaseUrl();
}
