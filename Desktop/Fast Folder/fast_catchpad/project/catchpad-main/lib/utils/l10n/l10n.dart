import 'package:catchpad/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/lang_model.dart';
import '../../prov/app_settings_prov.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class L10n {
  const L10n._();

  static const selectedLanguageKey = 'selectedLanguage';

  static const _appLangs = [
    LanguageModel(
      id: '1',
      code: 'en',
      name: 'English',
      isRtl: false,
    ),
    LanguageModel(
      id: '2',
      code: 'tr',
      name: 'Türkçe',
      isRtl: false,
    ),
    LanguageModel(
      id: '3',
      code: 'es',
      name: 'Spanish',
      isRtl: false,
    ),
  ];

  static List<LanguageModel> allLangModels() {
    return _appLangs;
  }

  static List<Locale> all() {
    return allLangModels().map((e) => e.locale).toList();
  }

  static AppLocalizations inst(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

final appLangProv =
    StateNotifierProvider<AppLangProviderNotifier, LanguageModel?>(
  (ref) {
    final settings = ref.watch(appSettingsProv);
    final lang = settings.language;

    FirebaseAuth.instance.setLanguageCode(lang?.code);

    return AppLangProviderNotifier(
      lang,
      ref: ref,
    );
  },
);

class AppLangProviderNotifier extends StateNotifier<LanguageModel?> {
  final StateNotifierProviderRef ref;
  AppLangProviderNotifier(LanguageModel? lang, {required this.ref})
      : super(lang);

  Future<bool> setLanguage(LanguageModel lang) async {
    FirebaseAuth.instance.setLanguageCode(lang.code);

    return ref.read(appSettingsProv.notifier).setLanguage(lang);
  }
}
