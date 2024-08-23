
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'catchpad_event.freezed.dart';
part 'catchpad_event.g.dart';

@freezed
class CatchpadEvent with _$CatchpadEvent {
  const factory CatchpadEvent({
    @JsonKey(name: 'eventId') String? eventId,
    @JsonKey(name: 'eventCreatedAt') String? eventCreatedAt,
    @JsonKey(name: 'eventLastDate') String? eventLastDate,
    @JsonKey(name: 'eventJoinUserIdList') List<String>? eventJoinUserIdList,
    @JsonKey(name: 'eventStatus') bool? eventStatus,
    @JsonKey(name: 'eventGameId') String? eventGameId,
    @JsonKey(name: 'eventName') String? eventName,
    @JsonKey(name: 'eventGameName') String? eventGameName,
    @JsonKey(name: 'eventDescription') String? eventDescription,
  }) = _CatchpadEvent;

  factory CatchpadEvent.fromJson(Map<String, Object?> json) =>
      _$CatchpadEventFromJson(json);
}
