import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lowguard/features/pairing/auth_interceptor.dart';

enum ConnectionStatus { connecting, connected, disconnected }

class ConnectionManager {
  static final ConnectionManager _instance = ConnectionManager._internal();
  factory ConnectionManager() => _instance;
  ConnectionManager._internal();

  final _logger = Logger();
  WebSocketChannel? _channel;
  StreamSubscription? _statusSubscription;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  final _storage = const FlutterSecureStorage();
  final _dio = Dio()..interceptors.add(LowGuardAuthInterceptor());

  final _statusController = StreamController<ConnectionStatus>.broadcast();
  Stream<ConnectionStatus> get statusStream => _statusController.stream;

  ConnectionStatus _currentStatus = ConnectionStatus.disconnected;
  ConnectionStatus get currentStatus => _currentStatus;

  String? _baseUrl;
  int _retryCount = 0;
  bool _shouldReconnect = false;

  void start(String baseUrl) {
    _baseUrl = _formatWsUrl(baseUrl);
    _shouldReconnect = true;
    _retryCount = 0;
    _connect();
    _listenToConnectivity();
  }

  void stop() {
    _shouldReconnect = false;
    _disconnect();
    _statusSubscription?.cancel();
    _reconnectTimer?.cancel();
  }

  String _formatWsUrl(String url) {
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'ws://').replaceAll(':8000', ':8000/ws');
    } else if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'wss://').replaceAll(':443', ':443/ws');
    }
    return url;
  }

  Future<void> _connect() async {
    if (_baseUrl == null) return;
    
    _disconnect();
    _updateStatus(ConnectionStatus.connecting);
    _logger.i('Connecting to WebSocket: $_baseUrl');

    try {
      // First check health
      final healthOk = await _checkHealth();
      if (!healthOk) {
        await _attemptWake();
      }

      _channel = WebSocketChannel.connect(Uri.parse(_baseUrl!));
      
      _channel!.stream.listen(
        (message) {
          if (_currentStatus != ConnectionStatus.connected) {
            _updateStatus(ConnectionStatus.connected);
            _retryCount = 0;
            _startHeartbeat();
          }
          _handleMessage(message);
        },
        onError: (error) {
          _logger.e('WebSocket Error: $error');
          _handleDisconnect();
        },
        onDone: () {
          _logger.w('WebSocket Closed');
          _handleDisconnect();
        },
      );
    } catch (e) {
      _logger.e('Failed to connect: $e');
      _handleDisconnect();
    }
  }

  Future<bool> _checkHealth() async {
    try {
      final httpUrl = _baseUrl!.replaceFirst('ws://', 'http://').replaceAll('/ws', '/health');
      final response = await _dio.get(httpUrl);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> _attemptWake() async {
    final host = Uri.parse(_baseUrl!.replaceFirst('ws://', 'http://')).host;
    final managerUrl = 'http://$host:9000/manager/wake';
    _logger.i('Attempting Auto-Wake via manager: $managerUrl');
    
    try {
      await _dio.post(managerUrl);
      _logger.i('Wake command sent successfully.');
      // Wait for boot
      await Future.delayed(const Duration(seconds: 5));
    } catch (e) {
      _logger.e('Auto-Wake failed: $e');
    }
  }

  void _disconnect() {
    _heartbeatTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
    _updateStatus(ConnectionStatus.disconnected);
  }

  void _handleDisconnect() {
    _disconnect();
    if (_shouldReconnect) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    
    // Exponential backoff with jitter
    // base 1s, cap 60s, 6 retries before cap
    final backoff = min(pow(2, _retryCount).toInt(), 60);
    final jitter = Random().nextInt(1000);
    final delay = Duration(seconds: backoff) + Duration(milliseconds: jitter);

    _logger.i('Reconnecting in ${delay.inSeconds}s (attempt ${_retryCount + 1})');
    
    _reconnectTimer = Timer(delay, () {
      _retryCount++;
      _connect();
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_currentStatus == ConnectionStatus.connected) {
        _channel?.sink.add(jsonEncode({'type': 'heartbeat'}));
      }
    });
  }

  void _handleMessage(dynamic message) {
    // Process messages if needed
    // For heartbeat, we just need to know we received something
    // _logger.d('Received: $message');
  }

  void _updateStatus(ConnectionStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  void _listenToConnectivity() {
    _statusSubscription?.cancel();
    _statusSubscription = Connectivity().onConnectivityChanged.listen((results) {
      // connectivity_plus 6.0 returns List<ConnectivityResult>
      if (results.any((r) => r != ConnectivityResult.none)) {
        if (_currentStatus == ConnectionStatus.disconnected && _shouldReconnect) {
          _logger.i('Network restored, immediate reconnection');
          _retryCount = 0;
          _connect();
        }
      }
    });
  }
}
