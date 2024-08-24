import 'package:audiotodo/line/db/local/locale_base.dart';
import 'package:audiotodo/line/repository/preferences_repository/preferences_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// typedef define
typedef CheckedMapPreferences = Map<String, bool>;

class PreferencesControlNotifier extends StateNotifier<CheckedMapPreferences>
    implements LocalePreferencesBase {
  PreferencesControlNotifier(CheckedMapPreferences state) : super({});

  final _localePreferencesRepository = PreferencesRepository();

  void changState(Map<String, bool> val) => state = val;

  @override
  Future<bool> checkShowCaseIsSeen(WidgetRef ref, String key) async {
    final isSeen =
        await _localePreferencesRepository.checkShowCaseIsSeen(ref, key);

    //Update the current state
    state.update(key, (_) => isSeen, ifAbsent: () => isSeen);

    return state[key]!;
  }

  @override
  Future<bool> showCaseIsSeenSetTrue(WidgetRef ref, String key) async {
    return await _localePreferencesRepository.showCaseIsSeenSetTrue(ref, key);
  }

  @override
  Future<bool> deleteShowCaseIsSeen(WidgetRef ref, String key) async {
    return await _localePreferencesRepository.deleteShowCaseIsSeen(ref, key);
  }
}
