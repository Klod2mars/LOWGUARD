import 'dart:async';
import 'package:lowguard/features/connectivity/domain/connectivity_repository.dart';

class MockConnectivityRepository implements ConnectivityRepository {
  final _controller = StreamController<bool>.broadcast();
  bool _isConnected = false;

  @override
  Stream<bool> get isNasConnected => _controller.stream;

  @override
  Future<void> startDiscovery() async {
    // Simulate finding the NAS after 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    _isConnected = true;
    _controller.add(true);
  }

  @override
  Future<void> stopDiscovery() async {
    _isConnected = false;
    _controller.add(false);
  }
}
