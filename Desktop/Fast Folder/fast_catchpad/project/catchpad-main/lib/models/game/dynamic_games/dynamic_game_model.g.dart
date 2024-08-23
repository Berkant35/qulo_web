// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicGameModel _$DynamicGameModelFromJson(Map<String, dynamic> json) =>
    DynamicGameModel(
      id: json['id'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => InstructionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      gameEndType: $enumDecode(_$GameEndTypeEnumMap, json['gameEndType']),
      scoreTypeParam1:
          $enumDecode(_$GameScoreTypeEnumMap, json['scoreTypeParam1']),
      scoreTypeParam2:
          $enumDecodeNullable(_$GameScoreTypeEnumMap, json['scoreTypeParam2']),
      metaData:
          GameMetaDataModel.fromJson(json['metaData'] as Map<String, dynamic>),
      enabled: json['enabled'] as bool? ?? true,
    )
      ..generalPlayer = json['generalPlayer'] == null
          ? null
          : PlayerModel.fromJson(json['generalPlayer'] as Map<String, dynamic>)
      ..onLeaderboard = json['onLeaderboard'] as bool;

Map<String, dynamic> _$DynamicGameModelToJson(DynamicGameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enabled': instance.enabled,
      'metaData': instance.metaData.toJson(),
      'generalPlayer': instance.generalPlayer?.toJson(),
      'onLeaderboard': instance.onLeaderboard,
      'instructions': instance.instructions.map((e) => e.toJson()).toList(),
      'gameEndType': _$GameEndTypeEnumMap[instance.gameEndType]!,
      'scoreTypeParam1': _$GameScoreTypeEnumMap[instance.scoreTypeParam1]!,
      'scoreTypeParam2': _$GameScoreTypeEnumMap[instance.scoreTypeParam2],
    };

const _$GameEndTypeEnumMap = {
  GameEndType.duration: 'duration',
  GameEndType.score: 'score',
  GameEndType.instructions: 'instructions',
};

const _$GameScoreTypeEnumMap = {
  GameScoreType.score: 'score',
  GameScoreType.percentage: 'percentage',
  GameScoreType.speed: 'speed',
  GameScoreType.correctCount: 'correctCount',
  GameScoreType.incorrectCount: 'incorrectCount',
  GameScoreType.totalDuration: 'totalDuration',
  GameScoreType.averageDuration: 'averageDuration',
  GameScoreType.maxDuration: 'maxDuration',
  GameScoreType.minDuration: 'minDuration',
  GameScoreType.totalDistance: 'totalDistance',
  GameScoreType.averageDistance: 'averageDistance',
  GameScoreType.maxDistance: 'maxDistance',
  GameScoreType.minDistance: 'minDistance',
  GameScoreType.level: 'level',
  GameScoreType.teamHarmony: 'teamHarmony',
  GameScoreType.deviceCatchCount: 'deviceCatchCount',
  GameScoreType.none: 'none',
};
