import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/lang_model.dart';
import '../utils.dart';

class JsonAppLocalizations {
  static final JsonAppLocalizations _singleton =
      JsonAppLocalizations._internal();

  JsonAppLocalizations._internal();

  static JsonAppLocalizations get instance => _singleton;

  var _localisedValues = <String, dynamic>{};

  Future<JsonAppLocalizations> load(Locale locale) async {
    final LanguageModel _lang = LanguageModel.fromLocale(locale);

    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(L10n.selectedLanguageKey, _lang.toString());
    String jsonContent =
        await rootBundle.loadString("assets/lang/lang_${_lang.code}.json");
    _localisedValues = json.decode(jsonContent);
    Map<dynamic, dynamic>? _vls = _localisedValues;
    _localisedValues = {};
    _vls.forEach(
      (key, value) {
        _localisedValues[key.toString().toLowerCase()] = value;
      },
    );

    return this;
  }

  String text(String key) {
    final String? v = _localisedValues[key.toLowerCase()];
    assert(v != null);
    return v ?? '';
  }

  List<String> getAllKeys() {
    return _localisedValues.keys.toList();
  }
}

class JsonAppLocalizationssDelegate
    extends LocalizationsDelegate<JsonAppLocalizations> {
  const JsonAppLocalizationssDelegate();

  @override
  bool isSupported(Locale locale) =>
      L10n.allLangModels().map((e) => e.code).contains(locale.languageCode);

  static Locale? currLocale;

  @override
  Future<JsonAppLocalizations> load(Locale locale) {
    currLocale = locale;
    return JsonAppLocalizations.instance.load(locale);
  }

  @override
  bool shouldReload(JsonAppLocalizationssDelegate old) => true;
}

String getStickerTitleStr(String key) {
  final val = JsonAppLocalizations.instance.text(key);
  assert(val.isNotEmpty, 'Missing translation for $key');
  return val;
}
