// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SystemStatus _$SystemStatusFromJson(Map<String, dynamic> json) =>
    _SystemStatus(
      system: json['system'] as String,
      nas: json['nas'] as String,
      network: json['network'] as String,
      butlerAi: json['butlerAi'] as String,
      perimeter: json['perimeter'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$SystemStatusToJson(_SystemStatus instance) =>
    <String, dynamic>{
      'system': instance.system,
      'nas': instance.nas,
      'network': instance.network,
      'butlerAi': instance.butlerAi,
      'perimeter': instance.perimeter,
      'timestamp': instance.timestamp,
    };
