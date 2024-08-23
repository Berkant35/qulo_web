import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/lang_model.dart';
import '../utils.dart';
import 'audio_settings.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  static const _appSettingsKey = 'app_settings';

  const AppSettings._();

  const factory AppSettings({
    @Default(true)
        bool firstEntering,
    @Default(false)
        bool registered,
    LanguageModel? language,
    @Default(
      AudioSettings(
        isMusicEnabled: true,
        isSoundEffectsEnabled: true,
      ),
    )
        AudioSettings audioSettings,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  static Future<AppSettings> init() async {
    final prefs = await SharedPreferences.getInstance();
    final set = prefs.getString(_appSettingsKey);
    AppSettings ret;

    if (set == null) {
      ret = const AppSettings();
    } else {
      final jsn = json.decode(set);
      ret = AppSettings.fromJson(jsn);
    }

    ret = ret.copyWith(
      firstEntering: AppSettingsToggles.welcome && ret.firstEntering,
      registered: !AppSettingsToggles.auth || ret.registered,
    );
    return ret;
  }

  Future<bool> store() async {
    final prefs = await SharedPreferences.getInstance();

    final jsn = toJson();
    final enc = json.encode(jsn);

    final setStr = prefs.setString(_appSettingsKey, enc);
    return setStr;
  }
}
