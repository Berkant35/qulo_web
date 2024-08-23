import 'package:catchpad/models/enums/game/challenge_type.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/current_loading_error_prov.dart';
import 'package:catchpad/prov/end_game_prov.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../managers/game/game_manager.dart';
import '../../prov/game/curr_game_prov.dart';
import '../../prov/game/game_curr_round_prov.dart';
import '../../prov/game/selected_players_prov.dart';
import '../../prov/game_result_prov.dart';
import '../../prov/global_providers.dart';
import '../../ui/game/setup_widgets/threshhold_value_setup_widget.dart';
import '../device/device_shuffler.dart';
import '../enums/game/game_end_type.dart';
import 'game_controls_setup.dart';
import 'game_drop_options_model.dart';
import 'game_model.dart';
import 'player/staged_player_model.dart';
import 'static_game_model.dart';

export 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart'
    show
    AccConfigModel,
    DeviceModel,
    DstConfigModel,
    PadSensorManager,
    AccSensorType,
    UsedSensorsType;

export '../enums/game/game_score_type.dart';

part 'static_game_setup_model.freezed.dart';

/// we dont want every model calling whatever it pleases
/// in the init, so we could easily migrate later.

typedef KeyboardValue<T> = T;

@freezed
class StaticGameSetupModel with _$StaticGameSetupModel {
  const StaticGameSetupModel._();

  /// the playerCount and padCount properties actually unnullable, but the game
  /// initializers will not initialize them. the game initializers will pass
  /// these value to the metadata, and in the StaticGameModel constructor, we
  /// call copyWithMetadata to merge these values.
  ///
  /// for now, we\'re limiting sensor count to 1, not 0, not 2, ONLY 1.
  /// why? WHY?? WHYY????
  /// well, because right now what we wanna do is to activate a single
  /// sensor at the start of the game, and disable it after it, so we
  /// do not need to activate a sensor each single time we want to use
  /// it, which can be a huge number, depending on the nature of the game.
  @Assert(
    'sensorTypes.length >=  1',
    '1, not 0, not 2, ONLY 1.',
  )
  const factory StaticGameSetupModel({
    @Default(GameControlsSetup()) GameControlsSetup controlsSetup,
    required GameEndType type,
    required GameScoreType scoreTypeParam1,
    // TODO: do processing accordingly
    required GameScoreType? scoreTypeParam2,
    GameScoreType? scoreTypeParam3,
    GameScoreType? scoreTypeParam4,
    GameScoreType? scoreTypeParam5,
    GameScoreType? scoreTypeParam6,

    /// some games will need general config
    /// and not player specific. for example,
    /// the xo game wants to have 9 pads
    /// but none assigned to the players,
    /// the catch the pad game wants to have
    /// indefinite number of pads and colors,
    /// again, none assigned to the players.
    ///
    /// should make sure to always mark
    /// hasName to false.
    StagedPlayerModel? stagedPlayerModel,
    StagedPlayerModel? generalStagedPlayerModel,
    int? roundCount,
    @Deprecated("You can use [] if you want use this "
        "attribute you must listen this value.But this parameter "
        "member of object and object killing and setting default "
        "value when close game so you can't remember last status.")
    @Default(true)
    bool doesHaveSound,
    @Default(false) bool isPercentage,
    @Default(false) bool isColorSelectOrder,
    @Default(false) bool isScore,
    @Default(false) bool isContainMainBase,

    ///When customer want same queue for all players this attribute must be true
    ///And then set queue that was saved queue
    bool? isIncludePeriodicQueue,

    ///This attribute is periodic queue that will be used in game
    @Default([]) List<DeviceModel> periodicQueue,

    ///These attributes determine how the game can be started. If this
    ///attribute is set to true, the chronometer will start automatically
    ///when the game starts. However, if this attribute is set to false,
    ///the game will only start when you move to the front pad or press the
    ///pad, and then you can start the chronometer.
    @Default(false) bool autoStart,

    /// If set to [true], this attribute activates the vibration feature within the game.
    /// When set to [false], the game will not trigger any vibration feedback.
    @Default(false) bool vibrationActivate,

    /// the values are in degrees for vibration
    NumRange? vibrationActiveDegree,

    ///This attribute determine if the chronometer will be used in the game.
    @Default(false) bool needChronometer,

    ///This attribute if we need input speacial value from keyboard
    ///and this we select which kind of keyboard run time type both number or text
    TextInputType? keyboardType,

    ///With this attribute we can get value from current keyboard input.
    KeyboardValue keyboardValue,

    /// this will be keyed by the sensor type,
    /// along with its lock value. keep false
    /// if you want the sensor to respect
    /// the threshold.
    /// btw the values of this means wether we
    /// accept conditionless flow of data AKA
    /// unlock the sensor
    required Map<UsedSensorsType, bool> sensorTypes,

    ///This parameter help select both sequential and randomly.
    Map<ChallengeType, bool>? challengeTypes,
    Map<int, String>? sequenceMap,
    @Default(0) int chosedSensorIndex,
    @Default(0) int choosedChallengeTypeIndex,
    @Default(true) bool allowSameColor,

    DstConfigModel? dstConfig,
    AccConfigModel? accConfig,

    GameDropOptionsModel? gameDropOptionsModel,

    /// this is non nullable, you can use '!' with this.
    /// see the comment above.
    NumRange? playerCount,

    /// this is non nullable, you can use '!' with this.
    /// see the comment above.
    NumRange? padCount,

    /// the values are in seconds
    NumRange? duration,

    /// the values are in seconds
    NumRange? timeout,

    /// Is there any delay between pad leds like games in formula?
    /// default delay value is 2 seconds
    NumRange? delay,

    /// the values are in milliseconds, so we have to use
    /// NumRange.distanceCm on this one as our excel values
    /// are in centimeters.
    NumRange? distance,

    /// Sensitivty for motion games
    /// assign radius value for pads
    NumRange? radius,
  }) = _StaticGameSetupModel;

