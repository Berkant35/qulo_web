// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConnectionLog _$$_ConnectionLogFromJson(Map<String, dynamic> json) =>
    _$_ConnectionLog(
      lastConnectionTime: json['last_connection_time'] as String?,
      macId: json['device_id'] as String?,
      deviceModel: json['device_model'] as String?,
    );

Map<String, dynamic> _$$_ConnectionLogToJson(_$_ConnectionLog instance) =>
    <String, dynamic>{
      'last_connection_time': instance.lastConnectionTime,
      'device_id': instance.macId,
      'device_model': instance.deviceModel,
    };
