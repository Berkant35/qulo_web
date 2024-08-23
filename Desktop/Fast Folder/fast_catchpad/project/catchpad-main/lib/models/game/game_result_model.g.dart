// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameResultModel _$GameResultModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['type', 'gameId', 'scoreTypeParam1'],
  );
  return GameResultModel(
    type: $enumDecode(_$GameEndTypeEnumMap, json['type']),
    players: _playersFromJson(json['players'] as List),
    playerResults: _playerResultsFromJson(json['playerResults'] as List),
    gameId: json['gameId'] as String,
    accountHolderId: json['accountHolderId'] as String? ?? '',
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    scoreTypeParam1:
        $enumDecode(_$GameScoreTypeEnumMap, json['scoreTypeParam1']),
    scoreTypeParam2:
        $enumDecodeNullable(_$GameScoreTypeEnumMap, json['scoreTypeParam2']),
    indexValue: json['indexValue'] as int?,
    winnerPlayerId: json['winnerPlayerId'] as String?,
  );
}

Map<String, dynamic> _$GameResultModelToJson(GameResultModel instance) =>
    <String, dynamic>{
      'type': _$GameEndTypeEnumMap[instance.type]!,
      'players': _playersToJson(instance.players),
      'playerResults': _playerResultsToJson(instance.playerResults),
      'gameId': instance.gameId,
      'accountHolderId': instance.accountHolderId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'scoreTypeParam1': _$GameScoreTypeEnumMap[instance.scoreTypeParam1]!,
      'scoreTypeParam2': _$GameScoreTypeEnumMap[instance.scoreTypeParam2],
      'indexValue': instance.indexValue,
      'winnerPlayerId': instance.winnerPlayerId,
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
