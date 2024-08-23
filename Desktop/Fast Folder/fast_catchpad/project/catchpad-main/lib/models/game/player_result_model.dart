import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../prov/end_game_prov.dart';
import '../../utils/utils.dart';
import 'score_point_model.dart';

part 'player_result_model.freezed.dart';
part 'player_result_model.g.dart';

FlSpot spotModelFromJson(Map<String, dynamic> json) =>
    FlSpot(double.parse(json['x']), double.parse(json['y']));

Map<String, dynamic> spotModelToJson(double x, double y) => {
      "x": x.toString(),
      "y": y.toString(),
    };

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Map<String, dynamic>? _scoreToJson(List<GameScorePointModel>? model) {
  Map<String, dynamic> returnJson = {};
  if (model != null) {
    for (var element in model) {
      returnJson[model.indexOf(element).toString()] = element.toJson();
    }
    return returnJson;
  } else {
    return null;
  }
}

List<GameScorePointModel>? _scoreFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return null;
  }
  List<GameScorePointModel>? scorePoints = [];
  for (Map<String, dynamic> element in json.values) {
    scorePoints.add(GameScorePointModel.fromJson(element));
  }
  if (scorePoints.isNotEmpty) {
    return scorePoints;
  } else {
    return null;
  }
}

List<GameScorePointModel>? _harmonyPointsFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return null;
  }
  List<GameScorePointModel>? scorePoints = [];
  for (Map<String, dynamic> element in json.values) {
    scorePoints.add(GameScorePointModel.fromJson(element));
  }
  if (scorePoints.isNotEmpty) {
    return scorePoints;
  } else {
    return null;
  }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Map<String, dynamic>? spotToJson(List<FlSpot>? model) {
  Map<String, dynamic> returnJson = {};
  if (model != null) {
    for (var element in model) {
      returnJson[model.indexOf(element).toString()] =
          spotModelToJson(element.x, element.y);
    }
    return returnJson;
  } else {
    return null;
  }
}

List<FlSpot> spotFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return [];
  }
  List<FlSpot>? spots = [];
  for (var element in json.values) {
    spots.add(spotModelFromJson(element as Map<String, dynamic>));
  }
  if (spots.isNotEmpty) {
    return spots;
  } else {
    return [];
  }
}

Map<String, dynamic>? _distanceToJson(List<DistanceModel>? model) {
  Map<String, dynamic> returnJson = {};
  if (model != null) {
    for (var element in model) {
      returnJson[model.indexOf(element).toString()] = element.toJson();
    }
    return returnJson;
  } else {
    return null;
  }
}

List<DistanceModel>? _distanceFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return null;
  }
  List<DistanceModel>? distances = [];
  for (var element in json.values) {
    distances.add(DistanceModel.fromJson(element as Map<String, dynamic>));
  }
  if (distances.isNotEmpty) {
    return distances;
  } else {
    return null;
  }
}

