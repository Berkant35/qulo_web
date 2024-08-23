// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_register_trace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaRegisterTraceModel _$$_IgaRegisterTraceModelFromJson(
        Map<String, dynamic> json) =>
    _$_IgaRegisterTraceModel(
      traceId: json['traceId'] as String?,
      endTime: json['endTime'] as String?,
      createdAt: json['createdAt'] as String?,
      passedTime: json['passedTime'] as int?,
      igaUserId: json['igaUserId'] as String?,
      isRegistered: json['isRegistered'] as bool?,
    );

Map<String, dynamic> _$$_IgaRegisterTraceModelToJson(
        _$_IgaRegisterTraceModel instance) =>
    <String, dynamic>{
      'traceId': instance.traceId,
      'endTime': instance.endTime,
      'createdAt': instance.createdAt,
      'passedTime': instance.passedTime,
      'igaUserId': instance.igaUserId,
      'isRegistered': instance.isRegistered,
    };
