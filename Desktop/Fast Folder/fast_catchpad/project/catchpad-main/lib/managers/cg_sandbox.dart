import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/models/beep_model.dart';
import 'package:catchpad/models/enums/game/game_badge_types.dart';
import 'package:catchpad/models/feedback/traces/ble/command_time_tracker.dart';

import 'package:catchpad/models/game/game_drop_options_model.dart';


import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/emb/iga/iga_background_ble.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/hold_steady_prov.dart';
import 'package:catchpad/prov/sticker_match_provider.dart';
import 'package:catchpad/ui/device/debug/dev_debug_options.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/widgets/game/stroop_test_widget.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:streamer/streamer.dart';
import 'package:xrandom/xrandom.dart';

import '../models/device/device_shuffler.dart';
import '../models/enums/game/challenge_type.dart';
import '../models/enums/game/education_type.dart';
import '../models/enums/game/game_end_type.dart';
import '../models/enums/game/stroop_modes.dart';
import '../models/game/attachment/attachment.dart';
import '../models/game/game_controls_setup.dart';
import '../models/game/game_model.dart';
import '../models/game/player/staged_player_model.dart';
import '../models/game/static_game_model.dart';
import '../prov/effect/show_effect_prov.dart';
import '../prov/effect/vibration_prov.dart';
import '../prov/end_game_prov.dart';
import '../prov/game/curr_game_prov.dart';
import '../prov/game/game_curr_round_prov.dart';
import '../prov/game/round_prov.dart';
import '../prov/game/selected_players_prov.dart';
import '../prov/game_result_prov.dart';
import '../prov/quiz_provider.dart';
import '../prov/selected_item_for_education_prov.dart';
import '../ui/device/debug/hold_steady_game_model.dart';
import '../ui/game/game_screen.dart';
import '../ui/game/setup_widgets/quiz_screen_control_setup_widget.dart';
import '../ui/game/setup_widgets/show_education_game_widget.dart';
import '../ui/game/setup_widgets/sport_mentor_controls_setup_widget.dart';
import '../utils/audio_files.dart';
import '../utils/cp_colors.dart';
import '../utils/game_consts.dart';
import '../utils/game_durations.dart';
import '../utils/utils.dart';
import '../utils/widgets/game/dort_islem_widget.dart';
import '../utils/widgets/game/harf_sayi_gor_widget.dart';
import 'cp_audio_player.dart';
import 'game/custom_game_operations.dart';
import 'static_game_manager.dart';
import 'sticker_manager.dart';

