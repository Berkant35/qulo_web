// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_trace_pre_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaPreTraceModel _$$_IgaPreTraceModelFromJson(Map<String, dynamic> json) =>
    _$_IgaPreTraceModel(
      traceId: json['traceId'] as String?,
      selectLanguage: json['selectLanguage'] as String?,
      selectPlayer: json['selectPlayer'] as String?,
      selectMode: json['selectMode'] as String?,
      createdAt: json['createdAt'] as String?,
      endTime: json['endTime'] as String?,
      passedTime: json['passedTime'] as int?,
      isEnterGame: json['isEnterGame'] as bool?,
    );

Map<String, dynamic> _$$_IgaPreTraceModelToJson(_$_IgaPreTraceModel instance) =>
    <String, dynamic>{
      'traceId': instance.traceId,
      'selectLanguage': instance.selectLanguage,
      'selectPlayer': instance.selectPlayer,
      'selectMode': instance.selectMode,
      'createdAt': instance.createdAt,
      'endTime': instance.endTime,
      'passedTime': instance.passedTime,
      'isEnterGame': instance.isEnterGame,
    };
