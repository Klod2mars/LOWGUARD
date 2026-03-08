import 'package:dio/dio.dart';
import 'package:lowguard/features/connectivity/data/remote_connectivity_repository.dart';
import 'package:lowguard/features/connectivity/domain/connectivity_repository.dart';
import 'package:lowguard/features/connectivity/domain/system_status.dart';
import 'package:lowguard/features/connectivity/data/discovery_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:lowguard/features/connectivity/data/connection_manager.dart';

part 'connectivity_provider.g.dart';

@riverpod
Dio dio(Ref ref) => Dio();

@riverpod
ConnectivityRepository connectivityRepository(Ref ref) {
  final baseUrl = ref.watch(discoveryProvider);
  return RemoteConnectivityRepository(ref.watch(dioProvider), baseUrl: baseUrl);
}

@riverpod
Stream<ConnectionStatus> connectionStatus(Ref ref) {
  return ConnectionManager().statusStream;
}

@riverpod
Future<SystemStatus> systemStatus(Ref ref) {
  return ref.watch(connectivityRepositoryProvider).getSystemStatus();
}
