import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'result_trace.freezed.dart';

part 'result_trace.g.dart';


// ignore: slash_for_doc_comments
/**
    [MetaTrace]     [PreTrace]     [GameTrace]     *[ResultTrace]
       |             |             |             |
      \|/           \|/           \|/           \|/
       -------------------------------------------
                       [PlayTrace]
*/

@freezed
class ResultTrace with _$ResultTrace {
  const factory ResultTrace({
    /// Represents the number of clicks made to the screen during the game.
    @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
    @Default(0)
    int? clickToScreenCount,

    /// Represents the amount of time passed during the game, measured
    /// in some unit (e.g., seconds).
    @JsonKey(name: 'passedTime', defaultValue: 0)
    @Default(0)
    int? passedTime,

    /// Indicates whether the "Again" button was triggered or not.
    @JsonKey(name: 'againButtonTrigger', defaultValue: false)
    @Default(false)
    bool? againButtonTrigger,

    /// Represents the initial battery charge percentage of the phone.
    @JsonKey(name: 'phoneChargeStartPercent')
    @Default(0)
    int? phoneChargeStartPercent,

    /// Represents the final battery charge percentage of the phone.
    @JsonKey(name: 'phoneChargeEndPercent')
    @Default(0)
    int? phoneChargeEndPercent,


    /// Represents a mapping of pad IDs to their battery levels.
    @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
    @Default({})
    Map<String, double>? padBatteryMapStop,

    ///Represents the timestamp when the game trace ended. It is a string
    ///parameter that holds the date and time information.
    @JsonKey(name: 'endTime') String? endTime,
    @JsonKey(name: 'createdTime') String? createdTime,

    @JsonKey(name: "createdMillisecondEpoch") String? createdMillisecondEpoch,

  }) = _ResultTrace;

  factory ResultTrace.fromJson(Map<String, Object?> json) =>
      _$ResultTraceFromJson(json).copyWith(
          createdTime: DateTime.now().toString().substring(0,20),
          createdMillisecondEpoch: DateTime.now().millisecondsSinceEpoch.toString()
      );
}