  ///This help us for report about which set conditions by user.
  Map<String, dynamic> toJson() => {
    'gameEndType': type.name,
    'scoreTypeParam1': scoreTypeParam1.name,
    'scoreTypeParam2': scoreTypeParam2?.name ?? undefinedGameSetupForJson,
    'scoreTypeParam3': scoreTypeParam3?.name ?? undefinedGameSetupForJson,
    'scoreTypeParam4': scoreTypeParam4?.name ?? undefinedGameSetupForJson,
    'scoreTypeParam5': scoreTypeParam5?.name ?? undefinedGameSetupForJson,
    'scoreTypeParam6': scoreTypeParam6?.name ?? undefinedGameSetupForJson,
    'roundCount': roundCount ?? undefinedGameSetupForJson,
    'isPercentage': isPercentage,
    'isColorSelectOrder': isColorSelectOrder,
    'isScore': isScore,
    'challengeTypes': challengeTypes != null
        ? Map.fromEntries(challengeTypes!.entries
        .map((entry) => MapEntry(entry.key.name, entry.value)))
        : {},
    'sequenceMap': sequenceMap ?? undefinedGameSetupForJson,
    'playerCount': playerCount != null
        ? playerCount!.def ?? undefinedGameSetupForJson
        : undefinedGameSetupForJson,
    'padCount': padCount != null
        ? padCount!.def ?? undefinedGameSetupForJson
        : undefinedGameSetupForJson,
    'duration': duration != null
        ? duration!.def ?? undefinedGameSetupForJson
        : undefinedGameSetupForJson,
    'timeout': timeout != null
        ? timeout!.def ?? undefinedGameSetupForJson
        : undefinedGameSetupForJson,
    'delay': delay != null
        ? delay!.def ?? undefinedGameSetupForJson
        : undefinedGameSetupForJson,
    'distance': distance != null
        ? distance!.def ?? undefinedGameSetupForJson
        : undefinedGameSetupForJson,
    'radius': radius != null
        ? radius!.def ?? undefinedGameSetupForJson
        : undefinedGameSetupForJson,
    'allowSameColor': allowSameColor,
  };

