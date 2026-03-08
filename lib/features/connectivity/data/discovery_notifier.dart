// lib/features/connectivity/data/discovery_notifier.dart
import 'dart:async';
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
    await _service.discoverOnce(timeout: Duration.zero); // Wrapped way to get last known if already stored or quickly fetch
    // Actually, I should use a public method for _lastKnownBaseUrl if I want to match the logic exactly.
    // Let's adjust DiscoveryService to have a public getter or just use the logic here.
    
    // For now, let's use the logic from the user snippet but adapted.
    // I'll make _lastKnownBaseUrl public in DiscoveryService in a moment if needed, 
    // or just call discoverOnce with a very short timeout.
    
    // Re-reading DiscoveryService: discoverOnce calls _lastKnownBaseUrl at the end.
    
    final resolved = await _service.discoverOnce(timeout: const Duration(milliseconds: 100));
    if (resolved != null) {
      state = resolved;
    }

    if (auto) {
      discoverNow();
      // start periodic background discovery (every 2 minutes)
      _pollTimer?.cancel();
      _pollTimer = Timer.periodic(const Duration(minutes: 2), (_) => discoverNow());
    }
  }

  Future<void> discoverNow() async {
    final resolved = await _service.discoverOnce();
    if (resolved != null) {
      state = resolved;
    }
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
      discoverNow();
      _pollTimer ??= Timer.periodic(const Duration(minutes: 2), (_) => discoverNow());
    } else {
      _pollTimer?.cancel();
      _pollTimer = null;
    }
  }
}
