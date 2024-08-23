// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'per_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PerPeriod _$$_PerPeriodFromJson(Map<String, dynamic> json) => _$_PerPeriod(
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => BriefDeviceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_PerPeriodToJson(_$_PerPeriod instance) =>
    <String, dynamic>{
      'devices': instance.devices?.map((e) => e.toJson()).toList(),
      'name': instance.name,
    };