abstract class CgSandbox {
  //
  // static StaticGameModel dengeTesti(WidgetRef ref) {
  //   return StaticGameModel(
  //     id: '53',
  //     onLeaderboard: true,
  //     metaData: GameMetaDataModel(
  //       id: '53',
  //       name: instForGameScreen.game_title_53,
  //       primaryScoreString:
  //       instForGameScreen.game_result_primary_score_balance_duration,
  //       description: instForGameScreen.game_description_39,
  //       imagePath: '53',
  //       playerCount: NumRange.playerCount(
  //         min: 1,
  //         max: 12,
  //       ),
  //       padCount: NumRange.padCount(
  //         min: 1,
  //         max: 12,
  //       ),
  //       duration: NumRange.duration(
  //         def: 20,
  //         min: GameDurations.normalGameDurationMin,
  //         max: GameDurations.normalGameDurationMax,
  //       ),
  //       radius: NumRange.radius(def: 5, min: 1, max: 10),
  //       tag: GameTag.balance,
  //       earnings: [
  //         GameEarning.balance,
  //       ],
  //       categories: {GameCategory.test: 6},
  //     ),
  //     setup: StaticGameSetupModel(
  //       type: GameEndType.score,
  //       // we're gonna be measuring the time each player
  //       // keeps the pad stable.
  //       scoreTypeParam1: GameScoreType.totalDuration,
  //       scoreTypeParam2: GameScoreType.none,
  //
  //       // for devices
  //       stagedPlayerModel: const StagedPlayerModel(),
  //       generalStagedPlayerModel: StagedPlayerModel.general(
  //         unavailableColors: [
  //           gameSuccessColor,
  //           gameErrorColor,
  //         ],
  //       ),
  //       sensorTypes: {
  //         UsedSensorsType.motion: false,
  //       },
  //       vibrationActivate: true,
  //       vibrationActiveDegree: NumRange.radius(def: 5, min: 1, max: 60),
  //       isPercentage: true,
  //       accConfig: const AccConfigModel(
  //         timeout: 100,
  //         threshold: 5,
  //         dataRate: DataRate.LIS2DH12_ODR_1kHz620_LP,
  //         mode: ConfigMode.LIS2DH12_HR_12bit,
  //         scale: ConfigScale.LIS2DH12_2g,
  //       ),
  //     ),
  //     execute: (ref, game) async {
  //       final players = ref.read(selectedPlayersPlayersProv);
  //       logger.w("Executor @@@@@");
  //
  //       ref.read(playerHoldStateControlProvider.notifier).initialize(ref);
  //
  //       final setup = game.setup;
  //       final mainPlayer = players.first;
  //       final devices = mainPlayer.devs;
  //       final devs = setup.getGameDevices(ref);
  //       final mainDevicesIds = devices.map((e) => e.id);
  //       final radius = game.setup.radius!.def;
  //       final vibrationRadius =
  //           ref.watch(currentGameProv)!.setup.vibrationActiveDegree?.def;
  //       final vibrationActive =
  //           ref.watch(currentVibrationDegree.notifier).state;
  //
  //
  //       // Sometimes the response time from the pad cannot be reset. This might be due to the command
  //       // sent to the pad not being received on the pad's side. Because this exercise involves a lot
  //       // of data exchange, which can cause issues in sending some commands. Consequently, it might
  //       // accumulate response time consecutively as if it stayed balanced at the end of the game.
  //       // To prevent this, we will keep our own stopwatch. If the difference exceeds a certain
  //       // threshold, we will use our stopwatch data to add the elapsed time as the score.
  //
  //       final myChronometer = Stopwatch();
  //
  //
  //       bool isVibrationNow = false;
  //
  //       Map<String, DeviceModel> devsMap = {
  //         for (final player in players) player.id: player.devs.first
  //       };
  //
  //       Map<String, DeviceModel> devMap = {for (final dev in devs) dev.id: dev};
  //
  //       HoldSteadyGameModel? gameModel;
  //
  //       // HOW WILL THIS WORK
  //       // the strategy we're gonna follow is to send a command once all
  //       // the pads are steady, and save the response time once one of them
  //       // is not steady anymore. this way at the end of the game we'll end
  //       // up with the longest time the player stayed in the zone.
  //       // as we're sending the command time at the same time to all the pads,
  //       // getting the response time from any is fine.
  //
  //       Map<String, Set<Direction>> lastDirections = {};
  //       Map<String, bool> lastWasSteady = {
  //         for (final devId in mainDevicesIds) devId: false,
  //       };
  //
  //       bool allAreSteady() => lastWasSteady.values.every((e) => e);
  //
  //       // we wanna stay listening to the device's angle
  //       final st = StaticGameManager.listenToMotionMulti(
  //         devs.map((e) => e.id),
  //         ref: ref,
  //       );
  //
  //       var streamer = Streamer(st);
  //
  //       final sender = SendStreamer<bool>();
  //
  //       Map<String, MotionEvent> lastEvents = {};
  //
  //       //Start my chronometer at the same time by pads.
  //       myChronometer.start();
  //
  //       for (var dev in devs) {
  //         StaticGameManager.sendIsCommand(
  //           dev.id,
  //           ref: ref,
  //         );
  //       }
  //
  //       for (final player in players) {
  //         StaticGameManager.addScorePoint(
  //           playerId: player.id,
  //           time: Duration.zero,
  //           ref: ref,
  //         );
  //       }
  //
  //       bool justforonce = true;
  //       final playerCount = players.length;
  //       var justForOnceCounter = 0;
  //
  //       Future<void> executor(WidgetRef ref) async {
  //         logger.w("Executor @@@@@");
  //         streamer.listen(
  //           onData: (event) async {
  //             final devId = event.deviceId;
  //             final dev = devMap[devId];
  //             final newDev = dev!.name.contains('V');
  //             lastEvents[devId] = event;
  //
  //             final playerid = devsMap.entries
  //                 .firstWhere((element) => element.value.id == event.deviceId);
  //
  //             gameModel = HoldSteadyGameModel.fromAcceleremetorGravityModel(
  //                 event.motion,
  //                 newDev: !newDev)
  //                 .copyWith(radius: radius!.toDouble());
  //
  //             final degree = HoldSteadyGameModel.calculateInclination(
  //                 event.motion.pitch, event.motion.roll);
  //
  //             final curPlayer =
  //             players.firstWhere((element) => element.id == playerid.key);
  //
  //             ref
  //                 .read(playerHoldStateControlProvider.notifier)
  //                 .addPlayerWithHoldStates(ref, curPlayer, gameModel!, degree);
  //
  //             // Once we receieve a steady angle from
  //             // any pad, (for the first time) we wanna
  //             // send an iscommand to all pads
  //
  //
  //
  //
  //             myChronometer.stop();
  //             final myDurationPoint = myChronometer.elapsed;
  //             final diffMyChronometerFromPadMS =
  //             myDurationPoint.compareTo(event.responseTime!).abs();
  //
  //             logger.i("Is This Ms: $diffMyChronometerFromPadMS");
  //
  //             if (justforonce) {
  //               justForOnceCounter++;
  //
  //               if (playerCount == justForOnceCounter) {
  //                 justforonce = false;
  //               }
  //
  //
  //
  //
  //               StaticGameManager.addScorePoint(
  //                 playerId: playerid.key,
  //                 time: diffMyChronometerFromPadMS > 1000 ? myDurationPoint : event.responseTime!,
  //                 ref: ref,
  //               );
  //             }
  //
  //             if (lastWasSteady[devId] == null) {
  //               StaticGameManager.addScorePoint(
  //                 playerId: playerid.key,
  //                 time: diffMyChronometerFromPadMS > 1000 ? myDurationPoint : event.responseTime!,
  //                 ref: ref,
  //               );
  //
  //               lastWasSteady[devId] = false;
  //             }
  //
  //             if (gameModel!.isSteady) {
  //               // if (isVibrationNow) {
  //               PadManager.toggleVibration(devId,
  //                   ref: ref, vibrationOn: false);
  //               //   isVibrationNow = false;
  //               // }
  //
  //               // There is a possibility that pad has been steady
  //               // before and we have sent iscommand accordingly (as we're
  //               // not recieving data ONLY when it leans or gets steady).
  //               // so we'll check if this was leaned before, which means
  //               // it was not steady and this is its first time.
  //
  //               if (lastWasSteady[devId] != true) {
  //                 // first thing we wanna do is to
  //                 // mark this pad as steady
  //
  //                 lastWasSteady[devId] = true;
  //
  //                 // now, if AND ONLY IF all the pads are steady,
  //                 // we wanna send is command to all of them.
  //                 // there may be a case where we have 4 pads,
  //                 // the first one gets from leaned to steady,
  //                 // but some other may be leaned at the moment
  //                 // and our conmdition for a command time is for
  //                 // each pad to be steady.
  //
  //                 if (lastWasSteady[devId] == true) {
  //                   myChronometer.reset();
  //                   myChronometer.start();
  //                   StaticGameManager.sendIsCommand(
  //                     devId,
  //                     ref: ref,
  //                   );
  //                 }
  //               }
  //             }
  //
  //             // Once it leans, we wanna add that response time
  //
  //             else {
  //               if (
  //               // !isVibrationNow &&
  //               vibrationActive &&
  //                   vibrationRadius != null &&
  //                   degree > vibrationRadius) {
  //                 //logger.i("Vibration Active");
  //                 await PadManager.toggleVibration(devId,
  //                     ref: ref, vibrationOn: true, val: "50")
  //                     .then((value) {
  //                   Future.delayed(const Duration(milliseconds: 2), () {
  //                     PadManager.toggleVibration(devId,
  //                         ref: ref, vibrationOn: true, val: "25");
  //                     // isVibrationNow = true;
  //                   });
  //                 });
  //               }
  //
  //               // There is a possibility that this pad has been leaned
  //               // before and we have registered its response time (as we're
  //               // not recieving data ONLY when it leans or gets steady).
  //               // so we'll check if this was steady before, which means
  //               // it was not leaned and this is its first time.
  //
  //               if (lastWasSteady[devId] == true) {
  //                 // this check should never be under because it depends on
  //                 // lastWasSteady
  //
  //                 const allSteady = true;
  //
  //                 // first thing we wanna do is to mark this one as steady.
  //
  //                 lastWasSteady[devId] = false;
  //
  //                 // a condition for this is we want to check that when this pad
  //                 // has leaned, all of the other are not leaned. so if ANY
  //                 // ONLY if all the pads are leaned and this one is not, we
  //                 // wanna add the response time.
  //
  //                 // DO NOT EVER ATTEMPT TO MOVE TO REPLACE THIS allSteady VARIABLE
  //                 // WITH THE FUNCTION CALL. we're doing the function call before
  //                 // turning this dev's state to not steady, so we can get an accurate
  //                 // result on their status then.
  //
  //                 if (allSteady) {
  //                   // and now we wanna add the response time to the logs,
  //                   // as it does not matter which pad's response time we log
  //                   // because they all recieve the iscommand at the same time.
  //                   // (maybe milliseconds off but what can u do about that)
  //
  //                   StaticGameManager.addScorePoint(
  //                     playerId: playerid.key,
  //                     time: diffMyChronometerFromPadMS > 1000 ? myDurationPoint : event.responseTime!,
  //                     ref: ref,
  //                   );
  //                   myChronometer.reset();
  //                   myChronometer.start();
  //                   StaticGameManager.sendIsCommand(
  //                     devId,
  //                     ref: ref,
  //                   );
  //                 }
  //               }
  //             }
  //
  //             // now we wanna led the relative angle.
  //             // we'll calculate our current directions
  //             // and if they are not the same as the
  //             // previous ones, we'll led the pad to
  //             // the color of the relative angle.
  //
  //                 {
  //               final dirs = gameModel!.directions;
  //
  //               final isSameDirection = setEquals(lastDirections[devId], dirs);
  //               lastDirections[devId] = dirs;
  //
  //               if (!isSameDirection) {
  //                 try {
  //                   await StaticGameManager.ledColor(
  //                     devId,
  //                     gameModel!.getColorSuccessError,
  //                     ref: ref,
  //                   );
  //                 } catch (e) {
  //                   streamer.cancel();
  //                   logger.e(e);
  //                 }
  //               }
  //             }
  //           },
  //         );
  //
  //         await streamer.done;
  //       }
  //
  //       Future<bool> disposeExecutor(WidgetRef ref) async {
  //         logger.w("Dispose Executor @@@@@");
  //         // if the game ends with the last position
  //         // of the pad steady, we wanna add the last response
  //         // time
  //
  //         if (lastEvents.isNotEmpty) {
  //           // again, all the pads are receiving the isCommand
  //           // at the same time, so we can just pick any of them.
  //           // we're picking any that has had an event. (they all will)
  //           // but idk i dont want a bug in this.
  //
  //           lastEvents.forEach((key, value) {
  //             final devId = key;
  //             final event = value;
  //
  //             final playerid = devsMap.entries
  //                 .firstWhere((element) => element.value.id == devId)
  //                 .key;
  //
  //             myChronometer.stop();
  //             final myDurationPoint = myChronometer.elapsed;
  //             final diffMyChronometerFromPadMS =
  //             myDurationPoint.compareTo(event.responseTime!).abs();
  //
  //             if (lastWasSteady[devId] != null && lastWasSteady[devId]!) {
  //
  //               StaticGameManager.addScorePoint(
  //                 playerId: playerid,
  //                 time: diffMyChronometerFromPadMS > 1000 ? myDurationPoint : event.responseTime!,
  //                 ref: ref,
  //               );
  //             }
  //           });
  //         }
  //
  //         streamer.cancel();
  //
  //         return true;
  //       }
  //
  //       await game.setup.executeGame(
  //         ref,
  //         executor,
  //         disposeCb: disposeExecutor,
  //       );
  //     },
  //   );
  // }

