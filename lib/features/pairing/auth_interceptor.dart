import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LowGuardAuthInterceptor extends Interceptor {
  final _storage = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final deviceId = await _storage.read(key: 'device_id');
    final deviceKey = await _storage.read(key: 'device_key_$deviceId');

    if (deviceId != null && deviceKey != null) {
      final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
      final method = options.method.toUpperCase();
      final path = options.path;
      final body = options.data != null ? jsonEncode(options.data) : '';
      
      final signature = _generateSignature(deviceKey, method, path, timestamp, body);
      
      options.headers['X-LowGuard-Auth'] = '$deviceId:$timestamp:$signature';
    }
    
    handler.next(options);
  }

  String _generateSignature(String key, String method, String path, String timestamp, String body) {
    final message = '$method|$path|$timestamp|$body';
    final hmacSha256 = Hmac(sha256, utf8.encode(key));
    final digest = hmacSha256.convert(utf8.encode(message));
    return digest.toString();
  }
}
