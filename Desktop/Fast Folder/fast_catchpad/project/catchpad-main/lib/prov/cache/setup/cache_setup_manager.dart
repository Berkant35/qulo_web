import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/models/game/static_game_setup_model.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/game/game_drop_options_model.dart';
import '../../game/curr_game_prov.dart';

///This provider will allow us to set up the structure that will ensure that
///the game settings are not adjusted repeatedly and remain in their final form.

class CacheSetupManager extends StateNotifier<Map<String, dynamic>> {
  CacheSetupManager(Map<String, dynamic> state) : super({});

  late SharedPreferences _curPref;

  Future<void> initialize(WidgetRef ref, String? gameId) async {
    _curPref = await SharedPreferences.getInstance();

    _curPref.getKeys().forEach((perKey) {
      final val = _curPref.get(perKey);
      print("perKey: $perKey, val: $val");
      state.addAll({perKey: val});
      StaticGameSetupModel staticGameSetupModel;
      final setup = ref.watch(currentGameSetupProv);
      if (gameId != null) {
        final isGameIdEqual = isEqualGameId(codedKey: perKey, gameId: gameId);
        print("gameID: $gameId -> $isGameIdEqual");
        if (perKey.contains("gameDuration") && setup != null && isGameIdEqual) {
          staticGameSetupModel = setup.copyWith(
              duration: setup.duration!.copyWith(def: val as int));
          print("gameDuration: $val");
          ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
        } else if (perKey.contains("radius") &&
            setup != null &&
            isGameIdEqual) {
          staticGameSetupModel =
              setup.copyWith(radius: setup.radius?.copyWith(def: val as int));
          ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
        } else if (perKey.contains("vibrationRadius") &&
            setup != null &&
            isGameIdEqual) {
          staticGameSetupModel = setup.copyWith(
              vibrationActiveDegree:
                  setup.vibrationActiveDegree?.copyWith(def: val as int));
          ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
        } else if (perKey.contains("distance") &&
            setup != null &&
            isGameIdEqual) {
          if (setup.distance == null ||
              val == null ||
              val.runtimeType != int ||
              setup.distance!.max < (val as int) ||
              setup.distance!.min > val) return;

          staticGameSetupModel =
              setup.copyWith(distance: setup.distance?.copyWith(def: val));

          ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
        }
      }
    });
  }

  bool isEqualGameId({required String codedKey, required String gameId}) {
    // codedKey -> perKey: gameDuration/s1, val: 25
    RegExp regExp = RegExp(r'[^/]+$');
    // Find the first match
    Match? match = regExp.firstMatch(codedKey);
    if (match != null) {
      // Extract the matched part
      String result = match.group(0)!;
      bool finalResult = result == gameId ? true : false;
      return finalResult;
    } else {
      print('No match found');
      return false;
    }
  }

  void setSensorCache(WidgetRef ref,
          {required String whichSetupKey,
          required String gameId,
          required UsedSensorsType val}) =>
      _curPref.setString(whichSetupKey + seperatorKey() + gameId, val.name);

  void setCustomDropOption(WidgetRef ref,
          {required String whichCustomDropOption,
          required String gameId,
          required DropOption val}) =>
      _curPref.setString(
          whichCustomDropOption + seperatorKey() + gameId, val.optionTitle);

  Future<String?> getCustomDropOptionTitle(WidgetRef ref,
          {required String whichCustomDropOption,
          required String gameId}) async =>
      _curPref.getString(whichCustomDropOption + seperatorKey() + gameId);

  Future<UsedSensorsType?> getSensor(WidgetRef ref,
      {required String whichSetupKey, required String gameId}) async {
    await initialize(ref, gameId);
    final sensorTypeText =
        _curPref.getString(whichSetupKey + seperatorKey() + gameId);
    final curSetup = ref.read(currentGameSetupProv);
    final list = curSetup!.sensorTypes.entries.map((e) => e.key).toList();

    final sensorType = getUsedSensorTypeFromString(sensorTypeText);

    if (sensorType != null && sensorTypeText != null) {
      final newSetup =
          curSetup.copyWith(chosedSensorIndex: list.indexOf(sensorType));

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }
    return sensorType;
  }

  UsedSensorsType? getUsedSensorTypeFromString(String? sensorTypeText) {
    switch (sensorTypeText) {
      case "none":
        return UsedSensorsType.none;
      case "motion":
        return UsedSensorsType.motion;
      case "force":
        return UsedSensorsType.force;
      case "distance":
        return UsedSensorsType.distance;
      case "tap":
        return UsedSensorsType.tap;
      default:
        return null;
    }
  }

