import 'package:freezed_annotation/freezed_annotation.dart';

import 'brief_device_info.dart';

part 'per_period.freezed.dart';
part 'per_period.g.dart';

@freezed
class PerPeriod with _$PerPeriod {
  const factory PerPeriod({
    @JsonKey(name: 'devices') List<BriefDeviceInfo>? devices,
    @JsonKey(name: 'name') String? name,
  }) = _PerPeriod;

  factory PerPeriod.fromJson(Map<String, Object?> json) =>
      _$PerPeriodFromJson(json);
}
