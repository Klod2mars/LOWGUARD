import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Camera {
  final String id;
  final String type;
  final String sourceUrl;
  final String? username;
  final String? password;
  final String status;
  final Map<String, dynamic> meta;

  Camera({
    required this.id,
    required this.type,
    required this.sourceUrl,
    this.username,
    this.password,
    required this.status,
    required this.meta,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      type: json['type'],
      sourceUrl: json['source_url'],
      username: json['username'],
      password: json['password'],
      status: json['status'] ?? 'OFFLINE',
      meta: Map<String, dynamic>.from(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'source_url': sourceUrl,
    'username': username,
    'password': password,
    'meta': meta,
  };
}

class CameraRepository {
  final Dio _dio;
  final String _baseUrl;
  MqttServerClient? _mqttClient;

  CameraRepository(this._dio, this._baseUrl);

  Future<List<Camera>> getCameras() async {
    final response = await _dio.get('$_baseUrl/cameras/');
    return (response.data as List).map((json) => Camera.fromJson(json)).toList();
  }

  Future<void> registerCamera(Camera camera) async {
    await _dio.post('$_baseUrl/cameras/register', data: camera.toJson());
  }

  String getSnapshotUrl(String cameraId) {
    return '$_baseUrl/cameras/$cameraId/snapshot?t=${DateTime.now().millisecondsSinceEpoch}';
  }

  void connectMqtt(String broker, int port, String clientId) async {
    _mqttClient = MqttServerClient(broker, clientId);
    _mqttClient!.port = port;
    _mqttClient!.logging(on: true);
    _mqttClient!.onDisconnected = () => print('MQTT Disconnected');
    
    try {
      await _mqttClient!.connect();
    } catch (e) {
      print('MQTT connection failed: $e');
    }
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? get cameraEvents {
    return _mqttClient?.updates;
  }
}

final cameraRepositoryProvider = Provider((ref) {
  // Assuming baseUrl is configured globally or passed here
  return CameraRepository(Dio(), 'http://localhost:8000');
});

final camerasProvider = FutureProvider<List<Camera>>((ref) async {
  final repo = ref.watch(cameraRepositoryProvider);
  return repo.getCameras();
});