  void setCacheSelectedColorValue(WidgetRef ref,
      {required String playerId,
      required Set<Color> colors,
      required String gameId}) {
    try {
      final colorsValueList = colors.map((e) => e.value.toString()).toList();
      _curPref.setStringList(
          gameId + seperatorKey() + playerId, colorsValueList);
      state.addAll({playerId + seperatorKey() + gameId: colors});
    } catch (e) {
      logger.e("Set Cache Color Value To Locale Error: $e");
    }
  }

/*
  This code defines a function called `getCacheSelectedColorValue` that takes in
  four parameters: `WidgetRef ref`, `String playerId`, `String gameId`, and
 `Function(Set<Color>? colors) setVal`. The function retrieves a list of color
 values from a cache using the `getStringList` method of a `_curPref` object.
  If the list is null, the function returns null. If the list is not null,
  the function creates a new `Set<Color>` object called `colorSetList` and
  iterates through each color value in the list. For each color value, the
  function converts it from a string to a `Color` object and adds it to the
  `colorSetList`. The function then adds the `colorSetList` to a state map
  with a key that combines the `playerId`, `seperatorKey()`, and `gameId`.
  Finally, the function calls the `setVal` function with the `colorSetList`
   as an argument and returns the `colorSetList`. If an error occurs during
   the execution of the function, the function logs an error message and
   returns null.*/
  Set<Color>? getCacheSelectedColorValue(WidgetRef ref,
      {required String playerId,
      required String gameId,
      required Function(Set<Color>? colors) setVal}) {
    try {
      final resColorList =
          _curPref.getStringList(gameId + seperatorKey() + playerId);

      if (resColorList == null) return null;
      Set<Color>? colorSetList = {};

      for (var perColorValueString in resColorList) {
        int valueOfColor = int.parse(perColorValueString);
        Color perColor = Color(valueOfColor);
        colorSetList.add(perColor);
      }
      state.addAll({playerId + seperatorKey() + gameId: colorSetList});
      setVal(colorSetList);
      return colorSetList;
    } catch (e) {
      logger.e("Get Cache Color Value From Locale Error: $e");
      return null;
    }
  }

  String seperatorKey() => '/';

  void setCacheAnyValue(WidgetRef ref,
      {required String whichSetupKey,
      required dynamic val,
      required String gameId}) {
    try {
      //For performance
      switch (val.runtimeType) {
        case int:
          _curPref.setInt(whichSetupKey + seperatorKey() + gameId, val);
          break;
        case double:
          _curPref.setDouble(whichSetupKey + seperatorKey() + gameId, val);
          break;
        case bool:
          _curPref.setBool(whichSetupKey + seperatorKey() + gameId, val);
          break;
        case String:
          _curPref.setString(whichSetupKey + seperatorKey() + gameId, val);
          break;
        default:
          break;
      }
    } catch (e) {
      logger.e(e);
    }
    final temp = Map<String, dynamic>.from(state);
    temp.addAll({whichSetupKey + seperatorKey() + gameId: val});
    state = temp;
  }

  dynamic getPerValue(WidgetRef ref,
      {required String whichSetupKey,
      required String typeOfVal,
      required CacheSetupKeys cacheEnum,
      required String gameId,
      required Function(dynamic val) setVal}) {
    try {
      var dynamicValue;

      //For performance
      switch (typeOfVal) {
        case "int":
          dynamicValue =
              _curPref.getInt(whichSetupKey + seperatorKey() + gameId);
          break;
        case "double":
          dynamicValue =
              _curPref.getDouble(whichSetupKey + seperatorKey() + gameId);
          break;
        case "bool":
          dynamicValue =
              _curPref.getBool(whichSetupKey + seperatorKey() + gameId);
          break;
        case "String":
          dynamicValue =
              _curPref.getString(whichSetupKey + seperatorKey() + gameId);
        default:
          dynamicValue = null;
          break;
      }

      // It'll stop us from having to do the caching every other time.
      state.addAll({whichSetupKey + seperatorKey() + gameId: dynamicValue});

      if (dynamicValue != null) {
        StaticGameSetupModel staticGameSetupModel;
        final setup = ref.watch(currentGameSetupProv);

        switch (cacheEnum) {
          case CacheSetupKeys.gameDuration:
            staticGameSetupModel = setup!.copyWith(
                duration: setup.duration!.copyWith(def: dynamicValue));
            ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
          case CacheSetupKeys.distance:
            staticGameSetupModel = setup!.copyWith(
                distance: setup.distance!.copyWith(def: dynamicValue));
            ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
          case CacheSetupKeys.delay:
            staticGameSetupModel = setup!
                .copyWith(delay: setup.delay!.copyWith(def: dynamicValue));
            ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
          case CacheSetupKeys.timeout:
            staticGameSetupModel = setup!
                .copyWith(timeout: setup.timeout!.copyWith(def: dynamicValue));
            ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
          case CacheSetupKeys.radius:
            staticGameSetupModel = setup!
                .copyWith(radius: setup.radius!.copyWith(def: dynamicValue));
            ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
          case CacheSetupKeys.sensitivity:
            staticGameSetupModel = setup!.copyWith(
                accConfig: setup.accConfig?.copyWith(
              threshold: dynamicValue.toInt(),
            ));
            dynamicValue = dynamicValue.toInt();
            ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);
          case CacheSetupKeys.vibrationRadius:
            staticGameSetupModel = setup!.copyWith(
                vibrationActiveDegree:
                    setup.vibrationActiveDegree!.copyWith(def: dynamicValue));
            ref.read(currentGameProv.notifier).setSetup(staticGameSetupModel);

          ///Todos
          case CacheSetupKeys.periodicOnOff:
          case CacheSetupKeys.autoStartOnOff:
          case CacheSetupKeys.effectOnOff:
          case CacheSetupKeys.sensor:
          case CacheSetupKeys.buzzerOn:
          case CacheSetupKeys.vibrationOnOff:
            return;

          case CacheSetupKeys.dropOption:
            ref.read(currentDropOptionManager.notifier).changState(
                DropOption(optionTitle: dynamicValue, optionValue: null));
        }
        setVal(dynamicValue);
      }

      return dynamicValue;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  void delete(WidgetRef ref, {required String whichSetupKey}) {
    _curPref.remove(whichSetupKey);
  }
}