  static StaticGameModel dengeTesti(WidgetRef ref) {
    return StaticGameModel(
      id: '53',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '53',
        name: instForGameScreen.game_title_53,
        primaryScoreString:
        instForGameScreen.game_result_primary_score_balance_duration,
        description: instForGameScreen.game_description_39,
        imagePath: '53',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        radius: NumRange.radius(def: 5, min: 1, max: 10),
        tag: GameTag.balance,
        earnings: [
          GameEarning.balance,
        ],
        categories: {GameCategory.test: 6},
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        // we're gonna be measuring the time each player
        // keeps the pad stable.
        scoreTypeParam1: GameScoreType.totalDuration,
        scoreTypeParam2: GameScoreType.none,

        // for devices
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          unavailableColors: [
            gameSuccessColor,
            gameErrorColor,
          ],
        ),
        sensorTypes: {
          UsedSensorsType.motion: false,
        },
        vibrationActivate: true,
        vibrationActiveDegree: NumRange.radius(def: 5, min: 1, max: 60),
        isPercentage: true,
        accConfig: const AccConfigModel(
          timeout: 100,
          threshold: 5,
          dataRate: DataRate.LIS2DH12_ODR_1kHz620_LP,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          scale: ConfigScale.LIS2DH12_2g,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        logger.w("Executor @@@@@");

        ref.read(playerHoldStateControlProvider.notifier).initialize(ref);

        final setup = game.setup;
        final mainPlayer = players.first;
        final devices = mainPlayer.devs;
        final devs = setup.getGameDevices(ref);
        final mainDevicesIds = devices.map((e) => e.id);
        final radius = game.setup.radius!.def;
        final vibrationRadius =
            ref.watch(currentGameProv)!.setup.vibrationActiveDegree?.def;
        final vibrationActive =
            ref.watch(currentVibrationDegree.notifier).state;

        //      Sometimes the response time from the pad cannot be reset. This might be due to the command
        //      sent to the pad not being received on the pad's side. Because this exercise involves a lot
        //      of data exchange, which can cause issues in sending some commands. Consequently, it might
        //      accumulate response time consecutively as if it stayed balanced at the end of the game.
        //      To prevent this, we will keep our own stopwatch. If the difference exceeds a certain
        //      threshold, we will use our stopwatch data to add the elapsed time as the score.

       final myChronometer = Stopwatch();

        Map<String, DeviceModel> devsMap = {
          for (final player in players) player.id: player.devs.first
        };

        Map<String, DeviceModel> devMap = {for (final dev in devs) dev.id: dev};

        HoldSteadyGameModel? gameModel;

        // HOW WILL THIS WORK
        // the strategy we're gonna follow is to send a command once all
        // the pads are steady, and save the response time once one of them
        // is not steady anymore. this way at the end of the game we'll end
        // up with the longest time the player stayed in the zone.
        // as we're sending the command time at the same time to all the pads,
        // getting the response time from any is fine.

        Map<String, Set<Direction>> lastDirections = {};
        Map<String, bool> lastWasSteady = {
          for (final devId in mainDevicesIds) devId: false,
        };

        bool allAreSteady() => lastWasSteady.values.every((e) => e);

        // we wanna stay listening to the device's angle
        final st = StaticGameManager.listenToMotionMulti(
          devs.map((e) => e.id),
          ref: ref,
        );

        var streamer = Streamer(st);

        final sender = SendStreamer<bool>();

        Map<String, MotionEvent> lastEvents = {};

        logger.i("Send Is Command: 592");
        for (var dev in devs) {
          StaticGameManager.sendIsCommand(
            dev.id,
            ref: ref,
          );
        }

        for (final player in players) {
          StaticGameManager.addScorePoint(
            playerId: player.id,
            time: Duration.zero,
            ref: ref,
          );
        }

        bool justforonce = true;
        final playerCount = players.length;
        var justForOnceCounter = 0;

        Future<void> executor(WidgetRef ref) async {
          logger.w("Executor @@@@@");
          streamer.listen(
            onData: (event) async {
              final devId = event.deviceId;
              final dev = devMap[devId];
              final newDev = dev!.name.contains('V');
              lastEvents[devId] = event;

              final playerid = devsMap.entries
                  .firstWhere((element) => element.value.id == event.deviceId);

              gameModel = HoldSteadyGameModel.fromAcceleremetorGravityModel(
                  event.motion,
                  newDev: !newDev)
                  .copyWith(radius: radius!.toDouble());

              final degree = HoldSteadyGameModel.calculateInclination(
                  event.motion.pitch, event.motion.roll);

              final curPlayer =
              players.firstWhere((element) => element.id == playerid.key);

              ref
                  .read(playerHoldStateControlProvider.notifier)
                  .addPlayerWithHoldStates(ref, curPlayer, gameModel!, degree);

              // Once we receieve a steady angle from
              // any pad, (for the first time) we wanna
              // send an iscommand to all pads

              if (justforonce) {
                justForOnceCounter++;

                if (playerCount == justForOnceCounter) {
                  justforonce = false;
                }

                StaticGameManager.addScorePoint(
                  playerId: playerid.key,
                  time: event.responseTime!,
                  ref: ref,
                );
              }

              if (lastWasSteady[devId] == null) {
                StaticGameManager.addScorePoint(
                  playerId: playerid.key,
                  time: event.responseTime!,
                  ref: ref,
                );

                lastWasSteady[devId] = false;
              }

              if (gameModel!.isSteady) {
                // if (isVibrationNow) {
                PadManager.toggleVibration(devId,
                    ref: ref, vibrationOn: false);
                //   isVibrationNow = false;
                // }

                // There is a possibility that pad has been steady
                // before and we have sent iscommand accordingly (as we're
                // not recieving data ONLY when it leans or gets steady).
                // so we'll check if this was leaned before, which means
                // it was not steady and this is its first time.

                if (lastWasSteady[devId] != true) {
                  // first thing we wanna do is to
                  // mark this pad as steady

                  lastWasSteady[devId] = true;

                  // now, if AND ONLY IF all the pads are steady,
                  // we wanna send is command to all of them.
                  // there may be a case where we have 4 pads,
                  // the first one gets from leaned to steady,
                  // but some other may be leaned at the moment
                  // and our conmdition for a command time is for
                  // each pad to be steady.

                  if (lastWasSteady[devId] == true) {
                    logger.i("Send Is Command: 695");
                    StaticGameManager.sendIsCommand(
                      devId,
                      ref: ref,
                    );
                  }
                }
              }

              // Once it leans, we wanna add that response time

              else {
                if (
                // !isVibrationNow &&
                vibrationActive &&
                    vibrationRadius != null &&
                    degree > vibrationRadius) {
                  //logger.i("Vibration Active");
                  await PadManager.toggleVibration(devId,
                      ref: ref, vibrationOn: true, val: "50")
                      .then((value) {
                    Future.delayed(const Duration(milliseconds: 2), () {
                      PadManager.toggleVibration(devId,
                          ref: ref, vibrationOn: true, val: "25");
                      // isVibrationNow = true;
                    });
                  });
                }

                // There is a possibility that this pad has been leaned
                // before and we have registered its response time (as we're
                // not recieving data ONLY when it leans or gets steady).
                // so we'll check if this was steady before, which means
                // it was not leaned and this is its first time.

                if (lastWasSteady[devId] == true) {
                  // this check should never be under because it depends on
                  // lastWasSteady

                  const allSteady = true;

                  // first thing we wanna do is to mark this one as steady.

                  lastWasSteady[devId] = false;

                  // a condition for this is we want to check that when this pad
                  // has leaned, all of the other are not leaned. so if ANY
                  // ONLY if all the pads are leaned and this one is not, we
                  // wanna add the response time.

                  // DO NOT EVER ATTEMPT TO MOVE TO REPLACE THIS allSteady VARIABLE
                  // WITH THE FUNCTION CALL. we're doing the function call before
                  // turning this dev's state to not steady, so we can get an accurate
                  // result on their status then.

                  if (allSteady) {
                    // and now we wanna add the response time to the logs,
                    // as it does not matter which pad's response time we log
                    // because they all recieve the iscommand at the same time.
                    // (maybe milliseconds off but what can u do about that)

                    StaticGameManager.addScorePoint(
                      playerId: playerid.key,
                      time: event.responseTime!,
                      ref: ref,
                    );
                    logger.i("Send Is Command: 761");

                    StaticGameManager.sendIsCommand(
                      devId,
                      ref: ref,
                    );
                  }
                }
              }

              // now we wanna led the relative angle.
              // we'll calculate our current directions
              // and if they are not the same as the
              // previous ones, we'll led the pad to
              // the color of the relative angle.

                  {
                final dirs = gameModel!.directions;

                final isSameDirection = setEquals(lastDirections[devId], dirs);
                lastDirections[devId] = dirs;

                if (!isSameDirection) {
                  try {
                    await StaticGameManager.ledColor(
                      devId,
                      gameModel!.getColorSuccessError,
                      ref: ref,
                    );
                  } catch (e) {
                    streamer.cancel();
                    logger.e(e);
                  }
                }
              }
            },
          );

          await streamer.done;
        }

        Future<bool> disposeExecutor(WidgetRef ref) async {
          logger.w("Dispose Executor @@@@@");
          // if the game ends with the last position
          // of the pad steady, we wanna add the last response
          // time

          if (lastEvents.isNotEmpty) {
            // again, all the pads are receiving the isCommand
            // at the same time, so we can just pick any of them.
            // we're picking any that has had an event. (they all will)
            // but idk i dont want a bug in this.

            lastEvents.forEach((key, value) {
              final devId = key;
              final event = value;

              final playerid = devsMap.entries
                  .firstWhere((element) => element.value.id == devId)
                  .key;

              if (lastWasSteady[devId] != null && lastWasSteady[devId]!) {
                StaticGameManager.addScorePoint(
                  playerId: playerid,
                  time: event.responseTime!,
                  ref: ref,
                );
              }
            });
          }

          streamer.cancel();

          return true;
        }

        await game.setup.executeGame(
          ref,
          executor,
          disposeCb: disposeExecutor,
        );
      },
    );
  }

  // static StaticGameModel colorSee(WidgetRef ref) {
  //   return StaticGameModel(
  //     id: '91',
  //     onLeaderboard: false,
  //     metaData: GameMetaDataModel(
  //       id: '91',
  //       name: instForGameScreen.game_title_90,
  //       description: instForGameScreen.game_description_90,
  //       imagePath: '91',
  //       playerCount: NumRange.playerCount(
  //         min: 1,
  //         max: 1,
  //       ),
  //       padCount: NumRange.padCount(
  //         min: 2,
  //         max: 12,
  //       ),
  //       distance: NumRange.distanceCm(
  //         def: 15,
  //         min: 5,
  //         max: 150,
  //       ),
  //       duration: NumRange.duration(
  //           def: 600,
  //           min: GameDurations.normalGameDurationMin,
  //           max: GameDurations.normalGameDurationMax,
  //           step: 5),
  //       delay: NumRange.delay(def: 0, min: 0, max: 10),
  //       tag: GameTag.reflex,
  //       badgeType: GameBadgeTypes.beta,
  //       earnings: [
  //         GameEarning.reflex,
  //         GameEarning.focus,
  //       ],
  //       categories: {
  //         GameCategory.sports: 6,
  //         GameCategory.entertainment: 17,
  //       },
  //     ),
  //     setup: StaticGameSetupModel(
  //       type: GameEndType.duration,
  //       scoreTypeParam1: GameScoreType.averageDuration,
  //       scoreTypeParam2: GameScoreType.score,
  //       scoreTypeParam3: GameScoreType.totalDuration,
  //       scoreTypeParam4: GameScoreType.minDuration,
  //       scoreTypeParam5: GameScoreType.maxDuration,
  //       stagedPlayerModel: StagedPlayerModel(
  //           colorCount: NumRange.count(min: 3, max: 9),
  //           defaultSelectedColors: [
  //             gameErrorColor,
  //             gameSuccessColor,
  //             const Color.fromARGB(255, 0, 0, 255)
  //           ]),
  //       generalStagedPlayerModel: StagedPlayerModel.general(
  //         hasDevices: true,
  //       ),
  //       isContainMainBase: true,
  //       sensorTypes: {
  //         UsedSensorsType.tap: false,
  //         UsedSensorsType.distance: true,
  //       },
  //       accConfig: const AccConfigModel(
  //         scale: ConfigScale.LIS2DH12_16g,
  //         mode: ConfigMode.LIS2DH12_HR_12bit,
  //         threshold: 40,
  //         timeout: 150,
  //       ),
  //       dstConfig: const DstConfigModel(
  //         threshold: 1000,
  //         timeout: 1000,
  //       ),
  //     ),
  //     execute: (ref, game) async {
  //       final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
  //       var delay = game.setup.delay?.def;
  //       bool stopToAgain = false;
  //       final players = ref.read(selectedPlayersPlayersProv);
  //
  //       final mainPlayer = players.elementAt(0);
  //       var devs = generalPlayer.devs;
  //
  //       devs = DeviceShuffler.shuffleDevicesUniquely(devs);
  //
  //       final chosenSensor = game.setup.sensorTypes.entries
  //           .elementAt(game.setup.chosedSensorIndex)
  //           .key;
  //
  //       for (var perDev in devs) {
  //         if (chosenSensor == UsedSensorsType.distance) {
  //           PadSensorManager.lockDstThreshold(ref: ref, deviceId: perDev.id);
  //         }
  //       }
  //
  //       logger.w(devs.toList());
  //       late String correctDeviceId;
  //
  //       var mainDev = ref.read(currentMainBaseDiscoveredState);
  //       var otherDevs = devs.where((element) => element != mainDev);
  //
  //       bool firstGame = true;
  //
  //       Future<void> round(WidgetRef ref) async {
  //         Future<void> roundCycles() async {
  //           var colors = mainPlayer.clrs.toList();
  //           final indexMainColor = Random().nextInt(colors.length);
  //
  //           Map<String, Color> tempColorSet = {};
  //
  //           tempColorSet.addAll({
  //             mainDev != null ? mainDev.id : generalPlayer.id:
  //             colors[indexMainColor]
  //           });
  //
  //           for (var otherPerDevice in otherDevs) {
  //             final otherColorIndex = Random().nextInt(colors.length);
  //             tempColorSet.addAll({otherPerDevice.id: colors[otherColorIndex]});
  //             colors.removeAt(otherColorIndex);
  //           }
  //
  //           final ftr = <Future>[];
  //
  //           tempColorSet.forEach((deviceId, value) {
  //             ftr.add(PadManager.ledColor(deviceId, SidesColorsModel.all(value),
  //                 ref: ref, isCommand: true));
  //           });
  //
  //           await Future.wait(ftr);
  //
  //           tempColorSet.forEach((key, value) {
  //             if (key != mainDev?.id && tempColorSet[mainDev?.id] == value) {
  //               correctDeviceId = key;
  //             }
  //           });
  //         }
  //
  //         if (firstGame) {
  //           await roundCycles();
  //           firstGame = false;
  //         }
  //
  //         var streamer = Streamer(
  //           StaticGameManager.listenToTouchMulti(
  //             devs.map((e) => e.id),
  //             ref: ref,
  //           ),
  //         );
  //
  //         var distanceStreamer = Streamer(
  //           StaticGameManager.listenToDistanceMulti(
  //             devs.map((e) => e.id),
  //             ref: ref,
  //           ),
  //         );
  //
  //         if (chosenSensor == UsedSensorsType.tap) {
  //           streamer.listen(
  //             onData: (event) async {
  //               if (event.isValid && event.deviceId == correctDeviceId) {
  //                 StaticGameManager.addScorePoint(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                   time: event.responseTime!,
  //                 );
  //
  //                 StaticGameManager.increaseScore(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                 );
  //
  //                 StaticGameManager.addFlSpot(
  //                     ref: ref,
  //                     playerId: mainPlayer.id,
  //                     spot: FlSpot(
  //                         StaticGameManager.getScore(
  //                             playerId: mainPlayer.id, ref: ref)
  //                             .toDouble(),
  //                         event.responseTime!.durationToDoubleForGraph()));
  //                 final ftr = <Future>[];
  //
  //                 ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
  //                 ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));
  //
  //                 await Future.wait(ftr);
  //                 await roundCycles();
  //                 stopToAgain = false;
  //               }
  //             },
  //           );
  //         } else {
  //           distanceStreamer.listen(
  //             onData: (event) async {
  //               if (event.isValid &&
  //                   event.deviceId == correctDeviceId &&
  //                   !stopToAgain) {
  //                 stopToAgain = true;
  //                 StaticGameManager.addScorePoint(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                   time: event.responseTime!,
  //                 );
  //
  //                 StaticGameManager.increaseScore(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                 );
  //
  //                 StaticGameManager.addFlSpot(
  //                     ref: ref,
  //                     playerId: mainPlayer.id,
  //                     spot: FlSpot(
  //                         StaticGameManager.getScore(
  //                             playerId: mainPlayer.id, ref: ref)
  //                             .toDouble(),
  //                         event.responseTime!.durationToDoubleForGraph()));
  //
  //                 final ftr = <Future>[];
  //
  //                 ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
  //                 ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));
  //
  //                 await Future.wait(ftr);
  //
  //                 await roundCycles();
  //                 stopToAgain = false;
  //               }
  //             },
  //           );
  //         }
  //
  //         await streamer.doneOr(() async => ref.watch(gameEndingProvider));
  //
  //         await distanceStreamer
  //             .doneOr(() async => ref.watch(gameEndingProvider));
  //       }
  //
  //       await game.setup.executeGame(
  //         ref,
  //         round,
  //       );
  //     },
  //   );
  // }
  //
  // static StaticGameModel colorPath(WidgetRef ref) {
  //   return StaticGameModel(
  //     id: '90',
  //     onLeaderboard: false,
  //     metaData: GameMetaDataModel(
  //       id: '90',
  //       name: instForGameScreen.game_title_90,
  //       description: instForGameScreen.game_description_90,
  //       imagePath: '90',
  //       playerCount: NumRange.playerCount(
  //         min: 1,
  //         max: 1,
  //       ),
  //       padCount: NumRange.padCount(
  //         min: 2,
  //         max: 12,
  //       ),
  //       distance: NumRange.distanceCm(
  //         def: 15,
  //         min: 5,
  //         max: 150,
  //       ),
  //       duration: NumRange.duration(
  //           def: 600,
  //           min: GameDurations.normalGameDurationMin,
  //           max: GameDurations.normalGameDurationMax,
  //           step: 5),
  //       delay: NumRange.delay(def: 0, min: 0, max: 10),
  //       tag: GameTag.reflex,
  //       badgeType: GameBadgeTypes.beta,
  //       earnings: [
  //         GameEarning.reflex,
  //         GameEarning.focus,
  //       ],
  //       categories: {
  //         GameCategory.sports: 5,
  //         GameCategory.entertainment: 16,
  //       },
  //     ),
  //     setup: StaticGameSetupModel(
  //       type: GameEndType.duration,
  //       scoreTypeParam1: GameScoreType.averageDuration,
  //       scoreTypeParam2: GameScoreType.score,
  //       scoreTypeParam3: GameScoreType.totalDuration,
  //       scoreTypeParam4: GameScoreType.minDuration,
  //       scoreTypeParam5: GameScoreType.maxDuration,
  //       stagedPlayerModel: StagedPlayerModel(
  //           colorCount: NumRange.count(min: 3, max: 9),
  //           defaultSelectedColors: [
  //             gameErrorColor,
  //             gameSuccessColor,
  //             const Color.fromARGB(255, 0, 0, 255)
  //           ]),
  //       generalStagedPlayerModel: StagedPlayerModel.general(
  //         hasDevices: true,
  //       ),
  //       isContainMainBase: true,
  //       sensorTypes: {
  //         UsedSensorsType.tap: false,
  //         UsedSensorsType.distance: true,
  //       },
  //       accConfig: const AccConfigModel(
  //         scale: ConfigScale.LIS2DH12_16g,
  //         mode: ConfigMode.LIS2DH12_HR_12bit,
  //         threshold: 40,
  //         timeout: 150,
  //       ),
  //       dstConfig: const DstConfigModel(
  //         threshold: 1000,
  //         timeout: 1000,
  //       ),
  //     ),
  //     execute: (ref, game) async {
  //       final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
  //       var delay = game.setup.delay?.def;
  //       bool stopToAgain = false;
  //       final players = ref.read(selectedPlayersPlayersProv);
  //
  //       final mainPlayer = players.elementAt(0);
  //       var devs = generalPlayer.devs;
  //
  //       devs = DeviceShuffler.shuffleDevicesUniquely(devs);
  //
  //       final chosenSensor = game.setup.sensorTypes.entries
  //           .elementAt(game.setup.chosedSensorIndex)
  //           .key;
  //
  //       for (var perDev in devs) {
  //         if (chosenSensor == UsedSensorsType.distance) {
  //           PadSensorManager.lockDstThreshold(ref: ref, deviceId: perDev.id);
  //         }
  //       }
  //
  //       logger.w(devs.toList());
  //       late String correctDeviceId;
  //
  //       var mainDev = ref.read(currentMainBaseDiscoveredState);
  //       var otherDevs = devs.where((element) => element != mainDev);
  //       bool roundTriggerFromMainDevice = false;
  //       bool firstGame = true;
  //
  //       Future<void> round(WidgetRef ref) async {
  //         roundTriggerFromMainDevice = false;
  //         Future<void> roundCycles() async {
  //           roundTriggerFromMainDevice = false;
  //           var colors = mainPlayer.clrs.toList();
  //
  //           final indexMainColor = Random().nextInt(colors.length);
  //
  //           Map<String, Color> tempColorSet = {};
  //
  //           tempColorSet.addAll({
  //             mainDev != null ? mainDev.id : generalPlayer.id:
  //             colors[indexMainColor]
  //           });
  //
  //           for (var otherPerDevice in otherDevs) {
  //             final otherColorIndex = Random().nextInt(colors.length);
  //             tempColorSet.addAll({otherPerDevice.id: colors[otherColorIndex]});
  //             colors.removeAt(otherColorIndex);
  //           }
  //
  //           final ftr = <Future>[];
  //
  //           tempColorSet.forEach((deviceId, value) {
  //             ftr.add(PadManager.ledColor(deviceId, SidesColorsModel.all(value),
  //                 ref: ref, isCommand: true));
  //           });
  //
  //           await Future.wait(ftr);
  //
  //           tempColorSet.forEach((key, value) {
  //             if (key != mainDev?.id && tempColorSet[mainDev?.id] == value) {
  //               correctDeviceId = key;
  //             }
  //           });
  //         }
  //
  //         if (firstGame) {
  //           await roundCycles();
  //           firstGame = false;
  //         }
  //
  //         var streamer = Streamer(
  //           StaticGameManager.listenToTouchMulti(
  //             devs.map((e) => e.id),
  //             ref: ref,
  //           ),
  //         );
  //
  //         var distanceStreamer = Streamer(
  //           StaticGameManager.listenToDistanceMulti(
  //             devs.map((e) => e.id),
  //             ref: ref,
  //           ),
  //         );
  //
  //         if (chosenSensor == UsedSensorsType.tap) {
  //           streamer.listen(
  //             onData: (event) async {
  //               if (!roundTriggerFromMainDevice &&
  //                   event.deviceId == mainDev!.id) {
  //                 roundTriggerFromMainDevice = true;
  //                 PadManager.ledOffNoResponse(mainDev.id, ref: ref);
  //               }
  //
  //               if (event.isValid &&
  //                   event.deviceId == correctDeviceId &&
  //                   roundTriggerFromMainDevice) {
  //                 StaticGameManager.addScorePoint(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                   time: event.responseTime!,
  //                 );
  //
  //                 StaticGameManager.increaseScore(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                 );
  //
  //                 StaticGameManager.addFlSpot(
  //                     ref: ref,
  //                     playerId: mainPlayer.id,
  //                     spot: FlSpot(
  //                         StaticGameManager.getScore(
  //                             playerId: mainPlayer.id, ref: ref)
  //                             .toDouble(),
  //                         event.responseTime!.durationToDoubleForGraph()));
  //
  //                 final ftr = <Future>[];
  //
  //                 ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
  //                 ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));
  //
  //                 await Future.wait(ftr);
  //
  //                 await roundCycles();
  //
  //                 stopToAgain = false;
  //               }
  //             },
  //           );
  //         } else {
  //           distanceStreamer.listen(
  //             onData: (event) async {
  //               if (!roundTriggerFromMainDevice &&
  //                   event.deviceId == mainDev!.id) {
  //                 roundTriggerFromMainDevice = true;
  //                 PadManager.ledOffNoResponse(mainDev.id, ref: ref);
  //               }
  //
  //               if (event.isValid &&
  //                   event.deviceId == correctDeviceId &&
  //                   !stopToAgain &&
  //                   roundTriggerFromMainDevice) {
  //                 stopToAgain = true;
  //
  //                 StaticGameManager.addScorePoint(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                   time: event.responseTime!,
  //                 );
  //
  //                 StaticGameManager.increaseScore(
  //                   ref: ref,
  //                   playerId: mainPlayer.id,
  //                 );
  //
  //                 StaticGameManager.addFlSpot(
  //                     ref: ref,
  //                     playerId: mainPlayer.id,
  //                     spot: FlSpot(
  //                         StaticGameManager.getScore(
  //                             playerId: mainPlayer.id, ref: ref)
  //                             .toDouble(),
  //                         event.responseTime!.durationToDoubleForGraph()));
  //
  //                 final ftr = <Future>[];
  //
  //                 ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
  //
  //                 ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));
  //
  //                 await Future.wait(ftr);
  //
  //                 await roundCycles();
  //
  //                 stopToAgain = false;
  //               }
  //             },
  //           );
  //         }
  //
  //         await streamer.doneOr(() async => ref.watch(gameEndingProvider));
  //
  //         await distanceStreamer
  //             .doneOr(() async => ref.watch(gameEndingProvider));
  //       }
  //
  //       await game.setup.executeGame(
  //         ref,
  //         round,
  //       );
  //     },
  //   );
  // }
}