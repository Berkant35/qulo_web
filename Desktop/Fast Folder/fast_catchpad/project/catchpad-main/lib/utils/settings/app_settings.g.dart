// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppSettings _$$_AppSettingsFromJson(Map<String, dynamic> json) =>
    _$_AppSettings(
      firstEntering: json['firstEntering'] as bool? ?? true,
      registered: json['registered'] as bool? ?? false,
      language: json['language'] == null
          ? null
          : LanguageModel.fromJson(json['language'] as Map<String, dynamic>),
      audioSettings: json['audioSettings'] == null
          ? const AudioSettings(
              isMusicEnabled: true, isSoundEffectsEnabled: true)
          : AudioSettings.fromJson(
              json['audioSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AppSettingsToJson(_$_AppSettings instance) =>
    <String, dynamic>{
      'firstEntering': instance.firstEntering,
      'registered': instance.registered,
      'language': instance.language?.toJson(),
      'audioSettings': instance.audioSettings.toJson(),
    };
