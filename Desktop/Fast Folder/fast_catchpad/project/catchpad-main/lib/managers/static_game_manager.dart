import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/app_settings_prov.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/device/device_shuffler.dart';
import '../prov/game_result_prov.dart';
import '../prov/global_providers.dart';
import '../utils/game_consts.dart';
import '../utils/settings/app_settings_toggles.dart';

/// all the stuff here is to standardize the way
/// static games work so it would be way easier
/// dynamize them later.
abstract class StaticGameManager {
  static Future<bool> ledAllOffWithDelay(
      {required WidgetRef ref, List<DiscoveredDevice>? devs}) async {
    devs ??= DeviceShuffler.readDevices(ref);

    bool ret = true;
    final ftrs = [];
    for (final dev in devs) {
      ftrs.add(
              () => ledOff(dev.id, ref: ref).then((value) => ret = ret && value));
    }
    await Future.wait(
      ftrs.map((e) => e()),
    );
    Future.delayed(const Duration(microseconds: 800));
    return ret;
  }
    static Future<bool> ledAllOffNoDelay(
      {required WidgetRef ref, List<DiscoveredDevice>? devs}) async {
    devs ??= DeviceShuffler.readDevices(ref);

    bool ret = true;
    final ftrs = [];

    for (final dev in devs) {
      if(ref.context.mounted){
        ftrs.add(
                () =>
                ledOff(dev.id, ref: ref).then((value) => ret = ret && value));
      }
    }

    await Future.wait(
      ftrs.map((e) => e()),
    );
    return ret;
  }
  
  static Future<bool> toggleLight(String deviceId, {
    required WidgetRef ref,
  }) =>
      PadManager.toggleLight(
        deviceId,
        ref: ref,
      ).then((value) => restartTimer(ref, deviceId));

  static Future<bool> restartTimer(WidgetRef ref, String deviceId) async {
    ref
        .read(currentAutoDisposeTimerManager.notifier)
        .restartTimer(deviceId, ref);
    return true;
  }


  static Future<bool> ledOff(String deviceId, {

    required WidgetRef ref,
    bool isCommand = false,
  }) async {
    try{


      if(!ref.context.mounted) return false;

     return PadManager.ledOff(deviceId, ref: ref, isCommand: isCommand)
          .then((value) {
            if(ref.read(currentEmbModeManager) == 0){
              return restartTimer(ref, deviceId);
            }else{
              return true;
            }
     });
    }catch(e){
      StackTrace stackTrace = StackTrace.current;
      logger.e(e.toString() + stackTrace.toString());
      return false;
    }

  }


  static Future<bool> ledOffNoResponse(String deviceId, {
    required WidgetRef ref,
    bool isCommand = false,
  }) =>
      PadManager.ledOffNoResponse(
        deviceId,
        ref: ref,
        isCommand: isCommand,
      ).then((value) => restartTimer(ref, deviceId));

  static Future<bool> sendIsCommand(String deviceId, {
    required WidgetRef ref,

  }) async {
    ref
        .read(currentSafeSetupManager.notifier)
        .setCommandTime(DateTime
        .now()
        .millisecondsSinceEpoch
        .toDouble());

    return PadManager.sendIsCommand(deviceId, ref: ref)
        .then((value) => restartTimer(ref, deviceId));
  }


  static Future<bool> ledColor(String deviceId,
      SidesColorsModel colorModel, {
        bool isCommand = false,
        bool withResponse = false,
        required WidgetRef ref,

        /// for how long to flash the led
        /// if null, it will flash forever
        Duration? duration,
      }) async {
    return PadManager.ledColor(deviceId, colorModel,

        isCommand: isCommand,
        duration: duration,
        ref: ref,
        withResponse: withResponse)

        .then((value) => restartTimer(ref, deviceId));
  }

  static Future<bool> ledColorNoResponse(String deviceId,
      SidesColorsModel colorModel, {
        bool isCommand = false,
        required WidgetRef ref,

        /// for how long to flash the led
        /// if null, it will flash forever
        Duration? duration,
      }) async {
    return PadManager.ledColorNoResponse(
      deviceId,
      colorModel,
      ref: ref,
      isCommand: isCommand,
      duration: duration,
    ).then((value) => restartTimer(ref, deviceId));
  }

  static Future<bool> ledMultiColor(Set<String> deviceIds,
      Set<SidesColorsModel> colorModels, {
        bool isCommand = false,
        required WidgetRef ref,

        /// for how long to flash the led
        /// if null, it will flash forever
        Duration? duration,
      }) async =>
      PadManager.ledMultiColor(
        deviceIds,
        colorModels,
        isCommand: isCommand,
        duration: duration,
        ref: ref,
      );

