// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_trace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaTraceModel _$$_IgaTraceModelFromJson(Map<String, dynamic> json) =>
    _$_IgaTraceModel(
      traceId: json['traceId'] as String?,
      createdAt: json['createdAt'] as String?,
      igaMetaTraceModel: json['igaMetaTrace'] == null
          ? null
          : IgaMetaTraceModel.fromJson(
              json['igaMetaTrace'] as Map<String, dynamic>),
      igaPreTraceModel: json['igaPreTrace'] == null
          ? null
          : IgaPreTraceModel.fromJson(
              json['igaPreTrace'] as Map<String, dynamic>),
      igaGameTraceModel: json['igaGameTrace'] == null
          ? null
          : IgaGameTraceModel.fromJson(
              json['igaGameTrace'] as Map<String, dynamic>),
      igaResultTraceModel: json['igaResultTrace'] == null
          ? null
          : IgaResultTraceModel.fromJson(
              json['igaResultTrace'] as Map<String, dynamic>),
      igaRegisterTraceModel: json['igaRegisterTrace'] == null
          ? null
          : IgaRegisterTraceModel.fromJson(
              json['igaRegisterTrace'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_IgaTraceModelToJson(_$_IgaTraceModel instance) =>
    <String, dynamic>{
      'traceId': instance.traceId,
      'createdAt': instance.createdAt,
      'igaMetaTrace': instance.igaMetaTraceModel?.toJson(),
      'igaPreTrace': instance.igaPreTraceModel?.toJson(),
      'igaGameTrace': instance.igaGameTraceModel?.toJson(),
      'igaResultTrace': instance.igaResultTraceModel?.toJson(),
      'igaRegisterTrace': instance.igaRegisterTraceModel?.toJson(),
    };
