import 'package:flutter/material.dart';

class SupportedLocales {
  static const Iterable<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('es'),
    Locale('de'),
    Locale('fr'),
    Locale('el'),
    Locale('et'),
    Locale('nb'),
    Locale('nn'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('hi'),
    Locale('ne'),
    Locale('uk'),
    Locale('hr'),
    Locale('tr'),
    Locale('lv'),
    Locale('lt'),
    Locale('ku'),
    Locale('nl'),
    Locale('it'),
    Locale('ko'),
    Locale('ja'),
    Locale('id'),
    Locale('cs'),
    Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
    Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
  ];
}
