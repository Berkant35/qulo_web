// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_trace_meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaMetaTraceModel _$$_IgaMetaTraceModelFromJson(Map<String, dynamic> json) =>
    _$_IgaMetaTraceModel(
      traceId: json['traceId'] as String?,
      connectedDevices: (json['connectedDevices'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      phoneInformation: json['tabletInfo'] as Map<String, dynamic>? ?? const {},
      locationInformation:
          json['locationInformation'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$_IgaMetaTraceModelToJson(
        _$_IgaMetaTraceModel instance) =>
    <String, dynamic>{
      'traceId': instance.traceId,
      'connectedDevices': instance.connectedDevices,
      'tabletInfo': instance.phoneInformation,
      'locationInformation': instance.locationInformation,
    };
