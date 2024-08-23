import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'brief_device_info.freezed.dart';
part 'brief_device_info.g.dart';

@freezed
class BriefDeviceInfo with _$BriefDeviceInfo {
  const factory BriefDeviceInfo({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'color') String? colorStr,
  }) = _BriefDeviceInfo;

  factory BriefDeviceInfo.fromJson(Map<String, Object?> json) =>
      _$BriefDeviceInfoFromJson(json);
}
