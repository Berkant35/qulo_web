

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'connection_log.freezed.dart';
part 'connection_log.g.dart';

@freezed
class ConnectionLog with _$ConnectionLog {
  const factory ConnectionLog({
    @JsonKey(name: 'last_connection_time') String? lastConnectionTime,
    @JsonKey(name: 'device_id') String? macId,
    @JsonKey(name: 'device_model') String? deviceModel,
  }) = _ConnectionLog;

  factory ConnectionLog.fromJson(Map<String, Object?> json) =>
      _$ConnectionLogFromJson(json);
}
