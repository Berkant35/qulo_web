// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameScorePointModel _$GameScorePointModelFromJson(Map<String, dynamic> json) =>
    GameScorePointModel(
      duration: Duration(microseconds: json['duration'] as int),
      scoredAt: DateTime.parse(json['scoredAt'] as String),
    );

Map<String, dynamic> _$GameScorePointModelToJson(
        GameScorePointModel instance) =>
    <String, dynamic>{
      'duration': instance.duration.inMicroseconds,
      'scoredAt': instance.scoredAt.toIso8601String(),
    };
