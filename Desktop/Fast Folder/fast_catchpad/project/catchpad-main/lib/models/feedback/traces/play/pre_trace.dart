import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_trace.freezed.dart';
part 'pre_trace.g.dart';

/*
    MetaTrace     *PreTrace     GameTrace     ResultTrace
       |             |             |             |
      \|/           \|/           \|/           \|/
       -------------------------------------------
                       PlayTrace
*/

@freezed
class PreTrace with _$PreTrace {
  const factory PreTrace({
    /// Represents the number of clicks made to the screen during the game.
    @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
    @Default(0)
    int? clickToScreenCount,

    /// Represents the amount of time passed during the game, measured in some unit (e.g., seconds).
    @JsonKey(name: 'passedTime', defaultValue: 0) @Default(0) int? passedTime,

    ///Represents the timestamp when the game trace ended. It is a string
    ///parameter that holds the date and time information.
    @JsonKey(name: 'endTime') String? endTime,

    /// Represents the timestamp when the game trace was created.
    @JsonKey(name: 'createdAt') String? createdAt,

    @JsonKey(name: "createdMillisecondEpoch") String? createdMillisecondEpoch,

    /// Represents the initial battery charge percentage of the phone.
    @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
    @Default(0)
    int? phoneChargeStartPercent,

    /// Represents a list of products associated with the game trace.
    @JsonKey(name: 'padList', defaultValue: {})
    @Default({})
    Map<String, dynamic> padList,

    /// Represents the location data (latitude and longitude) associated with the game trace.
    @JsonKey(name: 'locationData') Map<String, double>? locationData,

    /// Represents a mapping of pad IDs to their battery levels.
    @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
    @Default({})
    Map<String, double>? padBatteryMapStart,

    /// Indicates whether the player has entered the game or not.
    @JsonKey(name: 'isEnterToGame', defaultValue: false)
    @Default(false)
    bool? isEnterToGame,
  }) = _PreTrace;

  factory PreTrace.fromJson(Map<String, Object?> json) =>
      _$PreTraceFromJson(json).copyWith(
          createdAt: DateTime.now().toString().substring(0, 18),
          createdMillisecondEpoch:
              DateTime.now().millisecondsSinceEpoch.toString()
      );
}
