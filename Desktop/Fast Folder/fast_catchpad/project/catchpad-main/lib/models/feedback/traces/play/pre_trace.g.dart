// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PreTrace _$$_PreTraceFromJson(Map<String, dynamic> json) => _$_PreTrace(
      clickToScreenCount: json['clickToScreenCount'] as int? ?? 0,
      passedTime: json['passedTime'] as int? ?? 0,
      endTime: json['endTime'] as String?,
      createdAt: json['createdAt'] as String?,
      createdMillisecondEpoch: json['createdMillisecondEpoch'] as String?,
      phoneChargeStartPercent: json['phoneChargeStartPercent'] as int? ?? 0,
      padList: json['padList'] as Map<String, dynamic>? ?? {},
      locationData: (json['locationData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      padBatteryMapStart:
          (json['padBatteryMapStart'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              {},
      isEnterToGame: json['isEnterToGame'] as bool? ?? false,
    );

Map<String, dynamic> _$$_PreTraceToJson(_$_PreTrace instance) =>
    <String, dynamic>{
      'clickToScreenCount': instance.clickToScreenCount,
      'passedTime': instance.passedTime,
      'endTime': instance.endTime,
      'createdAt': instance.createdAt,
      'createdMillisecondEpoch': instance.createdMillisecondEpoch,
      'phoneChargeStartPercent': instance.phoneChargeStartPercent,
      'padList': instance.padList,
      'locationData': instance.locationData,
      'padBatteryMapStart': instance.padBatteryMapStart,
      'isEnterToGame': instance.isEnterToGame,
    };
