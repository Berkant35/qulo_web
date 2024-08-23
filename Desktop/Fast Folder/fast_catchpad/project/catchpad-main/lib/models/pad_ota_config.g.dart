// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_ota_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PadOtaConfig _$$_PadOtaConfigFromJson(Map<String, dynamic> json) =>
    _$_PadOtaConfig(
      currentVersionGithubLink: json['currentVersionGithubLink'] as String?,
      oldVersionGithubLink: json['oldVersionGithubLink'] as String?,
      requireUpdate: json['requireUpdate'] as bool?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$$_PadOtaConfigToJson(_$_PadOtaConfig instance) =>
    <String, dynamic>{
      'currentVersionGithubLink': instance.currentVersionGithubLink,
      'oldVersionGithubLink': instance.oldVersionGithubLink,
      'requireUpdate': instance.requireUpdate,
      'version': instance.version,
    };
