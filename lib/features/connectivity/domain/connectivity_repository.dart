import 'package:lowguard/features/connectivity/domain/system_status.dart';

abstract class ConnectivityRepository {
  Future<SystemStatus> getSystemStatus();
  Stream<bool> get isNasConnected;
  Future<void> startDiscovery();
  Future<void> stopDiscovery();
}
