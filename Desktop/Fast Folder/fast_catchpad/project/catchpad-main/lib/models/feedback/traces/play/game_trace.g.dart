// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameTrace _$$_GameTraceFromJson(Map<String, dynamic> json) => _$_GameTrace(
      clickToScreenCount: json['clickToScreenCount'] as int? ?? 0,
      isEnterToResult: json['isEnterToResult'] as bool? ?? false,
      passedTime: json['passedTime'] as int? ?? 0,
      createdTime: json['createdTime'] as String?,
      createdMillisecondEpoch: json['createdMillisecondEpoch'] as String?,
      endTime: json['endTime'] as String?,
    );

Map<String, dynamic> _$$_GameTraceToJson(_$_GameTrace instance) =>
    <String, dynamic>{
      'clickToScreenCount': instance.clickToScreenCount,
      'isEnterToResult': instance.isEnterToResult,
      'passedTime': instance.passedTime,
      'createdTime': instance.createdTime,
      'createdMillisecondEpoch': instance.createdMillisecondEpoch,
      'endTime': instance.endTime,
    };