  List<GameScoreType> get gameScoreTypes {
    return [
      scoreTypeParam1,
      if (scoreTypeParam2 != null) scoreTypeParam2!,
      if (scoreTypeParam3 != null) scoreTypeParam3!,
      if (scoreTypeParam4 != null) scoreTypeParam4!
    ];
  }

  StaticGameSetupModel copyWithMetadata(GameMetaDataModel meta) {
    return copyWith(
        duration: duration ?? meta.duration,
        distance: distance ?? meta.distance,
        timeout: timeout ?? meta.timeout,
        delay: delay ?? meta.delay,
        padCount: padCount ?? meta.padCount,
        playerCount: playerCount ?? meta.playerCount,
        radius: radius ?? meta.radius,
        vibrationActiveDegree: vibrationActiveDegree ?? meta.vibrationRadius);
  }

  Future<void> init({
    required GameModel game,
    required WidgetRef ref,
  }) async {
    var gameInitializeBreakPointProv =
    ref.read(currentGameInitializeBreakPoints.notifier);

    //g5-g10
    ref.read(gameResultProv.notifier).init(
        GameResultModel(
          accountHolderId: ref.read(currentUserProv)?.uid!,
          gameId: game.id,
          type: type,
          createdAt: DateTime.now(),
          scoreTypeParam1: scoreTypeParam1,
          scoreTypeParam2: scoreTypeParam2,
        ),
        ref);

    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g11, true);

    // TODO: process returning false

