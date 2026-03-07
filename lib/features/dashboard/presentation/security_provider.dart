import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lowguard/core/common/security_level.dart';
import 'package:lowguard/core/common/priority_bus.dart';

part 'security_provider.g.dart';

@riverpod
class SecurityStatus extends _$SecurityStatus {
  @override
  SecurityLevel build() {
    // Listen to PriorityBus for emergency level changes
    PriorityBus().alerts.listen((alert) {
      if (alert.level.index > state.index) {
        state = alert.level;
      }
    });
    return SecurityLevel.clear;
  }

  void updateLevel(SecurityLevel newLevel) {
    state = newLevel;
  }
}