@freezed
class PlayerResultModel with _$PlayerResultModel {
  const PlayerResultModel._();
  const factory PlayerResultModel({
    required String playerId,
    @Default('') String userName,
    @Default(0) int? indexValue,
    DateTime? startTime,
    DateTime? endTime,
    Map<String, int>? playerColorCatchCount,
    int? correctCount,
    int? incorrectCount,
    int? level,
    @Default(1) int incorrectWeight,
    @JsonKey(
        fromJson: spotFromJson,
        toJson: spotToJson,
        defaultValue: [],
        nullable: true)
    @Default([])
        List<FlSpot> graphSpots,

    /// this has not been deleted to be able to parse the previous
    /// results kept on the server. in the future we should transform
    /// those data and convert
    // ignore: deprecated_member_use_from_same_package
    ///  [timeSpans]
    ///  to [scorePoints].
    @Deprecated('this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
        List<Duration>? timeSpans,
    @JsonKey(toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
        List<GameScorePointModel>? scorePoints,

    /// this will be used to store the harmony between the team members
    /// the sentecnce above this makes 0 sense.
    ///
    /// let me explain:
    /// take the ekipIsi game for example, there what we are (previously)
    /// doing is we're stroing the last (second) player's response time.
    /// an additional thing we want for score is the harmony time, which
    /// means the time difference between the 2 players' responses.
    /// these games in the future should use something like
    /// [TeamResultModel] instead of [PlayerResultModel].
    /// I've not implemented that right now because of the time it will consume as
    /// it would require us to rearchitect the whole game system.
    @JsonKey(toJson: _scoreToJson, fromJson: _harmonyPointsFromJson, includeIfNull: true)
        List<GameScorePointModel>? teamHarmonyPoints,

    // TODO: this is a temp for displaying
    // a result in jumpOverThePad game.
    @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
        List<DistanceModel>? distances,
  }) = _PlayerResultModel;

  factory PlayerResultModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerResultModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "username": userName,
        "startTime": startTime,
        "endTime": endTime,
        "playerColorCatchCount": playerColorCatchCount,
        "correctCount": correctCount,
        "incorrectCount": incorrectCount,
        "level": level,
        "incorrectWeight": incorrectWeight,
        "indexvalue": indexValue,
        //"timeSpans": timeSpans,
        "scorePoints": _scoreToJson(scorePoints),
        "teamHarmonyPoints": _scoreToJson(teamHarmonyPoints),
        "distances": "merhaba dünya"
      };
  factory PlayerResultModel.fromRawJson(String str) =>
      PlayerResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

extension Score on PlayerResultModel {
  int get score {
    if (correctCount == null && incorrectCount == null) {
      return 0;
    }

    final correct = correctCount ?? 0;
    final incorrect = incorrectCount ?? 0;

    final incWei = incorrectWeight == 0 ? 1 : incorrectWeight;

    return correct - (incorrect ~/ incWei);
  }
}

extension _ScorePointList on List<GameScorePointModel>? {
  Iterable<Duration>? get allDurations {
    if (this == null) {
      return null;
    }

    return this!.map((e) => e.duration);
  }

  Duration? totalDuration({
    DateTime? startTime,
    DateTime? endTime,
  }) {
    if (this != null) {
      return allDurations!.reduce(
        (a, b) => a + b,
      );
    }

    if (startTime == null) return null;
    return (endTime ?? DateTime.now()).difference(startTime);
  }

  int? allDurationsSumInMicrosec() {
    if (this == null) {
      return null;
    }
    int i = 0;
    for (var dur in allDurations!) {
      i += dur.inMicroseconds;
    }
    return i;
  }

  Duration? averageDuration({
    DateTime? startTime,
    DateTime? endTime,
  }) {
    if (this != null) {
      final tot = allDurationsSumInMicrosec();
      return Duration(
        microseconds: tot! ~/ this!.allDurations!.length,
      );
    }

    return null;
  }

  Duration? minDurationForTeamHarmony(
      List<GameScorePointModel>? teamHarmonyPoints) {
    if (this == null) {
      return null;
    }

    return teamHarmonyPoints!.map((e) => e.duration).reduce(
          (a, b) => a < b ? a : b,
        );
  }

  Duration? maxDurationForTeamHarmony(
      List<GameScorePointModel>? teamHarmonyPoints) {
    if (this == null) {
      return null;
    }

    return teamHarmonyPoints!.map((e) => e.duration).reduce(
          (a, b) => a > b ? a : b,
        );
  }

  Duration? get minDuration {
    if (this != null) {
      var temp = allDurations!.toList();
      temp.sort(
        (a, b) => a.inMicroseconds.compareTo(b.inMicroseconds),
      );
      return temp.first;
      /* return allDurations!.reduce(
        (a, b) => a.inMicroseconds < b.inMicroseconds ? a : b,
      ); */
    }

    return null;
  }

  Duration? get maxDuration {
    if (this != null) {
      var temp = allDurations!.toList();
      temp.sort(
        (a, b) => a.inMicroseconds.compareTo(b.inMicroseconds),
      );
      return temp.last;
      /* return allDurations!.reduce(
        (a, b) => a.inMicroseconds > b.inMicroseconds ? a : b,
      ); */
    }

    return null;
  }
}

extension TeamHarmony on PlayerResultModel {
  Iterable<Duration>? get teamHarmonyDurations =>
      teamHarmonyPoints?.allDurations;

  Duration? get totalTeamHarmonyDuration =>
      teamHarmonyPoints?.totalDuration(startTime: startTime, endTime: endTime);

  Duration? get averageTeamHarmonyDuration => teamHarmonyPoints
      ?.averageDuration(startTime: startTime, endTime: endTime);

  Duration? get minTeamHarmonyDuration =>
      teamHarmonyPoints?.minDurationForTeamHarmony(teamHarmonyPoints);

  Duration? get maxTeamHarmonyDuration =>
      teamHarmonyPoints?.maxDurationForTeamHarmony(teamHarmonyPoints);
}

extension DeviceCatchCountforColors on PlayerResultModel {
  String? get deviceCatchCountforColors {
    String playerColorCatchCountText = '';
    playerColorCatchCount?.forEach((key, value) {
      playerColorCatchCountText += '$key|$value|';
    });
    if (playerColorCatchCount == null) {
      return null;
    }
    return playerColorCatchCountText;
  }
}

extension ScorePoints on PlayerResultModel {
  Iterable<Duration>? get scorePointsDurations => scorePoints?.allDurations;

  Duration? get totalDuration =>
      scorePoints?.totalDuration(startTime: startTime, endTime: endTime);

  Duration? get gameTime => gameChronometer.elapsed;

  Duration? get averageDuration =>
      scorePoints?.averageDuration(startTime: startTime, endTime: endTime);

  Duration? get minDuration => scorePoints?.minDuration;

  Duration? get maxDuration => scorePoints?.maxDuration;
}



extension Dis on PlayerResultModel {
  int? get averageDistance {
    if (distances == null) return null;

    final tot = totalDistance;
    if (tot == null) return null;

    return tot ~/ distances!.length;
  }

  int? get averageDistanceCm => averageDistance?.mmToCm.toInt();

  int? get totalDistance {
    if (distances == null) return null;
    return distances!.fold<int>(
      0,
      (a, b) => a + b.distance,
    );
  }

  int? get totalDistanceCm => totalDistance?.mmToCm.toInt();

  int? get maxDistance {
    if (distances == null) return null;
    return distances!.map((e) => e.distance).reduce(
          (a, b) => max(a, b),
        );
  }

  int? get maxDistanceCm => maxDistance?.mmToCm.toInt();

  int? get minDistance {
    if (distances == null) return null;
    return distances!.map((e) => e.distance).reduce(
          (a, b) => min(a, b),
        );
  }

  int? get minDistanceCm => minDistance?.mmToCm.toInt();
}