  static Future<bool> ledColorForSightDuration(String deviceId,
      SidesColorsModel colorModel, {
        bool isCommand = false,
        required WidgetRef ref,
      }) async =>
      ledColor(
        deviceId,
        colorModel,
        isCommand: isCommand,
        duration: sightDuration,
        ref: ref,
      ).then((value) => restartTimer(ref, deviceId));

  static Future<bool> ledMultiColorForSightDuration(Set<String> deviceIds,
      Set<SidesColorsModel> colorModels, {
        bool isCommand = false,
        required WidgetRef ref,
      }) async =>
      ledMultiColor(
        deviceIds,
        colorModels,
        isCommand: isCommand,
        duration: sightDuration,
        ref: ref,
      );





  static Future<bool> ledAllOff({
    required WidgetRef ref,
  }) async {
    final devs = DeviceShuffler.readDevices(ref);

    bool ret = true;

    for (final dev in devs) {
      ret = ret &&
          await ledOff(
            dev.id,
            ref: ref,
          );
    }

    return ret;
  }

  static Stream<TouchEvent> listenToTouch(String deviceId, {
    required WidgetRef ref,
  }) =>
      PadSensorManager.listenToTouch(
        deviceId,
        ref: ref,
      );

  static Stream<TouchEvent> listenToTouchMulti(Iterable<String> deviceIds, {
    required WidgetRef ref,
  }) =>
      PadSensorManager.listenToTouchMulti(
        deviceIds,
        ref: ref,
      );

  static Stream<MotionEvent> listenToMotion(String deviceId, {
    required WidgetRef ref,
  }) =>
      PadSensorManager.listenToMotion(
        deviceId,
        ref: ref,
      );

  static Stream<MotionEvent> listenToMotionMulti(Iterable<String> deviceIds, {
    required WidgetRef ref,
  }) =>
      PadSensorManager.listenToMotionMulti(
        deviceIds,
        ref: ref,
      );

  static Stream<DistanceEvent> listenToDistance(String deviceId, {
    required WidgetRef ref,
  }) =>
      PadSensorManager.listenToDistance(
        deviceId,
        ref: ref,
      );


  static Stream<DistanceEvent> listenToDistanceMulti(Iterable<String> deviceIds,
      {
        required WidgetRef ref,
      }) =>
      PadSensorManager.listenToDistanceMulti(
        deviceIds,
        ref: ref,
      );

