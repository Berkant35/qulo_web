// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayerResultModel _$$_PlayerResultModelFromJson(Map<String, dynamic> json) =>
    _$_PlayerResultModel(
      playerId: json['playerId'] as String,
      userName: json['userName'] as String? ?? '',
      indexValue: json['indexValue'] as int? ?? 0,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      playerColorCatchCount:
          (json['playerColorCatchCount'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      correctCount: json['correctCount'] as int?,
      incorrectCount: json['incorrectCount'] as int?,
      level: json['level'] as int?,
      incorrectWeight: json['incorrectWeight'] as int? ?? 1,
      graphSpots: json['graphSpots'] == null
          ? []
          : spotFromJson(json['graphSpots'] as Map<String, dynamic>?),
      timeSpans: (json['timeSpans'] as List<dynamic>?)
          ?.map((e) => Duration(microseconds: e as int))
          .toList(),
      scorePoints: _scoreFromJson(json['scorePoints'] as Map<String, dynamic>?),
      teamHarmonyPoints: _harmonyPointsFromJson(
          json['teamHarmonyPoints'] as Map<String, dynamic>?),
      distances: _distanceFromJson(json['distances'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_PlayerResultModelToJson(
        _$_PlayerResultModel instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'userName': instance.userName,
      'indexValue': instance.indexValue,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'playerColorCatchCount': instance.playerColorCatchCount,
      'correctCount': instance.correctCount,
      'incorrectCount': instance.incorrectCount,
      'level': instance.level,
      'incorrectWeight': instance.incorrectWeight,
      'graphSpots': spotToJson(instance.graphSpots),
      'timeSpans': instance.timeSpans?.map((e) => e.inMicroseconds).toList(),
      'scorePoints': _scoreToJson(instance.scorePoints),
      'teamHarmonyPoints': _scoreToJson(instance.teamHarmonyPoints),
      'distances': _distanceToJson(instance.distances),
    };
