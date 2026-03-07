import 'dart:async';
import 'package:dio/dio.dart';
import 'package:lowguard/features/connectivity/domain/connectivity_repository.dart';
import 'package:lowguard/features/connectivity/domain/system_status.dart';

class RemoteConnectivityRepository implements ConnectivityRepository {
  final Dio _dio;
  final String _baseUrl = 'http://localhost:8000'; // Target local backend

  RemoteConnectivityRepository(this._dio);

  @override
  Future<SystemStatus> getSystemStatus() async {
    try {
      final response = await _dio.get('$_baseUrl/status');
      if (response.statusCode == 200) {
        // Map keys from snake_case to camelCase if needed, but here we'll match the JSON
        final data = response.data as Map<String, dynamic>;
        
        // Convert keys to match field names in SystemStatus
        return SystemStatus.fromJson({
          'system': data['system'],
          'nas': data['nas'],
          'network': data['network'],
          'butlerAi': data['butler_ai'], // Map butler_ai to butlerAi
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
