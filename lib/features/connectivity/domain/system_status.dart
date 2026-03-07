import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_status.freezed.dart';
part 'system_status.g.dart';

@freezed
class SystemStatus with _$SystemStatus {
  const factory SystemStatus({
    required String system,
    required String nas,
    required String network,
    required String butlerAi,
    required String perimeter,
    required String timestamp,
  }) = _SystemStatus;

  factory SystemStatus.fromJson(Map<String, dynamic> json) => _$SystemStatusFromJson(json);
}