    // turn the debug off to all pads so we'd have a faster pads
    final players = ref.read(selectedPlayersProv).players;
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g12, true);
    final generalPlayer = ref.read(selectedGeneralPlayerProv)?.player;
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g13, true);

    final devs = [
      ...players.devices,
      if (generalPlayer?.devs != null) ...generalPlayer!.devs,
    ];
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g14, true);

    final setup = ref.read(currentGameSetupProv);
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g15, true);

    final _ftrConfigSensor = [
      activateSensor(ref, devs).timeout(const Duration(milliseconds: 500),
          onTimeout: () async {
            gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g16, true);
            return true;
          }),
      configSensor(ref, devs, game, setup!)
          .timeout(const Duration(milliseconds: 500), onTimeout: () async {
        gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g17, true);
        return true;
      })
    ];
    //When you exit any that limit one player game and then if you
    //enter multiplayer game first response times can be weird.
    //So we must refresh action and command times on pads.

    await Future.wait(_ftrConfigSensor);
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g18, true);
    // TODO Try to change ordering between these methods

    isManuallyChanged = false;
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g19, true);
  }

  MapEntry<UsedSensorsType, bool> get _usedSensorType =>
      sensorTypes.entries.elementAt(chosedSensorIndex);

  bool get anyPlayerHasName => stagedPlayerModel?.hasName == true;

  /// not all the games have to have a config, some of them will go with
  /// the general config.
  Future<bool> configSensor(WidgetRef ref, List<DiscoveredDevice> devs,
      GameModel game, StaticGameSetupModel setup) async {
    final sen = _usedSensorType;

    var res = true;
    for (var dev in devs) {
      final id = dev.id;

      switch (sen.key) {
        case UsedSensorsType.distance:
          var finalDstConfig = dstConfig ?? defDstConfigModel;
          finalDstConfig = finalDstConfig.copyWith(
              threshold: ((setup.distance?.def ?? 1000)));
          await PadSensorManager.configDstSensor(
            deviceId: id,
            ref: ref,
            model: finalDstConfig,
          );
          break;
        case UsedSensorsType.tap:
          await PadSensorManager.configAccSensor(
              deviceId: id,
              ref: ref,
              model: ((isManuallyChanged)
                  ? accConfig?.copyWith(
                  threshold: selectedThresholdValue.toInt())
                  : accConfig) ??
                  ((isManuallyChanged)
                      ? defAccConfigModel.copyWith(
                      threshold: selectedThresholdValue.toInt())
                      : defAccConfigModel),
              intModel: accInterruptConfigModelWithMinusOne);
          break;
        case UsedSensorsType.force:
          await PadSensorManager.configAccSensor(
              deviceId: dev.id,
              ref: ref,
              model: const AccConfigModel(
                threshold: defAccThreshold,
                timeout: 1000,
              ),
              intModel: accInterruptConfigModelWithMinusOne);
          break;
        case UsedSensorsType.motion:
          await PadSensorManager.configAccSensor(
              deviceId: id,
              ref: ref,
              model: accConfig ?? defAccConfigModel,
              intModel: accInterruptConfigModelWithMinusOne);
          break;
        case UsedSensorsType.none:
      }
    }

    return res;
  }

  Future<bool> activateSensor(
      WidgetRef ref, List<DiscoveredDevice> devs) async {
    final sen = _usedSensorType;
    Future<bool> Function({required WidgetRef ref, required String deviceId})
    cb;

    Future<bool> Function({required WidgetRef ref, required String deviceId})
    unlockCb;

    switch (sen.key) {
      case UsedSensorsType.distance:
        cb = PadSensorManager.activateDst;
        unlockCb = PadSensorManager.unlockDstThreshold;
        break;
      case UsedSensorsType.tap:
        cb = PadSensorManager.activateAccTap;
        unlockCb = PadSensorManager.unlockAccTapThreshold;
        break;
      case UsedSensorsType.motion:
        cb = PadSensorManager.activateAccGravity;
        unlockCb = PadSensorManager.unlockAccGravityThreshold;
        break;
      case UsedSensorsType.force:
        cb = PadSensorManager.activateAccForce;
        unlockCb = PadSensorManager.unlockAccForceThreshold;
        break;
      case UsedSensorsType.none:
        cb = ({required deviceId, required ref}) async => Future.value(true);
        unlockCb =
            ({required deviceId, required ref}) async => Future.value(true);
    }

    var res = true;

    for (var dev in devs) {
      final id = dev.id;

      /* PadSensorManager.deactivateAll(
          ref: ref, deviceId: id); */

      await cb(
        ref: ref,
        deviceId: id,
      );

      // each entry's value is wether to unlock or not.
      if (sen.value) {
        await unlockCb(
          ref: ref,
          deviceId: id,
        );
      }
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return res;
  }

  List<DeviceModel> getGameDevices(WidgetRef ref) {
    final game = ref.read(currentGameProv);

    if (game == null) {
      assert(false);
      return [];
    }

    final devs = game.allDevices;

    return devs;
  }

  // TODO: this is being called by activate and config
  // commands to activate the sensorrs before gameplay.
  // as right now this is called before initing devices,
  // we're gonna apply the settings on all devices
  // temporarily.
  // later, seperate stuff like pre-init and post-init.
  List<DeviceModel> getGameDevicesForConfig(WidgetRef ref) {
    return DeviceShuffler.readDevices(ref);
  }

  /// this method will be called by the games to run the rounds loop.
  /// games can specify `duration` to run for a certain amount of time,
  /// or `roundCount` to run a certain number of rounds. if neither is
  /// specified, the roundCount will be calculated from the staged players.
  /// the game can also specify `shouldStop` which will be called each time,
  /// and if it returns true, the game will stop.
  Future<void> executeGame(
      WidgetRef ref,
      Future<void> Function(WidgetRef ref) cb, {
        /// this is a fairly new system, we've been searching
        /// for a way for games to be able to dispose themselves
        /// at any moment https://app.clickup.com/24399144/v/dc/q8k98-1700.
        /// the proposed solution here would be to force all games to have
        /// a dispose callback in which they dispose everything they've used
        /// cancel a sensor stream listener etc. at the moment, this is only
        /// used in the tekAyak game
        /// TODO: force all games to implement this system.
        Future<bool> Function(WidgetRef ref)? disposeCb,

        /// if this is specified, we will loop the cb until this returns true
        Future<bool> Function(WidgetRef ref)? shouldStop,

        /// if this is specified, this will just be an additional condition
        /// to the roundCount or duration.
        Future<bool> Function(WidgetRef ref)? additionalStopCondition,
      }) async {
    ref.read(currentDevicesManagerProvider).forEach((key, value) {
      ref.read(currentAutoDisposeTimerManager.notifier).restartTimer(key, ref);
    });
    ref.read(gameEndingProvider.notifier).start();
    Future<bool?> dispose(WidgetRef ref) async {
      if (disposeCb != null) {
        return await disposeCb(ref);
      }

      return null;
    }

    int? rc;
    // there should be either a duration or a round count.
    // if there is not, we should get the roundCount from
    // the staged players
    if (duration != null) {
      final game = ref.read(currentGameProv);
      Duration? tempdt;
      bool hasSpecialEvent = false;

      if ((game?.id == 's16' || game?.id == 's14') &&
          ((game?.id == 's14' && duration!.duration.inSeconds == 40) ||
              (game?.id == 's16' && duration!.duration.inSeconds == 120)) &&
          adminIdList.contains(ref.read(currentUserProv)!.uid)) {
        //TODO Remove this part later this is only for events
        hasSpecialEvent = true;
        tempdt = duration!.duration;
        tempdt = const Duration(seconds: 1800);
      }
      if (hasSpecialEvent) {
        ref.read(gameDurationCountProv.notifier).setTo(tempdt!);
      } else {
        ref.read(gameDurationCountProv.notifier).setTo(duration!.duration);
      }
    } else {
      if (roundCount != null) {
        rc = roundCount;
      } else {
        final devs = getGameDevices(ref);
        rc = devs.length;
      }

      ref.read(gameRoundCountProv.notifier).setTo(rc!);
    }

    /// we should definetely be careful with the order of these calls.
    /// because `roundCount` may be initialized  with default value
    /// while also `shouldStop` exists.

    callback(WidgetRef ref) async {
      await cb(ref);
      try {
        ref.read(gameCurrRoundProv.notifier).increment();
      } catch (e) {
        logger.d('round increment error caught');
      }
    }

    if (shouldStop != null) {
      await GameManager.playWhile(
        ref: ref,
        cb: callback,
        shouldStop: shouldStop,
        additionalStopCondition: additionalStopCondition,
        disposeCb: dispose,
      );
      return;
    }

    if (duration != null) {
      await GameManager.playForDuration(
        ref: ref,
        cb: callback,
        additionalStopCondition: additionalStopCondition,
        disposeCb: dispose,
      );
      return;
    }

    if (rc != null) {
      await GameManager.playForRoundCount(
          ref: ref,
          cb: callback,
          additionalStopCondition: additionalStopCondition,
          disposeCb: dispose);
      return;
    }
  }

  bool allOptionsSelected(WidgetRef ref) {
    final a = controlsSetup.satisfiesAllConditions(ref);

    // here we're watching the provs, as we are going to be modifying the state
    // right after the build (see SelectedPlayersProvNot.updateState). and also
    // as customizations get tweaked, we need to update the state.

    final b = ref
        .watch(selectedPlayersProv)
        .allPlayersSatisfyConditionsWithWidgetRef(ref);

    final _gen = ref.watch(selectedGeneralPlayerProv);

    final c = _gen == null ||
        _gen.playerSatisfiesConditionsWithWidgetRef(ref) == true;

    //logger.i("A:$a \n B:$b \n C:$c = ${a && b && c} \n _gen == null ${_gen == null}");

    return (a && b && c);
  }
}