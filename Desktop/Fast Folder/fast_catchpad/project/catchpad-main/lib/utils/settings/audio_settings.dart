import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_settings.freezed.dart';
part 'audio_settings.g.dart';

@freezed
class AudioSettings with _$AudioSettings {
  const AudioSettings._();

  const factory AudioSettings({
    bool? isMusicEnabled,
    bool? isSoundEffectsEnabled,
  }) = _AudioSettings;

  bool get isAnyEnabled =>
      isMusicEnabled == true || isSoundEffectsEnabled == true;
  bool get isAllEnabled =>
      isMusicEnabled == true && isSoundEffectsEnabled == true;

  factory AudioSettings.fromJson(Map<String, dynamic> json) =>
      _$AudioSettingsFromJson(json);
}
