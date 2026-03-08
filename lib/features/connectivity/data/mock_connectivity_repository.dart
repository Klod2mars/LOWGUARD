import 'dart:async';
import 'package:lowguard/features/connectivity/domain/connectivity_repository.dart';
import 'package:lowguard/features/connectivity/domain/system_status.dart';

class MockConnectivityRepository implements ConnectivityRepository {
  final _controller = StreamController<bool>.broadcast();

  @override
  Stream<bool> get isNasConnected => _controller.stream;

  @override
  Future<void> startDiscovery() async {
    // Simulate finding the NAS after 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    _controller.add(true);
  }

  @override
  Future<void> stopDiscovery() async {
    _controller.add(false);
  }

  @override
  Future<SystemStatus> getSystemStatus() async {
    return SystemStatus(
      system: 'NOMINAL',
      nas: 'ONLINE',
      network: 'LOCAL',
      butlerAi: 'OLLAMA_IDLE',
      perimeter: 'ACTIVE',
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
