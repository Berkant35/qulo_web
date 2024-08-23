import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../models/lang_model.dart';
import '../utils/settings/app_settings.dart';

final firstEnteringProv = StateProvider<bool>(
  (ref) => ref.watch(appSettingsProv).firstEntering,
);

final registeredProv = StateProvider<bool>(
  (ref) => ref.watch(appSettingsProv).registered,
);

final appSettingsProv =
    StateNotifierProvider<_AppSettingsNotifier, AppSettings>(
  (ref) => _AppSettingsNotifier(mainScreenInitSettings),
);

class _AppSettingsNotifier extends StateNotifier<AppSettings> {
  _AppSettingsNotifier(AppSettings state) : super(state);

  Future<bool> applyChange() async {
    return await state.store();
  }

  Future<bool> _setState(AppSettings s) async {
    state = s;
    return await applyChange();
  }

  Future<bool> setRegisterd(bool r) async {
    final newS = state.copyWith(registered: r);

    return await _setState(newS);
  }

  Future<bool> setFirstEntering(bool f) async {
    final newS = state.copyWith(firstEntering: f);

    return await _setState(newS);
  }

  Future<bool> setLanguage(LanguageModel lang) async {
    final newS = state.copyWith(language: lang);

    return await _setState(newS);
  }
}
