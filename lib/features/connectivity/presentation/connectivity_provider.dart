import 'package:dio/dio.dart';
import 'package:lowguard/features/connectivity/data/remote_connectivity_repository.dart';
import 'package:lowguard/features/connectivity/domain/connectivity_repository.dart';
import 'package:lowguard/features/connectivity/domain/system_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@riverpod
Dio dio(DioRef ref) => Dio();

@riverpod
ConnectivityRepository connectivityRepository(ConnectivityRepositoryRef ref) {
  return RemoteConnectivityRepository(ref.watch(dioProvider));
}

@riverpod
Future<SystemStatus> systemStatus(SystemStatusRef ref) {
  return ref.watch(connectivityRepositoryProvider).getSystemStatus();
}
