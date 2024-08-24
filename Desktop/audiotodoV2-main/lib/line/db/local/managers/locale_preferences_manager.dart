import 'package:audiotodo/line/db/local/locale_base.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/meet/box_keys_hive.dart';
import 'package:audiotodo/utilities/constants/exceptions/application_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocalePreferencesManager implements LocalePreferencesBase{
  //Show Case Manager Methods

  /// Set the show case is seen
  @override
  Future<bool> showCaseIsSeenSetTrue(WidgetRef ref, String key) async {
    try {
      await Hive.openBox(BoxHiveKeys.showCase.name);
      await Hive.box(BoxHiveKeys.showCase.name).put(key, true);
      assert(Hive.box(BoxHiveKeys.showCase.name).get(key) == true);
      return true;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref);
      return false;
    }
  }
  /// Check the show case is seen
  @override
  Future<bool> checkShowCaseIsSeen(WidgetRef ref, String key) async {
    try {

      final res = await Hive.openBox(BoxHiveKeys.showCase.name);
      //check if the key is exist
      if (Hive.box(BoxHiveKeys.showCase.name).containsKey(key)) {
        final res = Hive.box(BoxHiveKeys.showCase.name).get(key);
        return res;
      } else {
        return false;
      }
    } catch (e) {
      logger.e("checkShowCaseIsSeen $e");
      ApplicationExceptions.handleRecordException(e.toString(), ref);
      return false;
    }
  }



  @override
  Future<bool> deleteShowCaseIsSeen(WidgetRef ref, String key) async {
    try {
      if (Hive.box(BoxHiveKeys.showCase.name).containsKey(key)) {
        await Hive.box(BoxHiveKeys.showCase.name).put(key, false);
        await Hive.box(BoxHiveKeys.showCase.name).delete(key);
      }
      return true;
    } catch (e) {
      ApplicationExceptions.handleRecordException(e.toString(), ref,title: "Delete Show Case Is Seen Error");
      return false;
    }
  }
}
