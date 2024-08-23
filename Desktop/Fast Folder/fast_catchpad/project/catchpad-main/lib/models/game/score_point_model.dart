import 'dart:convert';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:duration/duration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_point_model.g.dart';

GameScorePointModel gameScorePointModelFromJson(String str) =>
    GameScorePointModel.fromJson(json.decode(str));

String gameScorePointModelToJson(GameScorePointModel data) =>
    json.encode(data.toJson());

@JsonSerializable(
  createToJson: true,
)
class GameScorePointModel {
  GameScorePointModel({
    required this.duration,
    required this.scoredAt,
  });

  Duration duration;
  DateTime scoredAt;

  factory GameScorePointModel.fromJson(Map<String, dynamic> json) {
    return GameScorePointModel(
      duration: parseTime(json["duration"]),
      scoredAt: DateTime.parse(json["scoredAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "duration": duration.toString(),
        "scoredAt": scoredAt.toString(),
      };
}


/* class GameScorePointModel with _$GameScorePointModel {
  const factory GameScorePointModel({
    required Duration duration,
    required DateTime scoredAt,
  }) = _GameScorePointModel;

  factory GameScorePointModel.fromJson(Map<String, dynamic> json) =>
      _$GameScorePointModelFromJson(json);
  factory GameScorePointModel.toJson(Map<String, dynamic> json) =>
      _$GameScorePointModelToJson(json);
} */