import 'dart:async';
import 'package:dio/dio.dart';
import 'package:lowguard/features/connectivity/domain/connectivity_repository.dart';
import 'package:lowguard/features/connectivity/domain/system_status.dart';

/// RemoteConnectivityRepository
/// - La baseUrl peut être fournie via le constructeur (pour tests/DI)
/// - Ou via `--dart-define=API_BASE_URL=...` (valeur par défaut: http://localhost:8000)
class RemoteConnectivityRepository implements ConnectivityRepository {
  final Dio _dio;
  final String _baseUrl;

  RemoteConnectivityRepository(this._dio, {String? baseUrl})
    : _baseUrl =
          baseUrl ??
          const String.fromEnvironment(
            'API_BASE_URL',
            defaultValue: 'http://localhost:8000',
          );

  @override
  Future<SystemStatus> getSystemStatus() async {
    try {
      final response = await _dio.get('$_baseUrl/status');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        return SystemStatus.fromJson({
          'system': data['system'],
          'nas': data['nas'],
          'network': data['network'],
          'butlerAi': data['butler_ai'],
          'perimeter': data['perimeter'],
          'timestamp': data['timestamp'],
        });
      } else {
        throw Exception('Failed to load system status');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }

  // Reuse mock logic for physical discovery for now
  final _controller = StreamController<bool>.broadcast();
  @override
  Stream<bool> get isNasConnected => _controller.stream;

  @override
  Future<void> startDiscovery() async {
    _controller.add(true);
  }

  @override
  Future<void> stopDiscovery() async {
    _controller.add(false);
  }
}
