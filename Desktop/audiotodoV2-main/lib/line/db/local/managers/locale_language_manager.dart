part of '../locale_base.dart';

class LocaleLanguageManager extends LocaleLanguageBase {


  ///This class help for setter and getter about recognition languages
  @override
  Future<Locale?> getChoosedApplicationLanguage(WidgetRef ref) async {
    final languageBox = await LocaleBase.hive.openLazyBox(BoxHiveKeys.languages.name);

    try {
      final localeId = await languageBox.get(LanguageKeys.appLanguage.name,
          defaultValue: S.current.language_code);

      final createdLocale = Locale(localeId);

      return createdLocale;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,
          title: "Get Choosed Application Language");
      return null;
    }
  }

  @override
  Future<bool> updateChoosedApplicationLanguage(
      WidgetRef ref, String localeId) async {
    final languageBox = await LocaleBase.hive.openLazyBox(BoxHiveKeys.languages.name);

    try {
      await languageBox.put(LanguageKeys.appLanguage.name, localeId);

      assert(languageBox.keys.contains(LanguageKeys.appLanguage.name));

      return true;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,
          title: "Update Choosed Application Language");
      return false;
    }
  }

  @override
  Future<bool> deleteChoosedLocaleName(WidgetRef ref) async {
    return true;
  }

  @override
  Future<LocaleName?> getChoosedLocaleName(WidgetRef ref) async {
    final languageBox = await Hive.openLazyBox(BoxHiveKeys.languages.name);

    try {
      final localeName =
          await languageBox.get(LanguageKeys.recognitionLanguageName.name);
      final localeId =
          await languageBox.get(LanguageKeys.recognitionLanguageId.name);

      return (localeName != null && localeId != null)
          ? LocaleName(localeId, localeName)
          : null;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,
          title: "Get Choosed Application Language");
      return null;
    }
  }

  @override
  Future<bool> updateChoosedLocaleName(
      WidgetRef ref, LocaleName localeName) async {

    final languageBox = await Hive.openLazyBox(BoxHiveKeys.languages.name);
    try {
      final ftr = <Future>[
        languageBox.put(
            LanguageKeys.recognitionLanguageId.name, localeName.localeId),
        languageBox.put(
            LanguageKeys.recognitionLanguageName.name, localeName.name)
      ];

      await Future.wait(ftr);

      return true;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref);
      return false;
    }
  }
}
