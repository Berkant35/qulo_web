// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_trace_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaGameTraceModel _$$_IgaGameTraceModelFromJson(Map<String, dynamic> json) =>
    _$_IgaGameTraceModel(
      traceId: json['traceId'] as String?,
      selectedColors: (json['selectedColors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      endTime: json['endTime'] as String?,
      gameId: json['gameId'] as String?,
    );

Map<String, dynamic> _$$_IgaGameTraceModelToJson(
        _$_IgaGameTraceModel instance) =>
    <String, dynamic>{
      'traceId': instance.traceId,
      'selectedColors': instance.selectedColors,
      'createdAt': instance.createdAt,
      'endTime': instance.endTime,
      'gameId': instance.gameId,
    };
