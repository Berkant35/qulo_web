// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResultTrace _$$_ResultTraceFromJson(Map<String, dynamic> json) =>
    _$_ResultTrace(
      clickToScreenCount: json['clickToScreenCount'] as int? ?? 0,
      passedTime: json['passedTime'] as int? ?? 0,
      againButtonTrigger: json['againButtonTrigger'] as bool? ?? false,
      phoneChargeStartPercent: json['phoneChargeStartPercent'] as int? ?? 0,
      phoneChargeEndPercent: json['phoneChargeEndPercent'] as int? ?? 0,
      padBatteryMapStop:
          (json['padBatteryMapStop'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              {},
      endTime: json['endTime'] as String?,
      createdTime: json['createdTime'] as String?,
      createdMillisecondEpoch: json['createdMillisecondEpoch'] as String?,
    );

Map<String, dynamic> _$$_ResultTraceToJson(_$_ResultTrace instance) =>
    <String, dynamic>{
      'clickToScreenCount': instance.clickToScreenCount,
      'passedTime': instance.passedTime,
      'againButtonTrigger': instance.againButtonTrigger,
      'phoneChargeStartPercent': instance.phoneChargeStartPercent,
      'phoneChargeEndPercent': instance.phoneChargeEndPercent,
      'padBatteryMapStop': instance.padBatteryMapStop,
      'endTime': instance.endTime,
      'createdTime': instance.createdTime,
      'createdMillisecondEpoch': instance.createdMillisecondEpoch,
    };
