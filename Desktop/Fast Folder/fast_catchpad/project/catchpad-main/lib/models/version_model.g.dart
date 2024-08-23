// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VersionModel _$$_VersionModelFromJson(Map<String, dynamic> json) =>
    _$_VersionModel(
      buildNumber: json['buildNumber'] as int?,
      forceRequired: json['forceRequired'] as bool?,
      version: json['version'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$$_VersionModelToJson(_$_VersionModel instance) =>
    <String, dynamic>{
      'buildNumber': instance.buildNumber,
      'forceRequired': instance.forceRequired,
      'version': instance.version,
      'link': instance.link,
    };
