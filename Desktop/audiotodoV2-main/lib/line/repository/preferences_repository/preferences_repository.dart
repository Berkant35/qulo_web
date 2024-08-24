


import 'package:audiotodo/line/db/local/locale_base.dart';
import 'package:audiotodo/line/db/local/managers/locale_preferences_manager.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:hive/hive.dart';

class PreferencesRepository extends LocalePreferencesBase {
  final _localePreferencesManager = LocalePreferencesManager();

  @override
  Future<bool> checkShowCaseIsSeen(WidgetRef ref, String key) async {
     return await _localePreferencesManager.checkShowCaseIsSeen(ref, key);
  }


  @override
  Future<bool> showCaseIsSeenSetTrue(WidgetRef ref, String key) async {
     return await _localePreferencesManager.showCaseIsSeenSetTrue(ref, key);
  }

  @override
  Future<bool> deleteShowCaseIsSeen(WidgetRef ref, String key) async {
    return await _localePreferencesManager.deleteShowCaseIsSeen(ref, key);

  }

}