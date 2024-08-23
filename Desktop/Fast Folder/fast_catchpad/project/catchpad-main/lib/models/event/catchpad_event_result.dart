

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'catchpad_event_result.freezed.dart';
part 'catchpad_event_result.g.dart';

@freezed
class CatchpadEventResult with _$CatchpadEventResult {
  const factory CatchpadEventResult({
    @JsonKey(name: 'eventId') String? eventId,
    @JsonKey(name: 'gameId') String? gameId,
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'userFullName') String? userFullName,
    @JsonKey(name: 'userPrimaryScore') double? userPrimaryScore,
    @JsonKey(name: 'userSecondaryScore') int? userSecondaryScore,
  }) = _CatchpadEventResult;

  factory CatchpadEventResult.fromJson(Map<String, Object?> json) =>
      _$CatchpadEventResultFromJson(json);
}