  @Deprecated('player.timeSpans is deprecated. use addScorePoint instead')
  static void addTimeStamp({
    required WidgetRef ref,
    required String playerId,
    required Duration time,
  }) {
    try {
      if(!ref.context.mounted) return;

      return ref.read(gameResultProv.notifier).addTimeStamp(
        playerId: playerId,
        time: time,
      );
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static void addScorePoint({
    required WidgetRef ref,
    required String playerId,
    required Duration time,
  }) {
    try {
      if(!ref.context.mounted) return;

      ref
          .read(currentSafeSetupManager.notifier)
          .setActionTime(DateTime
          .now()
          .millisecondsSinceEpoch
          .toDouble());

      ref.read(currentSafeSetupManager.notifier).isSafeDifferent(time.inMilliseconds.toDouble());


    final gameId = ref.read(currentGameProv)!.id;

    if (kDebugMode &&
    ref.read(appSettingsToggleProvider).enableEnvironmentSelection) {
    //Duration randDuration = Duration(milliseconds: Random().nextInt(120));

    return ref
        .read(gameResultProv.notifier)
        .addScorePoint(ref, playerId: playerId, time: time, gameId: gameId);
    }

    return ref
        .read(gameResultProv.notifier)
        .addScorePoint(ref, playerId: playerId, time: time, gameId: gameId);

    } catch (e) {
    logger.e(e);
    return;
    }
  }

  static void addTeamHarmonyPoint({
    required WidgetRef ref,
    required String playerId,
    required List<Duration> times,
  }) {
    try {
      times.sort();

      Duration? harmony;
      if (times.isEmpty) {
        assert(false);
        return;
      }

      if (times.length == 1) {
        assert(false);
        harmony = times.first;
      } else {
        harmony = times.last - times.first;
      }

      logger.i('addTeamHarmonyPoint: $harmony');
      return ref.read(gameResultProv.notifier).addTeamHarmonyPoint(

        ref,
        playerId: playerId,
        time: harmony,
      );

    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static void addDistance({
    required WidgetRef ref,
    required String playerId,
    required DistanceModel distance,
  }) {
    try {
      if(!ref.context.mounted) return;

      return ref.read(gameResultProv.notifier).addDistance(
        playerId: playerId,
        distance: distance,
      );
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static void increaseCatchCountWithColor({
    required WidgetRef ref,
    required String playerId,
    required String color,
    int increase = 1,
  }) {
    try {
      if(!ref.context.mounted) return;

      return ref
          .read(gameResultProv.notifier)
          .increaseCatchCountWithColor(playerId, color);
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static void resetScore({
    required WidgetRef ref,
    required String playerId,
  }) {
    try {
      if(!ref.context.mounted) return;

      return ref.read(gameResultProv.notifier).resetScore(playerId);
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static void addFlSpot({required WidgetRef ref,
    required String playerId,
    required FlSpot spot}) {
    try {
      if(!ref.context.mounted) return;

      return ref.read(gameResultProv.notifier).addFlSpot(playerId, spot);
    } catch (e) {
      logger.e('addFlSpotError$e');
      return;
    }
  }


  static void increaseScore({required WidgetRef ref,
    required String playerId,
    increase = 1,
    Duration? duration}) {

    try {
      if(!ref.context.mounted) return;

      return ref
          .read(gameResultProv.notifier)
          .increaseScore(ref, playerId, increase);
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static void decreaseScore({
    required WidgetRef ref,
    required String playerId,
  }) {
    if(!ref.context.mounted) return;
    try {

      return ref.read(gameResultProv.notifier).decreaseScore(playerId);
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static void increaseLevel({
    required WidgetRef ref,
    required String playerId,
    increase = 1,
  }) {
    try {
      if(!ref.context.mounted) return;

      return ref
          .read(gameResultProv.notifier)
          .increaseLevel(playerId, increase);
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  static int getScore({required String playerId, required WidgetRef ref}) {
    try {
      return ref.read(gameResultProv.notifier).voidGetScore(playerId) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static void decreaseLevel({
    required WidgetRef ref,
    required String playerId,
  }) {
    try {
      return ref.read(gameResultProv.notifier).decreaseLevel(playerId);
    } catch (e) {
      logger.e(e);
      return;
    }
  }

  // TODO: call this in the games
  // that implement the catch - uncatch
  // logic
  static void increaseCatch({
    required WidgetRef ref,
    required String playerId,
  }) {
    /// TODO: currently we do not
    /// have a catch count, so in order
    /// for everyone who needs to use
    /// catch later to not modify, we're
    /// just pointing this method to increaseScore
    /// and we can remove this method later and
    /// actually increment the catch count
    return increaseScore(
      ref: ref,
      playerId: playerId,
    );
  }

  static void decreaseCatch({
    required WidgetRef ref,
    required String playerId,
  }) {
    /// TODO: currently we do not
    /// have a catch count, so in order
    /// for everyone who needs to use
    /// catch later to not modify, we're
    /// just pointing this method to increaseScore
    /// and we can remove this method later and
    /// actually decrement the catch count
    return decreaseScore(
      ref: ref,
      playerId: playerId,
    );
  }

  // #region config
  static Future<void> setAccThreshold({
    required String deviceId,
    required WidgetRef ref,
    required int threshold,
  }) {
    return PadSensorManager.configAccSensor(
        deviceId: deviceId,
        ref: ref,
        model: AccConfigModel(
          threshold: threshold,
        ),
        intModel: accInterruptConfigModelWithMinusOne);
  }

  static Future<void> setAccTimeout({
    required String deviceId,
    required WidgetRef ref,
    required int timeout,
  }) {
    return PadSensorManager.configAccSensor(
        deviceId: deviceId,
        ref: ref,
        model: AccConfigModel(
          timeout: timeout,
        ),
        intModel: accInterruptConfigModelWithMinusOne);
  }

  static Future<void> setDstThreshold({
    required String deviceId,
    required WidgetRef ref,
    required int threshold,
  }) {
    return PadSensorManager.configDstSensor(
      deviceId: deviceId,
      ref: ref,
      model: DstConfigModel(
        threshold: threshold,
      ),
    );
  }

  static Future<void> setDstTimeout({
    required String deviceId,
    required WidgetRef ref,
    required int timeout,
  }) {
    return PadSensorManager.configDstSensor(
      deviceId: deviceId,
      ref: ref,
      model: DstConfigModel(
        timeout: timeout,
      ),
    );
  }
// #endregion
}
