import 'dart:async';
import 'package:lowguard/core/common/security_level.dart';

class PriorityAlert {
  final String id;
  final String title;
  final String message;
  final SecurityLevel level;
  final DateTime timestamp;

  PriorityAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.level,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class PriorityBus {
  static final PriorityBus _instance = PriorityBus._internal();
  factory PriorityBus() => _instance;
  PriorityBus._internal();

  final _alertController = StreamController<PriorityAlert>.broadcast();
  Stream<PriorityAlert> get alerts => _alertController.stream;

  void publish(PriorityAlert alert) {
    _alertController.add(alert);
  }

  void dispose() {
    _alertController.close();
  }
}
