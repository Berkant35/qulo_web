import 'package:freezed_annotation/freezed_annotation.dart';

part 'command_time_tracker.freezed.dart';

part 'command_time_tracker.g.dart';

/// [CommandTimeTracker] is a class that tracks the time of each command sent and received.
@freezed
class CommandTimeTracker with _$CommandTimeTracker {
  const factory CommandTimeTracker({

    /// sendTime is the time when the command is sent.
    @JsonKey(name: 'senTime') @Default(0) int senTime,

    /// receiveTime is the time when the command is received.
    @JsonKey(name: 'actionOfReceiverTime') int? actionOfReceiverTime,

    /// elapsedTime is actionOfReceiverTime - senTime.
    @JsonKey(
        name: 'elapsedTime') int?  elapsedTime,

    /// turnCount is the number of turns that the command has been sent.
    @JsonKey(name: 'turnCount') @Default(0) int turnCount,

  }) = _CommandTimeTracker;

  factory CommandTimeTracker.fromJson(Map<String, Object?> json) =>
      _$CommandTimeTrackerFromJson(json);
}
