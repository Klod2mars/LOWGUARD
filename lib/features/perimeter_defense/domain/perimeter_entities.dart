import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_entity.freezed.dart';

@freezed
class SensorEntity with _$SensorEntity {
  const factory SensorEntity({
    required String id,
    required String name,
    required String type,
    required bool isActive,
    String? lastReading,
  }) = _SensorEntity;
}

@freezed
class IntruderEntity with _$IntruderEntity {
  const factory IntruderEntity({
    required String id,
    required DateTime detectedAt,
    required String location,
    String? imageUrl,
    @Default(false) bool isIdentified,
  }) = _IntruderEntity;
}
