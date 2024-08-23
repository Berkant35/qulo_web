import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'meta_trace.freezed.dart';

part 'meta_trace.g.dart';



/*
    *MetaTrace     PreTrace     GameTrace     ResultTrace
       |             |             |             |
      \|/           \|/           \|/           \|/
       -------------------------------------------
                       PlayTrace
*/


@freezed
class MetaTrace with _$MetaTrace {
  const factory MetaTrace({
    /// Represents the unique identifier for the game trace.
    @JsonKey(name: 'traceID')
    String? traceID,

    /// Represents the unique identifier for the user associated with the game trace.
    @JsonKey(name: 'userID')
    String? userID,

    /// Represents the unique identifier for the game associated with the trace.
    @JsonKey(name: 'gameID')
    String? gameID,

    /// Represents the operating system (OS) on which the game was played.
    @JsonKey(name: 'os')
    String? os,

    /// Represents the model of the phone used to play the game.
    @JsonKey(name: 'phoneModel')
    String? phoneModel,

    /// Represents the MAC address of the phone used to play the game.
    @JsonKey(name: 'phoneMacID')
    String? phoneMacID,

    @JsonKey(name: 'manufacturer')
    String? manufacturer,

    @JsonKey(name: 'cpuType')
    String? cpuType,

    @JsonKey(name: 'platformVersion')
    String? platformVersion,

    @JsonKey(name: 'imeiNo')
    String? imeiNo,

    @JsonKey(name: 'apiLevel')
    String? apiLevel,

    @JsonKey(name: 'deviceName')
    String? deviceName,

    @JsonKey(name: 'productName')
    String? productName,

    @JsonKey(name: 'hardware')
    String? hardware,

    /// Represents the timestamp when the game trace was created.
    @JsonKey(name: 'createdTime') String? createdTime,

    @JsonKey(name: "millisecondEpoch") String? createdMillisecondEpoch,

    String? createdAt,

  }) = _MetaTrace;

  factory MetaTrace.fromJson(Map<String, Object?> json) =>
      _$MetaTraceFromJson(json).copyWith(
        createdAt: DateTime.now().toString().substring(0,20),
        createdTime: DateTime.now().toIso8601String(),
        createdMillisecondEpoch: DateTime.now().millisecondsSinceEpoch.toString()
      );
}
