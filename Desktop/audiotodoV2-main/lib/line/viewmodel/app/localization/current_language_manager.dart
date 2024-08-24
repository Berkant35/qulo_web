import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/db/local/locale_base.dart';
import 'package:audiotodo/line/repository/preferences_repository/language_repository.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/app/application_constants.dart';
import 'package:audiotodo/utilities/constants/exceptions/application_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CurrentLanguageManagerNotifier extends StateNotifier<LocaleName?>
    implements LocaleLanguageBase {
  CurrentLanguageManagerNotifier(LocaleName? state) : super(null);
  final _localeLanguageRepository = LocaleLanguageRepository();
  List<LocaleName> currentLocales = [];

  Future<void> changeLocalLanguage(
    Locale locale,
    WidgetRef ref,
  ) async {
    await S.load(locale);
    await updateChoosedApplicationLanguage(ref, locale.languageCode);
  }

  Future<void> changeRecognitionLanguage(LocaleName locale,WidgetRef ref) async {
    state = locale;
    updateChoosedLocaleName(ref, locale);
  }

  Future<void> initializeCurrentRecognitionLanguage(WidgetRef ref) async {

    final result = await getChoosedLocaleName(ref);

    await ref
        .read(currentSpeechToTextManager.notifier)
        .getLocales(ref)
        .then((locales) {
      currentLocales = locales;

      if (result != null) {
        state = result;
      } else {
        for (var locale in currentLocales) {
          if (locale.localeId.contains(S.current.language_code)) {
            state = locale;
            updateChoosedLocaleName(ref, locale);
          }
        }
      }
    });


  }

  @override
  Future<Locale?> getChoosedApplicationLanguage(WidgetRef ref) async {
    final locale =
        await _localeLanguageRepository.getChoosedApplicationLanguage(ref);

    try {
      if (locale != null) {
        changeLocalLanguage(locale, ref);
      }
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,
          title: ErrorTexts.errorGetApplicationLanguageFromLocaleFailed);
    }

    return locale;
  }

  @override
  Future<bool> updateChoosedApplicationLanguage(
      WidgetRef ref, String localeId) async {
    try {
      final result = await _localeLanguageRepository
          .updateChoosedApplicationLanguage(ref, localeId);
      return result;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,
          title: ErrorTexts.errorUpdateApplicationLanguageFromLocaleFailed);
      return false;
    }
  }

  @override
  Future<bool> deleteChoosedLocaleName(WidgetRef ref) {
    // TODO: implement deleteChoosedLocaleName
    throw UnimplementedError();
  }

  @override
  Future<LocaleName?> getChoosedLocaleName(WidgetRef ref) async {
    try {
      final localeName =
          await _localeLanguageRepository.getChoosedLocaleName(ref);
      if (localeName != null) state = localeName;
      return localeName;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,
          title: ErrorTexts.errorUpdateChoosedLocaleNameFromLocaleFailed);
      return null;
    }
  }

  @override
  Future<bool> updateChoosedLocaleName(
      WidgetRef ref, LocaleName localeName) async {
    try {
      final result = await _localeLanguageRepository.updateChoosedLocaleName(
          ref, localeName);
      if (result) state = localeName;
      return result;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,
          title: ErrorTexts.errorUpdateChoosedLocaleNameFromLocaleFailed);
      return false;
    }
  }

  @override
  // TODO: implement hive
  HiveInterface get hive => throw UnimplementedError();
}
