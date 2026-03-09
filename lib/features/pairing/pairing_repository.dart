import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto/crypto.dart';

class PairingRepository {
  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  PairingRepository(this._dio);

  Future<void> saveDeviceKey(String cameraId, String key) async {
    await _storage.write(key: 'device_key_$cameraId', value: key);
  }

  Future<String?> getDeviceKey(String cameraId) async {
    return await _storage.read(key: 'device_key_$cameraId');
  }

  Future<void> saveBaseUrl(String url) async {
    await _storage.write(key: 'base_url', value: url);
  }

  Future<void> saveDeviceId(String id) async {
    await _storage.write(key: 'device_id', value: id);
  }

  Future<String?> getDeviceId() async {
    return await _storage.read(key: 'device_id');
  }

  Future<String?> getBaseUrl() async {
    return await _storage.read(key: 'base_url');
  }

  Future<Map<String, dynamic>> confirmPairing(String baseUrl, String token, String deviceId, String deviceName) async {
    final response = await _dio.post('$baseUrl/pair/confirm', data: {
      'token': token,
      'device_id': deviceId,
      'device_name': deviceName,
    });
    return response.data;
  }

  String generateSignature(String key, String method, String path, String timestamp, String body) {
    final message = '$method|$path|$timestamp|$body';
    final hmacSha256 = Hmac(sha256, utf8.encode(key));
    final digest = hmacSha256.convert(utf8.encode(message));
    return digest.toString();
  }
}

final pairingRepositoryProvider = Provider((ref) => PairingRepository(Dio()));
