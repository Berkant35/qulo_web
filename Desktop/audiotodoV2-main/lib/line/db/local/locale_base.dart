import 'dart:io';
import 'dart:ui';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_team.dart';
import 'package:audiotodo/utilities/constants/app/application_constants.dart';
import 'package:audiotodo/utilities/constants/enums/meet/box_keys_hive.dart';
import 'package:audiotodo/utilities/constants/exceptions/application_exceptions.dart';
import 'package:audiotodo/utilities/constants/exceptions/record_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:hive/src/hive_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../generated/l10n.dart';


part 'locale_manager.dart';
part 'managers/locale_language_manager.dart';



abstract class LocaleBase {
  /// Open Lazy Box And Open Box different
  /// If you need quickly get data you should use [openBox] but you not need
  /// quickly data you should [openLazyBox]. its performance good than [openBox]

  static const byteListTypeString = "Uint8List";
  // initialize the hive
  static final HiveInterface hiveInstance = Hive;
  static final hive = hiveInstance;

}

abstract class LocaleMeetBase {
  Future<bool> saveToLocalWithMeedId(File? file,String meetId,WidgetRef ref);
  Future<File?> getFileWithMeedId(String meetId,WidgetRef ref);
  Future<void> deleteMeetId(String meetId,WidgetRef ref);
  Future<void> deleteAllFiles(WidgetRef ref);
}

abstract class LocalePreferencesBase {
  Future<bool> showCaseIsSeenSetTrue(WidgetRef ref,String key);
  Future<bool> checkShowCaseIsSeen(WidgetRef ref,String key);
  Future<bool> deleteShowCaseIsSeen(WidgetRef ref,String key);
}

abstract class LocaleGptApiBase{
  Future<bool> setEndPoints(WidgetRef ref,String? endPoint);
  Future<String?> getEndPoints(WidgetRef ref);
}

abstract class LocaleLanguageBase extends LocaleBase {
  Future<Locale?> getChoosedApplicationLanguage(WidgetRef ref);
  Future<bool> updateChoosedApplicationLanguage(WidgetRef ref,String localeId);
  Future<LocaleName?> getChoosedLocaleName(WidgetRef ref);
  Future<bool> deleteChoosedLocaleName(WidgetRef ref);
  Future<bool> updateChoosedLocaleName(WidgetRef ref,LocaleName localeName);
}

abstract class ILocaleClickUpData {
  Future<List<ClickUpTeam>?> getTeamsFromClickUp(String collectionKey);
}


