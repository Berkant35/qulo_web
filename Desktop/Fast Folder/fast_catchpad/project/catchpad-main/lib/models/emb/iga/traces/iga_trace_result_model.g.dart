// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_trace_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaResultTraceModel _$$_IgaResultTraceModelFromJson(
        Map<String, dynamic> json) =>
    _$_IgaResultTraceModel(
      traceId: json['traceId'] as String?,
      isEnterRegistered: json['isEnterRegistered'] as bool?,
      createdAt: json['createdAt'] as String?,
      endTime: json['endTime'] as String?,
      passedTime: json['passedTime'] as int?,
    );

Map<String, dynamic> _$$_IgaResultTraceModelToJson(
        _$_IgaResultTraceModel instance) =>
    <String, dynamic>{
      'traceId': instance.traceId,
      'isEnterRegistered': instance.isEnterRegistered,
      'createdAt': instance.createdAt,
      'endTime': instance.endTime,
      'passedTime': instance.passedTime,
    };
