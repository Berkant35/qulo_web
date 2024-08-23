import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'game_trace.freezed.dart';
part 'game_trace.g.dart';

// ignore: slash_for_doc_comments
/**
    [MetaTrace]     [PreTrace]     [GameTrace]     *[ResultTrace]
    |             |             |             |
    \|/           \|/           \|/           \|/
    -------------------------------------------
    [PlayTrace]
 */


@freezed
class GameTrace with _$GameTrace {



  const factory GameTrace({
    /// [clickToScreenCount]: Represents the number of clicks made to the
    /// screen during the game. It is an optional parameter and its default
    /// value is 0.
    @JsonKey(name: 'clickToScreenCount',defaultValue: 0)
    @Default(0)
    int? clickToScreenCount,

    ///isEnterToResult: Indicates whether the player has entered the result
    ///screen or not. It is a boolean parameter and its default value is false.
    @JsonKey(name: 'isEnterToResult',defaultValue: false)
    @Default(false)
    bool? isEnterToResult,

    ///Represents the amount of time passed during the game, measured
    ///in some unit (e.g., seconds). It is an optional parameter and its
    ///default value is 0.
    @JsonKey(name: 'passedTime',defaultValue: 0)
    @Default(0)
    int? passedTime,

    ///createdTime: Represents the timestamp when the game trace was created.
    ///It is a string parameter that holds the date and time information.
    @JsonKey(name: 'createdTime') String? createdTime,
    @JsonKey(name: "createdMillisecondEpoch") String? createdMillisecondEpoch,

    ///Represents the timestamp when the game trace ended. It is a string
    ///parameter that holds the date and time information.
    @JsonKey(name: 'endTime') String? endTime,
  }) = _GameTrace;

  factory GameTrace.fromJson(Map<String, Object?> json) =>
      _$GameTraceFromJson(json).copyWith(
        createdTime: DateTime.now().toString().substring(0,20),
        createdMillisecondEpoch: DateTime.now().millisecondsSinceEpoch.toString()
      );
}
