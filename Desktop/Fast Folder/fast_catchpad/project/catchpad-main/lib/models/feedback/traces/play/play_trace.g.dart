// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayTrace _$$_PlayTraceFromJson(Map<String, dynamic> json) => _$_PlayTrace(
      gameControlSetup: json['gameControlSetup'] as Map<String, dynamic>? ?? {},
      createdTime: json['createdTime'] as String?,
      gameTrace: json['gameTrace'] == null
          ? const GameTrace()
          : GameTrace.fromJson(json['gameTrace'] as Map<String, dynamic>),
      metaTrace: json['metaTrace'] == null
          ? const MetaTrace()
          : MetaTrace.fromJson(json['metaTrace'] as Map<String, dynamic>),
      resultTrace: json['resultTrace'] == null
          ? const ResultTrace()
          : ResultTrace.fromJson(json['resultTrace'] as Map<String, dynamic>),
      preTrace: json['preTrace'] == null
          ? const PreTrace()
          : PreTrace.fromJson(json['preTrace'] as Map<String, dynamic>),
      createdMillisecondEpoch: json['millisecondEpoch'] as String?,
    );

Map<String, dynamic> _$$_PlayTraceToJson(_$_PlayTrace instance) =>
    <String, dynamic>{
      'gameControlSetup': instance.gameControlSetup,
      'createdTime': instance.createdTime,
      'gameTrace': instance.gameTrace?.toJson(),
      'metaTrace': instance.metaTrace?.toJson(),
      'resultTrace': instance.resultTrace?.toJson(),
      'preTrace': instance.preTrace?.toJson(),
      'millisecondEpoch': instance.createdMillisecondEpoch,
    };
