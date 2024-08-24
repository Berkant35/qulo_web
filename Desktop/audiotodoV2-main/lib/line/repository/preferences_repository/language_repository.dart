import 'dart:ui';

import 'package:audiotodo/line/db/local/locale_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

class LocaleLanguageRepository extends LocaleLanguageBase {
  final _localeLanguageManager = LocaleLanguageManager();



  @override
  Future<Locale?> getChoosedApplicationLanguage(WidgetRef ref) async {
    return await _localeLanguageManager.getChoosedApplicationLanguage(ref);
  }

  @override
  Future<bool> updateChoosedApplicationLanguage(
      WidgetRef ref, String localeId) async {
    return await _localeLanguageManager.updateChoosedApplicationLanguage(
        ref, localeId);
  }

  @override
  Future<bool> deleteChoosedLocaleName(WidgetRef ref) {
    // TODO: implement deleteChoosedLocaleName
    throw UnimplementedError();
  }

  @override
  Future<LocaleName?> getChoosedLocaleName(WidgetRef ref) async {
    return await _localeLanguageManager.getChoosedLocaleName(ref);
  }

  @override
  Future<bool> updateChoosedLocaleName(WidgetRef ref, LocaleName localeName) async {
    return await _localeLanguageManager.updateChoosedLocaleName(ref, localeName);
  }
}
