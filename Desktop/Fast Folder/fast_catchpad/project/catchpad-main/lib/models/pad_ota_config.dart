
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'pad_ota_config.freezed.dart';
part 'pad_ota_config.g.dart';

@freezed

class PadOtaConfig with _$PadOtaConfig {
  const factory PadOtaConfig({
    @JsonKey(name: 'currentVersionGithubLink') String? currentVersionGithubLink,
    @JsonKey(name: 'oldVersionGithubLink') String? oldVersionGithubLink,
    @JsonKey(name: 'requireUpdate') bool? requireUpdate,
    @JsonKey(name: 'version') String? version,
  }) = _PadOtaConfig;

  factory PadOtaConfig.fromJson(Map<String, Object?> json) =>
      _$PadOtaConfigFromJson(json);
}
