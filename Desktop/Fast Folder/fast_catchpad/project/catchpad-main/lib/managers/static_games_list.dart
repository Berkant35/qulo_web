import 'dart:async';
import 'dart:io';
import 'dart:math';

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

StreamController<int> mystream = StreamController.broadcast();
late AppLocalizations instForGameScreen;

abstract class StaticGamesList {
  //İkiye bölme formula yarisi

  static StaticGameModel demo(WidgetRef ref) {
    return StaticGameModel(
      id: 'demo',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 'demo',
        name: "demo",
        description: "demo",
        imagePath: '19',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 150,
        ),
        duration: NumRange.duration(
            def: 600,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 1,
          GameCategory.edu: 1,
          GameCategory.entertainment: 16,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 3, max: 9),
            defaultSelectedColors: [
              gameErrorColor,
              gameSuccessColor,
              const Color.fromARGB(255, 0, 0, 255)
            ]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        isContainMainBase: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 1000,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var delay = game.setup.delay?.def;
        bool stopToAgain = false;
        final players = ref.read(selectedPlayersPlayersProv);

        final mainPlayer = players.elementAt(0);
        var devs = generalPlayer.devs;

        devs = DeviceShuffler.shuffleDevicesUniquely(devs);

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        for (var perDev in devs) {
          if (chosenSensor == UsedSensorsType.distance) {
            PadSensorManager.lockDstThreshold(ref: ref, deviceId: perDev.id);
          }
        }

        logger.w(devs.toList());
        late String correctDeviceId;

        var mainDev = ref.read(currentMainBaseDiscoveredState);
        var otherDevs = devs.where((element) => element != mainDev);

        bool firstGame = true;

        Future<void> round(WidgetRef ref) async {
          Future<void> roundCycles() async {
            var colors = mainPlayer.clrs.toList();
            final indexMainColor = Random().nextInt(colors.length);

            Map<String, Color> tempColorSet = {};

            tempColorSet.addAll({
              mainDev != null ? mainDev.id : generalPlayer.id:
                  colors[indexMainColor]
            });

            for (var otherPerDevice in otherDevs) {
              final otherColorIndex = Random().nextInt(colors.length);
              tempColorSet.addAll({otherPerDevice.id: colors[otherColorIndex]});
              colors.removeAt(otherColorIndex);
            }

            final ftr = <Future>[];

            tempColorSet.forEach((deviceId, value) {
              ftr.add(PadManager.ledColor(deviceId, SidesColorsModel.all(value),
                  ref: ref, isCommand: true));
            });

            await Future.wait(ftr);

            tempColorSet.forEach((key, value) {
              if (key != mainDev?.id && tempColorSet[mainDev?.id] == value) {
                correctDeviceId = key;
              }
            });
          }

          if (firstGame) {
            await roundCycles();
            firstGame = false;
          }

          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          var distanceStreamer = Streamer(
            StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          if (chosenSensor == UsedSensorsType.tap) {
            streamer.listen(
              onData: (event) async {
                if (event.isValid && event.deviceId == correctDeviceId) {
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);
                  await roundCycles();
                  stopToAgain = false;
                }
              },
            );
          } else {
            distanceStreamer.listen(
              onData: (event) async {
                if (event.isValid &&
                    event.deviceId == correctDeviceId &&
                    !stopToAgain) {
                  stopToAgain = true;
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);

                  await roundCycles();
                  stopToAgain = false;
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));

          await distanceStreamer
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel demo2(WidgetRef ref) {
    return StaticGameModel(
      id: 'demo2',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 'demo2',
        name: "demo2",
        description: "demo2",
        imagePath: '19',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 150,
        ),
        duration: NumRange.duration(
            def: 600,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 1,
          GameCategory.edu: 1,
          GameCategory.entertainment: 16,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 3, max: 9),
            defaultSelectedColors: [
              gameErrorColor,
              gameSuccessColor,
              const Color.fromARGB(255, 0, 0, 255)
            ]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        isContainMainBase: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 1000,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var delay = game.setup.delay?.def;
        bool stopToAgain = false;
        final players = ref.read(selectedPlayersPlayersProv);

        final mainPlayer = players.elementAt(0);
        var devs = generalPlayer.devs;

        devs = DeviceShuffler.shuffleDevicesUniquely(devs);

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        for (var perDev in devs) {
          if (chosenSensor == UsedSensorsType.distance) {
            PadSensorManager.lockDstThreshold(ref: ref, deviceId: perDev.id);
          }
        }

        logger.w(devs.toList());
        late String correctDeviceId;

        var mainDev = ref.read(currentMainBaseDiscoveredState);
        var otherDevs = devs.where((element) => element != mainDev);
        bool roundTriggerFromMainDevice = false;
        bool firstGame = true;

        Future<void> round(WidgetRef ref) async {
          roundTriggerFromMainDevice = false;
          Future<void> roundCycles() async {
            roundTriggerFromMainDevice = false;
            var colors = mainPlayer.clrs.toList();

            final indexMainColor = Random().nextInt(colors.length);

            Map<String, Color> tempColorSet = {};

            tempColorSet.addAll({
              mainDev != null ? mainDev.id : generalPlayer.id:
                  colors[indexMainColor]
            });

            for (var otherPerDevice in otherDevs) {
              final otherColorIndex = Random().nextInt(colors.length);
              tempColorSet.addAll({otherPerDevice.id: colors[otherColorIndex]});
              colors.removeAt(otherColorIndex);
            }

            final ftr = <Future>[];

            tempColorSet.forEach((deviceId, value) {
              ftr.add(PadManager.ledColor(deviceId, SidesColorsModel.all(value),
                  ref: ref, isCommand: true));
            });

            await Future.wait(ftr);

            tempColorSet.forEach((key, value) {
              if (key != mainDev?.id && tempColorSet[mainDev?.id] == value) {
                correctDeviceId = key;
              }
            });
          }

          if (firstGame) {
            await roundCycles();
            firstGame = false;
          }

          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          var distanceStreamer = Streamer(
            StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          if (chosenSensor == UsedSensorsType.tap) {
            streamer.listen(
              onData: (event) async {
                if (!roundTriggerFromMainDevice &&
                    event.deviceId == mainDev!.id) {
                  roundTriggerFromMainDevice = true;
                  PadManager.ledOffNoResponse(mainDev.id, ref: ref);
                }

                if (event.isValid &&
                    event.deviceId == correctDeviceId &&
                    roundTriggerFromMainDevice) {
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);

                  await roundCycles();

                  stopToAgain = false;
                }
              },
            );
          } else {
            distanceStreamer.listen(
              onData: (event) async {
                if (!roundTriggerFromMainDevice &&
                    event.deviceId == mainDev!.id) {
                  roundTriggerFromMainDevice = true;
                  PadManager.ledOffNoResponse(mainDev.id, ref: ref);
                }

                if (event.isValid &&
                    event.deviceId == correctDeviceId &&
                    !stopToAgain &&
                    roundTriggerFromMainDevice) {
                  stopToAgain = true;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));

                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);

                  await roundCycles();

                  stopToAgain = false;
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));

          await distanceStreamer
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel formulaYarisiSecond(WidgetRef ref) {
    return StaticGameModel(
      id: 's1',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's1',
        name: instForGameScreen.game_title_1,
        description: instForGameScreen.game_description_1,
        imagePath: '1',
        playerCount: NumRange.playerCount(
          min: 2,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(def: 20, min: 10, max: 600, step: 5),
        distance: NumRange.distanceCm(
          def: 40,
          min: 20,
          max: 60,
        ),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reaction_speed,
          GameEarning.competitive_spirit,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 3,
          GameCategory.edu: 3,
          GameCategory.entertainment: 19,
          GameCategory.multiplayer: 7,
        },
        igaPickColor: true,
        igaMultiplePickColor: true,
        isContainOnIga: true,
        igaIngGameTextSpans: [],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.iga_f1_countdown_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text_bold,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_f1_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.catchCount,
          scoreTypeParam2: GameScoreType.averageDuration,
          scoreTypeParam3: GameScoreType.totalDuration,
          scoreTypeParam4: GameScoreType.minDuration,
          scoreTypeParam5: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
              colorCount: NumRange.count(
                min: 1,
                max: 1,
              ),
              defaultSelectedColors: [gameErrorColor, gameSuccessColor],
              deviceCount: NumRange.count(min: 1, max: 5)),
          generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
          ),
          sensorTypes: {
            UsedSensorsType.tap: false,
            UsedSensorsType.distance: false,
          },
          allowSameColor: false,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 30,
            timeout: 150,
          ),
          dstConfig: const DstConfigModel(threshold: 1000, timeout: 100)),
      execute: (ref, game) async {
        Set<PlayerModel> players = ref.read(selectedPlayersPlayersProv);

        if (ref.read(currentEmbModeManager) == 1) {
          final easyDiscoveredDevicesSet = ref
              .read(igaBackGroundManager.notifier)
              .easyDiscoveredDevices
              .toSet();
          final firstPlayerDiscoveredSet = ref
              .read(igaBackGroundManager.notifier)
              .firstPlayerDiscoveredDevices
              .toSet();
          final secondPlayerDiscoveredSet = ref
              .read(igaBackGroundManager.notifier)
              .secondPlayerDiscoveredDevices
              .toSet();

          logger
              .i("firstPlayerDiscoveredSet:${firstPlayerDiscoveredSet.length}");
          logger.i(
              "secondPlayerDiscoveredSet:${secondPlayerDiscoveredSet.length}");
          logger.i("easyDiscoveredDevice:${easyDiscoveredDevicesSet.length}");

          final firstPlayer = players.first.copyWith(
            devices:
                ref.read(currentIgaChooseLevelManager) == IGALevelModes.hard
                    ? ref
                        .read(igaBackGroundManager.notifier)
                        .firstPlayerDiscoveredDevices
                        .toList()
                    : easyDiscoveredDevicesSet
                        .intersection(firstPlayerDiscoveredSet)
                        .toList(),
          );

          logger.i(
              "Second Player Discovered Devices: $secondPlayerDiscoveredSet\nEasy $easyDiscoveredDevicesSet");

          final secondPlayer = players.last.copyWith(
            devices:
                ref.read(currentIgaChooseLevelManager) == IGALevelModes.hard
                    ? ref
                        .read(igaBackGroundManager.notifier)
                        .secondPlayerDiscoveredDevices
                        .toList()
                    : easyDiscoveredDevicesSet
                        .intersection(secondPlayerDiscoveredSet)
                        .toList(),
          );
          logger.i("After intersection: ${secondPlayer.devices.length}");

          players.clear();
          players.addAll([firstPlayer, secondPlayer]);
        }
        for (var perPlayer in players) {
          logger.i(
              "Each Player Device Length${perPlayer.id}:::${perPlayer.devs.length}");
        }

        List<DiscoveredDevice> devs =
            ref.read(selectedGeneralPlayerProv)!.player.devs;

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        final ran = Xrandom();

        DeviceModel? getUnusedDev(DeviceModel? thisone, String playerId) {
          final thisId = thisone?.id;

          final otherOnes = devs.where((d) => d.id != thisId);

          final otherIds = otherOnes.map((d) => d.id).toList();

          final currentPlayer =
              players.toList().firstWhere((element) => element.id == playerId);

          otherIds.clear();

          final currentPlayerDeviceList = currentPlayer.devs;

          for (var device in currentPlayerDeviceList) {
            otherIds.add(device.id);
          }

          final otherPlyerDeviceIds = devsMap.values
              .where((element) => element != null)
              .map((d) => d!.id)
              .toList();

          final otherUnoccupiedIds = otherIds
              .where((id) => !otherPlyerDeviceIds.contains(id))
              .toList();

          try {
            final ran = Xrandom();
            var result = ran.nextInt(otherUnoccupiedIds.length);
            return devs.firstWhere(
                (element) => element.id == otherUnoccupiedIds[result]);
          } catch (e) {
            assert(false);
            return null;
          }
        }

        final sender = SendStreamer<bool>();
        Streamer<TouchEvent>? streamer;
        Streamer<DistanceEvent>? streamerDist;

        switch (chosenSensor) {
          case UsedSensorsType.tap:
            streamer = Streamer(
              StaticGameManager.listenToTouchMulti(devs.map((e) => e.id),
                  ref: ref),
            );
            streamer = streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);

                  final id = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: id,
                      spot: FlSpot(
                          StaticGameManager.getScore(playerId: id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  StaticGameManager.ledOff(
                    devId,
                    ref: ref,
                    isCommand: false,
                  );
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  var newDev = getUnusedDev(devsMap[id], id);

                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;
                  StaticGameManager.ledColor(
                    newDev.id,
                    SidesColorsModel.all(colorsMap[id]!),
                    ref: ref,
                    isCommand: true,
                  );
                } catch (e) {
                  e;
                }
              },
            );
            break;
          case UsedSensorsType.distance:
            streamerDist = Streamer(
              StaticGameManager.listenToDistanceMulti(devs.map((e) => e.id),
                  ref: ref),
            );

            streamerDist = streamerDist.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);

                  final id = entry.key;
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: id,
                      spot: FlSpot(
                          StaticGameManager.getScore(playerId: id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                  sender.add(() async => await StaticGameManager.ledOff(
                        devId,
                        ref: ref,
                        isCommand: true,
                      ));

                  final newDev = getUnusedDev(devsMap[id], id);
                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;
                  sender.add(() async => await StaticGameManager.ledColor(
                        newDev.id,
                        SidesColorsModel.all(colorsMap[id]!),
                        ref: ref,
                        isCommand: true,
                      ));
                } catch (e) {
                  e;
                }
              },
            );
            break;
          default:
        }

        Future<void> round(WidgetRef ref) async {
          devs.shuffle(ran);

          for (var entry in devsMap.entries) {
            final id = entry.key;
            final dev = entry.value;

            if (dev != null) {
              continue;
            }

            final pDev = getUnusedDev(devsMap[id], id);

            if (pDev == null) {
              assert(false);
              continue;
            }
            devsMap[id] = pDev;

            final pDevId = pDev.id;

            StaticGameManager.ledColor(
              pDevId,
              SidesColorsModel.all(colorsMap[id]!),
              ref: ref,
              isCommand: true,
            );
          }

          // await Future.doWhile(
          //   () async {
          //     await Future.delayed(Duration.zero);
          //     // when any player catches their pad, skip to the next round
          //     // so we can reround them.
          //     return devsMap.values.every((value) => value != null);
          //   },
          // );
        }

        await game.setup.executeGame(ref, round);

        streamer?.cancel();
        streamerDist?.cancel();
      },
    );
  }

  static StaticGameModel goCenter(WidgetRef ref) {
    return StaticGameModel(
      id: '90',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '90',
        name: instForGameScreen.game_title_90,
        description: instForGameScreen.game_description_90,
        imagePath: '90',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        tag: GameTag.quickness,
        badgeType: GameBadgeTypes.newGame,
        earnings: [
          GameEarning.reaction_speed,
        ],
        categories: {
          GameCategory.sports: 1,
          GameCategory.entertainment: 1,
          GameCategory.test: 8,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 2, max: 9),
            colorDeviceDifference: 1,
            defaultSelectedColors: [
              gameErrorColor,
              gameSuccessColor,
              const Color.fromARGB(255, 0, 0, 255)
            ]),
        generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
            colorCount: NumRange.count(min: 2, max: 9),
            colorDeviceDifference: 1,
            defaultSelectedColors: [
              gameErrorColor,
              gameSuccessColor,
              const Color.fromARGB(255, 0, 0, 255)
            ]),
        isContainMainBase: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 1000,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var delay = game.setup.delay?.def;
        bool stopToAgain = false;
        final players = ref.read(selectedPlayersPlayersProv);

        final mainPlayer = players.elementAt(0);
        var devs = generalPlayer.devs;

        devs = DeviceShuffler.shuffleDevicesUniquely(devs);

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        for (var perDev in devs) {
          if (chosenSensor == UsedSensorsType.distance) {
            PadSensorManager.lockDstThreshold(ref: ref, deviceId: perDev.id);
          }
        }

        late String correctDeviceId;

        var mainDev = ref.read(currentMainBaseDiscoveredState);
        var otherDevs = devs.where((element) => element != mainDev);
        bool roundTriggerFromMainDevice = false;
        bool firstGame = true;
        Future<void> round(WidgetRef ref) async {
          roundTriggerFromMainDevice = false;
          Future<void> roundCycles() async {
            roundTriggerFromMainDevice = false;
            var colors = generalPlayer.clrs.toList();

            final indexMainColor = Random().nextInt(colors.length);

            Map<String, Color> tempColorSet = {};

            tempColorSet.addAll({
              mainDev != null ? mainDev.id : generalPlayer.id:
                  colors[indexMainColor]
            });

            for (var otherPerDevice in otherDevs) {
              final otherColorIndex = Random().nextInt(colors.length);
              tempColorSet.addAll({otherPerDevice.id: colors[otherColorIndex]});
              colors.removeAt(otherColorIndex);
            }

            final ftr = <Future>[];

            tempColorSet.forEach((deviceId, value) {
              ftr.add(PadManager.ledColor(deviceId, SidesColorsModel.all(value),
                  ref: ref, isCommand: true));
            });

            await Future.wait(ftr);

            tempColorSet.forEach((key, value) {
              if (key != mainDev?.id && tempColorSet[mainDev?.id] == value) {
                correctDeviceId = key;
              }
            });
          }

          if (firstGame) {
            await roundCycles();
            firstGame = false;
          }

          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          var distanceStreamer = Streamer(
            StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          if (chosenSensor == UsedSensorsType.tap) {
            streamer.listen(
              onData: (event) async {
                if (!roundTriggerFromMainDevice &&
                    event.deviceId == mainDev!.id) {
                  roundTriggerFromMainDevice = true;
                  PadManager.ledOffNoResponse(mainDev.id, ref: ref);
                }

                if (event.isValid &&
                    event.deviceId == correctDeviceId &&
                    roundTriggerFromMainDevice) {
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);

                  await roundCycles();

                  stopToAgain = false;
                }
              },
            );
          } else {
            distanceStreamer.listen(
              onData: (event) async {
                if (!roundTriggerFromMainDevice &&
                    event.deviceId == mainDev!.id) {
                  roundTriggerFromMainDevice = true;
                  PadManager.ledOffNoResponse(mainDev.id, ref: ref);
                }

                if (event.isValid &&
                    event.deviceId == correctDeviceId &&
                    !stopToAgain &&
                    roundTriggerFromMainDevice) {
                  stopToAgain = true;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));

                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);

                  await roundCycles();

                  stopToAgain = false;
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));

          await distanceStreamer
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel seeCenter(WidgetRef ref) {
    return StaticGameModel(
      id: '91',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '91',
        name: instForGameScreen.game_title_91,
        description: instForGameScreen.game_description_91,
        imagePath: '91',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        tag: GameTag.agility,
        badgeType: GameBadgeTypes.newGame,
        earnings: [
          GameEarning.reaction_speed,
        ],
        categories: {
          GameCategory.sports: 1,
          GameCategory.entertainment: 1,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 2, max: 9),
            colorDeviceDifference: 1,
            defaultSelectedColors: [
              gameErrorColor,
              gameSuccessColor,
              const Color.fromARGB(255, 0, 0, 255)
            ]),
        generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
            colorCount: NumRange.count(min: 2, max: 9),
            colorDeviceDifference: 1,
            defaultSelectedColors: [
              gameErrorColor,
              gameSuccessColor,
              const Color.fromARGB(255, 0, 0, 255)
            ]),
        isContainMainBase: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 1000,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var delay = game.setup.delay?.def;
        bool stopToAgain = false;
        final players = ref.read(selectedPlayersPlayersProv);

        final mainPlayer = players.elementAt(0);
        var devs = generalPlayer.devs;

        devs = DeviceShuffler.shuffleDevicesUniquely(devs);

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        for (var perDev in devs) {
          if (chosenSensor == UsedSensorsType.distance) {
            PadSensorManager.lockDstThreshold(ref: ref, deviceId: perDev.id);
          }
        }

        late String correctDeviceId;

        var mainDev = ref.read(currentMainBaseDiscoveredState);
        var otherDevs = devs.where((element) => element != mainDev);

        bool firstGame = true;

        Future<void> round(WidgetRef ref) async {
          Future<void> roundCycles() async {
            logger.i("Main Player Colors: ${mainPlayer.clrs}");
            var colors = generalPlayer.clrs.toList();
            final indexMainColor = Random().nextInt(colors.length);

            Map<String, Color> tempColorSet = {};

            tempColorSet.addAll({
              mainDev != null ? mainDev.id : generalPlayer.id:
                  colors[indexMainColor]
            });

            for (var otherPerDevice in otherDevs) {
              final otherColorIndex = Random().nextInt(colors.length);
              tempColorSet.addAll({otherPerDevice.id: colors[otherColorIndex]});
              colors.removeAt(otherColorIndex);
            }

            final ftr = <Future>[];

            tempColorSet.forEach((deviceId, value) {
              ftr.add(PadManager.ledColor(deviceId, SidesColorsModel.all(value),
                  ref: ref, isCommand: true));
            });

            await Future.wait(ftr);

            tempColorSet.forEach((key, value) {
              if (key != mainDev?.id && tempColorSet[mainDev?.id] == value) {
                correctDeviceId = key;
              }
            });
          }

          if (firstGame) {
            await roundCycles();
            firstGame = false;
          }

          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          var distanceStreamer = Streamer(
            StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          if (chosenSensor == UsedSensorsType.tap) {
            streamer.listen(
              onData: (event) async {
                if (event.isValid && event.deviceId == correctDeviceId) {
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);
                  await roundCycles();
                  stopToAgain = false;
                }
              },
            );
          } else {
            distanceStreamer.listen(
              onData: (event) async {
                if (event.isValid &&
                    event.deviceId == correctDeviceId &&
                    !stopToAgain) {
                  stopToAgain = true;
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  final ftr = <Future>[];

                  ftr.add(StaticGameManager.ledAllOffNoDelay(ref: ref));
                  ftr.add(Future.delayed(Duration(seconds: delay ?? 0)));

                  await Future.wait(ftr);

                  await roundCycles();
                  stopToAgain = false;
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));

          await distanceStreamer
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel formulaYarisi(WidgetRef ref) {
    return StaticGameModel(
      id: 's1',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's1',
        name: instForGameScreen.game_title_1,
        description: instForGameScreen.game_description_1,
        imagePath: '1',
        igaPickColor: true,
        igaMultiplePickColor: true,
        isContainOnIga: true,
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_f1_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        playerCount: NumRange.playerCount(
          min: 2,
          max: 11,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 3,
          GameCategory.edu: 3,
          GameCategory.entertainment: 19,
          GameCategory.multiplayer: 7,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.catchCount,
          scoreTypeParam2: GameScoreType.averageDuration,
          scoreTypeParam3: GameScoreType.totalDuration,
          scoreTypeParam4: GameScoreType.minDuration,
          scoreTypeParam5: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(
              min: 1,
              max: 1,
            ),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
          ),
          sensorTypes: {
            UsedSensorsType.tap: false,
            UsedSensorsType.distance: false,
          },
          allowSameColor: false,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 20,
            timeout: 150,
          ),
          dstConfig: const DstConfigModel(threshold: 1000, timeout: 100)),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final devs = ref.watch(selectedGeneralPlayerProv)!.player.devs;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        int roundCount = 0;

        int sentTime = DateTime.now().millisecondsSinceEpoch;

        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        final ran = Xrandom();

        DeviceModel? getUnusedDev(DeviceModel? thisone) {
          final thisId = thisone?.id;

          final otherOnes = devs.where((d) => d.id != thisId);
          final otherIds = otherOnes.map((d) => d.id).toList();
          final otherPlayerDeviceIds = devsMap.values
              .where((element) => element != null)
              .map((d) => d!.id)
              .toList();
          final otherUnoccupiedIds = otherIds
              .where((id) => !otherPlayerDeviceIds.contains(id))
              .toList();

          try {
            return devs
                .firstWhere((element) => element.id == otherUnoccupiedIds[0]);
          } catch (e) {
            assert(false);
            return null;
          }
        }

        final sender = SendStreamer<bool>();
        Streamer<TouchEvent>? streamer;
        Streamer<DistanceEvent>? streamerDist;

        switch (chosenSensor) {
          case UsedSensorsType.tap:
            streamer = Streamer(
              StaticGameManager.listenToTouchMulti(devs.map((e) => e.id),
                  ref: ref),
            );
            streamer = streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;

                  try {
                    final receiverMs = DateTime.now().millisecondsSinceEpoch;
                    int elapsedTime = receiverMs - sentTime;
                    ref
                        .read(currentBleTrackerStateManager.notifier)
                        .addCommandTracker(
                            ref,
                            CommandTimeTracker(
                              senTime: sentTime,
                              turnCount: roundCount,
                              actionOfReceiverTime: receiverMs,
                              elapsedTime: elapsedTime,
                            ));
                  } catch (e) {
                    logger.e("Error:$e");
                  }

                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);

                  final id = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: id,
                      spot: FlSpot(
                          StaticGameManager.getScore(playerId: id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  StaticGameManager.ledOff(
                    devId,
                    ref: ref,
                    isCommand: false,
                  );

                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  final newDev = getUnusedDev(devsMap[id]);
                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;

                  roundCount += 1;
                  sentTime = DateTime.now().millisecondsSinceEpoch;

                  StaticGameManager.ledColor(
                    newDev.id,
                    SidesColorsModel.all(colorsMap[id]!),
                    ref: ref,
                    isCommand: true,
                  );
                  await Future.delayed(const Duration(milliseconds: 20));
                } catch (e) {
                  e;
                }
              },
            );
            break;
          case UsedSensorsType.distance:
            streamerDist = Streamer(
              StaticGameManager.listenToDistanceMulti(devs.map((e) => e.id),
                  ref: ref),
            );

            streamerDist = streamerDist.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);
                  try {
                    final receiverMs = DateTime.now().millisecondsSinceEpoch;
                    int elapsedTime = receiverMs - sentTime;
                    logger.w(elapsedTime.toString());
                    ref
                        .read(currentBleTrackerStateManager.notifier)
                        .addCommandTracker(
                            ref,
                            CommandTimeTracker(
                              senTime: sentTime,
                              turnCount: roundCount,
                              actionOfReceiverTime: receiverMs,
                              elapsedTime: elapsedTime,
                            ));
                  } catch (e) {
                    logger.e("Error:$e");
                  }
                  final id = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: id,
                      spot: FlSpot(
                          StaticGameManager.getScore(playerId: id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                  sender.add(() async => await StaticGameManager.ledOff(
                        devId,
                        ref: ref,
                        isCommand: true,
                      ));
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  final newDev = getUnusedDev(devsMap[id]);
                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;

                  sender.add(() async => await StaticGameManager.ledColor(
                        newDev.id,
                        SidesColorsModel.all(colorsMap[id]!),
                        ref: ref,
                        isCommand: true,
                      ));
                  await Future.delayed(const Duration(milliseconds: 20));
                } catch (e) {
                  e;
                }
              },
            );
            break;
          default:
        }

        Future<void> round(WidgetRef ref) async {
          devs.shuffle(ran);

          for (var entry in devsMap.entries) {
            final id = entry.key;
            final dev = entry.value;

            if (dev != null) {
              continue;
            }

            final pDev = getUnusedDev(devsMap[id]);
            if (pDev == null) {
              assert(false);
              continue;
            }
            devsMap[id] = pDev;

            final pDevId = pDev.id;

            StaticGameManager.ledColor(
              pDevId,
              SidesColorsModel.all(colorsMap[id]!),
              ref: ref,
              isCommand: true,
            );
          }

          // await Future.doWhile(
          //   () async {
          //     await Future.delayed(Duration.zero);
          //     // when any player catches their pad, skip to the next round
          //     // so we can reround them.
          //     return devsMap.values.every((value) => value != null);
          //   },
          // );
        }

        await game.setup.executeGame(ref, round, disposeCb: (val) async {
          streamer?.cancel();
          streamerDist?.cancel();
          ref.read(currentFinishControlManager.notifier).changState(true);
          PlayerResultModel? winnerResult;

          for (var player in ref.read(gameResultProv)!.players) {
            final result =
                ref.read(gameResultProv.notifier).getPlayer(player.id);
            if (result != null) {
              winnerResult ??= result;

              if (result.correctCount != null &&
                  result.correctCount! > winnerResult.correctCount!) {
                winnerResult = result;
              } else if (result.scorePoints != null &&
                  result.scorePoints!.length ==
                      winnerResult.scorePoints!.length) {
                if (winnerResult.averageDuration!.inSeconds >
                    result.averageDuration!.inSeconds) {
                  winnerResult = result;
                }
              }
            }
          }
          final currentDeviceList = ref.read(currentDevicesManagerProvider);
          final futureList = <Future>[];

          for (int i = 0; i < 3; i++) {
            if (winnerResult != null) {
              currentDeviceList.forEach((key, value) {
                futureList.add(StaticGameManager.ledColorNoResponse(
                  key,
                  SidesColorsModel.all(colorsMap[winnerResult!.playerId]!),
                  ref: ref,
                  isCommand: true,
                ));
              });
            }
            Future.wait(futureList);
            await Future.delayed(const Duration(milliseconds: 700));
            StaticGameManager.ledAllOffNoDelay(ref: ref);
          }
          return true;
        });

        logger.i("GAME END CUSTOM FOR FORMULA");
      },
    );
  }

  static StaticGameModel renginiGoster(WidgetRef ref) {
    return StaticGameModel(
      id: 's2',
      metaData: GameMetaDataModel(
        id: 's2',
        name: instForGameScreen.game_title_2,
        description: instForGameScreen.game_description_2,
        imagePath: '2',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 10,
          max: 10,
        ),
        tag: GameTag.agility,
        earnings: [
          GameEarning.agility,
        ],
        categories: {
          GameCategory.entertainment: 26,
          GameCategory.multiplayer: 16,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: null,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel padKapmaca(WidgetRef ref) {
    return StaticGameModel(
      id: 's3',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's3',
        name: instForGameScreen.game_title_3,
        description: instForGameScreen.game_description_3,
        imagePath: '3',
        playerCount: NumRange.playerCount(
          min: 5,
          max: 11,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 12,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.focus,
          GameEarning.auditory,
          GameEarning.reflex,
        ],
        categories: {
          GameCategory.entertainment: 1,
          GameCategory.multiplayer: 13,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.none,
        scoreTypeParam2: GameScoreType.none,
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
            gameErrorColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          mentorControlsState: MentorControlsState.ask,
          gameAudioControls: const GameAudioSelectionSetup(
            musicSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: true,
            ),
          ),
          gameMusicSelectionSetup: GameMusicSelectionSetup.init(
            selectableMusics: {
              'damat_halayi': 'Damat Halayı',
              'delisin': 'Delisin',
              'martilar': 'Martılar',
              'hareketli_fon': 'Hareketli Fon',
              'neler_oluyor_hayatta': 'Neler Oluyor Hayatta',
            }.entries.map(
              (entry) {
                final title = entry.value;
                final fileTitle = entry.key;
                final path =
                    AudioFiles.getAsset(AudioFiles.catchThePadGame, fileTitle);
                return Attachment.music(
                  assetPath: path,
                  assetName: title,
                );
              },
            ).toSet(),
          ),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 45,
          timeout: 150,
        ),
      ),
      init: (ref, game) async {
        ref.read(gameRoundProv.notifier).setEnabled();
      },
      execute: (ref, game) async {
        final mainPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final clrs = mainPlayer.clrs;
        final devs = mainPlayer.devs;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        const mainColor = gameSuccessColor, eliminatedPadColor = gameErrorColor;

        List<int>? randomIndexes;
        int i = 0;
        Color getRandomColor() {
          final clrs = defaultConstColors(ref);
          final cnt = clrs.length;

          if (randomIndexes == null) {
            final indxs = List.generate(cnt, (index) => index);

            final rnd = Xrandom();

            indxs.shuffle(rnd);

            randomIndexes = List.from(indxs);
          }

          return clrs[randomIndexes![i++ % cnt]];
        }
        // int roundI = 0;
        // int playerCount = devs.length + 1;

        Future<void> round(WidgetRef ref) async {
          // all of these has been converted to methods,
          // so we get to have the new value if it changes
          StaticGameSetupModel setup() => ref.read(currentGameSetupProv)!;
          GameControlsSetup controls() => setup().controlsSetup;
          MentorControlsState mentorControlsState() =>
              controls().mentorControlsState;
          GameMusicSelectionSetup musicSetup() =>
              controls().gameMusicSelectionSetup!;
          Attachment selectedMusic() =>
              musicSetup().selectedMusics.elementAt(0);

          // await until the mentor resumes the game
          if (mentorControlsState() == MentorControlsState.allow) {
            while (ref.read(gameRoundProv) == GameRoundEnum.paused) {
              // this is critically important, otherwise the ui will freeze
              await Future.delayed(Duration.zero);
            }
          }

          audioPlayer.resume(selectedMusic());

          // shuffle devices and colors for each round
          devs.shuffle(Xrandom());
          clrs.shuffle(Xrandom());

          // if manual, we wanna light them randomly for a few times,
          // of mentor, then we wanna light them until we get a command
          // from the mentor

          randomColorsRound() async {
            devs.shuffle(Xrandom());
            clrs.shuffle(Xrandom());

            final ftrs = [];

            for (var device in devs) {
              ftrs.add(
                () => StaticGameManager.ledColor(
                  device.id,
                  SidesColorsModel.all(getRandomColor()),
                  isCommand: true,
                  ref: ref,
                ),
              );
            }

            await Future.wait(
              ftrs.map(
                (e) => e(),
              ),
            );

            // an error margin, for delays
            await Future.delayed(sightDuration);
          }

          if (mentorControlsState().isAllowed) {
            while (ref.read(gameRoundProv) != GameRoundEnum.paused) {
              await randomColorsRound();
            }
          } else {
            // generate a random number between 2 and 7
            final int randomNumber = Xrandom().nextInt(5);
            int g = 0;
            while (g <= randomNumber) {
              await randomColorsRound();
              g++;
            }
          }

          final ftrs = [];
          // now led them all the main color
          for (var i = 0; i < devs.length; i++) {
            final device = devs[i];

            ftrs.add(
              () => StaticGameManager.ledColor(
                device.id,
                SidesColorsModel.all(mainColor),
                isCommand: true,
                ref: ref,
              ),
            );
          }

          await Future.wait(
            ftrs.map(
              (e) => e(),
            ),
          );

          audioPlayer.pause();

          // now all the pads are led with different colors,
          // we wanna listen to all their touches, and the turn
          // off the leds when they are touched
          final touchedDevicesIds = <String>{};

          final devIds = devs.map((e) => e.id);

          final devIdNameIdMap = CpDiscoveredDevice.devIdNameIdMap(devs);

          final listenc = StaticGameManager.listenToTouchMulti(
            devIds,
            ref: ref,
          );
          final streamer = Streamer(listenc);

          streamer.listen(
            onData: (event) async {
              if (event.isValid) {
                final keys = devIdNameIdMap.keys.toList();
                final vals = devIdNameIdMap.values.toList();

                final idx =
                    keys.indexWhere((element) => element == event.deviceId);

                if (idx >= 0 && idx < vals.length) {
                  final devId = keys[idx];
                  touchedDevicesIds.add(event.deviceId);

                  // the last touched should light red
                  final isLastPad = touchedDevicesIds.length == devs.length;

                  Future<void> doAfterSight<R>(
                          Future<R> Function(dynamic) onValue) async =>
                      await Future.delayed(sightDuration)
                          .then((_) async => await onValue(_));

                  isLastPad
                      ? await StaticGameManager.ledColor(
                          devId,
                          SidesColorsModel.all(eliminatedPadColor),
                          ref: ref,
                        )
                      : await StaticGameManager.ledOff(
                          devId,
                          ref: ref,
                        );
                }
              }

              if (touchedDevicesIds.length == devIds.length ||
                  ref.read(gameEndingProvider)) {
                logger.d('bf break');
                streamer.cancel();
              }

              logger.d('no break');
            },
          );
          await streamer.doneOr(() async => ref.watch(gameEndingProvider));

          logger.d('af await multi touch');

          try {
            // if only 2 players left, we dont wanna exclude a device,
            // so in the last round, we would know which player won first
            // remove the last device

            // if (playerCount != 3) {
            devs.removeWhere(
              (element) => element.id == touchedDevicesIds.last,
            );
            // }

            logger.d('last device removed successfully ✅', e);
          } catch (e) {
            logger.d('last device removed unsuccessfully 🚨', e);
          }

          logger.d('af try remove device');

          for (var element in devs) {
            await StaticGameManager.ledOff(
              element.id,
              ref: ref,
            );
          }
        }

        await game.setup.executeGame(ref, round,
            // the game ends when there is 1 player left
            // so we check for 0, as n pad -> n + 1 players
            shouldStop: ((ref) async =>
                devs.length <= 1 || ref.watch(gameEndingProvider)),
            disposeCb: (ref) async {
          ref.read(gameScreenWidgetProv.notifier).state = null;
          return true;
        });
      },
    );
  }

  /// https://app.clickup.com/t/2888fv9
  static StaticGameModel ekipIsi(WidgetRef ref) {
    return StaticGameModel(
      id: 's4',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's4',
        name: instForGameScreen.game_title_4,
        primaryScoreString: instForGameScreen.game_result_primary_score_harmony,
        description: instForGameScreen.game_description_4,
        imagePath: '4',
        igaPickColor: true,
        igaMultiplePickColor: false,
        isContainOnIga: true,
        igaIngGameTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_tap_pad_same_time.capitalize(),
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 15.sp))
          ],
        ],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.iga_f1_countdown_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_ekip_isi_countdown_2,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_ekip_isi_countdown_3,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_team_work_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_team_work_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_team_work_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        inGameIgaHeader: instForGameScreen.iga_team_work_in_game_header_text,
        playerCount: NumRange.playerCount(
          min: 2,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 30,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        tag: GameTag.teamWork,
        earnings: [
          GameEarning.team_spirit,
          GameEarning.sync,
          GameEarning.coordination,
        ],
        categories: {
          GameCategory.sports: 27,
          GameCategory.edu: 5,
          GameCategory.entertainment: 14,
          GameCategory.multiplayer: 2,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.teamHarmony,
        scoreTypeParam2: GameScoreType.catchCount,
        stagedPlayerModel: const StagedPlayerModel(
          defaultSelectedColors: [gameErrorColor],
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          colorCount: NumRange.count(min: 1, max: 1),
          defaultSelectedColors: [gameErrorColor],
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 10,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final mainClr = generalPlayer.clrs.first;
        final ret = defaultConstColors(ref).toSet();
        // 4 tane renk lazım
        // ret.addAll(const [
        //   Color.fromARGB(255, 255, 0, 42),
        //   Color.fromARGB(255, 255, 27, 0),
        //   Color.fromARGB(255, 255, 0, 255),
        //   Color.fromARGB(255, 75, 18, 25),
        //   Color.fromARGB(255, 75, 40, 0),
        //   Color.fromARGB(255, 18, 23, 75),
        // ]);
        var clrs = ret.difference({mainClr}).toList();
        if (ref.read(currentEmbModeManager) == 1) {
          var list = ret.difference({mainClr}).toList().sublist(0, 5).toList();
          clrs.addAll(list);
        }
        var devs = generalPlayer.devs;
        if (ref.read(currentEmbModeManager) == 1 &&
            ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy) {
          devs = ref
              .read(igaBackGroundManager.notifier)
              .easyDiscoveredDevices
              .toList();
        }
        final players = ref.read(selectedPlayersPlayersProv);
        final playerCount = players.length;
        final mainPlayer = players.elementAt(0);

        bool isEnded = false;

        Future<void> round(WidgetRef ref) async {
          for (var element in devs) {
            await StaticGameManager.ledOff(element.id, ref: ref);
          }

          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          clrs = DeviceShuffler.shuffleColorsUniquely(clrs);

          // seperate the devs list into 2 lists, correct and wrong ones
          final List<DeviceModel> correctDevs = devs.sublist(0, playerCount);
          final List<DeviceModel> wrongDevs = devs.sublist(playerCount);

          // led [correctDevs] 255,0,0 ,
          // and mark [roundN] item [wrongDevs] a random color
          // from the list [colors]

          final ftrs = [];

          for (var i = 0;
              i <
                  wrongDevs
                      .sublist(
                          0, min(ref.read(gameCurrRoundProv), wrongDevs.length))
                      .length;
              i++) {
            final color = clrs[i];

            ftrs.add(
              () => StaticGameManager.ledColor(
                wrongDevs[i].id,
                SidesColorsModel.all(color),
                isCommand: true,
                ref: ref,
              ),
            );
          }

          for (var i = 0; i < correctDevs.length; i++) {
            ftrs.add(
              () => StaticGameManager.ledColor(
                correctDevs[i].id,
                SidesColorsModel.all(mainClr),
                isCommand: true,
                ref: ref,
              ),
            );
          }

          await Future.wait(
            ftrs.map((e) => e()),
          );

          const maxDurationBetweenEach = Duration(milliseconds: 500);
          final maxDurationBetweenEachMs =
              maxDurationBetweenEach.inMilliseconds;

          final stamps = <String, Duration>{};
          // listen to the touches,
          //
          // if the touched
          // device is in the [correctDevs] list, then
          // we wanna add the stamp to the list [stamps],
          // and if the stamps list matches the [correctDevs]
          // length, increase the score and break the loop.
          //
          // if the touched device is not in the [correctDevs]
          // list, we play a buzz and break the loop, and
          // decrease the score
          await for (final event in StaticGameManager.listenToTouchMulti(
            [
              ...correctDevs,
              ...wrongDevs,
            ].map((e) => e.id).toList(),
            ref: ref,
          )) {
            final isCorrectDev = correctDevs.any(
              (e) {
                return e.id == event.deviceId;
              },
            );
            if (isCorrectDev && event.responseTime != null) {
              if (stamps[event.deviceId] == null) {
                stamps[event.deviceId] = event.responseTime!;
              }

              // we dont wanna do anything when we catch the first pad.
              if (stamps.length != correctDevs.length) {
                continue;
              }

              final List<Duration> durations = stamps.values.toList();
              durations.sort();

              // we wanna log the team's durations and harmony
              // anyway, even if they fail.
              /* StaticGameManager.addScorePoint(
                ref: ref,
                playerId: mainPlayer.id,
                time: durations.last,
              ); */

              StaticGameManager.addTeamHarmonyPoint(
                ref: ref,
                playerId: mainPlayer.id,
                times: durations,
              );

              // do a success check, if fails we wanna break
              // the game, else we wanna increase the score.

              // if any pad gets caught 200ms after the first one, then it's a fail
              final Duration diff = durations.last - durations.first;
              /* if (diff.inMilliseconds >= maxDurationBetweenEachMs) {
                /* StaticGameManager.decreaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                ); */
                //_isEnded = true;

                break;
              } */

              // if not failed, increase the score
              StaticGameManager.increaseScore(
                ref: ref,
                playerId: mainPlayer.id,
              );

              break;
            } else {
              // if wrong pad caught, we wanna end the game
              //_isEnded = true;
            }
          }
        }

        await game.setup.executeGame(
          ref,
          round,
          additionalStopCondition: (ref) async {
            return isEnded;
          },
        );
      },
    );
  }

  static StaticGameModel padSende(WidgetRef ref) {
    return StaticGameModel(
      id: 's5',
      metaData: GameMetaDataModel(
        id: 's5',
        name: "Pad Sende",
        description:
            "Yeni nesil elim sende! Herkes Pad'ini sırtına bağlasın. Pad'ine sahip çık. Kazanan sen ol!",
        imagePath: '5',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 10,
          max: 10,
        ),
        tag: GameTag.grossMotor,
        earnings: [
          GameEarning.grossMotor,
        ],
        categories: {
          GameCategory.sports: 38,
          GameCategory.entertainment: 17,
          GameCategory.multiplayer: 14,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.none,
        scoreTypeParam2: GameScoreType.none,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel zipla(WidgetRef ref) {
    return StaticGameModel(
      id: 's6',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's6',
        name: instForGameScreen.game_title_6,
        primaryScoreString: instForGameScreen.game_result_primary_score_height,
        description: instForGameScreen.game_description_6,
        imagePath: '6',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 8,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 1,
        ),
        tag: GameTag.grossMotor,
        earnings: [
          GameEarning.grossMotor,
          GameEarning.muscleDev,
        ],
        categories: {
          GameCategory.sports: 50,
          GameCategory.entertainment: 12,
          GameCategory.multiplayer: 2,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        roundCount: 2,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          unavailableColors: [
            gameSuccessColor,
          ],
        ),

        /// when the player jumps, the lowest detected part would be their feet,
        /// which is what defines the height of the jump
        scoreTypeParam1: GameScoreType.averageDistance,
        scoreTypeParam2: GameScoreType.none,

        // supposed to be reaction, which in this case is the time it takes to jump
        sensorTypes: {
          UsedSensorsType.distance: false,
        },
        doesHaveSound: false,
        dstConfig: const DstConfigModel(
          timeout: 15,
          threshold: 1500,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final devs = game.setup.getGameDevices(ref);
        final mainPlayer = players.first;
        final devices = mainPlayer.devs;
        final color = mainPlayer.clrs.first;
        final mainDevice = devices[0];
        final mainDeviceId = mainDevice.id;
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];
        final mainPlayerId = mainPlayer.id;

        playerId(String devid) {
          return players
              .firstWhere((element) =>
                  element.devs.any((element) => element.id == devid))
              .id;
        }

        Map<String, DateTime?> ljtMap = {
          for (var player in players) player.id: null
        };
        Map<String, DiscoveredDevice> devMap = {
          for (var player in players) player.id: player.devs.first
        };

        // bool jumpEnded = false;

        // we do not initialize this here,
        // but after the first glampse
        DateTime? lastJumpTime;

        // game ending conditions:
        //  - the player ends the jump.

        // TODO: when we add this piece of code, and then send
        // a distance from simulator, the simulator blows up
        final ftrs = [];
        for (var dev in devs) {
          ftrs.add(() => StaticGameManager.ledColor(
                dev.id,
                SidesColorsModel.all(gameSuccessColor),
                ref: ref,
                isCommand: true,
              ));
        }
        await Future.wait(ftrs.map((e) => e()));
        Future<void> round(WidgetRef ref) async {
          // in each round we wanna listen to the jump,
          // and if we do not recieve data in 500ms, that
          // means the player did not jump, so we break the loop
          final strm = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
          var streamer = Streamer(strm);
          streamer = Streamer(strm).listen(
            onData: (event) async {
              final devid = event.deviceId;
              final playerid = playerId(devid);

              if (ljtMap[playerid] == null) {
                StaticGameManager.ledColor(
                  devid,
                  SidesColorsModel.all(mainColor),
                  ref: ref,
                );
              }

              final currentTime = DateTime.now();

              if (ljtMap[playerid] != null &&
                  currentTime.difference(ljtMap[playerid]!).inMilliseconds >
                      500) {
                streamer.cancel();
                return;
              }

              ljtMap[playerid] = DateTime.now();
              // TODO: add start time when we start first round,
              // and end time when we end the jump

              StaticGameManager.addDistance(
                ref: ref,
                playerId: playerid,
                distance: event.distance,
              );
            },
          );

          await streamer.doneOr(
            () async =>
                (ljtMap.values.every((element) => element != null) &&
                    ljtMap.entries.every((element) =>
                        DateTime.now()
                            .difference(element.value!)
                            .inMilliseconds >
                        500)) ||
                ref.watch(gameEndingProvider),
          );
        }

        await game.setup.executeGame(
          ref,
          round,
          disposeCb: (ref) async {
            return true;
          },
        );
      },
    );
  }

  static StaticGameModel xox(WidgetRef ref) {
    return StaticGameModel(
      id: 's7',
      metaData: GameMetaDataModel(
        id: 's7',
        name: "XOX",
        description: "Hedef rengini seç. XOX'te maharetini göster!",
        imagePath: '7',
        playerCount: NumRange.playerCount(
          min: 2,
          max: 2,
        ),
        padCount: NumRange.padCount(
          min: 9,
          max: 9,
        ),
        tag: GameTag.intelligence,
        earnings: [
          GameEarning.intelligence,
        ],
        categories: {
          GameCategory.edu: 26,
          GameCategory.entertainment: 16,
          GameCategory.multiplayer: 7,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.none,
        scoreTypeParam2: GameScoreType.none,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel esliKapmaca(WidgetRef ref) {
    return StaticGameModel(
      id: 's8',
      metaData: GameMetaDataModel(
        id: 's8',
        name: "Eşli Kapmaca",
        description:
            "Her çift renk gördüğünde, renklerden birini yakala! Acele etmeyi unutma.",
        imagePath: '8',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 10,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.focus,
          GameEarning.auditory,
          GameEarning.reflex,
        ],
        categories: {
          GameCategory.sports: 36,
          GameCategory.entertainment: 12,
          GameCategory.multiplayer: 13,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.none,
        scoreTypeParam2: GameScoreType.none,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel padGuresi(WidgetRef ref) {
    return StaticGameModel(
      id: 's9',
      metaData: GameMetaDataModel(
        id: 's9',
        name: "Pad Güreşi",
        description:
            "Yeni nesil mendil kapmaca! Pad'ini sırtına bağla. Rakibinin Pad'ini önce sen yakala.",
        imagePath: '9',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 5,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        tag: GameTag.resistance,
        earnings: [
          GameEarning.resistance,
          GameEarning.agility,
        ],
        categories: {
          GameCategory.sports: 37,
          //GameCategory.entertainment: 12,
          GameCategory.multiplayer: 9,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.none,
        scoreTypeParam2: GameScoreType.none,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel rengarenk(WidgetRef ref) {
    return StaticGameModel(
      id: 's10',
      metaData: GameMetaDataModel(
        id: 's10',
        name: instForGameScreen.game_title_10,
        description: instForGameScreen.game_description_10,
        imagePath: '10',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 10,
        ),
        tag: GameTag.visual,
        earnings: [
          GameEarning.visual,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.edu: 25,
          GameCategory.multiplayer: 23,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel sprint(WidgetRef ref) {
    return StaticGameModel(
      id: 's11',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's11',
        name: instForGameScreen.game_title_11,
        primaryScoreString: instForGameScreen.game_result_primary_score_sprint,
        description: instForGameScreen.game_description_11,
        imagePath: '11',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 1,
        ),
        duration: NumRange.duration(def: 15, min: 15, max: 90, step: 5),
        tag: GameTag.condition,
        earnings: [
          GameEarning.condition,
        ],
        categories: {
          GameCategory.sports: 18,
          GameCategory.multiplayer: 5,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.totalDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_2g,
          dataRate: DataRate.LIS2DH12_ODR_5kHz376_LP_1kHz344_NM_HP,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 1,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);

        final Map<String, StreamSubscription<TouchEvent>?> listenersMap = {
          for (final player in players) player.id: null,
        };

        final Map<String, DeviceModel> devsMap = {
          for (final player in players) player.id: player.devs[0],
        };

        final Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        final Map<String, bool> isLitMap = {
          for (final player in players) player.id: false,
        };

        Future<void> round(WidgetRef ref) async {
          for (var entry in listenersMap.entries
              .where((element) => element.value == null)) {
            final id = entry.key;

            final pDevId = devsMap[id]!.id;

            if (isLitMap[id] == false) {
              StaticGameManager.ledColorNoResponse(
                pDevId,
                SidesColorsModel.all(colorsMap[id]!),
                ref: ref,
                isCommand: true,
              );
            } else {
              StaticGameManager.ledOffNoResponse(
                pDevId,
                ref: ref,
              );
            }

            // inverse
            isLitMap[id] = isLitMap[id] == false;

            listenersMap[id] =
                StaticGameManager.listenToTouch(pDevId, ref: ref).listen(
              (event) {
                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: id,
                  time: event.responseTime!,
                );
                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: id,
                );

                listenersMap[id]?.cancel();
                listenersMap[id] = null;
              },
            );
          }

          await Future.doWhile(
            () async {
              await Future.delayed(Duration.zero);
              // when any player catches their map, skip to the next round
              // so we can reround them.
              return listenersMap.values.every((value) => value != null);
            },
          );
        }

        void cancelSub(StreamSubscription<TouchEvent>? u) {
          u?.cancel();
          u = null;
        }

        await game.setup.executeGame(ref, round);

        for (final value in listenersMap.values) {
          cancelSub(value);
        }
      },
    );
  }

  static StaticGameModel zipZip(WidgetRef ref) {
    return StaticGameModel(
      id: 's12',
      metaData: GameMetaDataModel(
        id: 's12',
        name: "Zıp Zıp",
        description:
            "Sıralı padler üzerinden tempo kaybetmeden zıplayarak geç. En çok zıpladığın Padi'i göreceksin. ",
        imagePath: '12',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 12,
        ),
        tag: GameTag.grossMotor,
        earnings: [
          GameEarning.grossMotor,
          GameEarning.muscleDev,
        ],
        categories: {
          GameCategory.sports: 15,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.maxDistance,
        scoreTypeParam2: GameScoreType.averageDistance,
        //TODO Add a new gamescoretype that seperates pads and assign them their individiual jump score
        sensorTypes: {
          UsedSensorsType.distance: false,
        },
        doesHaveSound: false,
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel kolaysaYakala(WidgetRef ref) {
    return StaticGameModel(
      id: 's13',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's13',
        name: instForGameScreen.game_title_13,
        description: instForGameScreen.game_description_13,
        imagePath: '13',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 15,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        delay: NumRange.delay(
            def: 450,
            min: 300,
            max: GameDurations.normalGameDurationMax,
            step: 150),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 10,
          GameCategory.entertainment: 4,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];
        var delay = game.setup.delay?.def;
        switch (delay) {
          case 300:
            delay = 600; //600-750
            break;
          case 450:
            delay = 450; //450-600
            break;
          case 600:
            delay = 300; //300-450
            break;
          default:
        }
        List<DeviceModel> devs = List.from(generalPlayer.devs);
        Duration? correctRespTime;
        Duration? incorrectRespTime;
        String devid = '';
        final devListener = StaticGameManager.listenToTouchMulti(
            devs.map((e) => e.id),
            ref: ref);
        final streamer = Streamer(devListener);
        bool catchStatus = false;
        Future<void> round(WidgetRef ref) async {
          Future roundCycler() async {
            do {
              devs = DeviceShuffler.shuffleDevicesUniquely(devs);
              final dev = devs[0];
              devid = dev.id;
              await StaticGameManager.ledColor(
                dev.id,
                SidesColorsModel.all(mainColor),
                ref: ref,
                isCommand: true,
              );

              await Future.delayed(const Duration(milliseconds: 50));

              await Future.delayed(
                  Duration(
                      milliseconds: (catchStatus ? 600 : 0) +
                          Random().nextInt(150) +
                          (delay ?? 0)), () {
                catchStatus = false;
              });

              await StaticGameManager.ledOff(
                dev.id,
                ref: ref,
                isCommand: true,
              );
            } while (!ref.watch(gameEndingProvider));
          }

          streamer.listen(
            onData: (event) async {
              if (event.isValid) {
                if (event.deviceId == devid) {
                  catchStatus = true;
                  correctRespTime = event.responseTime;
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );
                  if (correctRespTime != null) {
                    StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                        StaticGameManager.getScore(
                                playerId: mainPlayer.id, ref: ref)
                            .toDouble(),
                        correctRespTime!.durationToDoubleForGraph(),
                      ),
                    );
                  }

                  StaticGameManager.ledColor(
                    event.deviceId,
                    SidesColorsModel.all(gameSuccessColor),
                    ref: ref,
                  );

                  await Future.delayed(const Duration(milliseconds: 300))
                      .then((value) async {});
                } else {
                  incorrectRespTime = event.responseTime;
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );
                  if (incorrectRespTime != null) {
                    StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                        StaticGameManager.getScore(
                                playerId: mainPlayer.id, ref: ref)
                            .toDouble(),
                        incorrectRespTime!.durationToDoubleForGraph(),
                      ),
                    );
                  }
                }
              }
            },
          );

          roundCycler();
          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
        }

        Future<bool> disposeCb(ref) async {
          streamer.cancel();
          return true;
        }

        await game.setup.executeGame(ref, round, disposeCb: disposeCb);
      },
    );
  }

  static StaticGameModel dikkatTesti(WidgetRef ref) {
    return StaticGameModel(
      id: '52',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '52',
        name: instForGameScreen.game_title_52,
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        //TODO: change score string
        description: instForGameScreen.game_description_14,
        //TODO: change description
        imagePath: '52',
        //TODO: change image

        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 10,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
          step: 10,
        ),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(
          def: 0,
          min: 0,
          max: 5,
        ),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.focus,
          GameEarning.reflex,
        ],
        badgeType: GameBadgeTypes.none,
        categories: {GameCategory.test: 1},
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.score,
          scoreTypeParam3: GameScoreType.minDuration,
          scoreTypeParam4: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
          isScore: true,
          sensorTypes: {
            UsedSensorsType.tap: true,
            UsedSensorsType.distance: false
          },
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 45,
            timeout: 200,
          ),
          dstConfig: const DstConfigModel(
              threshold: 150, timeout: 400, limitValue: 7)),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        var devs = ref.read(selectedGeneralPlayerProv)!.player.devs;
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };
        final playerId = players.first.id;
        final playerColor = players.first.clrs.first;
        final delay = game.setup.delay?.def ?? 0;

        getPlayerColor() {
          return playerColor;
        }

        List<Color> getValidColors() {
          final playerClr = getPlayerColor();
          final allClrs = defaultConstColors(ref).toSet();
          final val = allClrs.difference({playerClr});
          return val.toList();
        }

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        var validColors = getValidColors();
        String cordevId = '';
        String? prevDeviceId;

        Future<void> round(WidgetRef ref) async {
          roundCycler() async {
            cordevId = '';
            bool randomChecker = false;
            while (!randomChecker) {
              devs = DeviceShuffler.shuffleDevicesUniquely(devs);
              validColors = DeviceShuffler.shuffleColorsUniquely(validColors);

              if (prevDeviceId == null || prevDeviceId != devs.first.id) {
                randomChecker = true;
                prevDeviceId = devs.first.id;
              }
            }

            final ftrs = [];
            for (int i = 0; i < devs.length; i++) {
              Color? colorForLed;
              if (i > 0) {
                colorForLed = validColors.elementAt(i - 1);
              } else {
                colorForLed = playerColor;
                devsMap[playerId] = devs.elementAt(i);
                cordevId = devs.elementAt(i).id;
              }
              ftrs.add(
                () => StaticGameManager.ledColor(
                  devs.elementAt(i).id,
                  SidesColorsModel.all(colorForLed!),
                  ref: ref,
                  isCommand: true,
                ),
              );
            }
            await Future.wait(
              ftrs.map((e) => e()),
            );
          }

          await roundCycler();

          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);

          final listenerDistance = StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref);

          final streamer = Streamer(listener);

          final listenerStream = Streamer(listenerDistance);

          if (chosenSensor == UsedSensorsType.distance) {
            listenerStream.listen(onData: (event) async {
              try {
                final devId = event.deviceId;
                if (cordevId == devId) {
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: playerId,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: playerId,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: playerId,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: playerId, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                } else {
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: playerId,
                  );
                }

                if (delay > 0) {
                  await StaticGameManager.ledAllOffNoDelay(ref: ref);
                  if (ref.read(buzzerManagerProvider) && cordevId == devId) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  await Future.delayed(Duration(seconds: delay));
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                await roundCycler();
              } catch (e) {
                logger.d(e.toString());
              }
            });
          } else {
            streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  if (cordevId == devId) {
                    StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: playerId,
                      time: event.responseTime!,
                    );
                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: playerId,
                    );
                  } else {
                    StaticGameManager.decreaseScore(
                      ref: ref,
                      playerId: playerId,
                    );
                  }

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: playerId,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: playerId, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  if (delay > 0) {
                    StaticGameManager.ledAllOffNoDelay(ref: ref);
                    if (ref.read(buzzerManagerProvider) && cordevId == devId) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    Future.delayed(Duration(seconds: delay), () {})
                        .then((value) async {
                      roundCycler();
                    });
                    //await Future.delayed(const Duration(milliseconds: 100));
                  } else {
                    roundCycler();
                  }
                  await roundCycler();
                } catch (e) {
                  logger.d(e.toString());
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel dikkatDikkat(WidgetRef ref) {
    return StaticGameModel(
      id: 's14',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's14',
        name: instForGameScreen.game_title_14,
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_14,
        imagePath: '14',
        igaPickColor: true,
        igaIngGameTextSpans: [
          igaGameStartedTextSpans(ref),
          [
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_first,
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 18.sp)),
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_second,
                style: Theme.of(ref.context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: CpColors.cpPrimary,
                    fontSize: 18.sp)),
          ],
        ],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text_bold,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
          step: 10,
        ),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(
          def: 0,
          min: 0,
          max: 5,
        ),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.decision_making,
          GameEarning.reaction_speed,
          GameEarning.neural_priming,
        ],
        categories: {
          GameCategory.sports: 2,
          GameCategory.edu: 2,
          GameCategory.entertainment: 17,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.score,
          scoreTypeParam3: GameScoreType.minDuration,
          scoreTypeParam4: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
          isScore: true,
          sensorTypes: {
            UsedSensorsType.tap: true,
            UsedSensorsType.distance: false
          },
          allowSameColor: false,
          vibrationActivate: true,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 20,
            timeout: 200,
          ),
          dstConfig: const DstConfigModel(
              threshold: 1000, timeout: 400, limitValue: 7)),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        var devs = ref.read(selectedGeneralPlayerProv)!.player.devs;

        if (ref.read(currentEmbModeManager) == 1) {
          devs = ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy
              ? ref
                  .read(igaBackGroundManager.notifier)
                  .easyDiscoveredDevices
                  .toList()
              : ref.read(bleConPr).keys.toList();
          logger.i("Easy Selection Devices: ${devs.length}");
        }

        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };
        final playerId = players.first.id;
        final playerColor = players.first.clrs.first;
        final delay = game.setup.delay?.def ?? 0;

        getPlayerColor() {
          return playerColor;
        }

        List<Color> getValidColors() {
          final playerClr = getPlayerColor();
          final allClrs = defaultConstColors(ref).toSet();
          final val = allClrs.difference({playerClr});
          List<Color> list = [];
          if (ref.read(currentEmbModeManager) == 1) {
            list =
                allClrs.difference({playerClr}).toList().sublist(0, 5).toList();
          }

          list.addAll(val.toList());

          return list;
        }

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        String? lastWrongDeviceId;
        var validColors = getValidColors();
        String cordevId = '';
        String? prevDeviceId;
        bool deadTimeout = false;
        Future<void> round(WidgetRef ref) async {
          //setings pads and colors for the game round and shuffle them
          roundCycler() async {
            deadTimeout = false;
            cordevId = '';
            bool randomChecker = false;
            while (!randomChecker) {
              devs = DeviceShuffler.shuffleDevicesUniquely(devs);
              validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
              if (prevDeviceId == null || prevDeviceId != devs.first.id) {
                randomChecker = true;
                prevDeviceId = devs.first.id;
              }
            }

            final ftrs = [];
            for (int i = 0; i < devs.length; i++) {
              Color? colorForLed;
              if (i > 0) {
                colorForLed = validColors.elementAt(i - 1);
              } else {
                colorForLed = playerColor;
                devsMap[playerId] = devs.elementAt(i);
                cordevId = devs.elementAt(i).id;
              }
              ftrs.add(
                () => StaticGameManager.ledColor(
                  devs.elementAt(i).id,
                  SidesColorsModel.all(colorForLed!),
                  ref: ref,
                  isCommand: true,
                ),
              );
            }
            await Future.wait(
              ftrs.map((e) => e()),
            );
          }

          await roundCycler();

          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);

          final listenerDistance = StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref);

          final streamer = Streamer(listener);

          final listenerStream = Streamer(listenerDistance);

          if (chosenSensor == UsedSensorsType.distance) {
            listenerStream.listen(onData: (event) async {
              try {
                if (event.isValid) {
                  final devId = event.deviceId;

                  // if the  correct color pick, run code below
                  if (cordevId == devId) {
                    //Weirds situations

                    // ref.read(currentHasDelayState.notifier).startDelay();

                    StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: playerId,
                      time: event.responseTime!,
                    );
                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: playerId,
                    );
                    StaticGameManager.addFlSpot(
                        ref: ref,
                        playerId: playerId,
                        spot: FlSpot(
                            StaticGameManager.getScore(
                                    playerId: playerId, ref: ref)
                                .toDouble(),
                            event.responseTime!.durationToDoubleForGraph()));

                    // Pads wait for a time we chosen when color picked

                    StaticGameManager.ledAllOffWithDelay(ref: ref);
                    
                    if (ref.read(buzzerManagerProvider.notifier).state &&
                        cordevId == devId) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    Future.delayed(Duration(seconds: delay))
                        .then((value) async {
                      await roundCycler();
                    });
                  } else {
                    // if the wrong color pick, run code below
                    if (lastWrongDeviceId != devId) {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      await StaticGameManager.ledAllOffWithDelay(ref: ref);
                      Future.delayed(Duration(seconds: delay))
                          .then((value) async {
                        await roundCycler();
                      });
                    }
                  }
                }
              } catch (e) {
                logger.d(e.toString());
              }
            });
          } else {
            streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;

                  if (event.isValid && deadTimeout == false) {
                    deadTimeout = true;
                    if (cordevId == devId) {
                      StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: playerId,
                        time: event.responseTime!,
                      );
                      StaticGameManager.increaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      StaticGameManager.addFlSpot(
                          ref: ref,
                          playerId: playerId,
                          spot: FlSpot(
                              StaticGameManager.getScore(
                                      playerId: playerId, ref: ref)
                                  .toDouble(),
                              event.responseTime!.durationToDoubleForGraph()));
                    } else {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                    }
                    StaticGameManager.ledAllOffNoDelay(ref: ref);

                    if (ref.read(buzzerManagerProvider) && cordevId == devId) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    Future.delayed(Duration(seconds: delay))
                        .then((value) async {
                      roundCycler();
                    });
                  }
                } catch (e) {
                  logger.d(e.toString());
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
          await listenerStream
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel dikkatDikkat2G(WidgetRef ref) {
    return StaticGameModel(
      id: 's14',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's14',
        name: '${instForGameScreen.game_title_14}2G',
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_14,
        imagePath: '14',
        igaPickColor: true,
        igaIngGameTextSpans: [
          igaGameStartedTextSpans(ref),
          [
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_first,
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 18.sp)),
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_second,
                style: Theme.of(ref.context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: CpColors.cpPrimary,
                    fontSize: 18.sp)),
          ],
        ],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text_bold,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
          step: 10,
        ),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(
          def: 0,
          min: 0,
          max: 5,
        ),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.decision_making,
          GameEarning.reaction_speed,
          GameEarning.neural_priming,
        ],
        categories: {
          GameCategory.sports: 2,
          GameCategory.edu: 2,
          GameCategory.entertainment: 17,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.score,
          scoreTypeParam3: GameScoreType.minDuration,
          scoreTypeParam4: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
          isScore: true,
          sensorTypes: {
            UsedSensorsType.tap: true,
            UsedSensorsType.distance: false
          },
          allowSameColor: false,
          vibrationActivate: true,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_2g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 20,
            timeout: 200,
          ),
          dstConfig: const DstConfigModel(
            threshold: 1000,
            timeout: 400,
          )),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        var devs = ref.read(selectedGeneralPlayerProv)!.player.devs;

        if (ref.read(currentEmbModeManager) == 1) {
          devs = ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy
              ? ref
                  .read(igaBackGroundManager.notifier)
                  .easyDiscoveredDevices
                  .toList()
              : ref.read(bleConPr).keys.toList();
          logger.i("Easy Selection Devices: ${devs.length}");
        }

        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };
        final playerId = players.first.id;
        final playerColor = players.first.clrs.first;
        final delay = game.setup.delay?.def ?? 0;

        getPlayerColor() {
          return playerColor;
        }

        List<Color> getValidColors() {
          final playerClr = getPlayerColor();
          final allClrs = defaultConstColors(ref).toSet();
          final val = allClrs.difference({playerClr});
          List<Color> list = [];
          if (ref.read(currentEmbModeManager) == 1) {
            list =
                allClrs.difference({playerClr}).toList().sublist(0, 5).toList();
          }

          list.addAll(val.toList());

          return list;
        }

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        String? lastWrongDeviceId;
        var validColors = getValidColors();
        String cordevId = '';
        String? prevDeviceId;

        Future<void> round(WidgetRef ref) async {
          roundCycler() async {
            cordevId = '';
            bool randomChecker = false;
            while (!randomChecker) {
              devs = DeviceShuffler.shuffleDevicesUniquely(devs);
              validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
              if (prevDeviceId == null || prevDeviceId != devs.first.id) {
                randomChecker = true;
                prevDeviceId = devs.first.id;
              }
            }

            final ftrs = [];
            for (int i = 0; i < devs.length; i++) {
              Color? colorForLed;
              if (i > 0) {
                colorForLed = validColors.elementAt(i - 1);
              } else {
                colorForLed = playerColor;
                devsMap[playerId] = devs.elementAt(i);
                cordevId = devs.elementAt(i).id;
              }
              ftrs.add(
                () => StaticGameManager.ledColor(
                  devs.elementAt(i).id,
                  SidesColorsModel.all(colorForLed!),
                  ref: ref,
                  isCommand: true,
                ),
              );
            }
            await Future.wait(
              ftrs.map((e) => e()),
            );
          }

          await roundCycler();

          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);

          final listenerDistance = StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref);

          final streamer = Streamer(listener);

          final listenerStream = Streamer(listenerDistance);

          if (chosenSensor == UsedSensorsType.distance) {
            listenerStream.listen(onData: (event) async {
              try {
                if (event.isValid) {
                  final devId = event.deviceId;

                  // if the  correct color pick, run code below

                  if (cordevId == devId) {
                    //Weirds situations

                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: playerId,
                      time: event.responseTime!,
                    );
                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: playerId,
                    );
                    StaticGameManager.addFlSpot(
                        ref: ref,
                        playerId: playerId,
                        spot: FlSpot(
                            StaticGameManager.getScore(
                                    playerId: playerId, ref: ref)
                                .toDouble(),
                            event.responseTime!.durationToDoubleForGraph()));

                    // Pads wait for a time we chosen when color picked

                    StaticGameManager.ledAllOffWithDelay(ref: ref);

                    Future.delayed(Duration(seconds: delay))
                        .then((value) async {
                      await roundCycler();
                    });
                  } else {
                    // if the wrong color pick, run code below
                    if (lastWrongDeviceId != devId) {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      await StaticGameManager.ledAllOffWithDelay(ref: ref);
                      Future.delayed(Duration(seconds: delay))
                          .then((value) async {
                        await roundCycler();
                      });
                    }
                  }
                }
              } catch (e) {
                logger.d(e.toString());
              }
            });
          } else {
            streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  if (event.isValid) {
                    if (cordevId == devId) {
                      if (ref.read(buzzerManagerProvider)) {
                        CustomDevDebugOperations.playAudio(event.deviceId, ref,
                            val: BeepModel.beep3);
                      }
                      StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: playerId,
                        time: event.responseTime!,
                      );
                      StaticGameManager.increaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      StaticGameManager.addFlSpot(
                          ref: ref,
                          playerId: playerId,
                          spot: FlSpot(
                              StaticGameManager.getScore(
                                      playerId: playerId, ref: ref)
                                  .toDouble(),
                              event.responseTime!.durationToDoubleForGraph()));
                    } else {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                    }

                    if (delay > 0) {
                      await StaticGameManager.ledAllOffNoDelay(ref: ref);
                      await Future.delayed(Duration(seconds: delay))
                          .then((value) async {
                        roundCycler();
                      });
                    } else {
                      roundCycler();
                    }
                  }
                } catch (e) {
                  logger.d(e.toString());
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
          await listenerStream
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel dikkatDikkat4G(WidgetRef ref) {
    return StaticGameModel(
      id: 's14',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's14',
        name: '${instForGameScreen.game_title_14}4G',
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_14,
        imagePath: '14',
        igaPickColor: true,
        igaIngGameTextSpans: [
          igaGameStartedTextSpans(ref),
          [
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_first,
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 18.sp)),
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_second,
                style: Theme.of(ref.context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: CpColors.cpPrimary,
                    fontSize: 18.sp)),
          ],
        ],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text_bold,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
          step: 10,
        ),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(
          def: 0,
          min: 0,
          max: 5,
        ),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.decision_making,
          GameEarning.reaction_speed,
          GameEarning.neural_priming,
        ],
        categories: {
          GameCategory.sports: 2,
          GameCategory.edu: 2,
          GameCategory.entertainment: 17,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.score,
          scoreTypeParam3: GameScoreType.minDuration,
          scoreTypeParam4: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
          isScore: true,
          sensorTypes: {
            UsedSensorsType.tap: true,
            UsedSensorsType.distance: false
          },
          allowSameColor: false,
          vibrationActivate: true,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_4g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 20,
            timeout: 200,
          ),
          dstConfig: const DstConfigModel(
            threshold: 1000,
            timeout: 400,
          )),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        var devs = ref.read(selectedGeneralPlayerProv)!.player.devs;

        if (ref.read(currentEmbModeManager) == 1) {
          devs = ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy
              ? ref
                  .read(igaBackGroundManager.notifier)
                  .easyDiscoveredDevices
                  .toList()
              : ref.read(bleConPr).keys.toList();
          logger.i("Easy Selection Devices: ${devs.length}");
        }

        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };
        final playerId = players.first.id;
        final playerColor = players.first.clrs.first;
        final delay = game.setup.delay?.def ?? 0;

        getPlayerColor() {
          return playerColor;
        }

        List<Color> getValidColors() {
          final playerClr = getPlayerColor();
          final allClrs = defaultConstColors(ref).toSet();
          final val = allClrs.difference({playerClr});
          List<Color> list = [];
          if (ref.read(currentEmbModeManager) == 1) {
            list =
                allClrs.difference({playerClr}).toList().sublist(0, 5).toList();
          }

          list.addAll(val.toList());

          return list;
        }

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        String? lastWrongDeviceId;
        var validColors = getValidColors();
        String cordevId = '';
        String? prevDeviceId;

        Future<void> round(WidgetRef ref) async {
          roundCycler() async {
            cordevId = '';
            bool randomChecker = false;
            while (!randomChecker) {
              devs = DeviceShuffler.shuffleDevicesUniquely(devs);
              validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
              if (prevDeviceId == null || prevDeviceId != devs.first.id) {
                randomChecker = true;
                prevDeviceId = devs.first.id;
              }
            }

            final ftrs = [];
            for (int i = 0; i < devs.length; i++) {
              Color? colorForLed;
              if (i > 0) {
                colorForLed = validColors.elementAt(i - 1);
              } else {
                colorForLed = playerColor;
                devsMap[playerId] = devs.elementAt(i);
                cordevId = devs.elementAt(i).id;
              }
              ftrs.add(
                () => StaticGameManager.ledColor(
                  devs.elementAt(i).id,
                  SidesColorsModel.all(colorForLed!),
                  ref: ref,
                  isCommand: true,
                ),
              );
            }
            await Future.wait(
              ftrs.map((e) => e()),
            );
          }

          await roundCycler();

          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);

          final listenerDistance = StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref);

          final streamer = Streamer(listener);

          final listenerStream = Streamer(listenerDistance);

          if (chosenSensor == UsedSensorsType.distance) {
            listenerStream.listen(onData: (event) async {
              try {
                if (event.isValid) {
                  final devId = event.deviceId;

                  // if the  correct color pick, run code below

                  if (cordevId == devId) {
                    //Weirds situations

                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: playerId,
                      time: event.responseTime!,
                    );
                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: playerId,
                    );
                    StaticGameManager.addFlSpot(
                        ref: ref,
                        playerId: playerId,
                        spot: FlSpot(
                            StaticGameManager.getScore(
                                    playerId: playerId, ref: ref)
                                .toDouble(),
                            event.responseTime!.durationToDoubleForGraph()));

                    // Pads wait for a time we chosen when color picked

                    StaticGameManager.ledAllOffWithDelay(ref: ref);

                    Future.delayed(Duration(seconds: delay))
                        .then((value) async {
                      await roundCycler();
                    });
                  } else {
                    // if the wrong color pick, run code below
                    if (lastWrongDeviceId != devId) {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      await StaticGameManager.ledAllOffWithDelay(ref: ref);
                      Future.delayed(Duration(seconds: delay))
                          .then((value) async {
                        await roundCycler();
                      });
                    }
                  }
                }
              } catch (e) {
                logger.d(e.toString());
              }
            });
          } else {
            streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  if (event.isValid) {
                    if (cordevId == devId) {
                      if (ref.read(buzzerManagerProvider)) {
                        CustomDevDebugOperations.playAudio(event.deviceId, ref,
                            val: BeepModel.beep3);
                      }
                      StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: playerId,
                        time: event.responseTime!,
                      );
                      StaticGameManager.increaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      StaticGameManager.addFlSpot(
                          ref: ref,
                          playerId: playerId,
                          spot: FlSpot(
                              StaticGameManager.getScore(
                                      playerId: playerId, ref: ref)
                                  .toDouble(),
                              event.responseTime!.durationToDoubleForGraph()));
                    } else {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                    }

                    if (delay > 0) {
                      await StaticGameManager.ledAllOffNoDelay(ref: ref);
                      await Future.delayed(Duration(seconds: delay))
                          .then((value) async {
                        roundCycler();
                      });
                    } else {
                      roundCycler();
                    }
                  }
                } catch (e) {
                  logger.d(e.toString());
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
          await listenerStream
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel dikkatDikkat8G(WidgetRef ref) {
    return StaticGameModel(
      id: 's14',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's14',
        name: '${instForGameScreen.game_title_14}8G',
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_14,
        imagePath: '14',
        igaPickColor: true,
        igaIngGameTextSpans: [
          igaGameStartedTextSpans(ref),
          [
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_first,
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 18.sp)),
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_second,
                style: Theme.of(ref.context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: CpColors.cpPrimary,
                    fontSize: 18.sp)),
          ],
        ],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text_bold,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen.iga_attention_stepper_two_text_bold,
                  style: Theme.of(ref.context).textTheme.headlineLarge),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_attention_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
          step: 10,
        ),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(
          def: 0,
          min: 0,
          max: 5,
        ),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.decision_making,
          GameEarning.reaction_speed,
          GameEarning.neural_priming,
        ],
        categories: {
          GameCategory.sports: 2,
          GameCategory.edu: 2,
          GameCategory.entertainment: 17,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.score,
          scoreTypeParam3: GameScoreType.minDuration,
          scoreTypeParam4: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
          isScore: true,
          sensorTypes: {
            UsedSensorsType.tap: true,
            UsedSensorsType.distance: false
          },
          allowSameColor: false,
          vibrationActivate: true,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_8g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 20,
            timeout: 200,
          ),
          dstConfig: const DstConfigModel(
            threshold: 1000,
            timeout: 400,
          )),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        var devs = ref.read(selectedGeneralPlayerProv)!.player.devs;

        if (ref.read(currentEmbModeManager) == 1) {
          devs = ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy
              ? ref
                  .read(igaBackGroundManager.notifier)
                  .easyDiscoveredDevices
                  .toList()
              : ref.read(bleConPr).keys.toList();
          logger.i("Easy Selection Devices: ${devs.length}");
        }

        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };
        final playerId = players.first.id;
        final playerColor = players.first.clrs.first;
        final delay = game.setup.delay?.def ?? 0;

        getPlayerColor() {
          return playerColor;
        }

        List<Color> getValidColors() {
          final playerClr = getPlayerColor();
          final allClrs = defaultConstColors(ref).toSet();
          final val = allClrs.difference({playerClr});
          List<Color> list = [];
          if (ref.read(currentEmbModeManager) == 1) {
            list =
                allClrs.difference({playerClr}).toList().sublist(0, 5).toList();
          }

          list.addAll(val.toList());

          return list;
        }

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        String? lastWrongDeviceId;
        var validColors = getValidColors();
        String cordevId = '';
        String? prevDeviceId;

        Future<void> round(WidgetRef ref) async {
          roundCycler() async {
            cordevId = '';
            bool randomChecker = false;
            while (!randomChecker) {
              devs = DeviceShuffler.shuffleDevicesUniquely(devs);
              validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
              if (prevDeviceId == null || prevDeviceId != devs.first.id) {
                randomChecker = true;
                prevDeviceId = devs.first.id;
              }
            }

            final ftrs = [];
            for (int i = 0; i < devs.length; i++) {
              Color? colorForLed;
              if (i > 0) {
                colorForLed = validColors.elementAt(i - 1);
              } else {
                colorForLed = playerColor;
                devsMap[playerId] = devs.elementAt(i);
                cordevId = devs.elementAt(i).id;
              }
              ftrs.add(
                () => StaticGameManager.ledColor(
                  devs.elementAt(i).id,
                  SidesColorsModel.all(colorForLed!),
                  ref: ref,
                  isCommand: true,
                ),
              );
            }
            await Future.wait(
              ftrs.map((e) => e()),
            );
          }

          await roundCycler();

          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);

          final listenerDistance = StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref);

          final streamer = Streamer(listener);

          final listenerStream = Streamer(listenerDistance);

          if (chosenSensor == UsedSensorsType.distance) {
            listenerStream.listen(onData: (event) async {
              try {
                if (event.isValid) {
                  final devId = event.deviceId;

                  // if the  correct color pick, run code below

                  if (cordevId == devId) {
                    //Weirds situations

                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: playerId,
                      time: event.responseTime!,
                    );
                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: playerId,
                    );
                    StaticGameManager.addFlSpot(
                        ref: ref,
                        playerId: playerId,
                        spot: FlSpot(
                            StaticGameManager.getScore(
                                    playerId: playerId, ref: ref)
                                .toDouble(),
                            event.responseTime!.durationToDoubleForGraph()));

                    // Pads wait for a time we chosen when color picked

                    StaticGameManager.ledAllOffWithDelay(ref: ref);

                    Future.delayed(Duration(seconds: delay))
                        .then((value) async {
                      await roundCycler();
                    });
                  } else {
                    // if the wrong color pick, run code below
                    if (lastWrongDeviceId != devId) {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      await StaticGameManager.ledAllOffWithDelay(ref: ref);
                      Future.delayed(Duration(seconds: delay))
                          .then((value) async {
                        await roundCycler();
                      });
                    }
                  }
                }
              } catch (e) {
                logger.d(e.toString());
              }
            });
          } else {
            streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  if (event.isValid) {
                    if (cordevId == devId) {
                      if (ref.read(buzzerManagerProvider)) {
                        CustomDevDebugOperations.playAudio(event.deviceId, ref,
                            val: BeepModel.beep3);
                      }
                      StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: playerId,
                        time: event.responseTime!,
                      );
                      StaticGameManager.increaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                      StaticGameManager.addFlSpot(
                          ref: ref,
                          playerId: playerId,
                          spot: FlSpot(
                              StaticGameManager.getScore(
                                      playerId: playerId, ref: ref)
                                  .toDouble(),
                              event.responseTime!.durationToDoubleForGraph()));
                    } else {
                      StaticGameManager.decreaseScore(
                        ref: ref,
                        playerId: playerId,
                      );
                    }

                    if (delay > 0) {
                      await StaticGameManager.ledAllOffNoDelay(ref: ref);
                      await Future.delayed(Duration(seconds: delay))
                          .then((value) async {
                        roundCycler();
                      });
                    } else {
                      roundCycler();
                    }
                  }
                } catch (e) {
                  logger.d(e.toString());
                }
              },
            );
          }

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
          await listenerStream
              .doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel stroopTest(WidgetRef ref) {
    final localestr = ref.read(appLangProv)?.locale.languageCode;
    return StaticGameModel(
      id: '79',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '79',
        name: instForGameScreen.game_title_79,
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_79,
        imagePath: localestr == 'tr' ? '79tr' : '79',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
          step: 5,
        ),
        /*duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(
          def: 0,
          min: 0,
          max: 5,
        ),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.focus,
        earnings: [
          GameEarning.focus,
          GameEarning.reflex,
        ],
        categories: {
          GameCategory.test: 1,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.score,
          scoreTypeParam3: GameScoreType.minDuration,
          scoreTypeParam4: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel.general(
              // colorCount: NumRange.count(min: 1, max: 1),
              // defaultSelectedColors: [gameErrorColor]
              ),
          generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
          ),
          gameDropOptionsModel: GameDropOptionsModel(
              dropOptionTitle: instForGameScreen.score_target,
              options: [
                DropOption(
                    optionTitle: StroopModes.text.textNotation(ref.context),
                    optionValue: StroopModes.text),
                DropOption(
                    optionTitle: StroopModes.color.textNotation(ref.context),
                    optionValue: StroopModes.color)
              ]),
          controlsSetup: const GameControlsSetup(
            gameAudioControls: GameAudioSelectionSetup(
              gameAudioSetup: GameAudioSelectionSetupItem(
                isEnabled: true,
                isChangable: false,
              ),
              soundEffectsSetup: GameAudioSelectionSetupItem(
                isEnabled: true,
                isChangable: false,
              ),
            ),
          ),
          isScore: true,
          sensorTypes: {
            UsedSensorsType.tap: false,
          },
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 40,
            timeout: 150,
          ),
          dstConfig: const DstConfigModel(threshold: 1000, timeout: 175)),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final playerId = mainPlayer.id;
        var delay = game.setup.delay?.def;
        List<DeviceModel> devs = List.from(generalPlayer.devs);
        final screenWidgetUpdater = ref.read(gameScreenWidgetProv.notifier);
        final colorMap = defaultConstColorsAsMap(ref);
        final colors = colorMap.values.toList();
        final keys = colorMap.keys.toList();
        var optionValue =
            ref.read(currentDropOptionManager)?.optionValue ?? StroopModes.text;

        String currentKey = keys.first;
        Color currentColor = colors.first;
        Color correctColor = colors.elementAt(1);
        String cordevId = '';
        bool clickedonce = false;
        bool isCorrect = true;
        List<Color> validColors = [];
        int counter = 0;
        getValidColors() {
          final playerClr = currentColor;
          final allClrs = defaultConstColors(ref);
          final val = allClrs.toSet().difference({playerClr, correctColor});
          validColors = val.toList();
          logger.w('Valid Colors: $validColors');
        }

        roundCycler() async {
          cordevId = '';
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
          validColors.insert(0, correctColor);
          if (currentColor != correctColor) {
            validColors.insert(1, currentColor);
          }
          if (optionValue == StroopModes.color && !isCorrect) {
            currentKey = keys[colors.indexOf(validColors[2])];
          }

          if (clickedonce && delay! > 1) {
            await StaticGameManager.ledAllOffNoDelay(ref: ref);
            await Future.delayed(Duration(seconds: delay));
          }
          clickedonce = true;
          final ftrs = [];
          cordevId = devs.first.id;
          for (int i = 0, j = 0; i < devs.length; i++, j++) {
            if (j == validColors.length) {
              j = 0;
            }
            ftrs.add(
              () => StaticGameManager.ledColor(
                devs[i].id,
                SidesColorsModel.all(validColors.elementAt(j)),
                ref: ref,
                isCommand: true,
              ),
            );
          }
          await Future.wait(
            ftrs.map((e) => e()),
          );
        }

        Future roundGenerator() async {
          counter++;
          if (counter == 4) {
            isCorrect = false;
          }
          logger.i(keys.length);

          if (optionValue == StroopModes.text) {
            if (isCorrect) {
              final index = Random().nextInt(keys.length);
              currentKey = keys[index];
              currentColor = colors[index];
              correctColor = colors[index];
            } else {
              final index = Random().nextInt(keys.length);
              currentKey = keys[index];
              var secindex = Random().nextInt(keys.length);
              if (secindex == index) {
                while (secindex == index) {
                  secindex = Random().nextInt(keys.length);
                }
              }
              currentColor = colors[secindex];
              correctColor = colors[index];
            }
          } else {
            // "Color Mode" seçeneği

            if (isCorrect) {
              // Kullanıcı doğru yanıtı seçti
              final index = Random().nextInt(colors.length);
              currentKey = keys[index];
              currentColor = colors[index];
              correctColor = colors[index];
            } else {
              // Kullanıcı yanlış yanıtı seçti
              final colorIndex = Random().nextInt(colors.length);
              currentColor = colors[colorIndex];
              correctColor = colors[colorIndex];
            }
          }

          getValidColors();
          await roundCycler();

          screenWidgetUpdater.state = StroopTestWidget(
            color: currentColor,
            word: currentKey,
          );
        }

        Future<void> round(WidgetRef ref) async {
          await roundGenerator();

          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);

          final streamer = Streamer(listener);
          int waitPoint = 0;
          Set<String> deviceList = {};
          streamer.listen(
            onData: (event) async {
              deviceList.add(event.deviceId);

              try {
                final devId = event.deviceId;

                if (waitPoint == 0 ||
                    DateTime.now().millisecondsSinceEpoch > waitPoint) {
                  if (cordevId == devId) {
                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: playerId,
                      time: event.responseTime!,
                    );
                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: playerId,
                    );
                  } else {
                    StaticGameManager.decreaseScore(
                        ref: ref, playerId: playerId);
                  }
                  waitPoint = DateTime.now().millisecondsSinceEpoch + 300;
                }
                await roundGenerator();
                deviceList.clear();
              } catch (e) {
                logger.d(e.toString());
              }
            },
          );
          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel korebe(WidgetRef ref) {
    return StaticGameModel(
      id: 's15',
      metaData: GameMetaDataModel(
        id: 's15',
        name: "Körebe",
        description:
            "Yeni nesil körebe! Gözlerini kapat. Pad'lere kulak ver! Ses gelen Pad'i olabildiğince hızlı bulmaya çalış.",
        imagePath: '15',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 10,
          max: 10,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.entertainment: 14,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel testformula(WidgetRef ref) {
    return StaticGameModel(
      id: 's16',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's16',
        name: "TEST",
        primaryScoreString: "TEST",
        description: instForGameScreen.game_description_16,
        imagePath: '16',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 1,
          GameCategory.edu: 1,
          GameCategory.entertainment: 16,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
            defaultSelectedColors: [gameErrorColor]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
        },
        isIncludePeriodicQueue: true,
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);

        final mainPlayer = players.elementAt(0);

        final colors = mainPlayer.clrs;

        final includePeriodically = game.setup.isIncludePeriodicQueue;

        final mainColor = colors.first;

        int roundCount = 0;
        int sentTime = DateTime.now().millisecondsSinceEpoch;

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        final setup = ref.read(currentGameSetupProv)!;

        final wantedDis = setup.distance!.def;

        final delay = setup.delay!.def;

        final sender = SendStreamer<bool>();

        Streamer<DistanceEvent>? streamer;

        //Sometimes playing this game realizing bullshits. For example
        //if your pads on desk that unconfortable surface and unbalance legs,
        //when you hit to one pad affecting all pads. So this condition help
        //for us when firstly catch true goal then shut up to others pads.(100ms)
        //When this delay occure this [scoreCondition] setting false other
        //condition to false
        var scoreCondition = true;

        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;

        var devs = generalPlayer.devs;

        Future<void> round(WidgetRef ref) async {
          late DiscoveredDevice dev;
          if (ref.read(currentIncludePeriodicallyQueueManager)) {
            final cDevs =
                ref.read(currentPeriodicallyQueueManager).values.first;

            dev = cDevs.elementAt(ref.read(gameCurrRoundProv) % cDevs.length);
          } else {
            devs = DeviceShuffler.shuffleDevicesUniquely(devs);
            dev = devs.first;
          }

          bool newPadLed = true;

          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(mainColor),
            ref: ref,
            isCommand: true,
          );

          if (chosenSensor == UsedSensorsType.tap) {
            await for (final event
                in StaticGameManager.listenToTouch(dev.id, ref: ref)) {
              if (event.isValid && scoreCondition) {
                logger.i("Event:${event.responseTime?.inMilliseconds}");
                scoreCondition = false;
                try {
                  final receiverMs = DateTime.now().millisecondsSinceEpoch;
                  int elapsedTime = receiverMs - sentTime;
                  ref
                      .read(currentBleTrackerStateManager.notifier)
                      .addCommandTracker(
                          ref,
                          CommandTimeTracker(
                            senTime: sentTime,
                            turnCount: roundCount,
                            actionOfReceiverTime: receiverMs,
                            elapsedTime: elapsedTime,
                          ));
                } catch (e) {
                  logger.e("Error:$e");
                }

                logger.i("Response Time: ${event.responseTime.toString()}");

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                StaticGameManager.addFlSpot(
                    ref: ref,
                    playerId: mainPlayer.id,
                    spot: FlSpot(
                        StaticGameManager.getScore(
                                playerId: mainPlayer.id, ref: ref)
                            .toDouble(),
                        event.responseTime!.durationToDoubleForGraph()));

                await StaticGameManager.ledOff(dev.id, ref: ref);
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }

                await Future.delayed(Duration(seconds: delay!));
                await Future.delayed(const Duration(milliseconds: 100));
                scoreCondition = true;
              }
              break;
            }
          } else {
            final strm = StaticGameManager.listenToDistance(
              dev.id,
              ref: ref,
            );

            await for (final event in strm) {
              final dis = event.distance.distance;
              if ((event.isValid || dis < wantedDis!) &&
                  newPadLed &&
                  scoreCondition) {
                try {
                  final receiverMs = DateTime.now().millisecondsSinceEpoch;
                  int elapsedTime = receiverMs - sentTime;
                  ref
                      .read(currentBleTrackerStateManager.notifier)
                      .addCommandTracker(
                          ref,
                          CommandTimeTracker(
                            senTime: sentTime,
                            turnCount: roundCount,
                            actionOfReceiverTime: receiverMs,
                            elapsedTime: elapsedTime,
                          ));
                } catch (e) {
                  logger.e("Error:$e");
                }
                scoreCondition = false;

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                StaticGameManager.addFlSpot(
                    ref: ref,
                    playerId: mainPlayer.id,
                    spot: FlSpot(
                        StaticGameManager.getScore(
                                playerId: mainPlayer.id, ref: ref)
                            .toDouble(),
                        event.responseTime!.durationToDoubleForGraph()));

                sender.add(
                    () async => StaticGameManager.ledOff(dev.id, ref: ref));

                newPadLed = false;
                await StaticGameManager.ledOff(dev.id, ref: ref);
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                await Future.delayed(Duration(seconds: delay!));
                await Future.delayed(const Duration(milliseconds: 100));
                scoreCondition = true;
              }
              break;
            }

            await streamer?.doneOr(() async {
              if (!newPadLed) {
                streamer?.cancel();
                streamer = null;
              }
              return !newPadLed;
            });
          }
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          logger.i("FORMULA END!");
          streamer?.cancel();
          return true;
        });
      },
    );
  }

  static StaticGameModel testFormulaYarisi(WidgetRef ref) {
    return StaticGameModel(
      id: 's1',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's1',
        name: instForGameScreen.game_title_1,
        description: instForGameScreen.game_description_1,
        imagePath: '1',
        playerCount: NumRange.playerCount(
          min: 2,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 3,
          GameCategory.edu: 3,
          GameCategory.entertainment: 19,
          GameCategory.multiplayer: 7,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.catchCount,
          scoreTypeParam3: GameScoreType.totalDuration,
          scoreTypeParam4: GameScoreType.minDuration,
          scoreTypeParam5: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(
              min: 1,
              max: 1,
            ),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
          ),
          sensorTypes: {
            UsedSensorsType.tap: false,
            UsedSensorsType.distance: false,
          },
          allowSameColor: false,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 40,
            timeout: 150,
          ),
          dstConfig: const DstConfigModel(threshold: 1000, timeout: 100)),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final devs = ref.watch(selectedGeneralPlayerProv)!.player.devs;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        int roundCount = 0;

        int sentTime = DateTime.now().millisecondsSinceEpoch;

        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        final ran = Xrandom();

        DeviceModel? getUnusedDev(DeviceModel? thisone) {
          final thisId = thisone?.id;

          final otherOnes = devs.where((d) => d.id != thisId);
          final otherIds = otherOnes.map((d) => d.id).toList();
          final otherPlayerDeviceIds = devsMap.values
              .where((element) => element != null)
              .map((d) => d!.id)
              .toList();
          final otherUnoccupiedIds = otherIds
              .where((id) => !otherPlayerDeviceIds.contains(id))
              .toList();

          try {
            return devs
                .firstWhere((element) => element.id == otherUnoccupiedIds[0]);
          } catch (e) {
            assert(false);
            return null;
          }
        }

        final sender = SendStreamer<bool>();
        Streamer<TouchEvent>? streamer;
        Streamer<DistanceEvent>? streamerDist;

        switch (chosenSensor) {
          case UsedSensorsType.tap:
            streamer = Streamer(
              StaticGameManager.listenToTouchMulti(devs.map((e) => e.id),
                  ref: ref),
            );
            streamer = streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;

                  try {
                    final receiverMs = DateTime.now().millisecondsSinceEpoch;
                    int elapsedTime = receiverMs - sentTime;
                    ref
                        .read(currentBleTrackerStateManager.notifier)
                        .addCommandTracker(
                            ref,
                            CommandTimeTracker(
                              senTime: sentTime,
                              turnCount: roundCount,
                              actionOfReceiverTime: receiverMs,
                              elapsedTime: elapsedTime,
                            ));
                  } catch (e) {
                    logger.e("Error:$e");
                  }

                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);

                  final id = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: id,
                      spot: FlSpot(
                          StaticGameManager.getScore(playerId: id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  StaticGameManager.ledOff(
                    devId,
                    ref: ref,
                    isCommand: false,
                  );
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  final newDev = getUnusedDev(devsMap[id]);
                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;

                  roundCount += 1;
                  sentTime = DateTime.now().millisecondsSinceEpoch;

                  StaticGameManager.ledColor(
                    newDev.id,
                    SidesColorsModel.all(colorsMap[id]!),
                    ref: ref,
                    isCommand: true,
                  );
                } catch (e) {
                  e;
                }
              },
            );
            break;
          case UsedSensorsType.distance:
            streamerDist = Streamer(
              StaticGameManager.listenToDistanceMulti(devs.map((e) => e.id),
                  ref: ref),
            );

            streamerDist = streamerDist.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);
                  try {
                    final receiverMs = DateTime.now().millisecondsSinceEpoch;
                    int elapsedTime = receiverMs - sentTime;
                    logger.w(elapsedTime.toString());
                    ref
                        .read(currentBleTrackerStateManager.notifier)
                        .addCommandTracker(
                            ref,
                            CommandTimeTracker(
                              senTime: sentTime,
                              turnCount: roundCount,
                              actionOfReceiverTime: receiverMs,
                              elapsedTime: elapsedTime,
                            ));
                  } catch (e) {
                    logger.e("Error:$e");
                  }
                  final id = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: id,
                      spot: FlSpot(
                          StaticGameManager.getScore(playerId: id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                  sender.add(() async => await StaticGameManager.ledOff(
                        devId,
                        ref: ref,
                        isCommand: true,
                      ));
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  final newDev = getUnusedDev(devsMap[id]);
                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;

                  sender.add(() async => await StaticGameManager.ledColor(
                        newDev.id,
                        SidesColorsModel.all(colorsMap[id]!),
                        ref: ref,
                        isCommand: true,
                      ));
                } catch (e) {
                  e;
                }
              },
            );
            break;
          default:
        }

        Future<void> round(WidgetRef ref) async {
          devs.shuffle(ran);

          for (var entry in devsMap.entries) {
            final id = entry.key;
            final dev = entry.value;

            if (dev != null) {
              continue;
            }

            final pDev = getUnusedDev(devsMap[id]);
            if (pDev == null) {
              assert(false);
              continue;
            }
            devsMap[id] = pDev;

            final pDevId = pDev.id;

            StaticGameManager.ledColor(
              pDevId,
              SidesColorsModel.all(colorsMap[id]!),
              ref: ref,
              isCommand: true,
            );
          }

          // await Future.doWhile(
          //   () async {
          //     await Future.delayed(Duration.zero);
          //     // when any player catches their pad, skip to the next round
          //     // so we can reround them.
          //     return devsMap.values.every((value) => value != null);
          //   },
          // );
        }

        await game.setup.executeGame(ref, round, disposeCb: (val) async {
          streamer?.cancel();
          streamerDist?.cancel();
          ref.read(currentFinishControlManager.notifier).changState(true);
          PlayerResultModel? winnerResult;

          for (var player in ref.read(gameResultProv)!.players) {
            final result =
                ref.read(gameResultProv.notifier).getPlayer(player.id);
            if (result != null) {
              winnerResult ??= result;

              if (result.correctCount != null &&
                  result.correctCount! > winnerResult.correctCount!) {
                winnerResult = result;
              } else if (result.scorePoints != null &&
                  result.scorePoints!.length ==
                      winnerResult.scorePoints!.length) {
                if (winnerResult.averageDuration!.inSeconds >
                    result.averageDuration!.inSeconds) {
                  winnerResult = result;
                }
              }
            }
          }
          final currentDeviceList = ref.read(currentDevicesManagerProvider);
          final futureList = <Future>[];

          for (int i = 0; i < 3; i++) {
            if (winnerResult != null) {
              currentDeviceList.forEach((key, value) {
                futureList.add(StaticGameManager.ledColorNoResponse(
                  key,
                  SidesColorsModel.all(colorsMap[winnerResult!.playerId]!),
                  ref: ref,
                  isCommand: true,
                ));
              });
            }
            Future.wait(futureList);
            await Future.delayed(const Duration(milliseconds: 700));
            StaticGameManager.ledAllOffNoDelay(ref: ref);
          }
          return true;
        });
      },
    );
  }

  static StaticGameModel formula(WidgetRef ref) {
    return StaticGameModel(
      onLeaderboard: true,
      id: 's16',
      metaData: GameMetaDataModel(
        id: 's16',
        name: instForGameScreen.game_title_16,
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_16,
        imagePath: '16',
        igaPickColor: true,
        igaIngGameTextSpans: [
          igaGameStartedTextSpans(ref),
          [
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_first,
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 18.sp)),
            TextSpan(
                text: instForGameScreen.iga_formula_in_game_second,
                style: Theme.of(ref.context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: CpColors.cpPrimary,
                    fontSize: 18.sp)),
          ],
        ],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_formula_stepper_two_text_bold,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            if (ref.read(appLangProv)?.name == 'English')
              TextSpan(
                  text: instForGameScreen.iga_formula_stepper_two_text_bold
                      .capitalize(),
                  style: Theme.of(ref.context).textTheme.headlineLarge),
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
            if (ref.read(appLangProv)?.name == 'Türkçe')
              TextSpan(
                  text:
                      " ${instForGameScreen.iga_formula_stepper_two_text_bold}",
                  style: Theme.of(ref.context).textTheme.headlineLarge),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_formula_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        isContainOnIga: true,
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        delay: NumRange.delay(def: 0, min: 0, max: 10000, step: 250),
        timeout: NumRange.delay(def: 100, min: 0, max: 10000, step: 100),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reaction_speed,
          GameEarning.peripheral_vision,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 2,
          GameCategory.edu: 1,
          GameCategory.entertainment: 16,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
            defaultSelectedColors: [gameErrorColor]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
          UsedSensorsType.none: true
        },
        allowSameColor: false,
        isIncludePeriodicQueue: true,
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 10,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 150,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        ///-------
        Streamer<DistanceEvent>? streamer;
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors.first;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        final setup = ref.watch(currentGameProv)!.setup;
        final wantedDis = setup.distance!.def!;
        final delay = setup.delay!.def;
        final sender = SendStreamer<bool>();
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        int roundCount = 0;
        int sentTime = DateTime.now().millisecondsSinceEpoch;

        //Sometimes playing this game realizing bullshits. For example
        //if your pads on desk that unconfortable surface and unbalance legs,
        //when you hit to one pad affecting all pads. So this condition help
        //for us when firstly catch true goal then shut up to others pads.(100ms)
        //When this delay occure this [scoreCondition] setting false other
        //condition to false
        var scoreCondition = true;
        var devs = generalPlayer.devs;

        // if (ref.read(currentEmbModeManager) == 1) {
        //   ref
        //       .read(currentEffectEnableManager.notifier)
        //       .changeState(effectForce: true);
        // }

        if (ref.read(currentEmbModeManager) == 1 &&
            ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy) {
          devs = ref
              .read(igaBackGroundManager.notifier)
              .easyDiscoveredDevices
              .toList();
        }

        ///-------
        Future<void> round(WidgetRef ref) async {
          late DiscoveredDevice dev;
          var cDevs = [];
          if (ref.read(currentIncludePeriodicallyQueueManager)) {
            cDevs = ref.read(currentPeriodicallyQueueManager).values.first;
            dev = cDevs.elementAt(ref.read(gameCurrRoundProv) % cDevs.length);
          } else {
            devs = DeviceShuffler.shuffleDevicesUniquely(devs);
            dev = devs.first;
          }

          bool newPadLed = true;
          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(ref
                        .read(currentIncludePeriodicallyQueueManager) &&
                    ref
                            .read(currentPeriodicallyQueueManager.notifier)
                            .currentPerPeriod
                            ?.devices?[
                                ref.read(gameCurrRoundProv) % cDevs.length]
                            .colorStr !=
                        null
                ? Color(int.parse(
                        ref
                            .read(currentPeriodicallyQueueManager.notifier)
                            .currentPerPeriod!
                            .devices![
                                ref.read(gameCurrRoundProv) % cDevs.length]
                            .colorStr!
                            .replaceFirst('#', ''),
                        radix: 16) |
                    0xFF000000)
                : mainColor),
            ref: ref,
            isCommand: true,
          );

          // PadManager.toggleVibration(dev.id,
          //     ref: ref, vibrationOn: true, val: "90");

          if (chosenSensor == UsedSensorsType.tap) {
            await for (final event
                in StaticGameManager.listenToTouch(dev.id, ref: ref)) {
              if (event.isValid && scoreCondition) {
                scoreCondition = false;
                // try {
                //   final receiverMs = DateTime.now().millisecondsSinceEpoch;
                //   int elapsedTime = receiverMs - sentTime;
                //   // ref
                //   //     .read(currentBleTrackerStateManager.notifier)
                //   //     .addCommandTracker(
                //   //         ref,
                //   //         CommandTimeTracker(
                //   //           senTime: sentTime,
                //   //           turnCount: roundCount,
                //   //           actionOfReceiverTime: receiverMs,
                //   //           elapsedTime: elapsedTime,
                //   //         ));
                // } catch (e) {
                //   logger.e("Error:$e");
                // }

                if (ref.context.mounted) {
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                }

                StaticGameManager.ledOff(dev.id, ref: ref);

                if (ref.context.mounted && ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }

                await Future.delayed(Duration(milliseconds: delay!));
                await Future.delayed(const Duration(milliseconds: 20));
                scoreCondition = true;
              }
              break;
            }
          } else if (chosenSensor == UsedSensorsType.none) {
            await Future.delayed(Duration(milliseconds: setup.timeout!.def!));
            StaticGameManager.ledOff(dev.id, ref: ref);
          } else {
            final strm = StaticGameManager.listenToDistance(
              dev.id,
              ref: ref,
            );

            await for (final event in strm) {
              final dis = event.distance.distance;

              if ((event.isValid && dis < wantedDis) && newPadLed) {
                try {
                  await StaticGameManager.ledOff(dev.id, ref: ref);
                  final receiverMs = DateTime.now().millisecondsSinceEpoch;
                  int elapsedTime = receiverMs - sentTime;
                  ref
                      .read(currentBleTrackerStateManager.notifier)
                      .addCommandTracker(
                          ref,
                          CommandTimeTracker(
                            senTime: sentTime,
                            turnCount: roundCount,
                            actionOfReceiverTime: receiverMs,
                            elapsedTime: elapsedTime,
                          ));
                } catch (e) {
                  logger.e("Error:$e");
                }
                scoreCondition = false;

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                StaticGameManager.addFlSpot(
                    ref: ref,
                    playerId: mainPlayer.id,
                    spot: FlSpot(
                        StaticGameManager.getScore(
                                playerId: mainPlayer.id, ref: ref)
                            .toDouble(),
                        event.responseTime!.durationToDoubleForGraph()));

                sender.add(
                    () async => StaticGameManager.ledOff(dev.id, ref: ref));
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                newPadLed = false;

                await Future.delayed(Duration(milliseconds: delay!));
                await Future.delayed(const Duration(milliseconds: 20));
                break;
              }
            }

            await streamer?.doneOr(() async {
              if (!newPadLed) {
                final receiverMs = DateTime.now().millisecondsSinceEpoch;
                int elapsedTime = receiverMs - sentTime;
                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: Duration(milliseconds: elapsedTime),
                );
                streamer?.cancel();
                streamer = null;
              }
              return !newPadLed;
            });
          }
          roundCount++;
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          streamer?.cancel();
          return true;
        });
      },
    );
  }

  static List<TextSpan> igaGameStartedTextSpans(WidgetRef ref) {
    return [];
  }

  static StaticGameModel parkur(WidgetRef ref) {
    return StaticGameModel(
      id: 'xxp',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 'xxp',
        name: instForGameScreen.game_title_xxp,
        primaryScoreString:
            instForGameScreen.activity_default_scores_total_duration,
        description: instForGameScreen.game_description_16,
        imagePath: '16',
        playerCount: NumRange.playerCount(min: 1, max: 1),
        padCount: NumRange.padCount(min: 0, max: 12),
        duration: NumRange.duration(def: 3, min: 3, max: 20, step: 1),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],
        categories: {
          GameCategory.sports: 1,
          GameCategory.edu: 1,
          GameCategory.entertainment: 1,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
            defaultSelectedColors: [gameErrorColor]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
        },
        challengeTypes: {
          ChallengeType.sequential: true,
          ChallengeType.random: false,
        },
        sequenceMap: {0: ""},
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);

        final mainPlayer = players.elementAt(0);

        final colors = mainPlayer.clrs;

        final mainColor = colors.first;

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        final setup = ref.read(currentGameSetupProv)!;

        final wantedDis = setup.distance!.def;

        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;

        var devs = generalPlayer.devs;

        final delay = setup.delay!.def;

        final sender = SendStreamer<bool>();

        Streamer<DistanceEvent>? streamer;

        Future<void> round(WidgetRef ref) async {}

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          streamer?.cancel();
          return true;
        });
      },
    );
  }

  static StaticGameModel dinleYakala(WidgetRef ref) {
    final smallText = Theme.of(ref.context)
        .textTheme
        .headlineMedium!
        .copyWith(color: Colors.white);

    return StaticGameModel(
      id: '84',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '84',
        name: instForGameScreen.game_title_111,
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_80,
        imagePath: '84',
        igaPickColor: false,
        inGameIgaHeader:
            instForGameScreen.iga_listen_and_catch_in_game_header_text,
        igaIngGameTextSpans: [
          igaGameStartedTextSpans(ref),
          [
            TextSpan(
                text: instForGameScreen.iga_auditory_test_in_game_first,
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 18.sp)),
            TextSpan(
                text: instForGameScreen.iga_auditory_test_in_game_second,
                style: Theme.of(ref.context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: CpColors.cpPrimary,
                    fontSize: 18.sp)),
            TextSpan(
                text: instForGameScreen.iga_auditory_test_in_game_third,
                style: Theme.of(ref.context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: CpColors.cpPrimary, fontSize: 18.sp)),
          ],
        ],
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_countdown_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_listen_and_catch_in_game_header_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_one_text_first,
                style: smallText),
            TextSpan(
                text:
                    " ${instForGameScreen.iga_listen_and_catch_stepper_one_text_bold_second}",
                style: smallText.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_one_text_third,
                style: smallText),
          ],
          [
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_two_text_first,
                style: smallText),

            //FIX ME
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_red_second,
                  style: smallText.copyWith(
                      color: Colors.red, fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_red_second,
                  style: smallText.copyWith(
                      color: Colors.red, fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
          ],
          [
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_three_text_first,
                style: smallText),

            //FIX ME
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_three_text_green_second,
                  style: smallText.copyWith(
                      color: CpColors.cpLightGreen,
                      fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_three_text_green_second,
                  style: smallText.copyWith(
                      color: CpColors.cpLightGreen,
                      fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_listen_and_catch_stepper_four_text,
                style: smallText),
          ],
        ],
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 10),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        timeout: NumRange.duration(def: 1000, min: 500, max: 10000, step: 500),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.focus,
          GameEarning.auditory_reaction,
        ],
        categories: {
          GameCategory.test: 6,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.uncatchCount,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        scoreTypeParam6: GameScoreType.catchCount,
        stagedPlayerModel: const StagedPlayerModel(
            //colorCount: NumRange.count(min: 1, max: 1),
            defaultSelectedColors: [gameErrorColor]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        doesHaveSound: false,
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
          UsedSensorsType.none: true
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 75,
          timeout: 200,
        ),
        isScore: true,
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        final setup = ref.read(currentGameSetupProv)!;
        final wantedDis = setup.distance!.def;
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        if (ref.read(currentEmbModeManager) == 1 &&
            ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy) {
          devs = ref
              .read(igaBackGroundManager.notifier)
              .easyDiscoveredDevices
              .toList();
        }
        final delay = setup.delay!.def;

        final sender = SendStreamer<bool>();

        Streamer<DistanceEvent>? streamer;

        Future<void> round(WidgetRef ref) async {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          final dev = devs.first;
          bool newPadLed = true;
          /*
          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(mainColor),
            ref: ref,
            isCommand: true,
          );*/

          await PadManager.sendIsCommand(dev.id, ref: ref);

          await CustomDevDebugOperations.playAudio(dev.id, ref,
              val: BeepModel.beep3);

          if (chosenSensor == UsedSensorsType.tap) {
            logger.i("NEW ROUND!");
            await for (final event in StaticGameManager.listenToTouchMulti(
                devs.map((e) => e.id),
                ref: ref)) {
              if (event.isValid) {
                if (event.deviceId != dev.id) {
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  // StaticGameManager.addScorePoint(
                  //   ref: ref,
                  //   playerId: mainPlayer.id,
                  //   time: event.responseTime!,
                  // );

                  await PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.red),
                      ref: ref);

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(event.deviceId, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                } else {
                  PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.green),
                      ref: ref);

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(dev.id, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                }
              }
            }
          } else if (chosenSensor == UsedSensorsType.none) {
            await Future.delayed(Duration(milliseconds: setup.timeout!.def!));
          } else {
            await for (final event in StaticGameManager.listenToDistanceMulti(
                devs.map((e) => e.id),
                ref: ref)) {
              final dis = event.distance.distance;
              if (event.isValid && dis <= wantedDis!) {
                if (event.deviceId != dev.id) {
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  // StaticGameManager.addScorePoint(
                  //   ref: ref,
                  //   playerId: mainPlayer.id,
                  //   time: event.responseTime!,
                  // );

                  await PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.red),
                      ref: ref);

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(event.deviceId, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                } else {
                  PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.green),
                      ref: ref);

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(dev.id, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                }
              }
            }
          }
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          /*final futureList = <Future>[];
          for (var device in devs) {
            for (int i = 0; i < 3; i++) {
              futureList.add(CustomDevDebugOperations.playAudio(device.id, ref,
                  val: BeepModel.beep3));
            }
          }
          Future.wait(futureList);*/
          streamer?.cancel();
          return true;
        });
      },
    );
  }

  static StaticGameModel isitselReaksiyonTesti(WidgetRef ref) {
    final smallText = Theme.of(ref.context)
        .textTheme
        .headlineMedium!
        .copyWith(color: Colors.white);
    return StaticGameModel(
      id: '84',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '84',
        name: instForGameScreen.game_title_80,
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_80,
        imagePath: '84',
        igaPickColor: false,
        inGameIgaHeader:
            instForGameScreen.iga_listen_and_catch_in_game_header_text,
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_countdown_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_listen_and_catch_in_game_header_text,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_one_text_first,
                style: smallText),
            TextSpan(
                text:
                    " ${instForGameScreen.iga_listen_and_catch_stepper_one_text_bold_second}",
                style: smallText.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_one_text_third,
                style: smallText),
          ],
          [
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_two_text_first,
                style: smallText),

            //FIX ME
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_red_second,
                  style: smallText.copyWith(
                      color: Colors.red, fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_red_second,
                  style: smallText.copyWith(
                      color: Colors.red, fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
          ],
          [
            TextSpan(
                text: instForGameScreen
                    .iga_listen_and_catch_stepper_three_text_first,
                style: smallText),

            //FIX ME
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'English' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_three_text_green_second,
                  style: smallText.copyWith(
                      color: CpColors.cpLightGreen,
                      fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_three_text_green_second,
                  style: smallText.copyWith(
                      color: CpColors.cpLightGreen,
                      fontWeight: FontWeight.bold)),

            if (ref.read(appLangProv) != null &&
                ref.read(appLangProv)!.name == 'Türkçe' &&
                ref.read(currentEmbModeManager) == 1)
              TextSpan(
                  text: instForGameScreen
                      .iga_listen_and_catch_stepper_two_text_third,
                  style: smallText),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_listen_and_catch_stepper_four_text,
                style: smallText),
          ],
        ],
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 10),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        timeout: NumRange.duration(def: 1000, min: 500, max: 10000, step: 500),
        tag: GameTag.auditory,
        earnings: [GameEarning.reflex, GameEarning.focus, GameEarning.auditory],
        categories: {
          GameCategory.test: 6,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.uncatchCount,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        scoreTypeParam6: GameScoreType.catchCount,
        stagedPlayerModel: const StagedPlayerModel(
            //colorCount: NumRange.count(min: 1, max: 1),
            defaultSelectedColors: [gameErrorColor]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        doesHaveSound: false,
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true,
          UsedSensorsType.none: true
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        isScore: true,
        dstConfig:
            const DstConfigModel(threshold: 1000, timeout: 150, limitValue: 7),
      ),
      execute: (ref, game) async {
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        final setup = ref.read(currentGameSetupProv)!;
        final wantedDis = setup.distance!.def;
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        if (ref.read(currentEmbModeManager) == 1 &&
            ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy) {
          devs = ref
              .read(igaBackGroundManager.notifier)
              .easyDiscoveredDevices
              .toList();
          logger.i("Easy Selection Devices: ${devs.length}");
        }
        final delay = setup.delay!.def;

        final sender = SendStreamer<bool>();

        Streamer<DistanceEvent>? streamer;

        Future<void> round(WidgetRef ref) async {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          final dev = devs.first;
          bool newPadLed = true;
          /*
          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(mainColor),
            ref: ref,
            isCommand: true,
          );*/

          await PadManager.sendIsCommand(dev.id, ref: ref);

          await CustomDevDebugOperations.playAudio(dev.id, ref,
              val: BeepModel.beep3, standartPitch: false);

          if (chosenSensor == UsedSensorsType.tap) {
            logger.i("NEW ROUND!");
            await for (final event in StaticGameManager.listenToTouchMulti(
                devs.map((e) => e.id),
                ref: ref)) {
              if (event.isValid) {
                if (event.deviceId != dev.id) {
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  // StaticGameManager.addScorePoint(
                  //   ref: ref,
                  //   playerId: mainPlayer.id,
                  //   time: event.responseTime!,
                  // );

                  await PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.red),
                      ref: ref);

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(event.deviceId, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                } else {
                  PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.green),
                      ref: ref);

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(dev.id, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                }
              }
            }
          } else if (chosenSensor == UsedSensorsType.none) {
            await Future.delayed(Duration(milliseconds: setup.timeout!.def!));
          } else {
            await for (final event in StaticGameManager.listenToDistanceMulti(
                devs.map((e) => e.id),
                ref: ref)) {
              final dis = event.distance.distance;
              if (event.isValid && dis <= wantedDis!) {
                if (event.deviceId != dev.id) {
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  await PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.red),
                      ref: ref);

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(event.deviceId, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                } else {
                  PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.green),
                      ref: ref);

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  await Future.delayed(const Duration(milliseconds: 300));
                  await StaticGameManager.ledOff(dev.id, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                }
              }
            }
          }
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          /*final futureList = <Future>[];
          for (var device in devs) {
            for (int i = 0; i < 3; i++) {
              futureList.add(CustomDevDebugOperations.playAudio(device.id, ref,
                  val: BeepModel.beep3));
            }
          }
          Future.wait(futureList);*/
          streamer?.cancel();
          return true;
        });
      },
    );
  }

  static StaticGameModel listenAndCatch(WidgetRef ref) {
    return StaticGameModel(
      id: '80',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '80',
        name: instForGameScreen.game_title_80,
        primaryScoreString:
            instForGameScreen.activity_default_scores_total_duration,
        description: instForGameScreen.game_description_80,
        imagePath: '82',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 10),
        /* duration: NumRange.duration(
          def: 20,
          min: 15,
          max: 120,
          step: 5,
        ), */
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        timeout: NumRange.duration(def: 1000, min: 100, max: 10000, step: 100),
        tag: GameTag.auditory,
        earnings: [GameEarning.reflex, GameEarning.focus, GameEarning.auditory],
        categories: {
          GameCategory.sports: 24,
          GameCategory.entertainment: 25,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.uncatchCount,
        scoreTypeParam3: GameScoreType.totalDuration,
        scoreTypeParam4: GameScoreType.minDuration,
        scoreTypeParam5: GameScoreType.maxDuration,
        scoreTypeParam6: GameScoreType.catchCount,
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 0, max: 0),
            defaultSelectedColors: [gameErrorColor]),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        doesHaveSound: false,
        sensorTypes: {
          UsedSensorsType.tap: true,
          UsedSensorsType.distance: true,
          UsedSensorsType.none: true
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        isScore: true,
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        final setup = ref.read(currentGameSetupProv)!;
        final wantedDis = setup.distance!.def;
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        final delay = setup.delay!.def;

        final sender = SendStreamer<bool>();

        Streamer<DistanceEvent>? streamer;

        Future<void> round(WidgetRef ref) async {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          final dev = devs.first;
          bool newPadLed = true;
          /*
          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(mainColor),
            ref: ref,
            isCommand: true,
          );*/

          await PadManager.sendIsCommand(dev.id, ref: ref);

          await CustomDevDebugOperations.playAudio(dev.id, ref,
              val: BeepModel.beep3);

          if (chosenSensor == UsedSensorsType.tap) {
            await for (final event in StaticGameManager.listenToTouchMulti(
                devs.map((e) => e.id),
                ref: ref)) {
              if (event.isValid) {
                /*
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                */
                if (event.deviceId != dev.id) {
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  PadManager.ledColor(
                      event.deviceId, SidesColorsModel.all(CpColors.red),
                      ref: ref);

                  await Future.delayed(const Duration(milliseconds: 100));
                  await StaticGameManager.ledOff(event.deviceId, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                } else {
                  Future.wait([
                    PadManager.ledColor(
                        event.deviceId, SidesColorsModel.all(CpColors.green),
                        ref: ref),
                    //audioPlayer.playSuccess()
                  ]);

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: mainPlayer.id,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: mainPlayer.id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  await Future.delayed(const Duration(milliseconds: 100));
                  await StaticGameManager.ledOff(dev.id, ref: ref);
                  await Future.delayed(Duration(seconds: delay!));
                  break;
                }
              }
            }
          } else if (chosenSensor == UsedSensorsType.none) {
            await Future.delayed(Duration(milliseconds: setup.timeout!.def!));
          } else {
            final strm = StaticGameManager.listenToDistanceMulti(
              devs.map((e) => e.id),
              ref: ref,
            );

            streamer = Streamer(strm).listen(
              onData: (event) async {
                final dis = event.distance.distance;
                if ((event.isValid || dis < wantedDis!) && newPadLed) {
                  /*if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }*/

                  if (event.deviceId != dev.id) {
                    StaticGameManager.decreaseScore(
                      ref: ref,
                      playerId: mainPlayer.id,
                    );
                    await PadManager.ledColor(
                        event.deviceId, SidesColorsModel.all(CpColors.red),
                        ref: ref);

                    await Future.delayed(const Duration(milliseconds: 300));

                    await PadManager.ledOff(event.deviceId, ref: ref);
                    await CustomDevDebugOperations.playAudio(dev.id, ref,
                        val: BeepModel.beep3);
                  } else {
                    await PadManager.ledColor(
                        event.deviceId, SidesColorsModel.all(CpColors.green),
                        ref: ref);

                    //audioPlayer.playSuccess();

                    StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: mainPlayer.id,
                      time: event.responseTime!,
                    );

                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: mainPlayer.id,
                    );

                    StaticGameManager.addFlSpot(
                        ref: ref,
                        playerId: mainPlayer.id,
                        spot: FlSpot(
                            StaticGameManager.getScore(
                                    playerId: mainPlayer.id, ref: ref)
                                .toDouble(),
                            event.responseTime!.durationToDoubleForGraph()));
                    await Future.delayed(const Duration(milliseconds: 300));
                    await StaticGameManager.ledOff(dev.id, ref: ref);
                    await Future.delayed(Duration(seconds: delay!));
                  }

                  sender.add(
                      () async => StaticGameManager.ledOff(dev.id, ref: ref));

                  newPadLed = false;
                }
              },
            );
            await streamer?.doneOr(() async {
              if (newPadLed) {
                streamer?.cancel();
                streamer = null;
              }
              return newPadLed;
            });
          }
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          /*final futureList = <Future>[];
          for (var device in devs) {
            for (int i = 0; i < 3; i++) {
              futureList.add(CustomDevDebugOperations.playAudio(device.id, ref,
                  val: BeepModel.beep3));
            }
          }
          Future.wait(futureList);*/
          streamer?.cancel();
          return true;
        });
      },
    );
  }

  /*
  static StaticGameModel unKnownName(WidgetRef ref){
    return StaticGameModel(
        id: '101',
        onLeaderboard: true,
        setup: StaticGameSetupModel(
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.averageDuration,
          scoreTypeParam2: GameScoreType.score,
          scoreTypeParam3: GameScoreType.totalDuration,
          sensorTypes: {},
        ),
        /*metaData: GameMetaDataModel(
          id: '101',
          name: inst
        ),*/
        execute: (ref,game)async{

       },
    );
  }*/

  /// /

  static StaticGameModel renkliBulmaca(WidgetRef ref) {
    return StaticGameModel(
      id: '81',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '81',
        name: instForGameScreen.game_title_81,
        primaryScoreString:
            instForGameScreen.activity_default_scores_average_duration,
        description: instForGameScreen.game_description_81,
        imagePath: '81',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 4,
        ),
        tag: GameTag.intelligence,
        earnings: [
          GameEarning.intelligence,
          GameEarning.memory,
        ],
        categories: {
          GameCategory.edu: 25,
          GameCategory.entertainment: 23,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.totalDuration,
        scoreTypeParam2: GameScoreType.none,
        stagedPlayerModel: StagedPlayerModel.general(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        roundCount: 1,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final gameColorKeys = ['Red', 'Green', 'Blue', 'Yellow'];
        final colorMap = defaultConstColorsAsMap(ref);
        colorMap.removeWhere((key, value) => !gameColorKeys.contains(key));
        final colorKeys = colorMap.keys.toList();
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final mainPlayerId = mainPlayer.id;
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        final listener = StaticGameManager.listenToTouchMulti(
            devs.map((e) => e.id),
            ref: ref);
        Streamer<TouchEvent> streamer;
        streamer = Streamer(listener);
        bool end = false;
        int mistakeCounter = 0;
        final devColorMap = {for (final dev in devs) dev.id: ''};
        final ftrs = [];
        ref.read(gameScreenWidgetProv.notifier).state = ExpansionTile(
          title: Text(instForGameScreen.game_ui_color_riddle_hint_title),
          children: [
            Text(instForGameScreen.game_ui_color_riddle_hint1),
            Text(instForGameScreen.game_ui_color_riddle_hint2),
            Text(instForGameScreen.game_ui_color_riddle_hint3),
            Text(instForGameScreen.game_ui_color_riddle_hint4),
          ],
        );
        Future gameStarter() async {
          devs.shuffle();
          for (int i = 0; i < devs.length; i++) {
            devColorMap[devs[i].id] = colorKeys[i];
            ftrs.add(() => StaticGameManager.ledColorNoResponse(
                  devs[i].id,
                  SidesColorsModel.all(colorMap[colorKeys[i]]!),
                  ref: ref,
                ));
          }
          await Future.wait(ftrs.map((e) => e()));
          ftrs.clear();
        }

        Future gameResetter() async {
          audioPlayer.playBuzz();
          await Future.delayed(const Duration(milliseconds: 1000));
          mistakeCounter++;
          if (mistakeCounter >= 3) {
            streamer.cancel();
            end = true;
            return;
          }
          await gameStarter();
        }

        Future yellowEvent() async {
          final redDevs = devs.where((dev) {
            return devColorMap[dev.id] == 'Red';
          }).toList();
          if (redDevs.isEmpty) {
            await gameResetter();
            return;
          }
          for (final dev in redDevs) {
            devColorMap[dev.id] = 'Off';
            ftrs.add(() => StaticGameManager.ledOffNoResponse(
                  dev.id,
                  ref: ref,
                ));
          }
          await Future.wait(ftrs.map((e) => e()));
          ftrs.clear();
        }

        Future redEvent() async {
          final yellowDevs = devs.where((dev) {
            return devColorMap[dev.id] == 'Yellow';
          }).toList();
          if (yellowDevs.isEmpty) {
            await gameResetter();
            return;
          }
          for (final dev in yellowDevs) {
            devColorMap[dev.id] = 'Red';
            ftrs.add(() => StaticGameManager.ledColorNoResponse(
                  dev.id,
                  SidesColorsModel.all(colorMap['Red']!),
                  ref: ref,
                ));
          }
          await Future.wait(ftrs.map((e) => e()));
          ftrs.clear();
        }

        Future greenEvent(String thisDevId) async {
          final redDevs = devs
              .where((dev) => devColorMap[dev.id] == 'Off')
              .map((e) => e.id)
              .toList();
          redDevs.add(thisDevId);
          for (final devId in redDevs) {
            devColorMap[devId] = 'Red';
            ftrs.add(() => StaticGameManager.ledColorNoResponse(
                  devId,
                  SidesColorsModel.all(colorMap['Red']!),
                  ref: ref,
                ));
          }
          await Future.wait(ftrs.map((e) => e()));
          ftrs.clear();
        }

        Future blueEvent(String thisDevId) async {
          final redDevs = devs
              .where((dev) => devColorMap[dev.id] == 'Red')
              .map((e) => e.id)
              .toList();
          redDevs.add(thisDevId);
          for (final devId in redDevs) {
            devColorMap[devId] = 'Green';
            ftrs.add(() => StaticGameManager.ledColorNoResponse(
                  devId,
                  SidesColorsModel.all(colorMap['Green']!),
                  ref: ref,
                ));
          }
          await Future.wait(ftrs.map((e) => e()));
          ftrs.clear();
        }

        Future gameSuccessChecker() async {
          if (devColorMap.values.every((color) => color == 'Red')) {
            audioPlayer.playSuccess();
            StaticGameManager.addScorePoint(
                ref: ref,
                playerId: mainPlayerId,
                time: gameChronometer.elapsed);
            await Future.delayed(const Duration(seconds: 1));
            streamer.cancel();
            end = true;
            return true;
          }
        }

        Future eventHandler(String key, String thisDevId) async {
          switch (key) {
            case 'Red':
              await redEvent();
              break;
            case 'Green':
              await greenEvent(thisDevId);
              break;
            case 'Blue':
              await blueEvent(thisDevId);
              break;
            case 'Yellow':
              await yellowEvent();
              break;
          }
          await gameSuccessChecker();
        }

        Future<void> round(WidgetRef ref) async {
          await gameStarter();
          streamer.listen(
            onData: (event) async {
              final key = devColorMap[event.deviceId];
              await eventHandler(key!, event.deviceId);
            },
          );
          await streamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
        }

        await game.setup.executeGame(ref, round);
      },
    );
  }

  static StaticGameModel aklindaTut(WidgetRef ref) {
    return StaticGameModel(
      id: 's17',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's17',
        name: instForGameScreen.game_title_17,
        description: instForGameScreen.game_description_17,
        imagePath: '17',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        tag: GameTag.memory,
        earnings: [
          GameEarning.memory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 18,
          GameCategory.entertainment: 8,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.level,
        scoreTypeParam2: GameScoreType.correctCount,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [gameErrorColor, gameSuccessColor],
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 25,
          timeout: 200,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];
        final mainPlayerId = mainPlayer.id;
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final devices = generalPlayer.devs;
        final devCount = devices.length;

        final allColors = defaultConstColors(ref);

        /// these colors will be used to confuse the user, like, if our iteration
        /// is 1,3,4, we could led 2 and 5 with these colors.
        final confusionColors = allColors.where((c) => c != mainColor).toList();

        final ran = Xrandom();

        /// we should start confusing player after level 3
        /// and maximum only half as times as the actual
        /// correct devices count.
        shouldConfuse({
          required int level,
          required int confusionCount,
          required int iterationDeviceCount,
        }) =>
            level > 3 && confusionCount < iterationDeviceCount / 2;

        const attentionSightDuration = Duration(milliseconds: 1000);

        int level = 2;

        bool gameEnded = false;

        Stream<TouchEvent> correctListener;
        Stream<TouchEvent> incorrectListener;

        Future<void> round(WidgetRef ref) async {
          // for level = 1, we can't just play with 1 pad
          // it would be too easy to win, so we will start
          // with 2 pads.
          final neededPads = level + 1;

          // just for easier code change, we wanna
          // use iterationCount as a reference to neededPads
          final iterationCount = neededPads;

          // neededpads = 4, devCount = 5 => neededPadListCount = 1 => we can make an iteration
          // over 1 list of pads.
          // neededpads = 7, devCount = 5 => neededPadListCount = 2 => we can make an iteration
          // over 2 lists of pads, AKA the same pad may repeat twice.
          final neededPadListCount = (neededPads / devCount).ceil();

          List<DiscoveredDevice> padList;

          // here we're gonna keep looping until
          // the same pad is never repeated twice.
          while (true) {
            padList = List.generate(
              neededPadListCount,
              (i) => List.generate(
                devCount,
                (j) => devices[j],
              ),
            ).expand((element) => element).toList();

            padList = DeviceShuffler.shuffleDevicesUniquely(padList);

            final newLs = <DeviceModel>[];

            for (var i = 0; i < padList.length; i++) {
              final item = padList[i];
              final itemId = item.id;

              if (i == 0) {
                newLs.add(item);
                continue;
              }

              final lastItem = padList[i - 1];
              final lastItemId = lastItem.id;

              if (itemId == lastItemId) {
                continue;
              }

              newLs.add(item);
            }

            if (newLs.length >= neededPads) {
              padList = newLs;
              break;
            }
          }

          final iterationList = padList.take(iterationCount).toList();

          int confusionCount = 0;
          // first, we wanna led the iteration pads with
          // the main color and await each the sight duration.
          for (var i = 0; i < iterationCount; i++) {
            final dev = iterationList[i];
            final devId = dev.id;

            {
              final shouldConfuseCb = shouldConfuse(
                level: level,
                confusionCount: confusionCount++,
                iterationDeviceCount: iterationCount,
              );

              final shouldConf = shouldConfuseCb && ran.nextBool();

              if (shouldConf) {
                int ranDevIndex;
                DeviceModel? ranDev;

                while (true) {
                  ranDevIndex = ran.nextInt(padList.length);
                  ranDev = padList[ranDevIndex];

                  final ranDevId = ranDev.id;
                  final prevRanDevId = i == 0 ? null : padList[i - 1].id;
                  final nextRanDevId =
                      i == iterationCount - 1 ? null : padList[i + 1].id;
                  if (![ranDevId, prevRanDevId, nextRanDevId].contains(devId)) {
                    break;
                  }
                }

                final ranColorIndex = ran.nextInt(
                  confusionColors.length,
                );

                final ranColor = confusionColors[ranColorIndex];
                await StaticGameManager.ledColor(
                  ranDev.id,
                  SidesColorsModel.all(ranColor),
                  duration: attentionSightDuration,
                  ref: ref,
                );
              }
            }

            await StaticGameManager.ledColor(
              dev.id,
              SidesColorsModel.all(mainColor),
              ref: ref,
              duration: attentionSightDuration,
              isCommand: true,
            );
          }

          audioPlayer.raceStart();
          bool correctCaught = false, incorrectCaught = false;

          // we wanna listen to each pad at its time,
          // but also listen to the others to end the game
          // if they are caught.
          for (var i = 0; i < neededPads && !gameEnded; i++) {
            final correctDev = iterationList[i];

            correctCaught = false;
            incorrectCaught = false;

            final otherDevices =
                padList.where((dev) => dev.id != correctDev.id).toList();

            // firstly, we wanna send a command to the correct device,
            // to get the response time when it is caught.
            await StaticGameManager.sendIsCommand(
              correctDev.id,
              ref: ref,
            );

            correctListener = StaticGameManager.listenToTouchMulti(
              [correctDev.id],
              ref: ref,
            );

            incorrectListener = StaticGameManager.listenToTouchMulti(
              otherDevices.map((dev) => dev.id).toList(),
              ref: ref,
            );

            final incorrectStreamer = Streamer(incorrectListener);

            final correctStreamer = Streamer(correctListener);

            correctStreamer.listen(
              onData: (event) async {
                if (!incorrectCaught) {
                  // when we catch the correct device, first thing we wanna do
                  // is to led the pad to success color, as long as sightDuration.
                  // we're not awaiting this, because we want the player
                  // to be able to catch the next device immediately, but we're
                  // awaiting at the end of the round because if we don't, the next
                  // round's colors will led before this one is out.
                  StaticGameManager.ledColorForSightDuration(
                    correctDev.id,
                    SidesColorsModel.all(gameSuccessColor),
                    ref: ref,
                  );

                  //secondly, we wanna add the timestamp of catching
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayerId,
                    time: event.responseTime!,
                  );

                  // thirdly, we wanna increase correct count
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: mainPlayerId,
                  );

                  // and finally, we wanna mark correctCaught as true so the loop
                  // can continue;
                  correctCaught = true;
                  correctStreamer.cancel();
                  incorrectStreamer.cancel();
                }
              },
            );

            incorrectStreamer.listen(
              onData: (event) async {
                if (!incorrectCaught) {
                  incorrectCaught = true;

                  // when we catch the incorrect device, first thing we wanna do
                  // is to led the pad to the incorrect color, as long as sightDuration
                  await StaticGameManager.ledColorForSightDuration(
                    event.deviceId,
                    SidesColorsModel.all(gameErrorColor),
                    ref: ref,
                  );

                  // secondly, we wanna increase incorrect count
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayerId,
                  );

                  // and finally, we wanna mark incorrectCaught and gameEnded as true
                  // so the game can end.
                  gameEnded = true;
                  correctStreamer.cancel();
                  incorrectStreamer.cancel();
                }
              },
            );

            await correctStreamer
                .doneOr(() async => ref.watch(gameEndingProvider));
            await incorrectStreamer
                .doneOr(() async => ref.watch(gameEndingProvider));
          }

          // now we wanna increase the level
          level++;
          StaticGameManager.increaseLevel(
            ref: ref,
            playerId: mainPlayerId,
          );

          // we're delaying here because we are not awaiting
          // the led of correct color. see above, on the correct listener.
          await Future.delayed(sightDuration * 2);
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return gameEnded || ref.watch(gameEndingProvider);
          },
        );
      },
    );
  }

  static StaticGameModel sayBakalim(WidgetRef ref) {
    return StaticGameModel(
      id: 's18',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's18',
        name: instForGameScreen.game_title_18,
        description: instForGameScreen.game_description_18,
        imagePath: '18',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        tag: GameTag.numeral,
        earnings: [
          GameEarning.numeral,
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 9,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 200,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        const clr = gameSuccessColor;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }
        bool end = false;
        bool goOn = true;
        Future<void> round(WidgetRef ref) async {
          goOn = true;
          String? corDevNameId;
          late final MapEntry<String, DiscoveredDevice> entry;
          try {
            entry = devMap.first;
            corDevNameId = entry.key;
          } catch (e) {
            end = true;
          }

          final correctDev = entry.value;

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          /* final ids = [];
          final incorrectDevs = <DiscoveredDevice>[]; */
          /* for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          } */

          StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          final audio = AudioFiles.langCardinal(correctDev.deviceNumber!);
          await audioPlayer.play(audio);

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            inc.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final otherDevsStreamer = Streamer(otherDevicesListener);
          final correctStreamer = Streamer(correctListener);
          otherDevsStreamer.listen(
            onData: (e) async {
              if (goOn) {
                goOn = false;
                final devNameId = devMap
                    .firstWhere((element) => element.value.id == e.deviceId)
                    .key;
                if (devNameId != corDevNameId) {
                  StaticGameManager.ledColor(
                    correctDev.id,
                    SidesColorsModel.all(clr),
                    ref: ref,
                    isCommand: true,
                  );

                  audioPlayer.playBuzz();
                  await Future.delayed(const Duration(milliseconds: 1000));
                  StaticGameManager.ledOff(
                    correctDev.id,
                    ref: ref,
                  );
                  StaticGameManager.decreaseScore(
                    ref: ref,
                    playerId: mainPlayer.id,
                  );

                  devMap.insert(devMap.length, entry);
                  correctStreamer.cancel();
                  otherDevsStreamer.cancel();
                }
              }
            },
          );

          correctStreamer.listen(
            onData: (event) async {
              if (event.isValid && event.responseTime != null && goOn) {
                goOn = false;
                StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );
                audioPlayer.playSuccess();
                await Future.delayed(const Duration(milliseconds: 1000));
                StaticGameManager.ledOff(correctDev.id, ref: ref);

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );
                otherDevsStreamer.cancel();
                correctStreamer.cancel();
              }
            },
          );

          await correctStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          otherDevsStreamer.cancel();
          await otherDevsStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          try {
            devMap.remove(entry);
          } catch (e) {
            logger.d(e.toString());
          }
        }

        await Future.delayed(Duration(milliseconds: Platform.isIOS ? 50 : 0));

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider);
          },
        );
      },
    );
  }

  static StaticGameModel notalar(WidgetRef ref) {
    return StaticGameModel(
      id: 's19',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's19',
        name: instForGameScreen.game_title_19,
        description: instForGameScreen.game_description_19,
        imagePath: '19',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 8,
        ),
        tag: GameTag.music,
        earnings: [
          GameEarning.music,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 10,
          GameCategory.entertainment: 20,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        devs = DeviceShuffler.shuffleDevicesUniquely(devs);
        var colors = defaultConstColors(ref);

        // if the devices are more or equal to the
        // number of notes, then we wanna assign a
        // pad to each note.
        final sender = SendStreamer<bool>();
        int i = 0;
        final audioPlayer = ref.watch(cpAudioPlayerProv);

        Future<void> round(WidgetRef ref) async {
          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          streamer = streamer.listen(
            onData: (event) async {
              logger.d("touched event$event && ${event.isValid}");
              if (event.isValid) {
                colors = DeviceShuffler.shuffleColorsUniquely(colors);
                // Audio file time is too long to wait when it comes to the last index of the notex
                // It starts to play but immidiately stops after cancelling stream and increasing i value so
                // When it gets to the last index we are waiting for the audio to finish playing.
                final dev = devs.firstWhere((dev) => dev.id == event.deviceId);
                /*final audio = AudioFiles.musicNote(
                    StickerManager.idToStickerNotesForMobile(
                        ref: ref,
                        isForGame: true,
                        val: dev.deviceNumber!.toString())!);

                audioPlayer.play(audio);*/

                await PadManager.playMusic(dev.id, ref: ref);

                sender.add(() => StaticGameManager.ledColor(
                    event.deviceId, SidesColorsModel.all(colors.first),
                    ref: ref));
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) =>
                        StaticGameManager.ledOff(event.deviceId, ref: ref));
              }
            },
          );

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
          i++;
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async =>
                500 == i || ref.watch(gameEndingProvider));
      },
    );
  }

  /*static StaticGameModel padHero(WidgetRef ref) {
    return StaticGameModel(
      id: 'xlc',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 'xlc',
        name: "Pad Hero",
        //instForGameScreen.game_title_20,
        description: instForGameScreen.game_description_20,
        imagePath: '101',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          // note count
          max: 8,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.auditoryIntelligence,
          GameEarning.intelligence,
        ],
        categories: {
          GameCategory.edu: 13,
          GameCategory.entertainment: 6,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        doesHaveSound: false,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
                isEnabled: true, isChangable: false, chooseMusic: true),
          ),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        var countOfDevice = devs.length;
        devs = DeviceShuffler.shuffleDevicesUniquely(devs);
        final currentMidiPro = ref.watch(currentMidiManager.notifier);
        currentMidiPro.initialize(ref);

        final currentMelody = ref.watch(currentMelodyManager);
        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final drumKeyMillisecondMap = {
          "2": 1300,
          "3": 1700,
          "4": 2100,
          "5": 3400,
          "6": 3900,
          "7": 4300,
          "8": 5600,
          "9": 6000,
          "10": 6400,
          "11": 9000,
          "12": 10100,
          "13": 10500,
          "14": 10900,
          "15": 12500,
          "16": 13000,
          "17": 13400,
          "18": 14500,
          "19": 14900,
          "20": 15300,
          "21": 17800,
          "22": 18400,
          "23": 18900,
          "24": 19500,
          "25": 20100,
          "26": 20600,
          "27": 21200,
          "28": 21700,
          "29": 22300,
          "30": 22800,
          "31": 23400,
          "32": 23900,
          "33": 24500,
          "34": 25000,
          "35": 25600,
        };

        List<int> numbers = [];

        for (var note in currentMelody!.notes!) {
          numbers.add(note.time!.toInt());
        }

        currentMidiPro.outLayerNumbers(numbers);

        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.first;
        final clrs = mainPlayer.clrs;

        Map<String, Map<String, num>> noteOfPad = {};

        num maxMidi = 0;
        num minMidi = 0;

        for (var note in currentMelody.notes!) {
          if (note.midi! > maxMidi) {
            maxMidi = note.midi!;
          }
          if (note.midi! < minMidi) {
            minMidi = note.midi!;
          }
        }

        num range = (maxMidi - minMidi) / countOfDevice;

        num startRange = minMidi;

        for (var device in devs) {
          noteOfPad.addAll({
            device.id: {"min": startRange, "max": startRange + range}
          });
          startRange += range;
        }
        int noteCounter = 0;
        /*late Note perNote;
        int local = 0;
        Note? nextNote;
        late num currentMidi;*/
        late String correctDeviceId;
        int _milliseconds = 0;
        int currentIndex = 0;
        Timer? _timer;

        void _startTimer() {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          correctDeviceId = devs.first.id;

          /*
          StaticGameManager.ledColor(
            correctDeviceId,
            SidesColorsModel.all(clrs.first),
            isCommand: true,
            ref: ref,
          );*/

          const duration = Duration(milliseconds: 1);

          _timer = Timer.periodic(duration, (Timer timer) {
            _milliseconds++;

            if (drumKeyMillisecondMap.values.toList()[currentIndex] - 1200 <
                _milliseconds) {
              final result = (_milliseconds - drumKeyMillisecondMap.values.toList()[currentIndex] - 1200)~/4;
              // 0-150 150-300 300-450 450-550

              StaticGameManager.ledColor(correctDeviceId, SidesColorsModel(
                  tl: CpColors.green,
                  tr: (result<300 && result>=150) ? CpColors.cpYellow : null,
                  bl: result >= 450 ? CpColors.blue : null,
                  br: (result<450 && result>=300) ? CpColors.red : null
              ), ref: ref);
            }

            if (drumKeyMillisecondMap.values.toList()[currentIndex] - 600 <
                _milliseconds) {
              currentIndex++;

              StaticGameManager.ledOff(
                correctDeviceId,
                ref: ref,
              );

              devs = DeviceShuffler.shuffleDevicesUniquely(devs);
              correctDeviceId = devs.first.id;


            }
            if (currentIndex == drumKeyMillisecondMap.values.length) {
              timer.cancel();
            }
          });
        }

        audioPlayer.playRocky();

        _startTimer();

        Future<void> round(WidgetRef ref) async {
          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          streamer = streamer.listen(
            onData: (event) async {
              if (event.isValid && correctDeviceId == event.deviceId) {
                StaticGameManager.ledOff(
                  correctDeviceId,
                  ref: ref,
                );

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseCatch(
                    ref: ref, playerId: mainPlayer.id);
              }
            },
          );

          await streamer.doneOr(() async =>
              ref.watch(gameEndingProvider) ||
              noteCounter == currentMelody.notes!.length);
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async => ref.watch(gameEndingProvider));
      },
    );
  }*/

  //Doğrusu bu
  // static StaticGameModel padHero(WidgetRef ref) {
  //   return StaticGameModel(
  //     id: 'xlc',
  //     onLeaderboard: true,
  //     metaData: GameMetaDataModel(
  //       id: 'xlc',
  //       name: "Pad Hero",
  //       //instForGameScreen.game_title_20,
  //       description: instForGameScreen.game_description_20,
  //       imagePath: '101',
  //       playerCount: NumRange.playerCount(
  //         min: 1,
  //         max: 1,
  //       ),
  //       padCount: NumRange.padCount(
  //         min: 2,
  //         // note count
  //         max: 8,
  //       ),
  //       badgeType: GameBadgeTypes.beta,
  //       tag: GameTag.auditory,
  //       earnings: [
  //         GameEarning.auditory,
  //         GameEarning.auditoryIntelligence,
  //         GameEarning.intelligence,
  //       ],
  //       categories: {
  //         GameCategory.edu: 13,
  //         GameCategory.entertainment: 6,
  //       },
  //     ),
  //     setup: StaticGameSetupModel(
  //       type: GameEndType.duration,
  //       scoreTypeParam1: GameScoreType.catchCount,
  //       scoreTypeParam2: GameScoreType.averageDuration,
  //       doesHaveSound: false,
  //       stagedPlayerModel: StagedPlayerModel(
  //         colorCount: NumRange.count(min: 1, max: 1),
  //       ),
  //       generalStagedPlayerModel: StagedPlayerModel.general(
  //         hasDevices: true,
  //       ),
  //       controlsSetup: const GameControlsSetup(
  //         gameAudioControls: GameAudioSelectionSetup(
  //           gameAudioSetup: GameAudioSelectionSetupItem(
  //             isEnabled: true,
  //             isChangable: false,
  //           ),
  //           soundEffectsSetup: GameAudioSelectionSetupItem(
  //               isEnabled: true, isChangable: false, chooseMusic: true),
  //         ),
  //       ),
  //       sensorTypes: {
  //         UsedSensorsType.tap: false,
  //       },
  //     ),
  //     execute: (ref, game) async {
  //       final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
  //       var devs = generalPlayer.devs;
  //       var countOfDevice = devs.length;
  //       devs = DeviceShuffler.shuffleDevicesUniquely(devs);
  //       final currentMidiPro = ref.watch(currentMidiManager.notifier);
  //       currentMidiPro.initialize(ref);
  //
  //       final currentMelody = ref.watch(currentMelodyManager);
  //       final audioPlayer = ref.watch(cpAudioPlayerProv);
  //
  //       final drumKeyMillisecondMap = {
  //         "2": 1300,
  //         "3": 1700,
  //         "4": 2100,
  //         "5": 3400,
  //         "6": 3900,
  //         "7": 4300,
  //         "8": 5600,
  //         "9": 6000,
  //         "10": 6400,
  //         "11": 9000,
  //         "12": 10100,
  //         "13": 10500,
  //         "14": 10900,
  //         "15": 12500,
  //         "16": 13000,
  //         "17": 13400,
  //         "18": 14500,
  //         "19": 14900,
  //         "20": 15300,
  //         "21": 17800,
  //         "22": 18400,
  //         "23": 18900,
  //         "24": 19500,
  //         "25": 20100,
  //         "26": 20600,
  //         "27": 21200,
  //         "28": 21700,
  //         "29": 22300,
  //         "30": 22800,
  //         "31": 23400,
  //         "32": 23900,
  //         "33": 24500,
  //         "34": 25000,
  //         "35": 25600,
  //       };
  //
  //       List<int> numbers = [];
  //
  //       for (var note in currentMelody!.notes!) {
  //         numbers.add(note.time!.toInt());
  //       }
  //
  //       currentMidiPro.outLayerNumbers(numbers);
  //
  //       final players = ref.read(selectedPlayersPlayersProv);
  //       final mainPlayer = players.first;
  //       final clrs = mainPlayer.clrs;
  //
  //       Map<String, Map<String, num>> noteOfPad = {};
  //
  //       num maxMidi = 0;
  //       num minMidi = 0;
  //
  //       for (var note in currentMelody.notes!) {
  //         if (note.midi! > maxMidi) {
  //           maxMidi = note.midi!;
  //         }
  //         if (note.midi! < minMidi) {
  //           minMidi = note.midi!;
  //         }
  //       }
  //
  //       num range = (maxMidi - minMidi) / countOfDevice;
  //
  //       num startRange = minMidi;
  //
  //       for (var device in devs) {
  //         noteOfPad.addAll({
  //           device.id: {"min": startRange, "max": startRange + range}
  //         });
  //         startRange += range;
  //       }
  //       int noteCounter = 0;
  //       /*late Note perNote;
  //       int local = 0;
  //       Note? nextNote;
  //       late num currentMidi;*/
  //       late String correctDeviceId;
  //       int milliseconds = 0;
  //       int currentIndex = 0;
  //       Timer? timer;
  //
  //       void startTimer() {
  //         devs = DeviceShuffler.shuffleDevicesUniquely(devs);
  //         correctDeviceId = devs.first.id;
  //
  //         StaticGameManager.ledColor(
  //           correctDeviceId,
  //           SidesColorsModel.all(clrs.first),
  //           isCommand: true,
  //           ref: ref,
  //         );
  //
  //         const duration = Duration(milliseconds: 1);
  //         timer = Timer.periodic(duration, (Timer timer) {
  //           milliseconds++;
  //
  //           if (drumKeyMillisecondMap.values.toList()[currentIndex] ==
  //               milliseconds) {
  //             currentIndex++;
  //
  //             StaticGameManager.ledOff(
  //               correctDeviceId,
  //               ref: ref,
  //             );
  //             devs = DeviceShuffler.shuffleDevicesUniquely(devs);
  //             correctDeviceId = devs.first.id;
  //
  //             StaticGameManager.ledColor(
  //               correctDeviceId,
  //               SidesColorsModel.all(clrs.first),
  //               isCommand: true,
  //               ref: ref,
  //             );
  //           }
  //           if (currentIndex == drumKeyMillisecondMap.values.length) {
  //             timer.cancel();
  //           }
  //         });
  //       }
  //
  //       audioPlayer.playRocky();
  //
  //       startTimer();
  //
  //       Future<void> round(WidgetRef ref) async {
  //         var streamer = Streamer(
  //           StaticGameManager.listenToTouchMulti(
  //             devs.map((e) => e.id),
  //             ref: ref,
  //           ),
  //         );
  //
  //         streamer = streamer.listen(
  //           onData: (event) async {
  //             if (event.isValid && correctDeviceId == event.deviceId) {
  //               StaticGameManager.ledOff(
  //                 correctDeviceId,
  //                 ref: ref,
  //               );
  //
  //               StaticGameManager.addScorePoint(
  //                 ref: ref,
  //                 playerId: mainPlayer.id,
  //                 time: event.responseTime!,
  //               );
  //
  //               StaticGameManager.increaseCatch(
  //                   ref: ref, playerId: mainPlayer.id);
  //             }
  //           },
  //         );
  //
  //         await streamer.doneOr(() async =>
  //             ref.watch(gameEndingProvider) ||
  //             currentIndex == drumKeyMillisecondMap.values.length);
  //       }
  //
  //       await game.setup.executeGame(ref, round,
  //           shouldStop: (ref) async => (ref.watch(gameEndingProvider) ||
  //               (currentIndex == drumKeyMillisecondMap.values.length)));
  //     },
  //   );
  // }
  static StaticGameModel padHero(WidgetRef ref) {
    return StaticGameModel(
      id: 'xlc',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 'xlc',
        name: "Pad Hero",
        //instForGameScreen.game_title_20,
        description: instForGameScreen.game_description_20,
        imagePath: '101',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        duration: NumRange.duration(def: 100, min: 100, max: 100),
        padCount: NumRange.padCount(
          min: 2,
          // note count
          max: 8,
        ),

        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.auditoryIntelligence,
          GameEarning.intelligence,
        ],
        categories: {
          GameCategory.edu: 13,
          GameCategory.entertainment: 6,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        doesHaveSound: false,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
                isEnabled: true, isChangable: false, chooseMusic: true),
          ),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        var countOfDevice = devs.length;
        devs = DeviceShuffler.shuffleDevicesUniquely(devs);
        String correctDeviceId = devs.first.id;
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.first;
        // final clrs = mainPlayer.clrs;
        const timeHits = AudioFiles.demoTimeHitMicroSeconds;
        List<int> under1000hits =
            timeHits.where((element) => element < 1000).toList();

        List<DiscoveredDevice> queueDiscoveredDeviceList = [];

        for (int i = 0; i < timeHits.length; i++) {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          // final chooseDevice = devs.first;

          if (queueDiscoveredDeviceList.isEmpty) {
            queueDiscoveredDeviceList.add(devs.first);
          } else {
            // Sıradaki elemanın bir öncekisiyle ve iki öncekisiyle aynı olmamasını kontrol et
            if (i >= 2 &&
                queueDiscoveredDeviceList[i - 1] == devs.first &&
                queueDiscoveredDeviceList[i - 2] == devs.first) {
              queueDiscoveredDeviceList.add(devs[1]);
            } else if (queueDiscoveredDeviceList[i - 1] == devs.first) {
              // Sadece bir öncekiyle aynıysa farklı bir eleman ekle
              queueDiscoveredDeviceList.add(devs[1]);
            } else {
              queueDiscoveredDeviceList.add(devs.first);
            }
          }
        }

        final stopWatch = Stopwatch();
        int counter = 0;
        int interval = 0;

        stopWatch.start();

        void startTimer() {
          if (ref.read(buzzerManagerProvider)) {
            Future.delayed(const Duration(milliseconds: 350), () {
              ref.read(cpAudioPlayerProv).playDemo();
              //ref.read(cpAudioPlayerProv).playPsy();
            });
          }
          //

          logger.i("Triggered!!! Time Hit!!");
          int timer = 0;
          Timer.periodic(const Duration(milliseconds: 1), (timer) async {
            Future(() async {
              // logger.i("Timer");
              //  350 En iyisi   /    400 En iyisi
              //  320 En iyisi   /    400 En iyisi
              //  400 En iyisi   /    400 En iyisi
              if (timeHits.contains((timer.tick) - 350)) {
                // if(counter>=3){
                //   DiscoveredDevice ledOffDevice = queueDiscoveredDeviceList[counter-3];
                //   PadManager.ledOffNoResponse(ledOffDevice.id, ref: ref);
                // }

                DiscoveredDevice correctDevice =
                    queueDiscoveredDeviceList[counter];

                correctDeviceId = correctDeviceId;
                PadManager.circularPadShow(correctDevice.id,
                        ref: ref,
                        circularColor: CpColors.green,
                        totalDuration: const Duration(milliseconds: 320),
                        timeOutLedOff: const Duration(milliseconds: 400))
                    .then((value) => PadManager.ledOffNoResponse(
                        correctDevice.id,
                        ref: ref));

                counter++;
                // final currentHitRound = timeHits.indexOf(counter);

                //
                // DiscoveredDevice ledOffDevice =
                //     queueDiscoveredDeviceList[currentHitRound];
                //
                // PadManager.ledOffNoResponse(ledOffDevice.id, ref: ref);
              }

              //  if(timeHits.length == counter) {
              //    ref.read(bleConPr).keys.forEach((device) {
              //      PadManager.ledOff(device.id, ref: ref);
              //    });
              //  }
              //
              // if (timeHits.contains((timer.tick) - 600)) {
              //   DiscoveredDevice correctDevice =
              //       queueDiscoveredDeviceList[counter];
              //    // DiscoveredDevice beforeDevice =
              //    // queueDiscoveredDeviceList[counter-1];
              //   counter++;
              //
              //   PadManager.circularPadShow(correctDevice.id,
              //       ref: ref,
              //       circularColor: CpColors.green,
              //       totalDuration: const Duration(milliseconds: 600),
              //       timeOutLedOff: const Duration(milliseconds: 1));
              //
              //   Future.delayed(const Duration(milliseconds: 450), () {
              //     correctDeviceId = correctDevice.id;
              //     // PadManager.ledOffNoResponse(beforeDevice.id, ref: ref);
              //   });
              //
              //   // if (counter > 0) {
              //   //   DiscoveredDevice beforeDevice = queueDiscoveredDeviceList[counter - 1];
              //   //   PadManager.ledOff(beforeDevice.id, ref: ref);
              //   // }
              //   //
              //   // counter++;
              //
              //   // if (counter == timeHits.length) {
              //   //   PadManager.ledOff(queueDiscoveredDeviceList.last.id, ref: ref);
              //   //   stopWatch.stop();
              //   //   ref.read(gameEndingProvider.notifier).end();
              //   // }
              //
              //   // if (counter + 1 < queueDiscoveredDeviceList.length) {
              //   //   // DiscoveredDevice nextDevice =
              //   //   //     queueDiscoveredDeviceList[counter + 1];
              //   //
              //   //
              //   //
              //   //   // PadManager.ledColor(
              //   //   //     nextDevice.id,
              //   //   //     SidesColorsModel.all(CpColors.red),
              //   //   //     ref: ref);
              //   //
              //   //   // PadManager.circularPadShow(nextDevice.id,
              //   //   //     ref: ref,
              //   //   //     circularColor: CpColors.red,
              //   //   //     totalDuration: Duration(
              //   //   //         milliseconds: ((timeHits[counter + 1] - currentTime))));
              //   //
              //   //   // counter++;
              //   // }
              // }
            });
          });

          //
        }

        startTimer();

        logger.w("Future Do While End");

        Future<void> round(WidgetRef ref) async {
          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          streamer.listen(
            onData: (event) async {
              if (event.isValid) {
                // PadManager.ledColor(
                //     correctDeviceId, SidesColorsModel.all(CpColors.success),
                //     ref: ref);

                await PadManager.ledOff(event.deviceId, ref: ref);

                if (event.deviceId == correctDeviceId) {
                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: event.responseTime!,
                  );

                  StaticGameManager.increaseCatch(
                      ref: ref, playerId: mainPlayer.id);
                }
              }
            },
          );

          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async => (ref.watch(gameEndingProvider)));
      },
    );
  }

  /*

           //
           // if (timeHits.contains(stopWatch.elapsedMilliseconds+200)) {
           //   // ref.read(bleConPr).keys.toList().forEach((device) async {
           //   //   await PadManager.ledOff(device.id, ref: ref);
           //   // });
           //   counter++;
           //   DiscoveredDevice correctDevice = queueDiscoveredDeviceList[counter];
           //    DiscoveredDevice nextDevice =
           //        queueDiscoveredDeviceList[counter + 1];
           //
           //   correctDeviceId = correctDevice.id;
           //
           //
           //   final index = timeHits.indexOf(stopWatch.elapsedMilliseconds);
           //
           //   if (index + 1 > timeHits.length - 1) return false;
           //   final nextToDiff = timeHits[index + 1] - timeHits[index];
           //
           //   PadManager.ledColor(
           //       correctDevice.id, SidesColorsModel.all(CpColors.yellow),
           //       ref: ref);
           //
           //   const timeout = nextToDiff; //- (nextToDiff ~/ 2.75);
           //
           //   PadManager.circularPadShow(nextDevice.id,
           //       ref: ref,
           //       circularColor: CpColors.red,
           //       totalDuration: Duration(milliseconds: timeout~/2));
           //
           //
           //
           //    await Future.delayed(const Duration(milliseconds: timeout), () {
           //      PadManager.ledOff(correctDevice.id, ref: ref);
           //      PadManager.circularPadShow(nextDevice.id,
           //          ref: ref,
           //          circularColor: CpColors.green,
           //          totalDuration: const Duration(
           //              milliseconds: 1000),
           //          // endColor: CpColors.warning,
           //          // timeOutLedOff: const Duration(milliseconds: 20),
           //          // passingEndColorTime: Duration(milliseconds: (timeout * 0.08).toInt())
           //      );
           //      // PadManager.ledOff(nextDevice.id, ref: ref);
           //    });
           //    await Future.delayed(const Duration(milliseconds: 1));
           // }
  *
  * */
  static StaticGameModel dahaDunAnnemizin(WidgetRef ref) {
    return StaticGameModel(
      id: 's20',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's20',
        name: instForGameScreen.game_title_20,
        description: instForGameScreen.game_description_20,
        imagePath: '20',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        gamePadCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 2,
          // note count
          max: 12,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.auditoryIntelligence,
          GameEarning.intelligence,
        ],
        categories: {
          GameCategory.edu: 13,
          GameCategory.entertainment: 6,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        doesHaveSound: false,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        devs = DeviceShuffler.shuffleDevicesUniquely(devs);

        // if the devices are more or equal to the
        // number of notes, then we wanna assign a
        // pad to each note.
        final autoAssignMode = devs.length < AudioFiles.musicNoteCount;

        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.first;
        final clrs = mainPlayer.clrs;

        int i = 0;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final allNotes = 'ccggaagffeeddcggffeedggffeedccggaagffeeddc'.split('');

        List<DiscoveredDevice> getDevs() {
          if (autoAssignMode) {
            // we wanna give a different pad each time.
            return DeviceShuffler.shuffleDevicesUniquely(devs);
          }

          // the devices are shuffled from the start
          // of the game.

          return devs;
        }

        DiscoveredDevice getDevAt(int index) {
          final d = getDevs();

          if (autoAssignMode) {
            // in auto assign we shuffle each time,
            // so 0est element is always different
            // from the previous one. but if you
            // use index, we may get the same pad
            // again.
            //
            // e.g. :
            // shuffle 1: [1,2,3,4], index = 0, => 1
            // shuffle 2: [2,1,4,3], index = 1, => 1
            //
            // but if we stick to 0
            // shuffle 1: [1,2,3,4], index = 0, => 1
            // shuffle 2: [2,1,4,3], index = 0, => 2
            return d.elementAt(0);
          }

          // as each note has a pad, when we use index
          // we'd get a unique pad for that note.
          return d.elementAt(notesCp.indexOf(allNotes[i]));
        }
        //ccggaagffeeddcggffeedggffeedccggaagffeeddc

        Future<void> round(WidgetRef ref) async {
          var correctDev = getDevAt(i);

          var audio = AudioFiles.musicNote(allNotes[i]);

          StaticGameManager.ledColor(
            correctDev.id,
            SidesColorsModel.all(clrs[0]),
            isCommand: true,
            ref: ref,
          );
          Future roundCycler() async {
            correctDev = getDevAt(i);

            audio = AudioFiles.musicNote(allNotes[i]);

            StaticGameManager.ledColor(
              correctDev.id,
              SidesColorsModel.all(clrs[0]),
              isCommand: true,
              ref: ref,
            );
          }

          var streamer = Streamer(
            StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref,
            ),
          );

          streamer = streamer.listen(
            onData: (event) async {
              logger.d("touched event$event && ${event.isValid}");
              if (event.isValid && correctDev.id == event.deviceId) {
                logger.d('touched$i && ${allNotes[i]} && ${allNotes.length}');
                // Audio file time is too long to wait when it comes to the last index of the notex
                // It starts to play but immidiately stops after cancelling stream and increasing i value so
                // When it gets to the last index we are waiting for the audio to finish playing.
                try {
                  if (i == allNotes.length - 1) {
                    await audioPlayer.play(audio);
                  } else {
                    audioPlayer.play(audio);
                  }
                } on Exception catch (e) {
                  logger.e(e.toString());
                }

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );
                StaticGameManager.increaseCatch(
                    ref: ref, playerId: mainPlayer.id);

                StaticGameManager.ledOff(
                  correctDev.id,
                  ref: ref,
                );

                i++;
                await roundCycler();
              }
            },
          );

          await streamer
              .doneOr(() async => ref.watch(gameEndingProvider) || i == 42);
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async =>
                allNotes.length == i || ref.watch(gameEndingProvider));
      },
    );
  }

  static StaticGameModel yuzIfadesi(WidgetRef ref) {
    return StaticGameModel(
      id: 's21',
      metaData: GameMetaDataModel(
        id: 's21',
        name: "Yüz ifadesi",
        description:
            "Rengi yanan emojiyi, kamera karşısında gerçekleştirmeye çalış. Duygularını ne kadar ifade edebildiğine bak!",
        imagePath: '21',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        tag: GameTag.drama,
        earnings: [
          GameEarning.drama,
        ],
        categories: {
          GameCategory.edu: 19,
          GameCategory.entertainment: 18,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.none,
        scoreTypeParam2: GameScoreType.none,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel tekAyak(WidgetRef ref) {
    return StaticGameModel(
      id: 's22',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's22',
        name: instForGameScreen.game_title_22,
        primaryScoreString:
            instForGameScreen.activity_default_scores_total_duration,
        description: instForGameScreen.game_description_22,
        imagePath: '22',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 6,
        ),
        gamePadCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        radius: NumRange.radius(
          def: 5,
          min: 1,
          max: 10,
        ),
        tag: GameTag.balance,
        earnings: [
          GameEarning.balance,
        ],
        categories: {
          GameCategory.sports: 5,
          GameCategory.edu: 26,
          GameCategory.entertainment: 12,
          GameCategory.multiplayer: 16,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        // we're gonna be measuring the time each player
        // keeps the pad stable.
        scoreTypeParam1: GameScoreType.totalDuration,
        scoreTypeParam2: GameScoreType.none,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          unavailableColors: [
            gameErrorColor,
          ],
        ),
        sensorTypes: {
          UsedSensorsType.motion: false,
        },
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
        final setup = game.setup;
        final mainPlayer = players.first;
        final devices = mainPlayer.devs;
        final devs = setup.getGameDevices(ref);
        final mainDevicesIds = devices.map((e) => e.id);
        final radius = game.setup.radius!.def;

        Map<String, List<DeviceModel>> devsMapCombined = {
          for (final player in players) player.id: player.devs
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

        playerId(String devid) {
          return devsMapCombined.entries
              .firstWhere((element) =>
                  element.value.map((e) => e.id).toList().contains(devid))
              .key;
        }

        sendIsCommandToPlayerDevs(String id) {
          final playerDevs =
              players.firstWhere((element) => element.id == id).devs;
          for (var playerDev in playerDevs) {
            StaticGameManager.sendIsCommand(playerDev.id, ref: ref);
          }
        }

        bool allAreSteady(String id) {
          final playerDevs =
              players.firstWhere((element) => element.id == id).devs;
          int i = 0;
          for (var playerDev in playerDevs) {
            if (lastWasSteady[playerDev.id] == true) {
              i++;
            }
          }
          if (i == 2) {
            return true;
          }
          return false;
        }

        // we wanna stay listening to the device's angle
        final st = StaticGameManager.listenToMotionMulti(
          devs.map((e) => e.id),
          ref: ref,
        );

        var streamer = Streamer(st);

        Map<String, MotionEvent> lastEvents = {};
        Map<String, MotionEvent> lastPlayerEvent = {};
        Future<void> executor(WidgetRef ref) async {
          for (final player in players) {
            StaticGameManager.addScorePoint(
              playerId: player.id,
              time: Duration.zero,
              ref: ref,
            );
          }
          streamer = streamer.listen(
            onData: (event) async {
              final devId = event.deviceId;

              lastEvents[devId] = event;
              final playerid = playerId(devId);
              lastPlayerEvent[playerid] = event;
              final dev = devMap[devId];
              final newDev = dev!.name.contains('V');
              gameModel = HoldSteadyGameModel.fromAcceleremetorGravityModel(
                      event.motion,
                      newDev: !newDev)
                  .copyWith(radius: radius!.toDouble());

              // once we receieve a steady angle from
              // any pad, (for the first time) we wanna
              // send an iscommand to all pads
              if (gameModel!.isSteady) {
                // there is a possibility that pad has been steady
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
                    sendIsCommandToPlayerDevs(playerid);
                  }
                }
              }

              // once it leans, we wanna add that response time
              else {
                // there is a possibility that this pad has been leaned
                // before and we have registered its response time (as we're
                // not recieving data ONLY when it leans or gets steady).
                // so we'll check if this was steady before, which means
                // it was not leaned and this is its first time.
                //

                if (lastWasSteady[devId] == true) {
                  // this check should never be under because it depends on
                  // lastWasSteady

                  final allSteady = allAreSteady(playerid);

                  // first thing we wanna do is to mark this one as steady.
                  lastWasSteady[devId] = false;

                  //
                  // a condition for this is we want to check that when this pad
                  // has leaned, all of the other are not leaned. so if ANY
                  // ONLY if all the pads are leaned and this one is not, we
                  // wanna add the response time.
                  //
                  // DO NOT EVER ATTEMPT TO MOVE TO REPLACE THIS allSteady VARIABLE
                  // WITH THE FUNCTION CALL. we're doing the function call before
                  // turning this dev's state to not steady, so we can get an accurate
                  // result on their status then.
                  if (allSteady) {
                    logger.i('IT IS ALL STEADY');
                    // and now we wanna add the response time to the logs,
                    // as it does not matter which pad's response time we log
                    // because they all recieve the iscommand at the same time.
                    // (maybe milliseconds off but what can u do about that)
                    sendIsCommandToPlayerDevs(playerid);

                    debugPrint("Event ResponseTime: ${event.responseTime}");

                    StaticGameManager.addScorePoint(
                      playerId: playerid,
                      time: event.responseTime!,
                      ref: ref,
                    );
                  }
                }
              }

              // now we wanna led the relative angle.
              //
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
          // if the game ends with the last position
          // of the pad steady, we wanna add the last response
          // time
          for (var player in players) {
            if (allAreSteady(player.id) && lastEvents.isNotEmpty) {
              // again, all the pads are recieving the iscommand
              // at the same time, so we can just pick any of them.
              // we're picking any that has had an event. (they all will)
              // but idk i dont want a bug in this.

              StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: player.id,
                  time: lastPlayerEvent[player.id]!.responseTime!);

              sendIsCommandToPlayerDevs(player.id);
            }
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

  static StaticGameModel harfler(WidgetRef ref) {
    return StaticGameModel(
      id: 's23',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's23',
        name: instForGameScreen.game_title_23,
        description: instForGameScreen.game_description_23,
        imagePath: '23',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 14,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        const clr = gameSuccessColor;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }

        //Why this here idk i was afraid to remove...(bool end = false;)
        bool end = false;

        Future<void> round(WidgetRef ref) async {
          final entry = devMap.first;
          late final DiscoveredDevice correctDev;
          try {
            correctDev = entry.value;
          } catch (e) {
            end = true;
          }

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          final ids = [];
          final incorrectDevs = <DiscoveredDevice>[];
          //Wrong devices detected!
          for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          }

          StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          final audio = AudioFiles.letterAudio(
              StickerManager.idToStickerLetterAudioNameApp(
                  ref: ref, val: correctDev.deviceNumber!.toString())!);

          await audioPlayer.play(audio);

          StaticGameManager.ledColor(
              correctDev.id, SidesColorsModel.all(gameErrorColor),
              ref: ref);

          /* CustomDevDebugOperations.playAudio(
            correctDev.id,
            ref,
            val: StickerManager.idToStickerLetterAudioNamePad(
              val: correctDev.deviceNameId!,
            )!,
          ); */

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevs.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final correctStreamer = Streamer(correctListener);

          final incorrectStreamer = Streamer(otherDevicesListener);

          correctStreamer.listen(
            onData: (event) async {
              logger.d(event.toString());
              if (event.isValid && event.responseTime != null) {
                StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );
                audioPlayer.playSuccess();

                PadManager.playMusic(correctDev.id, ref: ref);

                await Future.delayed(const Duration(seconds: 1));

                StaticGameManager.ledOff(correctDev.id, ref: ref);

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );
                incorrectStreamer.cancel();
                correctStreamer.cancel();
              }
            },
          );

          incorrectStreamer.listen(
            onData: (e) async {
              StaticGameManager.ledColor(
                correctDev.id,
                SidesColorsModel.all(clr),
                ref: ref,
                isCommand: true,
              );
              audioPlayer.playBuzz();
              await Future.delayed(const Duration(seconds: 1));
              StaticGameManager.ledOff(
                correctDev.id,
                ref: ref,
              );
              StaticGameManager.decreaseScore(
                ref: ref,
                playerId: mainPlayer.id,
              );
              devMap.insert(devMap.length, entry);
              correctStreamer.cancel();
              incorrectStreamer.cancel();
            },
          );

          await correctStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);

          await incorrectStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);

          try {
            devMap.remove(entry);
          } catch (e) {
            end = true;
          }
        }

        await Future.delayed(Duration(milliseconds: Platform.isIOS ? 50 : 0));

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider) || end;
          },
        );
      },
    );
  }

  static StaticGameModel sayilar(WidgetRef ref) {
    return StaticGameModel(
      id: 's24',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's24',
        name: instForGameScreen.game_title_24,
        description: instForGameScreen.game_description_24,
        imagePath: '24',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 9,
        ),
        tag: GameTag.numeral,
        earnings: [
          GameEarning.numeral,
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 7,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        const clr = gameSuccessColor;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }
        bool end = false;
        bool goOn = true;
        Future<void> round(WidgetRef ref) async {
          goOn = true;
          late final MapEntry<String, DiscoveredDevice> entry;
          try {
            entry = devMap.first;
          } catch (e) {
            end = true;
          }

          final correctDev = entry.value;

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          final ids = [];
          final incorrectDevs = <DiscoveredDevice>[];
          for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          }
          await StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          final ftr = [
            StaticGameManager.ledColor(
                correctDev.id, SidesColorsModel.all(gameErrorColor),
                ref: ref),
            PadManager.playMusic(correctDev.id, ref: ref)
          ];

          await Future.wait(ftr);

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevs.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final correctStreamer = Streamer(correctListener);

          final incorrectStreamer = Streamer(otherDevicesListener);

          correctStreamer.listen(
            onData: (event) async {
              logger.i("Event: ${event.tap.toString()}");
              if (event.isValid && event.responseTime != null && goOn) {
                goOn = false;
                await StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );

                await audioPlayer.playSuccess();

                await StaticGameManager.ledOff(correctDev.id, ref: ref);

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                incorrectStreamer.cancel();
                correctStreamer.cancel();
              }
            },
          );

          incorrectStreamer.listen(
            onData: (event) async {
              logger.i(
                  "Triggered --!-- ${ref.read(currentDevicesManagerProvider)[event.deviceId]!.bleName} ${event.tap.tapCounter}");

              if (goOn) {
                goOn = false;
                await StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                  isCommand: true,
                );

                await audioPlayer.playBuzz();

                StaticGameManager.ledOff(
                  correctDev.id,
                  ref: ref,
                );
                StaticGameManager.decreaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                devMap.insert(devMap.length, entry);
                correctStreamer.cancel();
                incorrectStreamer.cancel();
              }
            },
          );

          await correctStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          await incorrectStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          /*final audio = AudioFiles.langCardinal(correctDev.deviceNumber!);
          await audioPlayer.play(audio);*/

          try {
            devMap.remove(entry);
          } catch (e) {
            end = true;
          }
        }

        await Future.delayed(Duration(milliseconds: Platform.isIOS ? 50 : 0));

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider) || end;
          },
        );
      },
    );
  }

  static StaticGameModel hayvanlar(WidgetRef ref) {
    return StaticGameModel(
      id: 's25',
      metaData: GameMetaDataModel(
        id: 's25',
        name: instForGameScreen.game_title_25,
        description: instForGameScreen.game_description_25,
        imagePath: '25',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 11,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        const clr = gameSuccessColor;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }
        bool end = false;
        Future<void> round(WidgetRef ref) async {
          late final MapEntry<String, DiscoveredDevice> entry;
          try {
            entry = devMap.first;
          } catch (e) {
            end = true;
          }

          final correctDev = entry.value;

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          final ids = [];
          final incorrectDevs = <DiscoveredDevice>[];
          for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          }

          StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          /*final audio = AudioFiles.animalAudio(
            StickerManager.idToStickerAnimalAudioNameApp(
                val: correctDev.deviceNameId!, ref: ref)!,
          );
          await audioPlayer.play(audio);*/
          PadManager.playMusic(correctDev.id, ref: ref);
          await Future.delayed(const Duration(milliseconds: 500));
          StaticGameManager.ledColor(
              correctDev.id, SidesColorsModel.all(gameErrorColor),
              ref: ref);
          /* CustomDevDebugOperations.playAudio(
            correctDev.id,
            ref,
            val: StickerManager.idToStickerAnimalAudioNamePad(
              val: correctDev.deviceNameId!,
            )!,
          ); */
          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevs.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final correctStreamer = Streamer(correctListener);

          final incorrectStreamer = Streamer(otherDevicesListener);

          incorrectStreamer.listen(
            onData: (e) async {
              StaticGameManager.ledColor(
                correctDev.id,
                SidesColorsModel.all(clr),
                ref: ref,
                isCommand: true,
              );

              audioPlayer.playBuzz();
              await Future.delayed(const Duration(seconds: 1));
              StaticGameManager.ledOff(
                correctDev.id,
                ref: ref,
              );
              StaticGameManager.decreaseScore(
                ref: ref,
                playerId: mainPlayer.id,
              );

              devMap.insert(devMap.length, entry);

              correctStreamer.cancel();
              incorrectStreamer.cancel();
            },
          );

          correctStreamer.listen(
            onData: (event) async {
              logger.d(event.toString());
              if (event.isValid && event.responseTime != null) {
                StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );
                audioPlayer.playSuccess();
                await Future.delayed(const Duration(seconds: 1));
                StaticGameManager.ledOff(correctDev.id, ref: ref);

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );
                incorrectStreamer.cancel();
                correctStreamer.cancel();
              }
            },
          );
          await correctStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          await incorrectStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          try {
            devMap.remove(entry);
          } catch (e) {
            end = true;
          }
        }

        await Future.delayed(Duration(milliseconds: Platform.isIOS ? 50 : 0));

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider) || end;
          },
        );
      },
    );
  }

  static StaticGameModel dortIslem(WidgetRef ref) {
    return StaticGameModel(
      id: 's26',
      metaData: GameMetaDataModel(
        id: 's26',
        name: instForGameScreen.game_title_26,
        description: instForGameScreen.game_description_26,
        imagePath: '26',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        tag: GameTag.numeral,
        earnings: [
          GameEarning.numeral,
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 19,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
            gameErrorColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameOperationSelectionSetup: GameOperationSelectionSetup.init(),
          gameExecutionDevicesSelectionSetup:
              GameExecutionDeviceSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;

        List<DeviceModel> devs = List.from(generalPlayer.devs);

        // all of these has been converted to methods,
        // so we get to have the new value if it changes
        //
        // coming back after a while and reading this code and this
        // comment, I think that's crazy. how would these values change??
        // they're inchangable during the game. but I'm not gonna touch
        // this bcz it may break idk.
        StaticGameSetupModel setup() => ref.read(currentGameSetupProv)!;
        GameControlsSetup controls() => setup().controlsSetup;
        GameOperationSelectionSetup operationsSetup() =>
            controls().gameOperationSelectionSetup!;

        final selectedOperations = operationsSetup().selectedOperations;

        final executionDevicesSetup =
            controls().gameExecutionDevicesSelectionSetup!;

        // the user may wanna select to disable the controls to show only on pad,
        // only on app, or both. but never neither.
        final playableOnPad = executionDevicesSetup.isPlayableOnPads;

        // as operation colors, we wanna provide 4 colors
        // that are not the same as the main color
        final allColors = defaultConstColors(ref);
        final operationColors = allColors.take(selectedOperations.length);
        final operationsColorsMap = {
          for (int i = 0; i < selectedOperations.length; i++)
            selectedOperations.elementAt(i): operationColors.elementAt(i),
        };
        ref.read(operationColorsProv.notifier).state = operationsColorsMap;

        // TODO: before the game, assure every pad has a deviceNumber.
        // which can be achieved by making the user define a number sticker
        // on the pad.
        final devNumbers = devs.map((e) => e.deviceNumber!).toList();

        final combs = <MapEntry<MathOperation, List<int>>>[];

        for (var operat in selectedOperations) {
          final com =
              CustomGameOperations.numberCombinations(devNumbers, operat);

          final vals = com.value;

          for (var val in vals) {
            final entry = MapEntry(operat, val);
            combs.add(entry);
          }
        }

        final xr = Xrandom();
        combs.shuffle(xr);
        int i = 0;
        final combsLen = combs.length;
        Future<void> round(WidgetRef ref) async {
          await StaticGameManager.ledAllOff(ref: ref);

          final comb = combs[i % combsLen];

          final operation = comb.key;
          final numbers = comb.value;
          final result = operation.apply(numbers);

          if (playableOnPad) {
            final devicesOfNumbers =
                devs.where((e) => numbers.contains(e.deviceNumber!));
            for (var dev in devicesOfNumbers) {
              /// in the simulator, you may see a color difference
              /// if dev matches correctDev, and that is because of
              /// conversion between 100 and 255 etc. don't worry
              /// about that.
              await StaticGameManager.ledColor(
                dev.id,
                SidesColorsModel.all(operationsColorsMap[operation]!),
                ref: ref,
              );
            }
          }

          final gameScreenWidget = DortIslemWidget(combination: comb);
          ref.read(gameScreenWidgetProv.notifier).state = gameScreenWidget;

          DeviceModel correctDevice;

          try {
            correctDevice = devs.firstWhere((e) => e.deviceNumber == result);
          } catch (e) {
            assert(false);
            logger.e(e);
            return;
          }

          final otherDevices =
              devs.where((e) => e.id != correctDevice.id).toList();

          await StaticGameManager.sendIsCommand(
            correctDevice.id,
            ref: ref,
          );

          bool processOther = true;

          final audioPlayer = ref.watch(cpAudioPlayerProv);

          final devListener = StaticGameManager.listenToTouch(
            correctDevice.id,
            ref: ref,
          );

          final cordev = Streamer(devListener);

          final otherDevsListener = StaticGameManager.listenToTouchMulti(
            otherDevices.map((e) => e.id),
            ref: ref,
          );
          final incDev = Streamer(otherDevsListener);

          cordev.listen(
            onData: (event) async {
              if (processOther) {
                processOther = false;

                audioPlayer.playSuccess();

                StaticGameManager.addScorePoint(
                  ref: ref,
                  time: event.responseTime!,
                  playerId: mainPlayer.id,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                await StaticGameManager.ledMultiColorForSightDuration(
                  ref: ref,
                  {
                    correctDevice.id,
                    event.deviceId,
                  },
                  {
                    SidesColorsModel.all(gameSuccessColor),
                    SidesColorsModel.all(gameErrorColor),
                  },
                );
                cordev.cancel();
                incDev.cancel();
              }
            },
          );

          incDev.listen(
            onData: (event) async {
              if (processOther) {
                processOther = false;

                audioPlayer.playBuzz();

                StaticGameManager.decreaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                await StaticGameManager.ledColorForSightDuration(
                  ref: ref,
                  correctDevice.id,
                  SidesColorsModel.all(gameErrorColor),
                );
                cordev.cancel();
                incDev.cancel();
              }
            },
          );

          await incDev.doneOr(() async {
            if (ref.watch(gameEndingProvider)) {
              incDev.cancel();
              cordev.cancel();
            }
            return ref.watch(gameEndingProvider);
          });
          i++;
        }

        await game.setup.executeGame(
          ref,
          round,
        );

        ref.read(gameScreenWidgetProv.notifier).state = null;
      },
    );
  }

  static StaticGameModel emojiler(WidgetRef ref) {
    return StaticGameModel(
      id: 's27',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's27',
        name: instForGameScreen.game_title_27,
        description: instForGameScreen.game_description_27,
        imagePath: '27',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 8,
        ),
        tag: GameTag.visual,
        earnings: [
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 21,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
          gameEducationTypeSelectionSetup:
              GameEducationTypeSelectionSetup.init(),
        ),
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final generalPlayer = game.generalPlayer;
        final devs = generalPlayer!.devs;
        final setup = game.setup;
        List<String> emojis = [];
        final stickers = ref.read(stickerProvider).stickers;
        for (var dev in devs) {
          final stickerent = stickers.entries
              .firstWhere(
                  (sticker) => sticker.value == dev.deviceNumber.toString())
              .key;

          emojis.add(StickerManager.idToEmojiImageReturner(value: stickerent)!);
        }
        emojis = DeviceShuffler.shuffleUniquely(emojis, (p0, p1) => p0 == p1);
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        int index = -1;
        final control = setup.controlsSetup.gameEducationTypeSelectionSetup!
            .selectedOperations.first;
        bool showImage;
        switch (control) {
          case EducationType.read:
            showImage = false;
            break;
          case EducationType.learn:
            showImage = true;
            break;
        }
        ref.read(gameScreenWidgetProv.notifier).state =
            ShowEducationGameProperties(showImage: showImage);
        Future<void> round(WidgetRef ref) async {
          bool goodToGo = false;
          index++;
          String emoji = emojis.elementAt(index);
          ref.read(eduItemProv.notifier).setItem(EducationItemModel(
              item: emoji, imagePath: 'assets/images/emotions/$emoji.png'));
          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);
          final corDevDeviceNameId = stickers.entries
              .firstWhere((stckr) =>
                  emoji ==
                  StickerManager.idToEmojiImageReturner(value: stckr.key)!
                      .toLowerCase())
              .value;

          final corDev =
              devs.firstWhere((dev) => dev.deviceNameId == corDevDeviceNameId);
          final streamer = Streamer(listener);
          streamer.listen(
            onData: (event) async {
              //assert(event.isValid);
              if (corDev.id == event.deviceId) {
                StaticGameManager.ledColor(
                    event.deviceId, SidesColorsModel.all(gameSuccessColor),
                    ref: ref);
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) =>
                        StaticGameManager.ledOff(event.deviceId, ref: ref));
                if (index + 1 == devs.length) {
                  audioPlayer.playSuccess();
                  await Future.delayed(const Duration(seconds: 1));
                } else {
                  audioPlayer.playSuccess();
                }
                goodToGo = true;
              } else {
                StaticGameManager.ledColor(
                    corDev.id, SidesColorsModel.all(gameSuccessColor),
                    ref: ref);
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) => StaticGameManager.ledOff(corDev.id, ref: ref));
              }
            },
          );
          await streamer
              .doneOr(() async => goodToGo || ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return index + 1 == devs.length || ref.watch(gameEndingProvider);
          },
        );
      },
    );
  }

  static StaticGameModel sebzeler(WidgetRef ref) {
    return StaticGameModel(
      id: 's29',
      metaData: GameMetaDataModel(
        id: 's29',
        name: instForGameScreen.game_title_29,
        description: instForGameScreen.game_description_29,
        imagePath: '29',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        tag: GameTag.visual,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 32,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel meyveler(WidgetRef ref) {
    return StaticGameModel(
      id: 's28',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's28',
        name: instForGameScreen.game_title_28,
        description: instForGameScreen.game_description_28,
        imagePath: '28',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 8,
        ),
        tag: GameTag.visual,
        earnings: [
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 22,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
          gameEducationTypeSelectionSetup:
              GameEducationTypeSelectionSetup.init(),
        ),
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final generalPlayer = game.generalPlayer;
        final devs = generalPlayer!.devs;
        final setup = game.setup;
        List<String> fruits = [];
        final stickers = ref.read(stickerProvider).stickers;
        for (var dev in devs) {
          final stickerent = stickers.entries
              .firstWhere(
                  (sticker) => sticker.value == dev.deviceNumber.toString())
              .key;

          fruits
              .add(StickerManager.idToFruitsImageReturner(value: stickerent)!);
        }
        fruits = DeviceShuffler.shuffleUniquely(fruits, (p0, p1) => p0 == p1);
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        int index = -1;
        final control = setup.controlsSetup.gameEducationTypeSelectionSetup!
            .selectedOperations.first;
        bool showImage;
        switch (control) {
          case EducationType.read:
            showImage = false;
            break;
          case EducationType.learn:
            showImage = true;
            break;
        }
        ref.read(gameScreenWidgetProv.notifier).state =
            ShowEducationGameProperties(showImage: showImage);
        Future<void> round(WidgetRef ref) async {
          bool goodToGo = false;
          index++;
          String fruit = fruits.elementAt(index);
          ref.read(eduItemProv.notifier).setItem(EducationItemModel(
              item: fruit, imagePath: 'assets/images/fruits/$fruit.png'));
          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);
          final streamer = Streamer(listener);
          final corDevDeviceNameId = stickers.entries
              .firstWhere((stckr) =>
                  fruit ==
                  StickerManager.idToFruitsImageReturner(value: stckr.key)!
                      .toLowerCase())
              .value;

          final corDev =
              devs.firstWhere((dev) => dev.deviceNameId == corDevDeviceNameId);
          streamer.listen(
            onData: (event) async {
              //assert(event.isValid);
              if (corDev.id == event.deviceId) {
                StaticGameManager.ledColor(
                    event.deviceId, SidesColorsModel.all(gameSuccessColor),
                    ref: ref);
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) =>
                        StaticGameManager.ledOff(event.deviceId, ref: ref));
                if (index + 1 == devs.length) {
                  audioPlayer.playSuccess();
                  await Future.delayed(const Duration(seconds: 1));
                } else {
                  audioPlayer.playSuccess();
                }
                goodToGo = true;
              } else {
                StaticGameManager.ledColor(
                    corDev.id, SidesColorsModel.all(gameSuccessColor),
                    ref: ref);
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) => StaticGameManager.ledOff(corDev.id, ref: ref));
              }
            },
          );
          await streamer
              .doneOr(() async => goodToGo || ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return index + 1 == devs.length || ref.watch(gameEndingProvider);
          },
        );
      },
    );
  }

  static StaticGameModel carpimTablosu(WidgetRef ref) {
    return StaticGameModel(
      id: 's30',
      metaData: GameMetaDataModel(
        id: 's30',
        name: instForGameScreen.game_title_30,
        description: instForGameScreen.game_description_39,
        imagePath: '30',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 10,
          max: 10,
        ),
        tag: GameTag.numeral,
        earnings: [
          GameEarning.numeral,
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 20,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel ritmikSayma(WidgetRef ref) {
    return StaticGameModel(
      id: 's31',
      metaData: GameMetaDataModel(
        id: 's31',
        name: instForGameScreen.game_title_31,
        description: instForGameScreen.game_description_31,
        imagePath: '31',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 8,
        ),
        tag: GameTag.numeral,
        earnings: [
          GameEarning.numeral,
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 21,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel oruntu(WidgetRef ref) {
    return StaticGameModel(
      id: 's32',
      metaData: GameMetaDataModel(
        id: 's32',
        name: instForGameScreen.game_title_32,
        description: instForGameScreen.game_description_32,
        imagePath: '32',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 12,
        ),
        tag: GameTag.intelligence,
        earnings: [
          GameEarning.intelligence,
        ],
        categories: {
          GameCategory.edu: 18,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {},
    );
  }

  static StaticGameModel renkler(WidgetRef ref) {
    return StaticGameModel(
      id: 's33',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's33',
        name: "Renkler",
        description:
            "Ekranında gördüğün rengi bilmeye çalış. Cevap Pad'lerde gizli!",
        imagePath: '33',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 8,
        ),
        tag: GameTag.visual,
        earnings: [
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 30,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        controlsSetup: GameControlsSetup(
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
          gameEducationTypeSelectionSetup:
              GameEducationTypeSelectionSetup.init(),
        ),
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final generalPlayer = game.generalPlayer;
        final devs = generalPlayer!.devs;
        //final setup = game.setup;
        //final player = game.players.first;
        //var colors = defaultConstColors(ref);
        var colorsounds = colorSounds;
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        Future<void> round(WidgetRef ref) async {
          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);
          final streamer = Streamer(listener);
          streamer.listen(
            onData: (event) async {
              assert(event.isValid);
              colorsounds = DeviceShuffler.shuffleUniquely(
                  colorsounds, (p0, p1) => p0 == p1);
              final sound = colorsounds.first;
              StaticGameManager.ledColor(
                  event.deviceId, SidesColorsModel.all(gameSuccessColor),
                  ref: ref);
              Future.delayed(const Duration(milliseconds: 200)).then((value) =>
                  StaticGameManager.ledOff(event.deviceId, ref: ref));
              //final dev = devs.firstWhere((dev) => dev.id == event.deviceId);
              final audio = AudioFiles.colorAudio(sound);
              audioPlayer.play(audio);
            },
          );
          await streamer.done;
        }

        await game.setup.executeGame(ref, round);
      },
    );
  }

  static StaticGameModel tasitlar(WidgetRef ref) {
    return StaticGameModel(
      id: 's34',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's34',
        name: instForGameScreen.game_title_34,
        description: instForGameScreen.game_description_34,
        imagePath: '34',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 8,
        ),
        tag: GameTag.visual,
        earnings: [
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 23,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
          gameEducationTypeSelectionSetup:
              GameEducationTypeSelectionSetup.init(),
        ),
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final generalPlayer = game.generalPlayer;
        final devs = generalPlayer!.devs;
        final setup = game.setup;
        List<String> vehiclesounds = [];
        final stickers = ref.read(stickerProvider).stickers;
        for (var dev in devs) {
          final stickerent = stickers.entries
              .firstWhere(
                  (sticker) => sticker.value == dev.deviceNumber.toString())
              .key;

          vehiclesounds.add(
              StickerManager.idToVehicleSoundAudioReturner(value: stickerent)!);
        }
        vehiclesounds =
            DeviceShuffler.shuffleUniquely(vehiclesounds, (p0, p1) => p0 == p1);
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        int index = -1;
        int counter = 0;
        final control = setup.controlsSetup.gameEducationTypeSelectionSetup!
            .selectedOperations.first;
        bool showImage;
        switch (control) {
          case EducationType.read:
            showImage = false;
            break;
          case EducationType.learn:
            showImage = true;
            break;
        }
        ref.read(gameScreenWidgetProv.notifier).state =
            ShowEducationGameProperties(showImage: showImage);
        Future<void> round(WidgetRef ref) async {
          bool goodToGo = false;
          index++;
          String vehicleSound = vehiclesounds.elementAt(index);
          ref.read(eduItemProv.notifier).setItem(EducationItemModel(
              item: vehicleSound,
              imagePath: 'assets/images/vehicles/$vehicleSound.png'));
          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);
          final streamer = Streamer(listener);
          final corDevDeviceNameId = stickers.entries
              .firstWhere((stckr) =>
                  vehicleSound ==
                  StickerManager.idToVehicleSoundAudioReturner(
                          value: stckr.key)!
                      .toLowerCase())
              .value;

          final corDev =
              devs.firstWhere((dev) => dev.deviceNameId == corDevDeviceNameId);
          streamer.listen(
            onData: (event) async {
              //assert(event.isValid);
              if (event.deviceId == corDev.id) {
                counter++;
                StaticGameManager.ledColor(
                    event.deviceId, SidesColorsModel.all(gameSuccessColor),
                    ref: ref);
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) =>
                        StaticGameManager.ledOff(event.deviceId, ref: ref));
                final audio = AudioFiles.vehicleAudio(vehicleSound);
                if (index + 1 == devs.length) {
                  await audioPlayer.play(audio);
                } else {
                  audioPlayer.play(audio);
                }
                goodToGo = true;
              } else {
                try {
                  StaticGameManager.ledColor(
                      corDev.id, SidesColorsModel.all(gameSuccessColor),
                      ref: ref);
                  Future.delayed(const Duration(milliseconds: 200)).then(
                      (value) => StaticGameManager.ledOff(corDev.id, ref: ref));
                } catch (e) {
                  logger.d(e.toString());
                }
              }
            },
          );
          await streamer
              .doneOr(() async => goodToGo || ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devs.length == counter ||
                index + 1 == devs.length ||
                ref.watch(gameEndingProvider);
          },
        );
      },
    );
  }

  static StaticGameModel bulBakalim(WidgetRef ref) {
    return StaticGameModel(
      id: 's35',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: 's35',
        name: instForGameScreen.game_title_35,
        description: instForGameScreen.game_description_35,
        imagePath: '35',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        inGameIgaHeader: instForGameScreen.iga_pad_snatch_in_game_header_text,
        igaPickColor: false,
        igaCountDownTextSpans: [
          [
            TextSpan(
              text: instForGameScreen.game_loading_title_1,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_bul_bakalim_countdown_2,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.iga_bul_bakalim_countdown_3,
            )
          ],
          [
            TextSpan(
              text: instForGameScreen.start,
            ),
            const TextSpan(
                text: '!', style: TextStyle(color: CpColors.cpPrimary))
          ],
        ],
        igaTextSpans: [
          [
            TextSpan(
                text: instForGameScreen.iga_pad_snatch_stepper_one_text,
                style: Theme.of(ref.context).textTheme.headlineMedium)
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_pad_snatch_stepper_two_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_pad_snatch_stepper_three_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ],
          [
            TextSpan(
                text: instForGameScreen.iga_pad_snatch_stepper_four_text,
                style: Theme.of(ref.context).textTheme.headlineMedium),
          ]
        ],
        /*duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),*/
        padCount: NumRange.padCount(
          min: 4,
          max: 10,
        ),
        tag: GameTag.memory,
        earnings: [
          GameEarning.visual_memory,
          GameEarning.focus,
          GameEarning.neural_priming,
        ],
        categories: {
          GameCategory.edu: 17,
          GameCategory.entertainment: 7,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 10,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.first;
        final audioPlayer = ref.read(cpAudioPlayerProv);
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final clrs = defaultConstColors(ref);

        if (clrs.length.isOdd) {
          clrs.removeLast();
        }

        var devs = generalPlayer.devs;

        if (ref.read(currentEmbModeManager) == 1 &&
            ref.read(currentIgaChooseLevelManager) == IGALevelModes.easy) {
          devs = ref
              .read(igaBackGroundManager.notifier)
              .easyDiscoveredDevices
              .toList();
        }

        late final int totalCorrectCount;
        if (devs.length.isOdd) {
          devs.removeLast();
          totalCorrectCount = devs.length ~/ 2;
        } else {
          totalCorrectCount = devs.length ~/ 2;
        }

        // we want to match at most 2 devices for each color
        final Map<int, MapEntry<Color, List<DeviceModel>>> colorDevices = {};

        devs.shuffle(Xrandom());
        clrs.shuffle(Xrandom());

        for (var i = 0, j = 0;
            i < clrs.length && j < devs.length;
            i++, j += 2) {
          final color = clrs[i];
          final devicesForColor = devs.sublist(j, j + 2);

          colorDevices[i] = MapEntry(color, devicesForColor);
        }

        // loop all colorDevices keys, and ledColor them
        for (final entry in colorDevices.entries.map(
          (e) => e.value,
        )) {
          final color = entry.key;
          final devices = entry.value;

          for (final device in devices) {
            StaticGameManager.ledColor(
              device.id,
              SidesColorsModel.all(color),
              ref: ref,
            );
          }
        }

        await Future.delayed(const Duration(seconds: 6));

        ref.read(currentBulBakalim.notifier).changState(true);

        // loop all colorDevices keys, and ledOff them
        for (final device in colorDevices.values.expand((e) => e.value)) {
          StaticGameManager.ledOff(
            device.id,
            ref: ref,
          );
        }

        final rand = Xrandom();
        final entryCount = colorDevices.entries.length;
        final randIndexes = List.generate(
          entryCount,
          (index) => colorDevices.keys.elementAt(index),
        );
        randIndexes.shuffle(rand);

        int idx = 0;
        int correctCount = 0;
        bool goOn = true;

        if (ref.read(currentEmbModeManager) == 1) {
          ref.read(gameEndingProvider.notifier).startTimeOut(
              ref: ref, timeOutDurationSecond: 15, intervalCheckSecond: 1);
        }
        Future<void> round(WidgetRef ref) async {
          goOn = true;
          late int currentId;
          try {
            currentId = randIndexes[idx++];
          } catch (e) {
            currentId = randIndexes.first;
            ref.read(gameEndingProvider.notifier).end();
          }

          for (final dev in devs) {
            await PadManager.ledOff(
              dev.id,
              ref: ref,
            );
          }

          final correctEntry = colorDevices[currentId];
          final incorrectM =
              Map<int, MapEntry<Color, List<DiscoveredDevice>>>.from(
                  colorDevices)
                ..remove(currentId);
          final incorrectEntries = incorrectM.entries;

          assert(correctEntry != null);
          assert(incorrectEntries.isNotEmpty);

          final correctColor = correctEntry!.key;

          final correctDevices = correctEntry.value;
          final incorrectDevices =
              incorrectEntries.map((e) => e.value).expand((e) => e.value);
          // now only led the first device of the correct color
          StaticGameManager.ledColor(
            correctDevices[0].id,
            SidesColorsModel.all(correctColor),
            ref: ref,
          );

          // and send the command to the other device of the correct color
          final touchable = correctDevices[1];
          StaticGameManager.sendIsCommand(
            touchable.id,
            ref: ref,
          );

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevices.map((e) => e.id),
            ref: ref,
          );

          final correctDeviceListener = StaticGameManager.listenToTouch(
            touchable.id,
            ref: ref,
          );

          final streamerInc = Streamer(otherDevicesListener);

          final streamerCor = Streamer(correctDeviceListener);

          streamerInc.listen(
            onData: (event) async {
              if (ref.read(currentEmbModeManager) == 1) {
                ref.read(gameEndingProvider.notifier).updateMovePointDuration();

                ref.read(gameEndingProvider.notifier).startTimeOut(
                    ref: ref,
                    timeOutDurationSecond: 15,
                    intervalCheckSecond: 1);
              }
              if (goOn) {
                goOn = false;
                audioPlayer.playBuzz();
                StaticGameManager.decreaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                StaticGameManager.ledColor(
                  touchable.id,
                  SidesColorsModel.all(correctColor),
                  ref: ref,
                );

                // await half a second so the user can get a sense
                await Future.delayed(const Duration(milliseconds: 500));
                // final correctOne = inc
                randIndexes.insert(randIndexes.length, currentId);
                streamerCor.cancel();
                streamerInc.cancel();
              }
            },
          );

          streamerCor.listen(
            onData: (event) async {
              if (ref.read(currentEmbModeManager) == 1) {
                ref.read(gameEndingProvider.notifier).updateMovePointDuration();
                ref.read(gameEndingProvider.notifier).startTimeOut(
                    ref: ref,
                    timeOutDurationSecond: 15,
                    intervalCheckSecond: 1);
              }
              if (event.isValid && goOn) {
                goOn = false;
                audioPlayer.playSuccess();

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,

                  /// `isValid` assures this is not null
                  time: event.responseTime!,
                );

                StaticGameManager.ledColor(
                  touchable.id,
                  SidesColorsModel.all(correctColor),
                  ref: ref,
                );
                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                // await half a second so the user can get a sense
                await Future.delayed(const Duration(milliseconds: 500));
                streamerInc.cancel();
                streamerCor.cancel();
                correctCount++;
              }
            },
          );
          await streamerInc.doneOr(() async => ref.watch(gameEndingProvider));
          await streamerCor.doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(ref, round, shouldStop: (ref) async {
          return totalCorrectCount == correctCount ||
              ref.watch(gameEndingProvider);
        }, disposeCb: (_) async {
          ref.read(gameEndingProvider.notifier).end();
          return true;
        });
      },
    );
  }

  static StaticGameModel sekiller(WidgetRef ref) {
    return StaticGameModel(
      id: 's36',
      metaData: GameMetaDataModel(
        id: 's36',
        name: instForGameScreen.game_title_36,
        description: instForGameScreen.game_description_36,
        imagePath: '36',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 8,
        ),
        tag: GameTag.visual,
        earnings: [
          GameEarning.visual,
          GameEarning.auditory,
        ],
        categories: {
          GameCategory.edu: 24,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
          gameEducationTypeSelectionSetup:
              GameEducationTypeSelectionSetup.init(),
        ),
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(hasDevices: true),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final generalPlayer = game.generalPlayer;
        final devs = generalPlayer!.devs;
        final setup = game.setup;
        List<String> shapes = [];
        final stickers = ref.read(stickerProvider).stickers;
        for (var dev in devs) {
          final stickerent = stickers.entries
              .firstWhere(
                  (sticker) => sticker.value == dev.deviceNumber.toString())
              .key;

          shapes
              .add(StickerManager.idToShapesImageReturner(value: stickerent)!);
        }
        shapes = DeviceShuffler.shuffleUniquely(shapes, (p0, p1) => p0 == p1);
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        int index = -1;
        final control = setup.controlsSetup.gameEducationTypeSelectionSetup!
            .selectedOperations.first;
        bool showImage;
        switch (control) {
          case EducationType.read:
            showImage = false;
            break;
          case EducationType.learn:
            showImage = true;
            break;
        }
        ref.read(gameScreenWidgetProv.notifier).state =
            ShowEducationGameProperties(showImage: showImage);
        Future<void> round(WidgetRef ref) async {
          bool goodToGo = false;
          index++;
          String shape = shapes.elementAt(index);
          ref.read(eduItemProv.notifier).setItem(EducationItemModel(
              item: shape, imagePath: 'assets/images/shapes/$shape.png'));
          final listener = StaticGameManager.listenToTouchMulti(
              devs.map((e) => e.id),
              ref: ref);
          final streamer = Streamer(listener);
          final corDevDeviceNameId = stickers.entries
              .firstWhere((stckr) =>
                  shape ==
                  StickerManager.idToShapesImageReturner(value: stckr.key)!
                      .toLowerCase())
              .value;

          final corDev =
              devs.firstWhere((dev) => dev.deviceNameId == corDevDeviceNameId);
          streamer.listen(
            onData: (event) async {
              //assert(event.isValid);
              if (event.deviceId == corDev.id) {
                StaticGameManager.ledColor(
                    event.deviceId, SidesColorsModel.all(gameSuccessColor),
                    ref: ref);
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) =>
                        StaticGameManager.ledOff(event.deviceId, ref: ref));
                if (index + 1 == devs.length) {
                  audioPlayer.playSuccess();
                  await Future.delayed(const Duration(seconds: 1));
                } else {
                  audioPlayer.playSuccess();
                }
                goodToGo = true;
              } else {
                StaticGameManager.ledColor(
                    corDev.id, SidesColorsModel.all(gameSuccessColor),
                    ref: ref);
                Future.delayed(const Duration(milliseconds: 200)).then(
                    (value) => StaticGameManager.ledOff(corDev.id, ref: ref));
              }
            },
          );
          await streamer
              .doneOr(() async => goodToGo || ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return index + 1 == devs.length || ref.watch(gameEndingProvider);
          },
        );
      },
    );
  }

  static StaticGameModel drill(WidgetRef ref) {
    return StaticGameModel(
      id: 's37',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's37',
        name: instForGameScreen.game_title_37,
        primaryScoreString: instForGameScreen.score_target,
        description: instForGameScreen.game_description_37,
        imagePath: '37',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 30,
          min: 15,
          max: 60,
        ),
        tag: GameTag.condition,
        earnings: [
          GameEarning.condition,
        ],
        categories: {
          GameCategory.sports: 21,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.score,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];

        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final List<DeviceModel> devices = List.from(generalPlayer.devs);

        final xr = Xrandom();

        Future<void> round(WidgetRef ref) async {
          devices.shuffle(xr);
          final dev = devices[0];

          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(mainColor),
            ref: ref,
            isCommand: true,
          );

          await for (final event
              in StaticGameManager.listenToTouch(dev.id, ref: ref)) {
            if (event.isValid) {
              StaticGameManager.addScorePoint(
                ref: ref,
                playerId: mainPlayer.id,
                time: event.responseTime!,
              );
              StaticGameManager.increaseScore(
                ref: ref,
                playerId: mainPlayer.id,
              );
              /* StaticGameManager.addFlSpot(
                  ref: ref,
                  playerId: mainPlayer.id,
                  spot: FlSpot(
                      StaticGameManager.getScore(
                              playerId: mainPlayer.id, ref: ref)
                          .toDouble(),
                      event.responseTime!.durationToDoubleForGraph())); */

              await StaticGameManager.ledOff(dev.id, ref: ref);
            }
            break;
          }
        }

        await game.setup.executeGame(
          ref,
          round,
        );
      },
    );
  }

  static StaticGameModel sinav(WidgetRef ref) {
    return StaticGameModel(
      id: 's38',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: 's38',
        name: instForGameScreen.game_title_38,
        primaryScoreString: instForGameScreen.game_result_primary_score_push_up,
        description: instForGameScreen.game_description_38,
        imagePath: '38',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 30,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 10),
        distance: NumRange.distanceCm(
          def: 20,
          min: 5,
          max: 60,
        ),
        tag: GameTag.strength,
        earnings: [
          GameEarning.resistance,
        ],
        categories: {
          GameCategory.sports: 7,
          GameCategory.multiplayer: 17,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        sensorTypes: {
          UsedSensorsType.distance: true,
        },
        doesHaveSound: false,
        dstConfig:
            const DstConfigModel(threshold: 1000, timeout: 150, limitValue: 7),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final setup = ref.read(currentGameSetupProv)!;
        final devs = setup.getGameDevices(ref);
        final wantedDis = setup.distance!.def!;

        for (var dev in devs) {
          await StaticGameManager.sendIsCommand(dev.id, ref: ref);
        }

        final sender = SendStreamer();
        Streamer<DistanceEvent>? streamer;
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: player.devs.first
        };

        Map<String, bool> zoneMap = {
          for (final player in players) player.id: false,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        Map<String, DistanceEvent?> lastEvents = {
          for (final player in players) player.id: null,
        };
        bool ended = false;
        Future<void> round(WidgetRef ref) async {
          /// 1- await until the user gets into the our range
          /// which is game.distanceConfig.distance
          /// 2- led the player's color
          /// 3- await until the player gets out of the range

          var st = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
          streamer = Streamer(st).listen(
            onData: (event) async {
              final discDevice = devsMap.values
                  .firstWhere((element) => element!.id == event.deviceId);
              final playerId = devsMap.entries
                  .firstWhere((element) => element.value!.id == discDevice!.id)
                  .key;
              lastEvents[playerId] = event;
              final dis = event.distance.distance;
              if (!zoneMap[playerId]!) {
                /// await until the user gets into the our range
                /// which is game.distanceConfig.distance
                if (dis + 1 <= wantedDis) {
                  zoneMap[playerId] = true;

                  StaticGameManager.increaseCatch(
                    ref: ref,
                    playerId: playerId,
                  );

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: playerId,
                    time: event.responseTime!,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: playerId,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: playerId, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  sender.add(
                    () => StaticGameManager.ledColor(
                      devsMap[playerId]!.id,
                      SidesColorsModel.all(colorsMap[playerId]!),
                      ref: ref,
                      isCommand: true,
                    ),
                  );
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                }
              }

              /// the player has entered the zone,
              /// so we await for them to leave it.
              else {
                if (dis + 1 > wantedDis) {
                  zoneMap[playerId] = false;
                  sender.add(
                    () => StaticGameManager.ledOff(discDevice!.id,
                        ref: ref, isCommand: true),
                  );
                }
              }
            },
            onDone: () {
              ended = true;
              debugPrint("Ended $ended");
            },
          );
          Future.doWhile(
            () async {
              await Future.delayed(
                  Duration(milliseconds: setup.dstConfig!.timeout! + 75));
              lastEvents.forEach((key, value) async {
                if (lastEvents[key] != null) {
                  lastEvents[key] = null;
                } else {
                  if (zoneMap[key] == true) {
                    await StaticGameManager.ledOff(
                        players
                            .toList()
                            .firstWhere((element) => element.id == key)
                            .devs
                            .first
                            .id,
                        ref: ref,
                        isCommand: true);
                    zoneMap[key] = false;
                  }
                }
              });
              return !ended;
            },
          );
          await streamer!.done;
        }

        Future<bool> disposeCb(ref) async {
          streamer?.cancel();
          ended = true;
          return true;
        }

        await game.setup.executeGame(
          ref,
          round,
          disposeCb: disposeCb,
        );
      },
    );
  }

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
                PadManager.toggleVibration(devId, ref: ref, vibrationOn: false);
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
                    myChronometer.start();
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
                    myChronometer.stop();

                    logger.i(
                        "My Chronometer Elapsed: ${myChronometer.elapsed}\nEvent Response Time: ${event.responseTime!}");

                    final diff = (myChronometer.elapsed - event.responseTime!)
                        .inMilliseconds
                        .abs();

                    StaticGameManager.addScorePoint(
                      playerId: playerid.key,
                      time: diff > 1000
                          ? myChronometer.elapsed
                          : event.responseTime!,
                      ref: ref,
                    );
                    logger.i("Send Is Command: 761");
                    myChronometer.reset();
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

  static StaticGameModel dengedeKal(WidgetRef ref) {
    return StaticGameModel(
      id: '39',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '39',
        name: instForGameScreen.game_title_39,
        primaryScoreString:
            instForGameScreen.game_result_primary_score_balance_duration,
        description: instForGameScreen.game_description_39,
        imagePath: '39',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 1,
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
        categories: {
          GameCategory.sports: 6,
          GameCategory.edu: 27,
          GameCategory.entertainment: 11,
          GameCategory.multiplayer: 15,
        },
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

        final setup = game.setup;
        final mainPlayer = players.first;
        final devices = mainPlayer.devs;
        final devs = setup.getGameDevices(ref);
        final mainDevicesIds = devices.map((e) => e.id);
        final radius = game.setup.radius!.def;

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
          streamer = streamer.listen(
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
                    StaticGameManager.sendIsCommand(
                      devId,
                      ref: ref,
                    );
                  }
                }
              }

              // Once it leans, we wanna add that response time

              else {
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

  static StaticGameModel squat(WidgetRef ref) {
    return StaticGameModel(
      id: '40',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '40',
        name: instForGameScreen.game_title_40,
        primaryScoreString: instForGameScreen.game_result_primary_score_squat,
        description: instForGameScreen.game_description_40,
        imagePath: '40',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 30,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        distance: NumRange.distanceCm(
          def: 50,
          min: 5,
          max: 60,
        ),
        tag: GameTag.strength,
        earnings: [
          GameEarning.strength,
          GameEarning.resistance,
          GameEarning.speed,
        ],
        categories: {
          GameCategory.sports: 8,
          GameCategory.multiplayer: 18,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        sensorTypes: {
          UsedSensorsType.distance: false,
        },
        doesHaveSound: false,
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final setup = ref.read(currentGameSetupProv)!;
        final devs = setup.getGameDevices(ref);
        final wantedDis = setup.distance!.def!;
        for (var dev in devs) {
          await StaticGameManager.sendIsCommand(dev.id, ref: ref);
        }

        final sender = SendStreamer();
        Streamer<DistanceEvent>? streamer;
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: player.devs.first
        };

        Map<String, bool> zoneMap = {
          for (final player in players) player.id: false,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        Map<String, DistanceEvent?> lastEvents = {
          for (final player in players) player.id: null,
        };
        bool ended = false;
        Future<void> round(WidgetRef ref) async {
          /// 1- await until the user gets into the our range
          /// which is game.distanceConfig.distance
          /// 2- led the player's color
          /// 3- await until the player gets out of the range

          var st = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
          streamer = Streamer(st).listen(
            onData: (event) async {
              final discDevice = devsMap.values
                  .firstWhere((element) => element!.id == event.deviceId);
              final playerId = devsMap.entries
                  .firstWhere((element) => element.value!.id == discDevice!.id)
                  .key;
              lastEvents[playerId] = event;
              final dis = event.distance.distance;
              if (!zoneMap[playerId]!) {
                /// await until the user gets into the our range
                /// which is game.distanceConfig.distance
                if (dis + 1 <= wantedDis) {
                  zoneMap[playerId] = true;

                  StaticGameManager.increaseCatch(
                    ref: ref,
                    playerId: playerId,
                  );

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: playerId,
                    time: event.responseTime!,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: playerId,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: playerId, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));

                  sender.add(
                    () => StaticGameManager.ledColor(
                      devsMap[playerId]!.id,
                      SidesColorsModel.all(colorsMap[playerId]!),
                      ref: ref,
                      isCommand: true,
                    ),
                  );
                }
              }

              /// the player has entered the zone,
              /// so we await for them to leave it.
              else {
                if (dis + 1 > wantedDis) {
                  zoneMap[playerId] = false;
                  sender.add(
                    () => StaticGameManager.ledOff(discDevice!.id,
                        ref: ref, isCommand: true),
                  );
                }
              }
            },
            onDone: () => ended = true,
          );
          Future.doWhile(
            () async {
              await Future.delayed(
                  Duration(milliseconds: setup.dstConfig!.timeout! + 75));
              lastEvents.forEach((key, value) async {
                if (lastEvents[key] != null) {
                  lastEvents[key] = null;
                } else {
                  if (zoneMap[key] == true) {
                    await StaticGameManager.ledOff(
                        players
                            .toList()
                            .firstWhere((element) => element.id == key)
                            .devs
                            .first
                            .id,
                        ref: ref,
                        isCommand: true);
                    zoneMap[key] = false;
                  }
                }
              });
              return !ended;
            },
          );
          await streamer!.done;
        }

        Future<bool> disposeCb(ref) async {
          streamer?.cancel();
          ended = true;
          return true;
        }

        await game.setup.executeGame(
          ref,
          round,
          disposeCb: disposeCb,
        );
      },
    );
  }

  static StaticGameModel russianTwist(WidgetRef ref) {
    return StaticGameModel(
      id: '66',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '66',
        name: instForGameScreen.game_title_66,
        primaryScoreString: instForGameScreen.game_result_primary_score_twist,
        description: instForGameScreen.game_description_66,
        imagePath: '66',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 6,
        ),
        gamePadCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 2,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        tag: GameTag.strength,
        earnings: [
          GameEarning.strength,
          GameEarning.resistance,
          GameEarning.speed,
        ],
        categories: {
          GameCategory.sports: 24,
          GameCategory.multiplayer: 19,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        Map<String, List<DiscoveredDevice>> devMap = {
          for (var player in players) player.id: player.devs
        };
        Map<String, Map<String, bool>> clickMap = {
          for (var player in players)
            player.id: {for (var dev in player.devs) dev.id: false}
        };
        Map<String, Color> colorMap = {
          for (var player in players) player.id: player.clrs.first
        };
        Map<String, int> tapMap = {for (var player in players) player.id: 0};

        resetPlayersMap(String playerid) {
          var value = clickMap[playerid];
          value!.updateAll((key, value) => value = true);
          clickMap[playerid] = value;
        }

        playerId(String devid) {
          return players
              .firstWhere((element) =>
                  element.devs.any((element) => element.id == devid))
              .id;
        }

        otherDevId(String playerid, String devid) {
          return devMap[playerid]!.firstWhere((dev) => dev.id != devid).id;
        }

        final strm = StaticGameManager.listenToTouchMulti(
            devMap.values.expand((element) => element.map((e) => e.id)),
            ref: ref);
        final streamer = Streamer(strm);
        devMap.forEach((pid, pdevs) {
          clickMap[pid]![pdevs.first.id] = true;
          StaticGameManager.ledColor(
              pdevs.first.id, SidesColorsModel.all(colorMap[pid]!),
              ref: ref);
        });

        Future<void> round(WidgetRef ref) async {
          streamer.listen(
            onData: (tap) async {
              if (!tap.isValid) {
                assert(false);
              }
              final devid = tap.deviceId;
              final playerid = playerId(devid);
              if (clickMap[playerid]![devid] == true) {
                if (tapMap[playerid]! > 0) {
                  StaticGameManager.increaseScore(ref: ref, playerId: playerid);
                  StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: playerid,
                      time: tap.tap.responseTime!);
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: playerid,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: playerid, ref: ref)
                              .toDouble(),
                          tap.responseTime!.durationToDoubleForGraph()));
                }
                tapMap[playerid] = tapMap[playerid]! + 1;
                StaticGameManager.ledOff(devid, ref: ref);
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(tap.deviceId, ref,
                      val: BeepModel.beep3);
                }
                resetPlayersMap(playerid);
                clickMap[playerid]![devid] = false;
                String otherDevid = otherDevId(playerid, devid);
                StaticGameManager.ledColor(
                    otherDevid, SidesColorsModel.all(colorMap[playerid]!),
                    ref: ref, isCommand: true);
              }
            },
          );

          await streamer.done;
        }

        Future<bool> disposeExecutor(WidgetRef ref) async {
          streamer.cancel();
          return true;
        }

        await game.setup.executeGame(ref, round, disposeCb: disposeExecutor);
      },
    );
  }

  static StaticGameModel harfleriGor(WidgetRef ref) {
    return StaticGameModel(
      id: '42',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '42',
        name: instForGameScreen.game_title_42,
        description: instForGameScreen.game_description_42,
        imagePath: '42',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 15,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
            gameErrorColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        final audioPlayer = ref.watch(cpAudioPlayerProv);
        const clr = gameSuccessColor;

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }
        bool end = false;
        Future<void> round(WidgetRef ref) async {
          late final MapEntry<String, DiscoveredDevice> entry;
          try {
            entry = devMap.first;
          } catch (e) {
            end = true;
          }

          final correctDev = entry.value;

          final gameScreenWidget = HarfleriGorWidget(dev: correctDev);

          ref.read(gameScreenWidgetProv.notifier).state = gameScreenWidget;

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          final ids = [];
          final incorrectDevs = <DiscoveredDevice>[];
          for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          }

          StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevs.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final correctStreamer = Streamer(correctListener);

          final incorrectStreamer = Streamer(otherDevicesListener);

          incorrectStreamer.listen(
            onData: (e) async {
              final devId = e.deviceId;
              /*  final dev = incorrectDevs.firstWhere(
                  (dev) => dev.id == devId,
                ); */
/*
                CustomDevDebugOperations.playAudio(
                  devId,
                  ref,
                  val: StickerManager.idToStickerLetterAudioNamePad(
                    val: dev.deviceNameId!,
                  )!,
                ); */
              audioPlayer.playBuzz();

              StaticGameManager.ledColorForSightDuration(
                correctDev.id,
                SidesColorsModel.all(clr),
                ref: ref,
                isCommand: true,
              );
              StaticGameManager.ledColorForSightDuration(
                devId,
                SidesColorsModel.all(gameErrorColor),
                ref: ref,
                isCommand: true,
              );

              StaticGameManager.decreaseScore(
                ref: ref,
                playerId: mainPlayer.id,
              );

              devMap.insert(devMap.length, entry);
              correctStreamer.cancel();
              incorrectStreamer.cancel();
            },
          );

          correctStreamer.listen(
            onData: (event) async {
              logger.d(event.toString());
              if (event.isValid && event.responseTime != null) {
                /* CustomDevDebugOperations.playAudio(
                    correctDev.id,
                    ref,
                    val: StickerManager.idToStickerLetterAudioNamePad(
                      val: correctDev.deviceNameId!,
                    )!,
                  ); */
                audioPlayer.playSuccess();
                StaticGameManager.ledColorForSightDuration(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );
                incorrectStreamer.cancel();
                correctStreamer.cancel();
              }
            },
          );

          await correctStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          await incorrectStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          try {
            devMap.remove(entry);
          } catch (e) {
            end = true;
          }
        }

        await Future.delayed(Duration(milliseconds: Platform.isIOS ? 50 : 0));

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider) || end;
          },
        );
      },
    );
  }

  static StaticGameModel sayilariGor(WidgetRef ref) {
    return StaticGameModel(
      id: '46',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '46',
        name: instForGameScreen.game_title_46,
        description: instForGameScreen.game_description_46,
        imagePath: '46',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 8,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
            gameErrorColor,
          ],
        ),
        controlsSetup: const GameControlsSetup(
          gameAudioControls: GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        const clr = gameSuccessColor;

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        bool end = false;

        Future<void> round(WidgetRef ref) async {
          late final MapEntry<String, DiscoveredDevice> entry;
          try {
            entry = devMap.first;
          } catch (e) {
            end = true;
          }

          final correctDev = entry.value;

          final gameScreenWidget = SayilariGorWidget(dev: correctDev);

          ref.read(gameScreenWidgetProv.notifier).state = gameScreenWidget;

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          final ids = [];
          final incorrectDevs = <DiscoveredDevice>[];
          for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          }

          StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevs.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final correctStreamer = Streamer(correctListener);

          final incorrectStreamer = Streamer(otherDevicesListener);

          final inCorrectStreamerCheck =
              incorrectStreamer.listen(onData: (e) async {
            final devId = e.deviceId;
            audioPlayer.playBuzz();

            /* CustomDevDebugOperations.playAudio(
                  devId,
                  ref,
                  val: StickerManager.idToStickerAudioName(
                    val: correctDev.deviceNameId!,
                  )!,
                ); */

            StaticGameManager.ledColorForSightDuration(
              correctDev.id,
              SidesColorsModel.all(clr),
              ref: ref,
              isCommand: true,
            );
            StaticGameManager.ledColorForSightDuration(
              devId,
              SidesColorsModel.all(gameErrorColor),
              ref: ref,
              isCommand: true,
            );

            StaticGameManager.decreaseScore(
              ref: ref,
              playerId: mainPlayer.id,
            );

            devMap.insert(devMap.length, entry);
            correctStreamer.cancel();
            incorrectStreamer.cancel();
          });

          correctStreamer.listen(
            onData: (event) async {
              if (event.isValid && event.responseTime != null) {
                audioPlayer.playSuccess();

                CustomDevDebugOperations.playAudio(
                  correctDev.id,
                  ref,
                  val: "AUDIO${StickerManager.idToStickerAudioNameWithoutText2(
                    val: correctDev.deviceNameId!,
                  )!.toLowerCase()}.mp3",
                );

                logger
                    .i("AUDIO${StickerManager.idToStickerAudioNameWithoutText2(
                  val: correctDev.deviceNameId!,
                )!.toLowerCase()}.mp3");

                /*;
                CustomDevDebugOperations.playAudio(
                  correctDev.id,
                  ref,
                  val: "${StickerManager.idToStickerAudioNameWithoutText(
                    val: correctDev.deviceNameId!,
                  )!.toLowerCase()}.mp3",
                );

                CustomDevDebugOperations.playAudio(
                  correctDev.id,
                  ref,
                  val: "${StickerManager.idToStickerAudioNameWithoutText2(
                    val: correctDev.deviceNameId!,
                  )!.toLowerCase()}.mp3",
                );*/

                StaticGameManager.ledColorForSightDuration(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                incorrectStreamer.cancel();

                correctStreamer.cancel();
              }
            },
          );

          await correctStreamer.doneOr(() async {
            final correctListenerIsDone = ref.watch(gameEndingProvider) || end;
            return correctListenerIsDone;
          });

          await incorrectStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          try {
            devMap.remove(entry);
          } catch (e) {
            end = true;
          }

          logger.w("Sayilari Gör Round end");
          await Future.delayed(Duration(milliseconds: Platform.isIOS ? 50 : 0));
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider) || end;
          },
        );
      },
    );
  }

  static StaticGameModel safari(WidgetRef ref) {
    return StaticGameModel(
      id: '43',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '43',
        name: instForGameScreen.game_title_43,
        description: instForGameScreen.game_description_43,
        imagePath: '43',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 12,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);

        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;

        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        const clr = gameSuccessColor;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }
        bool end = false;
        bool goOn = true;
        bool cycleStopPlayAudio = true;

        Future<void> round(WidgetRef ref) async {
          goOn = true;
          late final MapEntry<String, DiscoveredDevice> entry;
          try {
            entry = devMap.first;
          } catch (e) {
            end = true;
          }

          final correctDev = entry.value;

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          final ids = [];
          final incorrectDevs = <DiscoveredDevice>[];

          for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          }

          StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          final audio = AudioFiles.animalAudio(
            StickerManager.idToStickerAnimalAudioNameApp(
                val: correctDev.deviceNameId!, ref: ref)!,
          );
          logger.i("TRIGGER AUDIO!");
          if (cycleStopPlayAudio) {
            audioPlayer.play(audio);
          }

          cycleStopPlayAudio = !cycleStopPlayAudio;

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevs.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final correctStreamer = Streamer(correctListener);

          final incorrectStreamer = Streamer(otherDevicesListener);

          incorrectStreamer.listen(
            onData: (e) async {
              if (goOn) {
                goOn = false;
                StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                  isCommand: true,
                );

                audioPlayer.playBuzz();
                await Future.delayed(const Duration(seconds: 1));
                StaticGameManager.ledOff(
                  correctDev.id,
                  ref: ref,
                );
                StaticGameManager.decreaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );

                devMap.insert(devMap.length, entry);
                correctStreamer.cancel();
                incorrectStreamer.cancel();
              }
            },
          );

          correctStreamer.listen(
            onData: (event) async {
              logger.d(event.toString());
              if (event.isValid && event.responseTime != null && goOn) {
                goOn = false;

                StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );

                PadManager.playMusic(correctDev.id, ref: ref);

                audioPlayer.playSuccess();
                await Future.delayed(const Duration(seconds: 1));
                StaticGameManager.ledOff(correctDev.id, ref: ref);

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );
                incorrectStreamer.cancel();
                correctStreamer.cancel();
              }
            },
          );

          logger.w("Future.any _ Start");
          await Future.delayed(const Duration(milliseconds: 300));
          await Future.any([
            correctStreamer
                .doneOr(() async => ref.watch(gameEndingProvider) || end),
            incorrectStreamer
                .doneOr(() async => ref.watch(gameEndingProvider) || end)
          ]);
          incorrectStreamer.cancel();
          correctStreamer.cancel();
          logger.w(
              "Future.any _ End\n${incorrectStreamer.queueIsEmpty} \n${correctStreamer.queueIsEmpty}");

          try {
            devMap.remove(entry);
          } catch (e) {
            end = true;
          }
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider) || end;
          },
        );
      },
    );
  }

  static StaticGameModel harfleriBul(WidgetRef ref) {
    return StaticGameModel(
      id: '41',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '41',
        name: instForGameScreen.game_title_41,
        description: instForGameScreen.game_description_41,
        imagePath: '41',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.edu: 16,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: const StagedPlayerModel(),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameStickerMatchSelectionSetup: GameStickerMatchSelectionSetup.init(),
          gameAudioControls: const GameAudioSelectionSetup(
            gameAudioSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
            soundEffectsSetup: GameAudioSelectionSetupItem(
              isEnabled: true,
              isChangable: false,
            ),
          ),
        ),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
      ),
      execute: (ref, game) async {
        final players = ref.watch(selectedPlayersPlayersProv);
        final mainPlayer = players.first;

        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        final devs = DeviceShuffler.shuffleDevicesUniquely(generalPlayer.devs);

        const clr = gameSuccessColor;

        final audioPlayer = ref.watch(cpAudioPlayerProv);

        final devMap = <MapEntry<String, DeviceModel>>[];

        for (final dev in devs) {
          final val = MapEntry(dev.deviceNameId!, dev);
          devMap.add(val);
        }
        bool end = false;
        Future<void> round(WidgetRef ref) async {
          late final MapEntry<String, DiscoveredDevice> entry;
          try {
            entry = devMap.first;
          } catch (e) {
            end = true;
          }
          final correctDev = entry.value;

          final inc = devMap
              .where((e) => e.key != correctDev.deviceNameId!)
              .map((e) => e.value)
              .toList();

          final ids = [];
          final incorrectDevs = <DiscoveredDevice>[];
          for (var dev in inc) {
            // we wanna remove the matching devices
            if (!ids.contains(dev.id)) {
              ids.add(dev.id);
              incorrectDevs.add(dev);
            }
          }

          StaticGameManager.sendIsCommand(
            correctDev.id,
            ref: ref,
          );

          final audio = AudioFiles.letterAudio(
            StickerManager.idToStickerLetterAudioNameApp(
              ref: ref,
              val: correctDev.deviceNameId!,
            )!,
          );

          audioPlayer.play(audio);

          final otherDevicesListener = StaticGameManager.listenToTouchMulti(
            incorrectDevs.map((e) => e.id),
            ref: ref,
          );

          final correctListener = StaticGameManager.listenToTouch(
            correctDev.id,
            ref: ref,
          );

          final correctStreamer = Streamer(correctListener);

          final incorrectStreamer = Streamer(otherDevicesListener);

          incorrectStreamer.listen(
            onData: (e) async {
              StaticGameManager.ledColor(
                correctDev.id,
                SidesColorsModel.all(clr),
                ref: ref,
                isCommand: true,
              );

              audioPlayer.playBuzz();
              await Future.delayed(const Duration(seconds: 1));
              StaticGameManager.ledOff(
                correctDev.id,
                ref: ref,
              );
              StaticGameManager.decreaseScore(
                ref: ref,
                playerId: mainPlayer.id,
              );

              devMap.insert(devMap.length, entry);
              correctStreamer.cancel();
              incorrectStreamer.cancel();
            },
          );

          correctStreamer.listen(
            onData: (event) async {
              logger.d(event.toString());
              if (event.isValid && event.responseTime != null) {
                StaticGameManager.ledColor(
                  correctDev.id,
                  SidesColorsModel.all(clr),
                  ref: ref,
                );
                audioPlayer.playSuccess();
                await Future.delayed(const Duration(seconds: 1));
                StaticGameManager.ledOff(correctDev.id, ref: ref);

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );

                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: mainPlayer.id,
                );
                incorrectStreamer.cancel();
                correctStreamer.cancel();
              }
            },
          );
          await correctStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          await incorrectStreamer
              .doneOr(() async => ref.watch(gameEndingProvider) || end);
          try {
            devMap.remove(entry);
          } catch (e) {
            end = true;
          }
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return devMap.isEmpty || ref.watch(gameEndingProvider) || end;
          },
        );
      },
    );
  }

  static StaticGameModel hamstringAndSpagat(WidgetRef ref,
      {required String id,
      required String name,
      required List<int> orderNumbers,
      required String description,
      bool onleaderboard = false}) {
    return StaticGameModel(
        id: id,
        onLeaderboard: onleaderboard,
        metaData: GameMetaDataModel(
          id: id,
          name: name,
          primaryScoreString:
              instForGameScreen.game_result_primary_score_distance,
          description: description,
          imagePath: id,
          earnings: [GameEarning.condition],
          tag: GameTag.condition,
          categories: {
            GameCategory.sports: orderNumbers.first,
            GameCategory.multiplayer: orderNumbers.last,
          },
          playerCount: NumRange.playerCount(
            min: 1,
            max: 12,
          ),
          padCount: NumRange.padCount(
            min: 1,
            max: 12,
          ),
        ),
        setup: StaticGameSetupModel(
            generalStagedPlayerModel: StagedPlayerModel.general(
              unavailableColors: [
                gameSuccessColor,
                gameErrorColor,
              ],
            ),
            stagedPlayerModel: const StagedPlayerModel(
              hasDevices: true,
              //colorCount: NumRange.count(min: 1, max: 1)
            ),
            type: GameEndType.duration,
            scoreTypeParam1: GameScoreType.minDistance,
            scoreTypeParam2: GameScoreType.none,
            sensorTypes: {
              UsedSensorsType.distance: false,
            },
            dstConfig: const DstConfigModel(threshold: 1500, timeout: 15)),
        execute: (ref, game) async {
          final players = ref.read(selectedPlayersPlayersProv);
          final devs = game.setup.getGameDevices(ref);
          final Map<String, List<DistanceModel>> distanceMap = {
            for (var player in players) player.id: []
          };
          final Map<String, String> devIdMap = {
            for (var player in players) player.id: player.devs.first.id
          };

          final strm = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
          for (var dev in devs) {
            StaticGameManager.ledColor(
              dev.id,
              SidesColorsModel.all(gameErrorColor),
              ref: ref,
            );
          }

          Streamer<DistanceEvent> streamer = Streamer(strm);
          playerId(String devid) {
            return players
                .firstWhere((element) =>
                    element.devs.any((element) => element.id == devid))
                .id;
          }

          bool finishGame = false;
          Future<void> oneRoundedGame(ref) async {
            Future.delayed(const Duration(seconds: 5)).then((value) {
              distanceMap.forEach((key, value) async {
                var tempDist = value;
                if (tempDist.isEmpty) {
                  StaticGameManager.addDistance(
                      ref: ref,
                      playerId: key,
                      distance: const DistanceModel(
                          commandTime: 0,
                          actionTime: 0,
                          distance: 0,
                          rangeStatus: 0,
                          limitCheckCurrent: 0));
                } else {
                  tempDist.sort((a, b) => a.distance.compareTo(b.distance));
                  StaticGameManager.addDistance(
                      ref: ref, playerId: key, distance: tempDist.first);
                }
                StaticGameManager.ledColor(
                  devIdMap[key]!,
                  SidesColorsModel.all(gameSuccessColor),
                  ref: ref,
                );
                if (distanceMap.keys.toList().indexOf(key) ==
                    distanceMap.keys.length - 1) {
                  await Future.delayed(const Duration(milliseconds: 300));
                  finishGame = true;
                }
              });
            });
            streamer = Streamer(strm).listen(
              onData: (event) async {
                final devid = event.deviceId;
                final playerid = playerId(devid);
                distanceMap[playerid]!.add(event.distance);
              },
            );

            await streamer.doneOr(() async => finishGame);
          }

          await game.setup.executeGame(
            ref,
            oneRoundedGame,
          );
        });
  }

  static StaticGameModel odak(WidgetRef ref) {
    return StaticGameModel(
        id: '54',
        onLeaderboard: false,
        metaData: GameMetaDataModel(
            id: '54',
            name: instForGameScreen.game_title_54,
            description: instForGameScreen.game_description_54,
            imagePath: '54',
            earnings: [
              GameEarning.resistance,
              GameEarning.reflex,
              GameEarning.speed
            ],
            tag: GameTag.focus,
            categories: {
              GameCategory.sports: 25,
              GameCategory.entertainment: 18,
            },
            playerCount: NumRange.playerCount(min: 1, max: 1),
            padCount: NumRange.padCount(min: 3, max: 12)),
        setup: StaticGameSetupModel(
            stagedPlayerModel:
                StagedPlayerModel(colorCount: NumRange.count(min: 1, max: 1)),
            generalStagedPlayerModel: StagedPlayerModel.general(
              hasDevices: true,
            ),
            duration: NumRange.duration(def: 20, min: 20, max: 60),
            type: GameEndType.duration,
            scoreTypeParam1: GameScoreType.averageDuration,
            scoreTypeParam2: GameScoreType.score,
            scoreTypeParam3: GameScoreType.minDuration,
            scoreTypeParam4: GameScoreType.maxDuration,
            isScore: true,
            sensorTypes: {
              UsedSensorsType.tap: false,
            }),
        execute: (ref, game) async {
          final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;

          final players = ref.read(selectedPlayersPlayersProv);
          final mainPlayer = players.elementAt(0);

          final colors = mainPlayer.clrs;
          final mainColor = colors[0];

          List<DeviceModel> devs = List.from(generalPlayer.devs);
          bool ended = false;
          //Duration? correctRespTime;
          //Duration? incorrectRespTime;
          Future<void> round(WidgetRef ref) async {
            devs = DeviceShuffler.shuffleDevicesUniquely(devs);
            final dev = devs[0];
            final otherDevs = devs.sublist(1);
            final ftrs = [];
            ftrs.add(() => StaticGameManager.ledColor(
                  dev.id,
                  SidesColorsModel.all(mainColor),
                  ref: ref,
                  isCommand: true,
                ));

            List<Color> availableRandomColors = defaultConstColors(ref);
            availableRandomColors.remove(mainColor);
            for (var incDev in otherDevs) {
              Color randomizedColor = availableRandomColors[
                  Random().nextInt(availableRandomColors.length - 1)];
              ftrs.add(() => StaticGameManager.ledColor(
                    incDev.id,
                    SidesColorsModel.all(randomizedColor),
                    ref: ref,
                    isCommand: true,
                  ));
            }
            await Future.wait(ftrs.map((e) => e()));

            bool caughtCorrect = false,
                caughtIncorrect = false,
                isProcessing = false;
            ended = false;
            final listener =
                StaticGameManager.listenToTouch(dev.id, ref: ref).listen(
              (event) {
                caughtCorrect = true;
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                //correctRespTime = event.responseTime;
                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: mainPlayer.id,
                  time: event.responseTime!,
                );
              },
            );
            final otherListener = StaticGameManager.listenToTouchMulti(
                    otherDevs.map((e) => e.id),
                    ref: ref)
                .listen(
              (event) {
                caughtIncorrect = true;
                //incorrectRespTime = event.responseTime;
              },
            );

            const singleTick = 2;
            var totalDuration = Random().nextInt(1000) + 1500;

            Timer.periodic(
              const Duration(milliseconds: singleTick),
              (timer) async {
                if (isProcessing) {
                  return;
                }

                final passed = timer.tick * singleTick;

                if (passed >= totalDuration ||
                    caughtCorrect ||
                    caughtIncorrect) {
                  isProcessing = true;
                  totalDuration = Random().nextInt(1000) + 1500;

                  if (caughtCorrect) {
                    StaticGameManager.increaseScore(
                      ref: ref,
                      playerId: mainPlayer.id,
                    );
                    StaticGameManager.ledColor(
                      dev.id,
                      SidesColorsModel.all(gameSuccessColor),
                      ref: ref,
                    );
                    /* if (correctRespTime != null) {
                      StaticGameManager.addFlSpot(
                          ref: ref,
                          playerId: mainPlayer.id,
                          spot: FlSpot(
                              StaticGameManager.getScore(
                                      playerId: mainPlayer.id, ref: ref)
                                  .toDouble(),
                              correctRespTime!.durationToDoubleForGraph()));
                    }*/
                  } else {
                    StaticGameManager.decreaseScore(
                      ref: ref,
                      playerId: mainPlayer.id,
                    );
                    /*if (incorrectRespTime != null) {
                      StaticGameManager.addFlSpot(
                          ref: ref,
                          playerId: mainPlayer.id,
                          spot: FlSpot(
                              StaticGameManager.getScore(
                                      playerId: mainPlayer.id, ref: ref)
                                  .toDouble(),
                              incorrectRespTime!.durationToDoubleForGraph()));
                    }*/
                  }

                  await StaticGameManager.ledOff(
                    dev.id,
                    ref: ref,
                  );

                  ended = true;
                  listener.cancel();
                  otherListener.cancel();
                }
              },
            );

            await Future.doWhile(
              () async {
                await Future.delayed(Duration.zero);

                return !ended;
              },
            );
          }

          await game.setup.executeGame(
            ref,
            round,
            disposeCb: (ref) async {
              ended = true;
              return true;
            },
          );
        });
  }

  static StaticGameModel testOdak(WidgetRef ref) {
    return StaticGameModel(
        id: '54',
        onLeaderboard: false,
        metaData: GameMetaDataModel(
          id: '54',
          name: instForGameScreen.game_title_54,
          description: instForGameScreen.game_description_54,
          imagePath: '54',
          earnings: [
            GameEarning.resistance,
            GameEarning.reflex,
            GameEarning.speed
          ],
          tag: GameTag.focus,
          categories: {
            GameCategory.sports: 25,
            GameCategory.entertainment: 18,
          },
          playerCount: NumRange.playerCount(min: 1, max: 1),
          padCount: NumRange.padCount(min: 3, max: 12),
          gamePadCount: NumRange.padCount(min: 3, max: 12),
        ),
        setup: StaticGameSetupModel(
            stagedPlayerModel:
                StagedPlayerModel(colorCount: NumRange.count(min: 1, max: 1)),
            generalStagedPlayerModel: StagedPlayerModel.general(
              hasDevices: true,
            ),
            duration: NumRange.duration(def: 20, min: 20, max: 60),
            type: GameEndType.duration,
            scoreTypeParam1: GameScoreType.averageDuration,
            scoreTypeParam2: GameScoreType.score,
            scoreTypeParam3: GameScoreType.minDuration,
            scoreTypeParam4: GameScoreType.maxDuration,
            isScore: true,
            accConfig: const AccConfigModel(
              scale: ConfigScale.LIS2DH12_16g,
              mode: ConfigMode.LIS2DH12_HR_12bit,
              threshold: 60,
              timeout: 200,
            ),
            dstConfig: const DstConfigModel(threshold: 1000, timeout: 100),
            sensorTypes: {
              UsedSensorsType.tap: false,
            }),
        execute: (ref, game) async {
          final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;

          final players = ref.read(selectedPlayersPlayersProv);
          final mainPlayer = players.elementAt(0);

          final colors = mainPlayer.clrs;
          final mainColor = colors[0];

          List<DeviceModel> devs = List.from(generalPlayer.devs);

          bool ended = false;
          bool turnCount = false;
          //Duration? correctRespTime;
          //Duration? incorrectRespTime;

          Future<void> round(WidgetRef ref) async {
            devs = DeviceShuffler.shuffleDevicesUniquely(devs);

            final dev = devs[0];
            final otherDevs = devs.sublist(1);
            final ftrs = [];

            ftrs.add(() => StaticGameManager.ledColor(
                  dev.id,
                  SidesColorsModel.all(mainColor),
                  ref: ref,
                  isCommand: true,
                ));

            List<Color> availableRandomColors = defaultConstColors(ref);

            availableRandomColors.remove(mainColor);

            for (var incDev in otherDevs) {
              Color randomizedColor = availableRandomColors[
                  Random().nextInt(availableRandomColors.length - 1)];

              ftrs.add(() => StaticGameManager.ledColor(
                    incDev.id,
                    SidesColorsModel.all(randomizedColor),
                    ref: ref,
                    isCommand: true,
                  ));
            }

            await Future.wait(ftrs.map((e) => e()));

            bool caughtCorrect = false,
                caughtIncorrect = false,
                isProcessing = false;

            ended = false;

            const singleTick = 2;
            var totalDuration = Random().nextInt(1000) + 1500;

            //final listener = StaticGameManager.listenToTouch(dev.id, ref: ref);

            final otherListener = Streamer(StaticGameManager.listenToTouchMulti(
                devs.map((e) => e.id),
                ref: ref));
            bool isListening = false;

            Timer timer = Timer.periodic(
              const Duration(milliseconds: singleTick),
              (timer) async {
                final passed = timer.tick * singleTick;

                if (isProcessing) {
                  return;
                } else {
                  if (passed >= totalDuration) {
                    isProcessing = true;
                    ended = true;

                    StaticGameManager.decreaseScore(
                      ref: ref,
                      playerId: mainPlayer.id,
                    );

                    return;
                  }

                  if (!isListening) {
                    isListening = true;

                    otherListener.listen(
                      onData: (event) async {
                        isListening = false;
                        ended = true;

                        debugPrint("Event!!!");

                        if (!isProcessing &&
                            event.isValid &&
                            event.deviceId == dev.id) {
                          if (ref.read(buzzerManagerProvider)) {
                            isProcessing = true;
                            CustomDevDebugOperations.playAudio(
                                event.deviceId, ref,
                                val: BeepModel.beep3);
                          }

                          StaticGameManager.increaseScore(
                            ref: ref,
                            playerId: mainPlayer.id,
                          );

                          StaticGameManager.ledColor(
                            dev.id,
                            SidesColorsModel.all(gameSuccessColor),
                            ref: ref,
                          );

                          StaticGameManager.addScorePoint(
                            ref: ref,
                            playerId: mainPlayer.id,
                            time: event.responseTime!,
                          );

                          return;
                        } else if (!isProcessing && event.isValid) {
                          isProcessing = true;
                          StaticGameManager.decreaseScore(
                            ref: ref,
                            playerId: mainPlayer.id,
                          );
                          ended = true;

                          return;
                          //incorrectRespTime = event.responseTime;
                        }
                      },
                    );
                  }
                }
              },
            );
            final passed = timer.tick * singleTick;
            await Future.delayed(
                Duration(
                    milliseconds: totalDuration - passed > 0
                        ? totalDuration - passed
                        : 0),
                () => logger.w('Turn end!'));
            /* const singleTick = 2;
            var totalDuration = Random().nextInt(1000) + 1500;

            timer = Timer.periodic(
              const Duration(milliseconds: singleTick),
              (timer) async {
                if (isProcessing) {
                  return;
                }

                final passed = timer.tick * singleTick;

                if (passed >=
                        totalDuration || //TODO look random time management for games like odak and kolaysa yakala
                    caughtCorrect ||
                    caughtIncorrect) {
                  isProcessing = true;
                  totalDuration = Random().nextInt(1000) + 1500;

                  if (caughtCorrect) {
                    StaticGameManager.increaseCatch(
                      ref: ref,
                      playerId: mainPlayer.id,
                    );
                  } else {
                    StaticGameManager.decreaseCatch(
                      ref: ref,
                      playerId: mainPlayer.id,
                    );
                  }

                  await StaticGameManager.ledOff(
                    dev.id,
                    ref: ref,
                  );

                  ended = true;
                  listener.cancel();
                  otherListener.cancel();
                }
              },
            ); */

            await Future.doWhile(
              () async {
                await Future.delayed(Duration.zero);
                return !ended;
              },
            );
          }

          await game.setup.executeGame(
            ref,
            round,
            disposeCb: (ref) async {
              ended = true;

              return true;
            },
          );
        });
  }

  static StaticGameModel yuzMetre(WidgetRef ref) {
    return StaticGameModel(
        id: '57',
        onLeaderboard: false,
        metaData: GameMetaDataModel(
            id: '57',
            name: instForGameScreen.game_title_57,
            description: instForGameScreen.game_description_57,
            imagePath: '57',
            earnings: [
              GameEarning.resistance,
            ],
            tag: GameTag.agility,
            categories: {
              GameCategory.sports: 23,
              GameCategory.multiplayer: 14,
            },
            playerCount: NumRange.playerCount(
              min: 1,
              max: 8,
            ),
            padCount: NumRange.padCount(min: 2, max: 2)),
        setup: StaticGameSetupModel(
          stagedPlayerModel: StagedPlayerModel(
              colorCount: NumRange.count(min: 1, max: 1),
              hasDevices: true,
              defaultSelectedColors: [gameErrorColor]),
          roundCount: 10,
          type: GameEndType.duration,
          scoreTypeParam1: GameScoreType.totalDuration,
          scoreTypeParam2: GameScoreType.none,
          sensorTypes: {
            UsedSensorsType.tap: false,
          },
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 40,
            timeout: 1000,
          ),
        ),
        execute: (ref, game) async {
          final players = ref.read(selectedPlayersPlayersProv);
          Map<String, List<DiscoveredDevice>> devMap = {
            for (var player in players) player.id: player.devs
          };
          Map<String, Map<String, bool>> clickMap = {
            for (var player in players)
              player.id: {for (var dev in player.devs) dev.id: false}
          };
          Map<String, Color> colorMap = {
            for (var player in players) player.id: player.clrs.first
          };
          Map<String, int> tapMap = {for (var player in players) player.id: 0};

          resetPlayersMap(String playerid) {
            var value = clickMap[playerid];
            value!.updateAll((key, value) => value = true);
            clickMap[playerid] = value;
          }

          playerId(String devid) {
            return players
                .firstWhere((element) =>
                    element.devs.any((element) => element.id == devid))
                .id;
          }

          otherDevId(String playerid, String devid) {
            return devMap[playerid]!.firstWhere((dev) => dev.id != devid).id;
          }

          final strm = StaticGameManager.listenToTouchMulti(
              devMap.values.expand((element) => element.map((e) => e.id)),
              ref: ref);
          final streamer = Streamer(strm);
          devMap.forEach((pid, pdevs) {
            clickMap[pid]![pdevs.first.id] = true;
            StaticGameManager.ledColor(
                pdevs.first.id, SidesColorsModel.all(colorMap[pid]!),
                ref: ref);
          });
          bool catchederr = false;
          Future<void> round(WidgetRef ref) async {
            try {
              streamer.listen(
                onData: (tap) async {
                  if (!tap.isValid) {
                    assert(false);
                  }
                  final devid = tap.deviceId;
                  final playerid = playerId(devid);
                  if (clickMap[playerid]![devid] == true &&
                      tapMap[playerid]! < 11) {
                    if (tapMap[playerid]! > 0) {
                      StaticGameManager.addScorePoint(
                          ref: ref,
                          playerId: playerid,
                          time: tap.tap.responseTime!);
                      StaticGameManager.increaseScore(
                          ref: ref, playerId: playerid);
                      StaticGameManager.addFlSpot(
                          ref: ref,
                          playerId: playerid,
                          spot: FlSpot(
                              StaticGameManager.getScore(
                                      playerId: playerid, ref: ref)
                                  .toDouble(),
                              tap.responseTime!.durationToDoubleForGraph()));
                    }
                    tapMap[playerid] = tapMap[playerid]! + 1;
                    StaticGameManager.ledOff(devid, ref: ref);
                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(tap.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    resetPlayersMap(playerid);
                    clickMap[playerid]![devid] = false;
                    String otherDevid = otherDevId(playerid, devid);
                    if (tapMap[playerid]! < 11) {
                      StaticGameManager.ledColor(
                          otherDevid, SidesColorsModel.all(colorMap[playerid]!),
                          ref: ref, isCommand: true);
                    }
                  }
                },
              );
            } catch (e) {
              catchederr = true;
            }

            await streamer.doneOr(() async =>
                tapMap.values.every((element) => element == 11) ||
                catchederr ||
                ref.watch(gameEndingProvider));
          }

          await game.setup.executeGame(ref, round);
        });
  }

  static StaticGameModel yankosuvetekayakformula(WidgetRef ref,
      {required String name,
      required String description,
      required String id,
      required NumRange padCount,
      required GameTag tag,
      required bool onLeaderBoard,
      required List<GameEarning> earnings,
      required int categoriesOrder}) {
    return StaticGameModel(
      id: id,
      onLeaderboard: onLeaderBoard,
      metaData: GameMetaDataModel(
        id: id,
        name: name,
        description: description,
        primaryScoreString: instForGameScreen.score_target,
        imagePath: id,
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: padCount,
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        tag: tag,
        earnings: earnings,
        categories: {
          GameCategory.sports: categoriesOrder,
          //GameCategory.entertainment:12
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        scoreTypeParam2: GameScoreType.catchCount,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;

        Future<void> round(WidgetRef ref) async {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          final dev = devs[0];

          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(mainColor),
            ref: ref,
            isCommand: true,
          );

          await for (final event
              in StaticGameManager.listenToTouch(dev.id, ref: ref)) {
            if (event.isValid) {
              StaticGameManager.addScorePoint(
                ref: ref,
                playerId: mainPlayer.id,
                time: event.responseTime!,
              );
              StaticGameManager.increaseScore(
                ref: ref,
                playerId: mainPlayer.id,
              );
              /* StaticGameManager.addFlSpot(
                  ref: ref,
                  playerId: mainPlayer.id,
                  spot: FlSpot(
                      StaticGameManager.getScore(
                              playerId: mainPlayer.id, ref: ref)
                          .toDouble(),
                      event.responseTime!.durationToDoubleForGraph())); */

              await StaticGameManager.ledOff(dev.id, ref: ref);
            }
            break;
          }
        }

        await game.setup.executeGame(ref, round);
      },
    );
  }

  // static StaticGameModel fabricTest(WidgetRef ref) {
  //   return StaticGameModel(
  //     id: '47',
  //     metaData: GameMetaDataModel(
  //       id: '47',
  //       name: instForGameScreen.game_title_47,
  //       description: instForGameScreen.game_description_47,
  //       imagePath: '47',
  //       playerCount: NumRange.playerCount(
  //         min: 1,
  //         max: 1,
  //       ),
  //       badgeType: GameBadgeTypes.none,
  //       padCount: NumRange.padCount(min: 1, max: 12),
  //       distance: NumRange.distanceCm(def: 30, min: 5, max: 60),
  //       tag: GameTag.speed,
  //       earnings: [
  //         GameEarning.agility,
  //         GameEarning.speed,
  //         GameEarning.strength
  //       ],
  //       categories: {GameCategory.test: 1},
  //     ),
  //     setup: StaticGameSetupModel(
  //       type: GameEndType.duration,
  //       scoreTypeParam1: GameScoreType.totalDuration,
  //       scoreTypeParam2: GameScoreType.averageDuration,
  //       scoreTypeParam3: GameScoreType.minDuration,
  //       scoreTypeParam4: GameScoreType.maxDuration,
  //       autoStart: true,
  //       needChronometer: true,
  //       stagedPlayerModel: StagedPlayerModel(
  //         colorCount: NumRange.count(min: 1, max: 1),
  //       ),
  //       roundCount: 1,
  //       generalStagedPlayerModel: StagedPlayerModel.general(
  //         hasDevices: true,
  //       ),
  //       sensorTypes: {
  //         UsedSensorsType.distance: false,
  //         UsedSensorsType.tap: false,
  //       },
  //       dstConfig: const DstConfigModel(
  //         threshold: 1000,
  //         timeout: 150,
  //       ),
  //     ),
  //     execute: (ref, game) async {
  //       final firstActionDateTimeController =
  //       ref.read(currentFirstActionTimeManager.notifier);
  //
  //       final setup = ref.read(currentGameSetupProv);
  //       final players = ref.read(selectedPlayersPlayersProv);
  //       final mainPlayer = players.elementAt(0);
  //       final colors = mainPlayer.clrs;
  //       final mainColor = colors[0];
  //       final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
  //       var devs = generalPlayer.devs;
  //       Map<String, bool> devMapListen = {for (var dev in devs) dev.id: true};
  //       final ftrs = [];
  //       for (var dev in devs) {
  //         ftrs.add(() => StaticGameManager.ledColor(
  //             dev.id, SidesColorsModel.all(mainColor),
  //             ref: ref, isCommand: true));
  //       }
  //       await Future.wait(ftrs.map((e) => e()));
  //
  //       late Stream st;
  //
  //       final chosenSensor = game.setup.sensorTypes.entries
  //           .elementAt(game.setup.chosedSensorIndex)
  //           .key;
  //
  //       if (chosenSensor == UsedSensorsType.distance) {
  //         st = StaticGameManager.listenToDistanceMulti(
  //           devs.map((e) => e.id),
  //           ref: ref,
  //         );
  //       } else {
  //         st = StaticGameManager.listenToTouchMulti(
  //           devs.map((e) => e.id),
  //           ref: ref,
  //         );
  //       }
  //
  //       final streamer = Streamer(st);
  //
  //       Future<void> round(WidgetRef ref) async {
  //         if (!ref.read(currentFirstActionStateManager)) {
  //           ref
  //               .read(currentFirstActionTimeManager.notifier)
  //               .changState(DateTime.now());
  //         }
  //
  //         streamer.listen(
  //           onData: (event) async {
  //             final devid = event.deviceId;
  //             if (devMapListen[devid]! == true) {
  //               devMapListen[devid] = false;
  //
  //               if (ref.read(buzzerManagerProvider)) {
  //                 CustomDevDebugOperations.playAudio(event.deviceId, ref,
  //                     val: BeepModel.beep3);
  //               }
  //
  //               if (ref.read(currentFirstActionTimeManager) != null) {
  //                 StaticGameManager.increaseScore(
  //                     ref: ref, playerId: mainPlayer.id);
  //                 StaticGameManager.addScorePoint(
  //                     ref: ref,
  //                     playerId: mainPlayer.id,
  //                     time: event.responseTime!);
  //                 //StaticGameManager.addFlSpot(
  //                 //    ref: ref,d
  //                 //    playerId: mainPlayer.id,
  //                 //    spot: FlSpot(
  //                 //        StaticGameManager.getScore(
  //                 //            playerId: mainPlayer.id, ref: ref)
  //                 //            .toDouble(),
  //                 //        event.responseTime!.durationToDoubleForGraph()));
  //                 firstActionDateTimeController
  //                     .addRoundPoint(event.responseTime!);
  //               } else {
  //                 ref
  //                     .read(currentFirstActionTimeManager.notifier)
  //                     .changState(DateTime.now());
  //               }
  //
  //               StaticGameManager.ledOff(devid, ref: ref);
  //               for (var dev in devs) {
  //                 if (devid != dev.id) {
  //                   StaticGameManager.sendIsCommand(dev.id, ref: ref);
  //                 }
  //               }
  //               if (devMapListen.values.every((element) => element == false)) {
  //                 streamer.cancel();
  //                 ref
  //                     .read(currentFirstActionTimeManager.notifier)
  //                     .endStopWatch();
  //               }
  //             }
  //           },
  //         );
  //         await streamer.doneOr(() async =>
  //         devMapListen.values.every((element) => element == false) ||
  //             ref.watch(gameEndingProvider));
  //       }
  //
  //       await game.setup.executeGame(ref, round,
  //           shouldStop: (ref) async =>
  //           devMapListen.values.every((element) => element == false) ||
  //               ref.watch(gameEndingProvider));
  //     },
  //   );
  // }

  static StaticGameModel suratTesti(WidgetRef ref) {
    return StaticGameModel(
      id: '47',
      metaData: GameMetaDataModel(
        id: '47',
        name: instForGameScreen.game_title_47,
        description: instForGameScreen.game_description_47,
        imagePath: '47',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        badgeType: GameBadgeTypes.none,
        padCount: NumRange.padCount(min: 1, max: 12),
        distance: NumRange.distanceCm(def: 30, min: 5, max: 60),
        tag: GameTag.speed,
        earnings: [
          GameEarning.agility,
          GameEarning.speed,
          GameEarning.strength
        ],
        categories: {GameCategory.test: 1},
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.totalDuration,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        autoStart: true,
        needChronometer: true,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.distance: false,
          UsedSensorsType.tap: false,
        },
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final firstActionDateTimeController =
            ref.read(currentFirstActionTimeManager.notifier);

        final setup = ref.read(currentGameSetupProv);
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        Map<String, bool> devMapListen = {for (var dev in devs) dev.id: true};
        final ftrs = [];
        for (var dev in devs) {
          ftrs.add(() => StaticGameManager.ledColor(
              dev.id, SidesColorsModel.all(mainColor),
              ref: ref, isCommand: true));
        }
        await Future.wait(ftrs.map((e) => e()));

        late Stream st;

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        if (chosenSensor == UsedSensorsType.distance) {
          st = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
        } else {
          st = StaticGameManager.listenToTouchMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
        }

        final streamer = Streamer(st);

        Future<void> round(WidgetRef ref) async {
          if (!ref.read(currentFirstActionStateManager)) {
            ref
                .read(currentFirstActionTimeManager.notifier)
                .changState(DateTime.now());
          }

          streamer.listen(
            onData: (event) async {
              final devid = event.deviceId;
              if (devMapListen[devid]! == true) {
                devMapListen[devid] = false;

                if (ref.read(currentFirstActionTimeManager) != null) {
                  StaticGameManager.increaseScore(
                      ref: ref, playerId: mainPlayer.id);
                  StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: mainPlayer.id,
                      time: event.responseTime!);
                  //StaticGameManager.addFlSpot(
                  //    ref: ref,d
                  //    playerId: mainPlayer.id,
                  //    spot: FlSpot(
                  //        StaticGameManager.getScore(
                  //            playerId: mainPlayer.id, ref: ref)
                  //            .toDouble(),
                  //        event.responseTime!.durationToDoubleForGraph()));
                  firstActionDateTimeController
                      .addRoundPoint(event.responseTime!);
                } else {
                  ref
                      .read(currentFirstActionTimeManager.notifier)
                      .changState(DateTime.now());
                }

                StaticGameManager.ledOff(devid, ref: ref);
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                for (var dev in devs) {
                  if (devid != dev.id) {
                    StaticGameManager.sendIsCommand(dev.id, ref: ref);
                  }
                }
                if (devMapListen.values.every((element) => element == false)) {
                  streamer.cancel();
                  ref
                      .read(currentFirstActionTimeManager.notifier)
                      .endStopWatch();
                }
              }
            },
          );
          await streamer.doneOr(() async =>
              devMapListen.values.every((element) => element == false) ||
              ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async =>
                devMapListen.values.every((element) => element == false) ||
                ref.watch(gameEndingProvider));
      },
    );
  }

  static StaticGameModel patlayiciGucTesti(WidgetRef ref) {
    return StaticGameModel(
      id: '48',
      metaData: GameMetaDataModel(
        id: '48',
        name: instForGameScreen.game_title_48,
        description: instForGameScreen.game_description_48,
        imagePath: '48',
        playerCount: NumRange.playerCount(min: 1, max: 1),
        padCount: NumRange.padCount(min: 2, max: 12),
        distance: NumRange.distanceCm(def: 30, min: 5, max: 60),
        tag: GameTag.speed,
        earnings: [
          GameEarning.agility,
          GameEarning.speed,
          GameEarning.strength
        ],
        categories: {GameCategory.test: 4},
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.totalDuration,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        needChronometer: true,
        sensorTypes: {
          UsedSensorsType.distance: false,
          UsedSensorsType.tap: false,
        },
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 50,
        ),
      ),
      execute: (ref, game) async {
        final firstActionDateTimeController =
            ref.read(currentFirstActionTimeManager.notifier);
        final setup = ref.read(currentGameSetupProv);
        final autoStart = setup!.autoStart;
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        Map<String, bool> devMapListen = {for (var dev in devs) dev.id: true};
        final ftrs = [];
        for (var dev in devs) {
          ftrs.add(() => StaticGameManager.ledColor(
              dev.id, SidesColorsModel.all(mainColor),
              ref: ref, isCommand: false));
        }
        await Future.wait(ftrs.map((e) => e()));

        late Stream st;

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        if (chosenSensor == UsedSensorsType.distance) {
          st = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
        } else {
          st = StaticGameManager.listenToTouchMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
        }
        //This pad id will be trigger for the game
        String? startPointPadId;

        bool gameStartCondition = false;
        int lastSeenMillisecondEpoch = 0;
        Timer timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
          if (startPointPadId != null) {
            final dateTime = DateTime.now().millisecondsSinceEpoch;
            final diff = dateTime - lastSeenMillisecondEpoch;
            if (diff > 100) {
              gameStartCondition = true;
              StaticGameManager.ledOff(startPointPadId!, ref: ref);
              timer.cancel();
              ref
                  .read(currentFirstActionTimeManager.notifier)
                  .changState(DateTime.now());

              for (var element in devs) {
                StaticGameManager.sendIsCommand(element.id, ref: ref);
              }
            }
          }
        });
        final streamer = Streamer(st);

        Future<void> round(WidgetRef ref) async {
          streamer.listen(
            onData: (event) async {
              final devId = event.deviceId;

              final distanceEvent = event;

              startPointPadId ??= distanceEvent.deviceId;

              logger.i("Start Point Pad Id: $startPointPadId");

              if (startPointPadId == distanceEvent.deviceId) {
                devMapListen[devId] = false;
                lastSeenMillisecondEpoch =
                    DateTime.now().millisecondsSinceEpoch;

                logger.i("Last Seen: $lastSeenMillisecondEpoch");
              }

              if (gameStartCondition) {
                if (devMapListen[devId]! == true) {
                  devMapListen[devId] = false;

                  if (ref.read(currentFirstActionTimeManager) != null) {
                    StaticGameManager.increaseScore(
                        ref: ref, playerId: mainPlayer.id);

                    StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: mainPlayer.id,
                        time: event.responseTime!);

                    firstActionDateTimeController
                        .addRoundPoint(event.responseTime!);
                  } else {
                    ref
                        .read(currentFirstActionTimeManager.notifier)
                        .changState(DateTime.now());
                  }

                  StaticGameManager.ledOff(devId, ref: ref);

                  for (var dev in devs) {
                    if (devId != dev.id) {
                      StaticGameManager.sendIsCommand(dev.id, ref: ref);
                    }
                  }

                  if (devMapListen.values
                      .every((element) => element == false)) {
                    streamer.cancel();
                    ref
                        .read(currentFirstActionTimeManager.notifier)
                        .endStopWatch();
                  }
                }
              }
            },
          );
          await streamer.doneOr(() async =>
              devMapListen.values.every((element) => element == false) ||
              ref.watch(gameEndingProvider));
          timer.cancel();
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async =>
                devMapListen.values.every((element) => element == false) ||
                ref.watch(gameEndingProvider),
            disposeCb: (ref) async {
              timer.cancel();
              return true;
            });
      },
    );
  }

  static StaticGameModel pasTesti(WidgetRef ref) {
    return StaticGameModel(
      id: '50',
      metaData: GameMetaDataModel(
        id: '50',
        name: instForGameScreen.game_title_50,
        //TODO
        description: instForGameScreen.game_description_50,
        // TODO
        imagePath: '50',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(min: 2, max: 12),
        distance: NumRange.distanceCm(def: 30, min: 5, max: 60),
        delay: NumRange.delay(def: 0, min: 0, max: 10),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.focus,
        ],

        categories: {
          GameCategory.test: 3,
        }, //TODO
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.totalDuration,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        keyboardType: TextInputType.number,
        keyboardValue: KeyboardValue<int>,
        needChronometer: true,
        isIncludePeriodicQueue: true,
        sensorTypes: {
          UsedSensorsType.distance: false,
          UsedSensorsType.tap: false,
        },
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 800,
        ),
      ),
      execute: (ref, game) async {
        final firstActionDateTimeController =
            ref.read(currentFirstActionTimeManager.notifier);
        final setup = ref.read(currentGameSetupProv);

        final autoStart = setup!.autoStart;
        final players = ref.read(selectedPlayersPlayersProv);
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final wantedDis = setup.distance!.def!;
        final mainColor = colors[0];
        final generalPlayer = ref.watch(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        List<DiscoveredDevice> discoveredDevices = devs;
        int counterOfPad = devs.length;
        final delay = setup.delay!.def;

        final pasCount = int.parse(setup.keyboardValue!) - 1;

        int roundCount = 0;

        List<DiscoveredDevice> tempList = devs;

        DiscoveredDevice? lastTempDiscoveredDevice;
        var genDevs = generalPlayer.devices;

        logger.i("Selected Devices: ${genDevs.length}");

        Streamer<SensorEvent>? streamer;

        Future<void> round(WidgetRef ref) async {
          late DiscoveredDevice currentDevice;
          if (!ref.read(currentIncludePeriodicallyQueueManager)) {
            int randomIndex = Random().nextInt(tempList.length);
            currentDevice = tempList[randomIndex];

            while (lastTempDiscoveredDevice != null) {
              if (lastTempDiscoveredDevice!.id == currentDevice.id &&
                  genDevs.contains(currentDevice)) {
                randomIndex = Random().nextInt(tempList.length);
                currentDevice = tempList[randomIndex];
              } else {
                lastTempDiscoveredDevice = null;
                break;
              }
            }
          } else {
            final cDevs =
                ref.read(currentPeriodicallyQueueManager).values.first;

            currentDevice =
                cDevs.elementAt(ref.read(gameCurrRoundProv) % cDevs.length);
          }

          if (delay != null) {
            await Future.delayed(Duration(seconds: delay));
          }

          StaticGameManager.sendIsCommand(currentDevice.id, ref: ref);

          if (chosenSensor == UsedSensorsType.distance) {
            final strm =
                StaticGameManager.listenToDistance(currentDevice.id, ref: ref);

            StaticGameManager.ledColor(
                currentDevice.id,
                SidesColorsModel.all(ref
                            .read(currentIncludePeriodicallyQueueManager) &&
                        ref
                                .read(currentPeriodicallyQueueManager.notifier)
                                .currentPerPeriod
                                ?.devices?[roundCount]
                                .colorStr !=
                            null
                    ? Color(int.parse(
                            ref
                                .read(currentPeriodicallyQueueManager.notifier)
                                .currentPerPeriod!
                                .devices![roundCount]
                                .colorStr!
                                .replaceFirst('#', ''),
                            radix: 16) |
                        0xFF00000)
                    : mainColor),
                ref: ref,
                isCommand: true);

            if (ref.read(currentFirstActionTimeManager) == null) {
              ref
                  .read(currentFirstActionTimeManager.notifier)
                  .changState(DateTime.now());
            }

            streamer = Streamer(strm).listen(
              onData: (distanceEvent) async {
                if (distanceEvent.isValid &&
                    distanceEvent.distance.distance < wantedDis) {
                  StaticGameManager.increaseScore(
                      ref: ref, playerId: mainPlayer.id);

                  StaticGameManager.addScorePoint(
                      ref: ref,
                      playerId: mainPlayer.id,
                      time: distanceEvent.responseTime!);

                  firstActionDateTimeController
                      .addRoundPoint(distanceEvent.responseTime!);

                  StaticGameManager.ledOff(currentDevice.id, ref: ref);

                  if ((roundCount + 1) % counterOfPad == 0) {
                    lastTempDiscoveredDevice = currentDevice;
                    tempList = ref
                        .read(currentDevicesManagerProvider.notifier)
                        .connectedDevice
                        .values
                        .toList();
                  }
                  streamer!.cancel();
                  roundCount++;
                }
              },
            );
          } else {
            final strm = StaticGameManager.listenToTouch(
              currentDevice.id,
              ref: ref,
            );

            StaticGameManager.ledColor(
                currentDevice.id,
                SidesColorsModel.all(ref
                            .read(currentIncludePeriodicallyQueueManager) &&
                        ref
                                .read(currentPeriodicallyQueueManager.notifier)
                                .currentPerPeriod
                                ?.devices?[roundCount]
                                .colorStr !=
                            null
                    ? Color(int.parse(
                            ref
                                .read(currentPeriodicallyQueueManager.notifier)
                                .currentPerPeriod!
                                .devices![roundCount]
                                .colorStr!
                                .replaceFirst('#', ''),
                            radix: 16) |
                        0xFF000000)
                    : mainColor),
                ref: ref,
                isCommand: true);

            if (ref.read(currentFirstActionTimeManager) == null) {
              ref
                  .read(currentFirstActionTimeManager.notifier)
                  .changState(DateTime.now());
            }

            streamer = Streamer(strm).listen(onData: (touchEvent) async {
              if (touchEvent.isValid) {
                StaticGameManager.increaseScore(
                    ref: ref, playerId: mainPlayer.id);

                StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: mainPlayer.id,
                    time: touchEvent.responseTime!);

                firstActionDateTimeController
                    .addRoundPoint(touchEvent.responseTime!);

                StaticGameManager.ledOff(currentDevice.id, ref: ref);

                logger.i((roundCount)); //2 3

                logger.i(counterOfPad); //2 1

                if ((roundCount + 1) % counterOfPad == 0) {
                  lastTempDiscoveredDevice = currentDevice;
                  tempList = ref
                      .read(currentDevicesManagerProvider.notifier)
                      .connectedDevice
                      .values
                      .toList();
                }
                streamer!.cancel();
                roundCount++;
              }
            });
          }

          tempList.remove(currentDevice);

          await streamer?.doneOr(() async {
            if (roundCount > pasCount) {
              logger.i("roundCount $roundCount pass Count $pasCount");
              streamer!.cancel();
              ref.read(currentFirstActionTimeManager.notifier).endStopWatch();
            }
            return (roundCount > pasCount || ref.watch(gameEndingProvider));
          });
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async =>
                roundCount > pasCount || ref.watch(gameEndingProvider),
            disposeCb: (ref) async {
              return true;
            });
      },
    );
  }

  static StaticGameModel sutTesti(WidgetRef ref) {
    return StaticGameModel(
      id: '49',
      metaData: GameMetaDataModel(
        id: '49',
        name: instForGameScreen.game_title_49,
        description: instForGameScreen.game_description_49,
        imagePath: '49',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(min: 2, max: 12),
        distance: NumRange.distanceCm(def: 30, min: 5, max: 60),
        tag: GameTag.speed,
        earnings: [
          GameEarning.agility,
          GameEarning.speed,
          GameEarning.strength
        ],
        categories: {GameCategory.test: 2},
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.totalDuration,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        keyboardType: TextInputType.number,
        keyboardValue: KeyboardValue<int>,
        needChronometer: true,
        sensorTypes: {
          UsedSensorsType.distance: false,
        },
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 1,
        ),
      ),
      execute: (ref, game) async {
        final firstActionDateTimeController =
            ref.read(currentFirstActionTimeManager.notifier);
        final setup = ref.read(currentGameSetupProv);
        final autoStart = setup!.autoStart;
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final wantedDis = setup.distance!.def!;

        final mainColor = colors[0];
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        Map<String, bool> devMapListen = {for (var dev in devs) dev.id: true};
        final ftrs = [];
        for (var dev in devs) {
          ftrs.add(() => StaticGameManager.ledColor(
              dev.id, SidesColorsModel.all(mainColor),
              ref: ref, isCommand: false));
        }
        await Future.wait(ftrs.map((e) => e()));

        late Stream st;

        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;

        if (chosenSensor == UsedSensorsType.distance) {
          st = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
        } else {
          st = StaticGameManager.listenToTouchMulti(
            devs.map((e) => e.id),
            ref: ref,
          );
        }
        //This pad id will be trigger for the game
        String? startPointPadId;

        bool ballThrowState = false;
        int lastSeenMillisecondEpoch = 0;
        Timer timer = Timer.periodic(const Duration(milliseconds: 25), (timer) {
          if (startPointPadId != null) {
            final dateTime = DateTime.now().millisecondsSinceEpoch;
            final diff = dateTime - lastSeenMillisecondEpoch;

            if (diff > 120) {
              ballThrowState = true;
              StaticGameManager.ledOff(startPointPadId!, ref: ref);
              timer.cancel();
              ref
                  .read(currentFirstActionTimeManager.notifier)
                  .changState(DateTime.now());

              for (var element in devs) {
                StaticGameManager.sendIsCommand(element.id, ref: ref);
              }
            }
          }
        });
        final streamer = Streamer(st);

        Future<void> round(WidgetRef ref) async {
          streamer.listen(
            onData: (event) async {
              final devId = event.deviceId;

              final distanceEvent = event as DistanceEvent;

              startPointPadId ??= distanceEvent.deviceId;

              if (startPointPadId == distanceEvent.deviceId) {
                devMapListen[devId] = false;
                lastSeenMillisecondEpoch =
                    DateTime.now().millisecondsSinceEpoch;
              }

              if (ballThrowState &&
                  distanceEvent.distance.distance < wantedDis) {
                if (devMapListen[devId]! == true) {
                  devMapListen.forEach((key, value) {
                    devMapListen[key] = false;
                  });

                  if (ref.read(currentFirstActionTimeManager) != null) {
                    StaticGameManager.increaseScore(
                        ref: ref, playerId: mainPlayer.id);

                    StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: mainPlayer.id,
                        time: distanceEvent.responseTime!);

                    firstActionDateTimeController
                        .addRoundPoint(distanceEvent.responseTime!);
                  } else {
                    ref
                        .read(currentFirstActionTimeManager.notifier)
                        .changState(DateTime.now());
                  }

                  for (var dev in devs) {
                    StaticGameManager.ledOff(dev.id, ref: ref);
                  }

                  if (devMapListen.values
                      .every((element) => element == false)) {
                    streamer.cancel();
                    ref
                        .read(currentFirstActionTimeManager.notifier)
                        .endStopWatch();
                  }
                }
              }
            },
          );

          await streamer.doneOr(() async =>
              devMapListen.values.every((element) => element == false) ||
              ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(ref, round,
            shouldStop: (ref) async =>
                devMapListen.values.every((element) => element == false) ||
                ref.watch(gameEndingProvider),
            disposeCb: (ref) async {
              timer.cancel();
              return true;
            });
      },
    );
  }

  // Kuvvet oyunlarında Config ayarında 1000ms timeout kullanılmalı.
  // Aktivite seçim ekranında seçilebilecek olan round sayısı opsiyonel ve default değeri ile yer almalı
  // Round bazlı da olabilir duration bazlı da olabilir. Maksimumu gösterilecek.
  // Gelecekte multiplayer seçeneği ile oyuncular yarışa da bilirler.
  // Oyuncular kendi renklerini seçebilecek
  static StaticGameModel boksmakinesi(
    WidgetRef ref,
  ) {
    return StaticGameModel(
      id: '100',
      onLeaderboard: true,
      metaData: GameMetaDataModel(
        id: '100',
        name: instForGameScreen.game_title_76,
        primaryScoreString:
            instForGameScreen.game_result_primary_score_highest_strength,
        description: instForGameScreen.game_description_76,
        imagePath: '100',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(min: 1, max: 1),
        tag: GameTag.strength,
        earnings: [GameEarning.strength, GameEarning.condition],
        categories: {GameCategory.sports: 50},
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        scoreTypeParam2: GameScoreType.level,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 1),
        ),
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        sensorTypes: {
          UsedSensorsType.force: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_4g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 1000,
        ),
      ),
      execute: (ref, game) async {
        int highestScore = 0;
        int averageScore = 0;
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final colors = mainPlayer.clrs;
        final mainColor = colors[0];
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        int touchCount = 0;
        Future<void> round(WidgetRef ref) async {
          final dev = devs[0];

          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(mainColor),
            ref: ref,
            isCommand: false,
          );

          final listener = StaticGameManager.listenToTouch(dev.id, ref: ref);
          final Streamer<TouchEvent> streamer = Streamer(listener);

          streamer.listen(onData: (event) async {
            if (touchCount < 3) {
              if (ref.read(buzzerManagerProvider)) {
                CustomDevDebugOperations.playAudio(event.deviceId, ref,
                    val: BeepModel.beep3);
              }
              final tapCt = event.tap.tapCounter;

              StaticGameManager.resetScore(ref: ref, playerId: mainPlayer.id);
              StaticGameManager.increaseScore(
                  ref: ref, playerId: mainPlayer.id, increase: tapCt);
              averageScore += tapCt;
              if (tapCt > highestScore) {
                highestScore = tapCt;
              }
              touchCount++;
              if (touchCount == 3) {
                StaticGameManager.resetScore(ref: ref, playerId: mainPlayer.id);
                StaticGameManager.increaseScore(
                    ref: ref, playerId: mainPlayer.id, increase: highestScore);
                StaticGameManager.increaseLevel(
                    ref: ref,
                    playerId: mainPlayer.id,
                    increase: averageScore ~/ 3);
                await Future.delayed(const Duration(seconds: 1));
                streamer.cancel();
              }
            }
          });
          await streamer.doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(ref, round);
      },
    );
  }

  static StaticGameModel ozelantrenman(
    WidgetRef ref,
  ) {
    return StaticGameModel(
      id: '67',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
          id: '67',
          name: instForGameScreen.game_title_67,
          description: instForGameScreen.game_description_67,
          imagePath: '67',
          playerCount: NumRange.playerCount(
            min: 1,
            max: 1,
          ),
          padCount: NumRange.padCount(min: 1, max: 12),
          delay: NumRange.delay(def: 0, min: 0, max: 5),
          tag: GameTag.resistance,
          earnings: [GameEarning.resistance, GameEarning.reflex],
          categories: {
            GameCategory.sports: 11,
            GameCategory.edu: 30,
            GameCategory.entertainment: 15,
          },
          duration: NumRange.duration(
              def: 30,
              min: GameDurations.normalGameDurationMin,
              max: GameDurations.normalGameDurationMax,
              step: 5),

          /* NumRange.duration(def: 1000, min: 1000, max: 1000), */
          distance: NumRange.distanceCm(
            def: 40,
            min: 5,
            max: 60,
          ),
          timeout:
              NumRange.duration(def: 1000, min: 100, max: 10000, step: 100)),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        // Was catch count before need to fix it later
        scoreTypeParam2: GameScoreType.deviceCatchCount,
        scoreTypeParam3: GameScoreType.totalDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 7),
        ),
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        chosedSensorIndex: 0,
        controlsSetup: GameControlsSetup(
          gameExerciseOpeartionsSelectionSetup:
              GameExerciseOpeartionsSelectionSetup.init(),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: false,
          UsedSensorsType.none: false,
        },
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        final playerId = mainPlayer.id;
        var colors = mainPlayer.clrs;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        final setup = ref.read(currentGameSetupProv)!;
        final wantedDis = setup.distance!.def!;
        final sender = SendStreamer<bool>();
        Stream<TouchEvent> listener;
        Streamer<DistanceEvent>? streamer;
        Streamer<TouchEvent>? streamertouch;
        bool cond = false;
        bool inProgress = false;
        bool clickedOnce = false;
        Color? lastColor;
        int repeat = 0;
        Future<void> round(WidgetRef ref) async {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          final dev = devs[0];
          List<DiscoveredDevice> otherDevs = [];
          if (devs.length > 1) {
            otherDevs = devs.sublist(1);
          }

          Color randomizedColor =
              colors.elementAt(Random().nextInt(colors.length));

          if (randomizedColor == lastColor && devs.length > 1) {
            colors = DeviceShuffler.shuffleColorsUniquely(colors);
            randomizedColor = colors.first;
            lastColor = null;
          } else if (randomizedColor == lastColor && devs.length == 1) {
            final tempColor =
                colors.firstWhere((element) => element != lastColor);
            randomizedColor = tempColor;
          }

          for (var dev in otherDevs) {
            await StaticGameManager.ledOff(
              dev.id,
              ref: ref,
              isCommand: false,
            );
          }

          if (clickedOnce) {
            await Future.delayed(Duration(seconds: setup.delay!.def!));
          }

          await StaticGameManager.ledColor(
            dev.id,
            SidesColorsModel.all(randomizedColor),
            ref: ref,
            isCommand: true,
          );

          if (inProgress && devs.length == 1) {
            inProgress = false;
            await Future.delayed(const Duration(milliseconds: 5000));
          }

          Future<void> close() async {
            streamer?.cancel();
            streamertouch?.cancel();
            streamer = null;
            streamertouch = null;
            return;
          }

          switch (chosenSensor) {
            case UsedSensorsType.tap:
              listener = StaticGameManager.listenToTouch(dev.id, ref: ref);
              streamertouch = Streamer(listener);
              await Future.delayed(const Duration(milliseconds: 150));

              streamertouch!.listen(
                onData: (event) async {
                  assert(event.isValid);
                  if (event.isValid && event.responseTime != null) {
                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    StaticGameManager.increaseCatchCountWithColor(
                        ref: ref,
                        playerId: playerId,
                        color: randomizedColor.value.toRadixString(16));
                    StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: playerId,
                        time: event.responseTime!);
                    clickedOnce = true;
                    if (lastColor == randomizedColor) {
                      repeat++;
                      if (repeat == 2) {
                        repeat = 0;
                        lastColor = null;
                      }
                    } else {
                      lastColor = randomizedColor;
                    }
                    //StaticGameManager.increaseScore(ref: ref, playerId: playerId);
                  }
                  close();
                },
              );
              await streamertouch!.done;
              break;
            case UsedSensorsType.distance:
              final strm = StaticGameManager.listenToDistance(
                dev.id,
                ref: ref,
              );
              await Future.delayed(const Duration(milliseconds: 150));
              streamer = Streamer(strm).listen(
                onData: (event) async {
                  if (event.distance.distance < wantedDis) {
                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    sender.add(() async =>
                        StaticGameManager.increaseCatchCountWithColor(
                            ref: ref,
                            playerId: playerId,
                            color: randomizedColor.value.toRadixString(16)));
                    StaticGameManager.addScorePoint(
                        ref: ref,
                        playerId: playerId,
                        time: event.responseTime!);
                    clickedOnce = true;
                    if (lastColor == randomizedColor) {
                      repeat++;
                      if (repeat == 2) {
                        repeat = 0;
                        lastColor = null;
                      }
                    } else {
                      lastColor = randomizedColor;
                    }
                    //StaticGameManager.increaseScore(ref: ref, playerId: playerId);
                    inProgress = true;
                    close();
                  }
                },
              );

              await streamer!.done;
              break;
            case UsedSensorsType.none:
              sender.add(() async =>
                  StaticGameManager.increaseCatchCountWithColor(
                      ref: ref,
                      playerId: playerId,
                      color: randomizedColor.value.toRadixString(16)));
              clickedOnce = true;
              if (lastColor == randomizedColor) {
                repeat++;
                if (repeat == 2) {
                  repeat = 0;
                  lastColor = null;
                }
              } else {
                lastColor = randomizedColor;
              }
              await Future.delayed(Duration(milliseconds: setup.timeout!.def!));
              break;
            default:
          }
          /*
          await Future.doWhile(
            () async {
              await Future.delayed(Duration.zero);
              switch (chosenSensor) {
                case UsedSensorsType.tap:
                  cond = listener != null;
                  break;
                case UsedSensorsType.distance:
                  cond = streamer != null;
                  break;
                default:
              }
              if (!cond) {
                close();
              }
              return cond;
            },
          ); */
        }

        await game.setup.executeGame(
          ref,
          round,
          disposeCb: (ref) async {
            streamer?.cancel();
            streamertouch?.cancel();
            streamertouch = null;
            streamer = null;
            return true;
          },
        );
      },
    );
  }

  static StaticGameModel dikkatYarisi(WidgetRef ref) {
    return StaticGameModel(
      id: '70',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '70',
        name: instForGameScreen.game_title_70,
        description: instForGameScreen.game_description_70,
        imagePath: '70',
        playerCount: NumRange.playerCount(
          min: 2,
          max: 11,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        duration: NumRange.duration(
          def: 20,
          min: GameDurations.normalGameDurationMin,
          max: GameDurations.normalGameDurationMax,
        ),
        tag: GameTag.speed,
        earnings: [
          GameEarning.speed,
          GameEarning.reflex,
        ],
        categories: {
          GameCategory.sports: 18,
          GameCategory.entertainment: 3,
          GameCategory.multiplayer: 8,
        },
      ),
      setup: StaticGameSetupModel(
          type: GameEndType.score,
          scoreTypeParam1: GameScoreType.catchCount,
          scoreTypeParam2: GameScoreType.averageDuration,
          scoreTypeParam3: GameScoreType.minDuration,
          scoreTypeParam4: GameScoreType.maxDuration,
          stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(
              min: 1,
              max: 1,
            ),
          ),
          generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
          ),
          sensorTypes: {
            UsedSensorsType.tap: false,
          },
          allowSameColor: false,
          accConfig: const AccConfigModel(
            scale: ConfigScale.LIS2DH12_16g,
            mode: ConfigMode.LIS2DH12_HR_12bit,
            threshold: 40,
            timeout: 150,
          ),
          dstConfig: const DstConfigModel(threshold: 1000, timeout: 100)),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        var devs = ref.read(selectedGeneralPlayerProv)!.player.devs;
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        Streamer<TouchEvent>? streamer;

        getPlayerColor() {
          return colorsMap.values.toSet();
        }

        List<Color> getValidColors() {
          final playerClr = getPlayerColor();
          final allClrs = defaultConstColors(ref).toSet();
          final val = allClrs.difference(playerClr);
          return val.toList();
        }

        var validColors = getValidColors();
        roundSetup() async {
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
          final ftrs = [];
          for (int i = 0; i < devs.length; i++) {
            Color? colorForLed;
            if (i > colorsMap.values.length - 1) {
              colorForLed = validColors.elementAt(i - colorsMap.values.length);
            } else {
              colorForLed = colorsMap.values.elementAt(i);
            }
            try {
              final plId = colorsMap.entries
                  .firstWhere((element) => element.value == colorForLed)
                  .key;
              devsMap[plId] = devs.elementAt(i);
            } catch (e) {
              logger.d.call(e.toString());
            }
            ftrs.add(
              () => StaticGameManager.ledColor(
                devs.elementAt(i).id,
                SidesColorsModel.all(colorForLed!),
                ref: ref,
                isCommand: true,
              ),
            );
          }
          await Future.wait(
            ftrs.map((e) => e()),
          );
        }

        Future<void> round(WidgetRef ref) async {
          await roundSetup();
          streamer = Streamer(
            StaticGameManager.listenToTouchMulti(devs.map((e) => e.id),
                ref: ref),
          );

          streamer = streamer?.listen(
            onData: (event) async {
              try {
                final devId = event.deviceId;
                final entry =
                    devsMap.entries.firstWhere((e) => e.value?.id == devId);
                final id = entry.key;

                StaticGameManager.addScorePoint(
                  ref: ref,
                  playerId: id,
                  time: event.responseTime!,
                );
                StaticGameManager.increaseScore(
                  ref: ref,
                  playerId: id,
                ); //
                StaticGameManager.ledAllOffNoDelay(
                  ref: ref,
                );
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                await Future.delayed(const Duration(milliseconds: 50));
                await roundSetup();
              } catch (e) {
                e;
              }
            },
          );
          await streamer?.doneOr(() async => ref.watch(gameEndingProvider));
        }

        await game.setup.executeGame(
          ref,
          round,
          disposeCb: (ref) async {
            streamer?.cancel();
            return true;
          },
        );
      },
    );
  }

  static StaticGameModel grupEgzersiz(WidgetRef ref) {
    return StaticGameModel(
      id: '71',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '71',
        name: instForGameScreen.game_title_71,
        description: instForGameScreen.game_description_71,
        imagePath: '71',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        distance: NumRange.distanceCm(
          def: 15,
          min: 5,
          max: 60,
        ),
        duration: NumRange.duration(
            def: 45,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        tag: GameTag.exercise,
        earnings: [
          GameEarning.exercise,
          GameEarning.resistance,
        ],
        categories: {
          GameCategory.sports: 15,
          //GameCategory.entertainment: 9,
          GameCategory.multiplayer: 9,
          GameCategory.edu: 32,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.deviceCatchCount,
        generalStagedPlayerModel: StagedPlayerModel.general(
          colorCount: NumRange.count(min: 1, max: 10),
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameExerciseOpeartionsSelectionSetup:
              GameExerciseOpeartionsSelectionSetup.init(),
          mentorControlsState: MentorControlsState.ask,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: true
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      init: (ref, game) async {
        ref.read(gameRoundProv.notifier).setEnabled();
      },
      execute: (ref, game) async {
        final mainPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final mainClrs = mainPlayer.clrs;
        final clrs = defaultConstColors(ref);
        final devs = mainPlayer.devs;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        final wantedDis = game.setup.distance?.def;

        Map<String, bool> devMapTouched = {for (var dev in devs) dev.id: false};
        StaticGameSetupModel setup() => ref.read(currentGameSetupProv)!;
        GameControlsSetup controls() => setup().controlsSetup;
        MentorControlsState mentorControlsState() =>
            controls().mentorControlsState;
        if (mentorControlsState() == MentorControlsState.deny) {
          final gameScreenWidget = SportMentorControlSetupWidget(
            devs: devs,
            exerciseOperations: null,
            game: game,
            doesHaveGameRound: true,
          );
          ref.read(gameScreenWidgetProv.notifier).state = gameScreenWidget;
        }

        resetDevMap() {
          devMapTouched.forEach((key, value) {
            devMapTouched[key] = false;
          });
        }

        checkDevMap() {
          return !devMapTouched.values.any((element) => element == false);
        }

        // int roundI = 0;
        // int playerCount = devs.length + 1;
        var validColors = mainClrs;

        List<int>? randomIndexes;
        int i = 0;
        Color getRandomValidColor() {
          validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
          return validColors.first;
        }

        Color getRandomColor(
            [bool isValidColor = false, Color colorToRemove = Colors.white]) {
          final List<Color> clrs = defaultConstColors(ref);

          final cnt = clrs.length;

          if (randomIndexes == null) {
            final indxs = List.generate(cnt, (index) => index);

            final rnd = Xrandom();

            indxs.shuffle(rnd);

            randomIndexes = List.from(indxs);
          }

          return clrs[randomIndexes![i++ % cnt]];
        }

        Future<void> round(WidgetRef ref) async {
          // all of these has been converted to methods,
          // so we get to have the new value if it changes
          StaticGameSetupModel setup() => ref.read(currentGameSetupProv)!;
          GameControlsSetup controls() => setup().controlsSetup;
          MentorControlsState mentorControlsState() =>
              controls().mentorControlsState;
          if (mentorControlsState() == MentorControlsState.deny) {
            Future.delayed(Duration(seconds: Random().nextInt(5) + 5))
                .then((value) async {
              ref.read(gameRoundProv.notifier).setPaused();
              var randomSelectedColor = getRandomValidColor();
              final ftrs = [];
              for (var device in devs) {
                ftrs.add(
                  () => StaticGameManager.ledColor(
                    device.id,
                    SidesColorsModel.all(randomSelectedColor),
                    ref: ref,
                  ),
                );
              }
              await Future.wait(
                ftrs.map(
                  (e) => e(),
                ),
              );
              StaticGameManager.increaseScore(ref: ref, playerId: 'mentor');
              StaticGameManager.increaseCatchCountWithColor(
                  ref: ref,
                  playerId: 'mentor',
                  color: randomSelectedColor.value.toRadixString(16));
            });
          }

          if (mentorControlsState() == MentorControlsState.allow) {
            final gameScreenWidget = SportMentorControlSetupWidget(
              devs: devs,
              exerciseOperations: null,
              game: game,
              doesHaveGameRound: true,
            );
            ref.read(gameScreenWidgetProv.notifier).state = gameScreenWidget;
          }
          // await until the mentor resumes the game
          while (ref.read(gameRoundProv) == GameRoundEnum.paused) {
            // this is critically important, otherwise the ui will freeze
            await Future.delayed(Duration.zero);
          }

          // shuffle devices and colors for each round
          devs.shuffle(Xrandom());
          clrs.shuffle(Xrandom());

          // if manual, we wanna light them randomly for a few times,
          // of mentor, then we wanna light them until we get a command
          // from the mentor

          randomColorsRound() async {
            devs.shuffle(Xrandom());
            clrs.shuffle(Xrandom());

            // led all the pads with different colors
            for (var device in devs) {
              final color = getRandomColor();

              StaticGameManager.ledColor(
                device.id,
                SidesColorsModel.all(color),
                isCommand: true,
                ref: ref,
              );
            }

            // an error margin, for delays
            await Future.delayed(
                Duration(milliseconds: sightDuration.inMilliseconds ~/ 2));
          }

          while (ref.read(gameRoundProv) != GameRoundEnum.paused) {
            await randomColorsRound();
          }

          // on resume

          // now all the pads are led with different colors,
          // we wanna listen to all their touches, and the turn
          // off the leds when they are touched

          final devIds = devs.map((e) => e.id);

          final devIdNameIdMap = CpDiscoveredDevice.devIdNameIdMap(devs);
          if (chosenSensor == UsedSensorsType.distance) {
            final sawDevicesIds = <String>{};
            final listend = StaticGameManager.listenToDistanceMulti(
              devIds,
              ref: ref,
            );

            await for (final event in listend) {
              final dis = event.distance.distance;
              if (event.isValid && dis < wantedDis!) {
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                final keys = devIdNameIdMap.keys.toList();
                final vals = devIdNameIdMap.values.toList();

                final idx =
                    keys.indexWhere((element) => element == event.deviceId);

                if (idx >= 0 && idx < vals.length) {
                  final devId = keys[idx];
                  sawDevicesIds.add(event.deviceId);

                  // the last touched should light red

                  devMapTouched[devId] = true;
                  if (checkDevMap()) {
                    resetDevMap();
                    ref.read(gameRoundProv.notifier).setOngoing();
                  }
                  await StaticGameManager.ledColor(
                    devId,
                    SidesColorsModel.all(gameSuccessColor),
                    ref: ref,
                  );
                }
              }

              if (sawDevicesIds.length == devIds.length ||
                  ref.watch(gameRoundProv) == GameRoundEnum.ongoing) {
                logger.d('bf break');
                break;
              }

              logger.d('no break');
            }
          } else {
            final touchedDevicesIds = <String>{};
            final listenc = StaticGameManager.listenToTouchMulti(
              devIds,
              ref: ref,
            );

            await for (final event in listenc) {
              if (event.isValid) {
                if (ref.read(buzzerManagerProvider)) {
                  CustomDevDebugOperations.playAudio(event.deviceId, ref,
                      val: BeepModel.beep3);
                }
                final keys = devIdNameIdMap.keys.toList();
                final vals = devIdNameIdMap.values.toList();

                final idx =
                    keys.indexWhere((element) => element == event.deviceId);

                if (idx >= 0 && idx < vals.length) {
                  final devId = keys[idx];
                  touchedDevicesIds.add(event.deviceId);

                  // the last touched should light red

                  devMapTouched[devId] = true;
                  if (checkDevMap()) {
                    resetDevMap();
                    ref.read(gameRoundProv.notifier).setOngoing();
                  }
                  await StaticGameManager.ledColor(
                    devId,
                    SidesColorsModel.all(gameSuccessColor),
                    ref: ref,
                  );
                }
              }

              if (touchedDevicesIds.length == devIds.length ||
                  ref.watch(gameRoundProv) == GameRoundEnum.ongoing) {
                logger.d('bf break');
                break;
              }

              logger.d('no break');
            }
          }

          logger.d('af await multi touch');

          await StaticGameManager.ledAllOffNoDelay(ref: ref);
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          ref.read(gameScreenWidgetProv.notifier).state = null;
          StaticGameManager.ledAllOffNoDelay(ref: ref);
          return true;
        });
      },
    );
  }

  static StaticGameModel grupEgzersiziki(WidgetRef ref) {
    return StaticGameModel(
      id: '72',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '72',
        name: instForGameScreen.game_title_72,
        description: instForGameScreen.game_description_72,
        imagePath: '72',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 10,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 45,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        tag: GameTag.exercise,
        earnings: [
          GameEarning.exercise,
          GameEarning.resistance,
        ],
        categories: {
          GameCategory.sports: 16,
          GameCategory.multiplayer: 10,
          GameCategory.edu: 33,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.deviceCatchCount,
        generalStagedPlayerModel: StagedPlayerModel.general(
          colorCount: NumRange.count(min: 1, max: 10),
          deviceCount: NumRange.padCount(min: 1, max: 12),
          hasDevices: true,
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        controlsSetup: GameControlsSetup(
          gameExerciseOpeartionsSelectionSetup:
              GameExerciseOpeartionsSelectionSetup.init(),
          mentorControlsState: MentorControlsState.ask,
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      init: (ref, game) async {
        ref.read(gameRoundProv.notifier).setEnabled();
      },
      execute: (ref, game) async {
        final mainPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        final devs = mainPlayer.devs;
        final clrs = mainPlayer.clrs;
        var validClrs = mainPlayer.clrs;
        StaticGameSetupModel setup() => ref.read(currentGameSetupProv)!;
        GameControlsSetup controls() => setup().controlsSetup;
        MentorControlsState mentorControlsState() =>
            controls().mentorControlsState;
        List<int>? randomIndexes;
        int i = 0;
        Color getRandomValidColor() {
          validClrs = DeviceShuffler.shuffleColorsUniquely(validClrs);
          return clrs.first;
        }

        Color getRandomColor() {
          //final clrs = defaultConstColors(ref);
          final cnt = clrs.length;

          if (randomIndexes == null) {
            final indxs = List.generate(cnt, (index) => index);

            final rnd = Xrandom();

            indxs.shuffle(rnd);

            randomIndexes = List.from(indxs);
          }

          return clrs[randomIndexes![i++ % cnt]];
        }

        if (mentorControlsState() == MentorControlsState.deny) {
          final randomSelectedColor = getRandomValidColor();
          final ftrs = [];
          for (var device in devs) {
            ftrs.add(
              () => StaticGameManager.ledColor(
                device.id,
                SidesColorsModel.all(randomSelectedColor),
                ref: ref,
              ),
            );
          }
          await Future.wait(
            ftrs.map(
              (e) => e(),
            ),
          );

          StaticGameManager.increaseScore(ref: ref, playerId: 'mentor');
          StaticGameManager.increaseCatchCountWithColor(
              ref: ref,
              playerId: 'mentor',
              color: randomSelectedColor.value.toRadixString(16));
        }

        Future<void> round(WidgetRef ref) async {
          // all of these has been converted to methods,
          // so we get to have the new value if it changes
          StaticGameSetupModel setup() => ref.read(currentGameSetupProv)!;
          GameControlsSetup controls() => setup().controlsSetup;
          MentorControlsState mentorControlsState() =>
              controls().mentorControlsState;
          if (mentorControlsState() == MentorControlsState.deny) {
            ref.read(gameScreenWidgetProv.notifier).state = null;
            ref.read(gameRoundProv.notifier).setOngoing();
            await Future.delayed(Duration(seconds: Random().nextInt(5) + 5));
            final randomSelectedColor = getRandomColor();
            for (var device in devs) {
              await StaticGameManager.ledColor(
                device.id,
                SidesColorsModel.all(randomSelectedColor),
                isCommand: true,
                ref: ref,
              );
            }
            ref.read(gameRoundProv.notifier).setPaused();
            StaticGameManager.increaseScore(ref: ref, playerId: 'mentor');
            StaticGameManager.increaseCatchCountWithColor(
                ref: ref,
                playerId: 'mentor',
                color: randomSelectedColor.value.toRadixString(16));
            return;
          } else {
            final gameScreenWidget = SportMentorControlSetupWidget(
              devs: devs,
              exerciseOperations: null,
              game: game,
              randomized: false,
              doesHaveGameRound: true,
            );

            ref.read(gameScreenWidgetProv.notifier).state = gameScreenWidget;
          }
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          ref.read(gameScreenWidgetProv.notifier).state = null;
          StaticGameManager.ledAllOffNoDelay(ref: ref);
          return true;
        });
      },
    );
  }

  static StaticGameModel atisSerbest(WidgetRef ref) {
    return StaticGameModel(
      id: '75',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '75',
        name: instForGameScreen.game_title_75,
        description: instForGameScreen.game_description_75,
        imagePath: '75',
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
            step: 5),
        distance: NumRange.distanceCm(def: 20, min: 5, max: 60, step: 5),
        tag: GameTag.resistance,
        earnings: [
          GameEarning.resistance,
          GameEarning.speed,
        ],
        categories: {
          GameCategory.sports: 13,
          GameCategory.edu: 28,
          GameCategory.entertainment: 10,
          GameCategory.multiplayer: 3,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        allowSameColor: true,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        generalStagedPlayerModel: StagedPlayerModel.general(
          unavailableColors: [
            gameSuccessColor,
          ],
        ),
        stagedPlayerModel: StagedPlayerModel(
            colorCount: NumRange.count(min: 1, max: 1),
            hasDevices: true,
            hasName: true),
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig:
            const DstConfigModel(threshold: 1000, timeout: 700, limitValue: 7),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final setup = ref.read(currentGameSetupProv)!;
        final devs = setup.getGameDevices(ref);
        final wantedDis = setup.distance!.def!;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        for (var dev in devs) {
          await StaticGameManager.sendIsCommand(dev.id, ref: ref);
          if (chosenSensor == UsedSensorsType.distance) {
            PadSensorManager.lockDstThreshold(ref: ref, deviceId: dev.id);
          }
        }

        final sender = SendStreamer();
        Streamer<DistanceEvent>? streamerDst;
        Streamer<TouchEvent>? streamerTap;
        Map<String, bool> clickMap = {
          for (final player in players) player.id: true
        };
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: player.devs.first
        };
        Map<String, Color> colorMap = {
          for (final player in players) player.id: player.clrs.first
        };
        final ftrs = [];
        final stopwatch = Stopwatch();
        for (var dev in devs) {
          final playerId = devsMap.entries
              .where((element) => element.value?.id == dev.id)
              .first
              .key;
          ftrs.add(
            () => StaticGameManager.ledColor(
                dev.id, SidesColorsModel.all(colorMap[playerId]!),
                ref: ref, isCommand: true),
          );
        }
        await Future.wait(
          ftrs.map(
            (e) => e(),
          ),
        );
        stopwatch.reset();
        stopwatch.start();
        bool goon = true;
        Future<bool> process(String playerId, Duration responseTime,
            String devId, int delay) async {
          if (ref.read(buzzerManagerProvider)) {
            CustomDevDebugOperations.playAudio(devId, ref,
                val: BeepModel.beep3);
          }
          if (clickMap[playerId]!) {
            clickMap[playerId] = false;
            logger.d('event: audiodone');
            /* CustomDevDebugOperations.playAudio(devId, ref,
                val: BeepModel.beep3); */
            StaticGameManager.increaseScore(ref: ref, playerId: playerId);
            StaticGameManager.addScorePoint(
                ref: ref, playerId: playerId, time: responseTime);
            debugPrint('duration responseTime: $responseTime');
            debugPrint(
                'duration responseTimeinmillisec: ${responseTime.inMilliseconds}');

            /* StaticGameManager.addFlSpot(
                ref: ref,
                playerId: playerId,
                spot: FlSpot(
                    StaticGameManager.getScore(playerId: playerId, ref: ref)
                        .toDouble(),
                    responseTime.durationToDoubleForGraph())); */
            /* await StaticGameManager.ledColor(
                devId, SidesColorsModel.all(gameSuccessColor),
                ref: ref);
            await Future.delayed(Duration(milliseconds: delay));
            await StaticGameManager.ledColor(
                devId, SidesColorsModel.all(colorMap[playerId]!),
                ref: ref, isCommand: true);
            stopwatch.reset();
            clickMap[playerId] = true;
            return true; */
            Future<bool> miniprocess() async {
              await StaticGameManager.ledColor(
                  devId, SidesColorsModel.all(gameSuccessColor),
                  ref: ref);
              await Future.delayed(Duration(milliseconds: delay));
              await StaticGameManager.ledColor(
                  devId, SidesColorsModel.all(colorMap[playerId]!),
                  ref: ref, isCommand: true);
              stopwatch.reset();
              clickMap[playerId] = true;
              return true;
            }

            //await miniprocess();

            sender.add(() => miniprocess());
          }
          return false;
        }

        Future<void> round(WidgetRef ref) async {
          switch (chosenSensor) {
            case UsedSensorsType.tap:
              var multiTouchListener = StaticGameManager.listenToTouchMulti(
                  devs.map((e) => e.id),
                  ref: ref);
              streamerTap = Streamer(multiTouchListener);
              streamerTap?.listen(
                onData: (tapdata) async {
                  logger.i("Tap Data: ${tapdata.tap.toJson()}");
                  if (goon) {
                    try {
                      goon = false;
                      final playerId = devsMap.entries
                          .where((element) =>
                              element.value?.id == tapdata.deviceId)
                          .first
                          .key;
                      await process(
                          playerId,
                          tapdata.responseTime ??
                              BigGuy.responseTime(tapdata.tap.actionTime,
                                  tapdata.tap.commandTime)!,
                          tapdata.deviceId,
                          200);
                    } catch (e) {
                      logger.d(e.toString());
                    }
                    goon = true;
                  }
                },
              );
              await streamerTap?.done;
              break;
            case UsedSensorsType.distance:
              var multiDistanceListener =
                  StaticGameManager.listenToDistanceMulti(devs.map((e) => e.id),
                      ref: ref);
              streamerDst = Streamer(multiDistanceListener);
              streamerDst?.listen(
                onData: (dstData) async {
                  if (goon) {
                    goon = false;
                    try {
                      final dis = dstData.distance.distance;
                      if (dis < wantedDis) {
                        final playerId = devsMap.entries
                            .where((element) =>
                                element.value?.id == dstData.deviceId)
                            .first
                            .key;
                        await process(playerId, dstData.responseTime!,
                            dstData.deviceId, 200);
                      }
                    } catch (e) {
                      logger.d(e.toString());
                    }
                    goon = true;
                  }
                },
              );
              await streamerDst?.done;
              break;
            default:
          }
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          ref.read(gameScreenWidgetProv.notifier).state = null;
          streamerDst?.cancel();
          streamerTap?.cancel();
          StaticGameManager.ledAllOffNoDelay(ref: ref);
          return true;
        });
      },
    );
  }

  static StaticGameModel ilkGelen(WidgetRef ref) {
    return StaticGameModel(
      id: '74',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '74',
        name: instForGameScreen.game_title_74,
        primaryScoreString: instForGameScreen.score_target,
        description: instForGameScreen.game_description_74,
        imagePath: '74',
        playerCount: NumRange.playerCount(
          min: 2,
          max: 12,
        ),
        padCount: NumRange.padCount(
          min: 4,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 40,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        tag: GameTag.speed,
        earnings: [
          GameEarning.reflex,
          GameEarning.speed,
        ],
        categories: {
          GameCategory.sports: 17,
          GameCategory.entertainment: 13,
          GameCategory.multiplayer: 5,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        allowSameColor: false,
        generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
            unavailableColors: [const Color.fromARGB(255, 23, 227, 91)]),
        stagedPlayerModel:
            StagedPlayerModel(colorCount: NumRange.count(min: 1, max: 1)),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        var devs = ref.read(selectedGeneralPlayerProv)!.player.devs;
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        Streamer<TouchEvent>? streamer;

        getPlayerColor() {
          return colorsMap.values.toSet();
        }

        List<Color> getValidColors() {
          final playerClr = getPlayerColor();
          final allClrs = defaultConstColors(ref)
              .where((element) =>
                  element != const Color.fromARGB(255, 23, 227, 91))
              .toSet();
          final val = allClrs.difference(playerClr);
          return val.toList();
        }

        var validColors = getValidColors();

        Future<void> round(WidgetRef ref) async {
          bool goNewRound = false;
          bool clickable = true;
          devs = DeviceShuffler.shuffleDevicesUniquely(devs);
          validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
          final ftrs = [];
          for (int i = 0; i < devs.length; i++) {
            Color? colorForLed;

            if (i < colorsMap.values.length) {
              colorForLed = colorsMap.values.elementAt(i);
            } else {
              validColors = DeviceShuffler.shuffleColorsUniquely(validColors);
              colorForLed = validColors.first;
            }
            try {
              final plId = colorsMap.entries
                  .firstWhere((element) => element.value == colorForLed)
                  .key;
              devsMap[plId] = devs.elementAt(i);
            } catch (e) {
              logger.d.call(e.toString());
            }
            ftrs.add(() => StaticGameManager.ledColor(
                  devs.elementAt(i).id,
                  SidesColorsModel.all(colorForLed!),
                  ref: ref,
                  isCommand: true,
                ));
          }
          await Future.wait(
            ftrs.map(
              (e) => e(),
            ),
          );

          await Future.delayed(const Duration(milliseconds: 300));

          streamer = Streamer(
            StaticGameManager.listenToTouchMulti(devs.map((e) => e.id),
                ref: ref),
          );

          streamer = streamer?.listen(
            onData: (event) async {
              try {
                bool isGoodToGo;
                List<String> devIds = [];
                for (var devId in devsMap.entries) {
                  if (devId.value != null) {
                    devIds.add(devId.value!.id);
                  }
                }
                isGoodToGo = devIds.contains(event.deviceId);
                if (clickable && isGoodToGo) {
                  clickable = false;
                  final devId = event.deviceId;
                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);

                  final playerid = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: playerid,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: playerid,
                  );
                  /* StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: playerid,
                      spot: FlSpot(
                          StaticGameManager.getScore(
                                  playerId: playerid, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph())); */
                  StaticGameManager.ledAllOffNoDelay(
                    ref: ref,
                  ).then((value) {
                    if (ref.read(buzzerManagerProvider)) {
                      CustomDevDebugOperations.playAudio(event.deviceId, ref,
                          val: BeepModel.beep3);
                    }
                    Future.delayed(const Duration(seconds: 4))
                        .then((value) => goNewRound = true);
                  });
                }
              } catch (e) {
                e;
              }
            },
          );
          await streamer?.doneOr(() async => goNewRound);
        }

        await game.setup.executeGame(ref, round);

        streamer?.cancel();
      },
    );
  }

  static StaticGameModel renkliYaris(WidgetRef ref) {
    return StaticGameModel(
      id: '73',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '73',
        name: instForGameScreen.game_title_73,
        description: instForGameScreen.game_description_73,
        imagePath: '73',
        playerCount: NumRange.playerCount(
          min: 2,
          max: 11,
        ),
        padCount: NumRange.padCount(
          min: 3,
          max: 12,
        ),
        duration: NumRange.duration(
            def: 20,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        tag: GameTag.reflex,
        earnings: [
          GameEarning.reflex,
          GameEarning.speed,
          GameEarning.focus,
          GameEarning.competition
        ],
        categories: {
          GameCategory.sports: 4,
          GameCategory.edu: 4,
          GameCategory.entertainment: 2,
          GameCategory.multiplayer: 6,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDuration,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        allowSameColor: false,
        generalStagedPlayerModel: StagedPlayerModel.general(
            hasDevices: true,
            unavailableColors: [const Color.fromARGB(255, 23, 227, 91)]),
        stagedPlayerModel:
            StagedPlayerModel(colorCount: NumRange.count(min: 1, max: 1)),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);

        final devs = ref.read(selectedGeneralPlayerProv)!.player.devs;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        Map<String, DeviceModel?> devsMap = {
          for (final player in players) player.id: null,
        };

        Map<String, Color> colorsMap = {
          for (final player in players) player.id: player.clrs[0],
        };

        final ran = Xrandom();
        final clrs = defaultConstColors(ref).toSet();
        var validClrs = clrs.difference(colorsMap.values.toSet()).toList();
        triggerOtherDevColorsRandomly() async {
          Color getRandomValidColor() {
            validClrs = DeviceShuffler.shuffleColorsUniquely(validClrs);
            return validClrs.first;
          }

          final ftrs = [];
          for (var dev in devs) {
            if (!devsMap.values.contains(dev)) {
              final randomSelectedColor = getRandomValidColor();
              ftrs.add(() => StaticGameManager.ledColor(
                  dev.id, SidesColorsModel.all(randomSelectedColor),
                  ref: ref));
            }
          }
          await Future.wait(ftrs.map((e) => e()));
        }

        DeviceModel? getUnusedDev(DeviceModel? thisone) {
          final thisId = thisone?.id;

          final otherOnes = devs.where((d) => d.id != thisId);
          final otherIds = otherOnes.map((d) => d.id).toList();
          final otherPlyerDeviceIds = devsMap.values
              .where((element) => element != null)
              .map((d) => d!.id)
              .toList();
          final otherUnoccupiedIds = otherIds
              .where((id) => !otherPlyerDeviceIds.contains(id))
              .toList();

          try {
            return devs
                .firstWhere((element) => element.id == otherUnoccupiedIds[0]);
          } catch (e) {
            assert(false);
            return null;
          }
        }

        final sender = SendStreamer<bool>();
        Streamer<TouchEvent>? streamer;
        Streamer<DistanceEvent>? streamerDist;

        switch (chosenSensor) {
          case UsedSensorsType.tap:
            streamer = Streamer(
              StaticGameManager.listenToTouchMulti(devs.map((e) => e.id),
                  ref: ref),
            );

            streamer = streamer.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);

                  final id = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );
                  StaticGameManager.addFlSpot(
                      ref: ref,
                      playerId: id,
                      spot: FlSpot(
                          StaticGameManager.getScore(playerId: id, ref: ref)
                              .toDouble(),
                          event.responseTime!.durationToDoubleForGraph()));
                  StaticGameManager.ledOff(
                    devId,
                    ref: ref,
                    isCommand: true,
                  );
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  final newDev = getUnusedDev(devsMap[id]);
                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;
                  await StaticGameManager.ledColor(
                    newDev.id,
                    SidesColorsModel.all(colorsMap[id]!),
                    ref: ref,
                    isCommand: true,
                  );

                  if (Platform.isIOS) {
                    await Future.delayed(const Duration(milliseconds: 50));
                  }
                  triggerOtherDevColorsRandomly();
                } catch (e) {
                  e;
                }
              },
            );
            break;
          case UsedSensorsType.distance:
            streamerDist = Streamer(
              StaticGameManager.listenToDistanceMulti(devs.map((e) => e.id),
                  ref: ref),
            );

            streamerDist = streamerDist.listen(
              onData: (event) async {
                try {
                  final devId = event.deviceId;
                  final entry =
                      devsMap.entries.firstWhere((e) => e.value?.id == devId);

                  final id = entry.key;

                  StaticGameManager.addScorePoint(
                    ref: ref,
                    playerId: id,
                    time: event.responseTime!,
                  );
                  StaticGameManager.increaseScore(
                    ref: ref,
                    playerId: id,
                  );
                  sender.add(() async => await StaticGameManager.ledOff(
                        devId,
                        ref: ref,
                        isCommand: true,
                      ));
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  final newDev = getUnusedDev(devsMap[id]);
                  if (newDev == null) {
                    assert(false);
                    return;
                  }

                  devsMap[id] = newDev;
                  sender.add(() async => await StaticGameManager.ledColor(
                        newDev.id,
                        SidesColorsModel.all(colorsMap[id]!),
                        ref: ref,
                        isCommand: true,
                      ));
                  triggerOtherDevColorsRandomly();
                } catch (e) {
                  e;
                }
              },
            );
            break;
          default:
        }

        triggerOtherDevColorsRandomly();
        Future<void> round(WidgetRef ref) async {
          devs.shuffle(ran);

          for (var entry in devsMap.entries) {
            final id = entry.key;
            final dev = entry.value;

            if (dev != null) {
              continue;
            }

            final pDev = getUnusedDev(devsMap[id]);
            if (pDev == null) {
              assert(false);
              continue;
            }
            devsMap[id] = pDev;

            final pDevId = pDev.id;

            StaticGameManager.ledColor(
              pDevId,
              SidesColorsModel.all(colorsMap[id]!),
              ref: ref,
              isCommand: true,
            );
          }

          // await Future.doWhile(
          //   () async {
          //     await Future.delayed(Duration.zero);
          //     // when any player catches their pad, skip to the next round
          //     // so we can reround them.
          //     return devsMap.values.every((value) => value != null);
          //   },
          // );
        }

        await game.setup.executeGame(ref, round, disposeCb: (val) async {
          streamer?.cancel();
          streamerDist?.cancel();

          ref.read(currentFinishControlManager.notifier).changState(true);

          PlayerResultModel? winnerResult;

          for (var player in ref.read(gameResultProv)!.players) {
            final result =
                ref.read(gameResultProv.notifier).getPlayer(player.id);
            if (result != null) {
              winnerResult ??= result;

              if (result.correctCount != null &&
                  (result.correctCount ?? 0) >
                      (winnerResult.correctCount ?? 0)) {
                winnerResult = result;
              } else if (result.scorePoints != null &&
                  result.scorePoints!.length ==
                      winnerResult.scorePoints!.length) {
                if (winnerResult.averageDuration!.inSeconds >
                    result.averageDuration!.inSeconds) {
                  winnerResult = result;
                }
              }
            }
          }
          final currentDeviceList = ref.read(currentDevicesManagerProvider);
          final futureList = <Future>[];
          for (int i = 0; i < 3; i++) {
            if (winnerResult != null) {
              currentDeviceList.forEach((key, value) {
                futureList.add(StaticGameManager.ledColorNoResponse(
                  key,
                  SidesColorsModel.all(colorsMap[winnerResult!.playerId]!),
                  ref: ref,
                  isCommand: false,
                ));
              });
            }
            Future.wait(futureList);
            await Future.delayed(const Duration(milliseconds: 800));
            StaticGameManager.ledAllOff(ref: ref);
            await Future.delayed(const Duration(milliseconds: 250));
          }
          return true;
        });

        streamer?.cancel();
        streamerDist?.cancel();
      },
    );
  }

  static StaticGameModel siraliYakalama(
    WidgetRef ref,
  ) {
    return StaticGameModel(
      id: '68',
      onLeaderboard: false,
      metaData: GameMetaDataModel(
        id: '68',
        name: instForGameScreen.game_title_68,
        description: instForGameScreen.game_description_68,
        imagePath: '68',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(min: 1, max: 12),
        tag: GameTag.resistance,
        earnings: [GameEarning.resistance, GameEarning.reflex],
        categories: {
          GameCategory.sports: 12,
          GameCategory.edu: 29,
          GameCategory.entertainment: 21,
        },
        duration: NumRange.duration(
            def: 30,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        distance: NumRange.distanceCm(
          def: 40,
          min: 5,
          max: 60,
        ),
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        // Was catch count before need to fix it later
        scoreTypeParam2: GameScoreType.deviceCatchCount,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 7),
        ),
        isColorSelectOrder: true,
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        chosedSensorIndex: 0,
        controlsSetup: GameControlsSetup(
          gameExerciseOpeartionsSelectionSetup:
              GameExerciseOpeartionsSelectionSetup.init(),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
          UsedSensorsType.distance: false,
        },
        allowSameColor: true,
        accConfig: const AccConfigModel(
          scale: ConfigScale.LIS2DH12_16g,
          mode: ConfigMode.LIS2DH12_HR_12bit,
          threshold: 40,
          timeout: 150,
        ),
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 250,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);

        //TODO BU YORUM SATIRINI DENE ÇÜNKÜ CRASHYLTİCSTE HATA DONUYOR
        /*PlayerModel generalPlayer = mainPlayer;
        if(ref.read(selectedGeneralPlayerProv) != null ){
          generalPlayer  = ref.read(selectedGeneralPlayerProv)!.player;

        }*/
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        final playerId = mainPlayer.id;
        final colors = mainPlayer.clrs;
        final chosenSensor = game.setup.sensorTypes.entries
            .elementAt(game.setup.chosedSensorIndex)
            .key;
        final setup = ref.read(currentGameSetupProv)!;
        final wantedDis = setup.distance!.def!;
        final sender = SendStreamer<bool>();
        StreamSubscription<SensorEvent>? listener;
        StreamSubscription<DistanceEvent>? streamer;
        bool cond = false;

        bool inProgress = false;
        Map<String, Color> devColorMap = {};
        late Color expectedColor;
        resetMap() {
          expectedColor = colors.elementAt(0);
          devColorMap.clear();
        }

        sendIsCommandToAll() {
          for (var devid in devColorMap.keys) {
            sender.add(() => StaticGameManager.sendIsCommand(devid, ref: ref));
          }
        }

        final ftrs = [];

        int counter = 0;
        DiscoveredDevice? lastDiscoveredDevice;
        Future<void> round(WidgetRef ref) async {
          await StaticGameManager.ledAllOff(ref: ref);

          void close() {
            StaticGameManager.ledAllOff(ref: ref);
            counter = 0;
            listener?.cancel();
            listener = null;
            streamer?.cancel();
            streamer = null;

            return;
          }

          counter = 0;

          devs = DeviceShuffler.shuffleDevicesUniquely(devs);

          ftrs.clear();

          resetMap();

          for (var i = 0; i < colors.length; i++) {
            devColorMap.addAll({devs.elementAt(i).id: colors.elementAt(i)});
            ftrs.add(() => StaticGameManager.ledColor(
                  devs.elementAt(i).id,
                  SidesColorsModel.all(colors.elementAt(i)),
                  ref: ref,
                  isCommand: true,
                ));
          }

          await Future.wait(ftrs.map((e) => e()));

          if (inProgress && devs.length == 1) {
            inProgress = false;
            await Future.delayed(const Duration(milliseconds: 5000));
          }

          sendIsCommandToAll();

          switch (chosenSensor) {
            case UsedSensorsType.tap:
              await Future.delayed(const Duration(milliseconds: 150));

              listener = StaticGameManager.listenToTouchMulti(
                      devs.map((e) => e.id),
                      ref: ref)
                  .listen(
                      onError: (val) =>
                          logger.e("Listen To Touch Multi ${val.toString()}"),
                      (event) async {
                //assert(event.isValid);

                if (event.isValid &&
                    event.responseTime != null &&
                    devColorMap[event.deviceId] == expectedColor) {
                  lastDiscoveredDevice = generalPlayer.devs
                      .firstWhere((element) => element.id == event.deviceId);

                  await StaticGameManager.ledOff(event.deviceId, ref: ref);
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  StaticGameManager.increaseCatchCountWithColor(
                      ref: ref,
                      playerId: playerId,
                      color: expectedColor.value.toRadixString(16));

                  StaticGameManager.addScorePoint(
                      ref: ref, playerId: playerId, time: event.responseTime!);

                  counter++;

                  if (counter == (colors.length)) {
                    close();
                  }

                  sendIsCommandToAll();

                  try {
                    expectedColor = colors.elementAt(counter);
                  } catch (e) {
                    close();
                  }
                }
              });

              break;
            case UsedSensorsType.distance:
              await Future.delayed(const Duration(milliseconds: 150));

              streamer = StaticGameManager.listenToDistanceMulti(
                devs.map((e) => e.id),
                ref: ref,
              ).listen((event) async {
                if (event.distance.distance < wantedDis &&
                    devColorMap[event.deviceId] == expectedColor) {
                  lastDiscoveredDevice = generalPlayer.devs
                      .firstWhere((element) => element.id == event.deviceId);

                  await StaticGameManager.ledOff(event.deviceId, ref: ref);
                  if (ref.read(buzzerManagerProvider)) {
                    CustomDevDebugOperations.playAudio(event.deviceId, ref,
                        val: BeepModel.beep3);
                  }
                  StaticGameManager.increaseCatchCountWithColor(
                      ref: ref,
                      playerId: playerId,
                      color: expectedColor.value.toRadixString(16));

                  StaticGameManager.addScorePoint(
                      ref: ref, playerId: playerId, time: event.responseTime!);

                  counter++;

                  if (counter == (colors.length)) {
                    close();
                  }

                  sendIsCommandToAll();

                  try {
                    expectedColor = colors.elementAt(counter);
                  } catch (e) {
                    close();
                  }
                }
              });

              break;
            default:
          }

          await Future.doWhile(() async {
            await Future.delayed(Duration.zero);

            switch (chosenSensor) {
              case UsedSensorsType.tap:
                cond = listener != null;
                break;

              case UsedSensorsType.distance:
                cond = streamer != null;
                break;

              default:
            }

            //await Future.delayed(
            //    Duration(milliseconds: Platform.isAndroid ? 50 : 200));

            if (!cond) {
              close();
            }

            return cond;
          });

          logger.i("Exit on doWhile");
        }

        await game.setup.executeGame(
          ref,
          round,
          disposeCb: (ref) async {
            listener?.cancel();
            listener = null;
            streamer?.cancel();
            streamer = null;
            return true;
          },
        );
      },
    );
  }

  static StaticGameModel takimEgzersiz(
    WidgetRef ref,
  ) {
    return StaticGameModel(
      id: '69',
      metaData: GameMetaDataModel(
        id: '69',
        name: instForGameScreen.game_title_69,
        description: instForGameScreen.game_description_69,
        imagePath: '69',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(min: 1, max: 12),
        tag: GameTag.resistance,
        earnings: [GameEarning.resistance, GameEarning.reflex],
        categories: {
          GameCategory.sports: 14,
          GameCategory.edu: 31,
          GameCategory.entertainment: 22,
          GameCategory.multiplayer: 4,
        },
        duration: NumRange.duration(
            def: 30,
            min: GameDurations.normalGameDurationMin,
            max: GameDurations.normalGameDurationMax,
            step: 5),
        timeout: NumRange.duration(def: 3, min: 1, max: 10, step: 1),
        delay: NumRange.delay(def: 1, min: 1, max: 10),
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.averageDuration,
        // Was catch count before need to fix it later
        scoreTypeParam2: GameScoreType.deviceCatchCount,
        scoreTypeParam3: GameScoreType.minDuration,
        scoreTypeParam4: GameScoreType.maxDuration,
        stagedPlayerModel: StagedPlayerModel(
          colorCount: NumRange.count(min: 1, max: 7),
        ),
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(
          hasDevices: true,
        ),
        controlsSetup: GameControlsSetup(
          gameExerciseOpeartionsSelectionSetup:
              GameExerciseOpeartionsSelectionSetup.init(),
        ),
        sensorTypes: {
          UsedSensorsType.tap: false,
        },
        dstConfig: const DstConfigModel(
          threshold: 1000,
          timeout: 150,
        ),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final mainPlayer = players.elementAt(0);
        final generalPlayer = ref.read(selectedGeneralPlayerProv)!.player;
        var devs = generalPlayer.devs;
        var colors = mainPlayer.clrs;
        final setup = game.setup;
        final double delay = setup.delay!.def! / 2;
        final int timeout = setup.timeout!.def!;
        final ftrs = [];
        Future<void> round(WidgetRef ref) async {
          colors = DeviceShuffler.shuffleColorsUniquely(colors);
          final random = Xrandom();
          final currentIndex = random.nextInt(colors.length);
          var color = colors[currentIndex];
          ftrs.clear();
          for (var dev in devs) {
            ftrs.add(() => StaticGameManager.ledColor(
                  dev.id,
                  SidesColorsModel.all(color),
                  ref: ref,
                ));
          }
          await Future.wait(ftrs.map((e) => e()));
          await Future.delayed(Duration(seconds: timeout.toInt()));

          await StaticGameManager.ledAllOffNoDelay(ref: ref);
          await Future.delayed(Duration(milliseconds: (delay * 1000).toInt()));
          return;
        }

        await game.setup.executeGame(
          ref,
          round,
          disposeCb: (ref) async {
            StaticGameManager.ledAllOffNoDelay(ref: ref);
            return true;
          },
        );
      },
    );
  }

  static StaticGameModel padquizGame(
    WidgetRef ref,
  ) {
    return StaticGameModel(
      id: '77',
      metaData: GameMetaDataModel(
        id: '77',
        name: instForGameScreen.game_title_77,
        description: instForGameScreen.game_description_77,
        imagePath: '77',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 12,
        ),
        radius: NumRange.radius(def: 15, min: 10, max: 20, step: 1),
        padCount: NumRange.padCount(min: 1, max: 12),
        tag: GameTag.knowledge,
        earnings: [GameEarning.knowledge, GameEarning.intelligence],
        categories: {
          GameCategory.edu: 20,
          GameCategory.entertainment: 5,
          GameCategory.multiplayer: 1,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.score,
        scoreTypeParam1: GameScoreType.score,
        // Was catch count before need to fix it later
        scoreTypeParam2: GameScoreType.averageDuration,
        stagedPlayerModel: StagedPlayerModel(
            hasDevices: true, deviceCount: NumRange.count(min: 1, max: 1)),
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(),
        controlsSetup: GameControlsSetup(
            gameQuizSelectionSetup: GameQuizSelectionSetup.init()),
        isScore: true,
        sensorTypes: {
          UsedSensorsType.motion: false,
        },
      ),
      init: (ref, game) async {
        final questions = ref.read(selectedQuizProvider)!.questions;
        ref.read(currentQuestionProv.notifier).setQuestion(questions.first);
        ref.read(isCurrentQuizdone.notifier).reset();
        return;
      },
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final setup = game.setup;
        final quiz = ref.read(selectedQuizProvider)!;
        final devs = setup.getGameDevices(ref);
        final questions = quiz.questions;
        final max = questions.length - 1;
        final audioPlayer = ref.watch(cpAudioPlayerProv);
        final radius = game.setup.radius!.def;

        var gameScreenWidget = QuizScreenWidget(
            audioPlayer: audioPlayer,
            questions: questions,
            quiz: quiz,
            devs: devs,
            max: max,
            game: game);

        Map<String, DiscoveredDevice> devsMap = {
          for (var player in players) player.id: player.devs.first
        };

        Map<String, DeviceModel> devMap = {for (final dev in devs) dev.id: dev};

        Map<String, bool> processMap = {
          for (var player in players) player.id: true
        };

        Map<String, List<Duration>> scoreMap = {
          for (var player in players) player.id: []
        };

        Map<String, bool> answeredMap = {
          for (var player in players) player.id: false
        };
        HoldSteadyGameModel? gameModel;

        // HOW WILL THIS WORK
        // the strategy we're gonna follow is to send a command once all
        // the pads are steady, and save the response time once one of them
        // is not steady anymore. this way at the end of the game we'll end
        // up with the longest time the player stayed in the zone.
        // as we're sending the command time at the same time to all the pads,
        // getting the response time from any is fine.

        Map<String, Set<Direction>> lastDirections = {};
        final st = StaticGameManager.listenToMotionMulti(
          devs.map((e) => e.id),
          ref: ref,
        );
        Map<String, MotionEvent> lastEvents = {};
        for (var dev in devs) {
          StaticGameManager.sendIsCommand(
            dev.id,
            ref: ref,
          );
        }
        var question = ref.read(currentQuestionProv);
        var timer =
            Timer.periodic(const Duration(milliseconds: 200), (timer) async {
          var lastquestion = ref.read(currentQuestionProv);
          if (answeredMap.values.every((answer) => answer == true) &&
              question != lastquestion) {
            question = lastquestion;
            answeredMap.forEach((key, value) {
              answeredMap[key] = false;
              processMap[key] = true;
            });
            final ftrs = [];
            for (var dev in devs) {
              ftrs.add(() => StaticGameManager.ledColor(
                    dev.id,
                    SidesColorsModel.all(
                        const Color.fromARGB(255, 255, 102, 0)),
                    ref: ref,
                  ));
            }
            await Future.wait(ftrs.map((e) => e()));
          }
        });

        var streamer = Streamer(st);
        Future<void> round(WidgetRef ref) async {
          Future ledSuccess(String devid, playerid, responsetime) async {
            if (ref.read(buzzerManagerProvider)) {
              CustomDevDebugOperations.playAudio(devid, ref,
                  val: BeepModel.beep3);
            }
            StaticGameManager.addScorePoint(
                ref: ref, playerId: playerid, time: responsetime);
            StaticGameManager.increaseScore(ref: ref, playerId: playerid);
            await StaticGameManager.ledColor(
              devid,
              SidesColorsModel.all(gameSuccessColor),
              ref: ref,
            );
            return;
          }

          Future ledFailure(String devid, playerid, responsetime) async {
            StaticGameManager.addScorePoint(
                ref: ref, playerId: playerid, time: responsetime);
            StaticGameManager.decreaseScore(ref: ref, playerId: playerid);
            await StaticGameManager.ledColor(
              devid,
              SidesColorsModel.all(gameErrorColor),
              ref: ref,
            );
            return;
          }

          ref.read(gameScreenWidgetProv.notifier).state = gameScreenWidget;
          streamer = streamer.listen(onData: (event) async {
            final devId = event.deviceId;
            lastEvents[devId] = event;
            final playerid = devsMap.entries
                .firstWhere((element) => element.value.id == event.deviceId)
                .key;
            final dev = devMap[devId];
            final newDev = dev!.name.contains('V');
            gameModel = HoldSteadyGameModel.fromAcceleremetorGravityModel(
                    event.motion,
                    newDev: !newDev)
                .copyWith(radius: radius!.toDouble());
            {
              final dirs = gameModel!.directions;

              final isSameDirection = setEquals(lastDirections[devId], dirs);
              lastDirections[devId] = dirs;

              if (!isSameDirection && processMap[playerid]!) {
                if (gameModel!.isBottomLeft ||
                    gameModel!.isBottomRight ||
                    gameModel!.isTopLeft ||
                    gameModel!.isTopRight) {
                  processMap[playerid] = false;
                }
                var question = ref.read(currentQuestionProv);
                try {
                  await StaticGameManager.ledColor(
                    devId,
                    gameModel!.colorForQuiz,
                    ref: ref,
                  );

                  if (gameModel!.isBottomLeft) {
                    answeredMap[playerid] = true;
                    if (!newDev) {
                      if (question!.correctAnswer == 'D') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    } else {
                      if (question!.correctAnswer == 'C') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    }
                  } else if (gameModel!.isBottomRight) {
                    answeredMap[playerid] = true;
                    if (!newDev) {
                      if (question!.correctAnswer == 'B') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    } else {
                      if (question!.correctAnswer == 'D') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    }
                  } else if (gameModel!.isTopLeft) {
                    answeredMap[playerid] = true;
                    if (!newDev) {
                      if (question!.correctAnswer == 'C') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    } else {
                      if (question!.correctAnswer == 'A') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    }
                  } else if (gameModel!.isTopRight) {
                    answeredMap[playerid] = true;
                    if (!newDev) {
                      if (question!.correctAnswer == 'A') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    } else {
                      if (question!.correctAnswer == 'B') {
                        ledSuccess(devId, playerid, event.responseTime!);
                      } else {
                        ledFailure(devId, playerid, event.responseTime!);
                      }
                    }
                  } else {}
                } catch (e) {
                  streamer.cancel();
                  logger.e(e);
                }
              }
            }
          });

          await streamer.doneOr(() async =>
              ref.watch(isCurrentQuizdone) || ref.watch(gameEndingProvider));
          timer.cancel();
          await StaticGameManager.ledAllOffNoDelay(ref: ref);
          return;
        }

        await game.setup.executeGame(
          ref,
          round,
          shouldStop: (ref) async {
            return ref.watch(isCurrentQuizdone) ||
                ref.watch(gameEndingProvider);
          },
          disposeCb: (ref) async {
            ref.read(isCurrentQuizdone.notifier).reset();
            ref.read(currentQuestionProv.notifier).reset();
            return true;
          },
        );
      },
    );
  }

  static StaticGameModel korebePUBG(WidgetRef ref) {
    return StaticGameModel(
      id: '101',
      metaData: GameMetaDataModel(
        id: '101',
        name: "Körebe PUBG",
        description:
            "Ebenin gözlerini kapar ve dinlemeye başlar. Padlerin yaknından geçen oyuncular padteki buzzerı tetikler ve ebe oraya doğru yönlenip rakibini yakalamaya çalışır.\n- Her 10 saniyede padlerdeki görüş alanı 50 cm artar",
        imagePath: '15',
        playerCount: NumRange.playerCount(
          min: 1,
          max: 1,
        ),
        padCount: NumRange.padCount(
          min: 1,
          max: 12,
        ),
        duration: NumRange.duration(def: 90, min: 60, max: 120, step: 30),
        tag: GameTag.auditory,
        earnings: [
          GameEarning.auditory,
          GameEarning.visual,
        ],
        categories: {
          GameCategory.entertainment: 14,
        },
      ),
      setup: StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.none,
        sensorTypes: {
          UsedSensorsType.distance: true,
        },
        roundCount: 1,
        generalStagedPlayerModel: StagedPlayerModel.general(
            deviceCount: NumRange.count(min: 1, max: 1),
            colorCount: NumRange.count(min: 1, max: 1)),
        dstConfig: const DstConfigModel(timeout: 100, threshold: 150),
      ),
      execute: (ref, game) async {
        final players = ref.read(selectedPlayersPlayersProv);
        final setup = ref.read(currentGameSetupProv)!;

        bool selectedAnyColor = setup.generalStagedPlayerModel!.hasColors;

        if (selectedAnyColor) {
          if (setup.generalStagedPlayerModel!.defaultSelectedColors != null) {
            for (var color
                in setup.generalStagedPlayerModel!.defaultSelectedColors!) {
              debugPrint("Color:$color");
            }
          } else {
            debugPrint("Null");
          }
        }

        final devs = setup.getGameDevices(ref);

        Streamer<DistanceEvent>? streamerDst;
        var multiDistanceListener = StaticGameManager.listenToDistanceMulti(
            devs.map((e) => e.id),
            ref: ref);
        streamerDst = Streamer(multiDistanceListener);

        // ---------- ////////////|\\\\\\\\\\\ ---------- \\
        for (var device in devs) {
          await StaticGameManager.ledColor(
              device.id, SidesColorsModel.all(CpColors.success),
              ref: ref, isCommand: true);
        }

        int dynamicDistance = 0;

        Timer.periodic(const Duration(seconds: 10), (Timer timer) {
          dynamicDistance += 50;

          for (var device in devs) {
            Future.wait([
              CustomDevDebugOperations.playAudio(device.id, ref,
                  val: BeepModel.beep3),
              StaticGameManager.ledColor(
                      device.id, SidesColorsModel.all(CpColors.yellow),
                      ref: ref, isCommand: true)
                  .then((value) async {
                await Future.delayed(const Duration(milliseconds: 1500),
                    () async {
                  await StaticGameManager.ledColor(
                      device.id, SidesColorsModel.all(CpColors.success),
                      ref: ref, isCommand: true);
                });
              })
            ]);
          }
        });

        streamerDst.cancel();

        Future<void> round(WidgetRef ref) async {
          streamerDst!.listen(
            onData: (dstData) async {
              debugPrint(dynamicDistance.toString() +
                  dstData.distance.distance.toString());

              if (dstData.distance.distance <= dynamicDistance) {
                StaticGameManager.ledColor(
                        dstData.deviceId, SidesColorsModel.all(CpColors.error),
                        ref: ref, isCommand: true)
                    .then((value) {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    CustomDevDebugOperations.playAudio(dstData.deviceId, ref,
                            val: BeepModel.beep3)
                        .then((value) async {
                      await Future.delayed(const Duration(milliseconds: 1000),
                          () async {
                        await StaticGameManager.ledColor(dstData.deviceId,
                            SidesColorsModel.all(CpColors.success),
                            ref: ref, isCommand: true);
                      });
                    });
                  });
                });
              } else {
                await StaticGameManager.ledColor(
                    dstData.deviceId, SidesColorsModel.all(CpColors.success),
                    ref: ref, isCommand: true);
              }
            },
          );
        }

        await game.setup.executeGame(ref, round, disposeCb: (ref) async {
          streamerDst!.cancel();
          ref.read(gameScreenWidgetProv.notifier).state = null;
          StaticGameManager.ledAllOffNoDelay(ref: ref);
          return true;
        });
      },
    );
  }
}

// #region legacy

// /// https://app.clickup.com/t/2888g27
// Catch The : execute: (ref, game) async {
//   final players = ref.read(selectedPlayersPlayersProv);
//   final mainPlayer = players.first;
//   final clrs = mainPlayer.clrs;
//   final devs = mainPlayer.devs;

//   Future<void> round(WidgetRef ref) async {
//     devs.shuffle(Xrandom());
//     final shuffled = devs;
//     // shuffler.getRound(roundN);

//     // now we have the shuffled devices. first thing we wanna
//     // do is to make its length even
//     if (shuffled.length.isOdd) {
//       shuffled.removeLast();
//     }

//     clrs.shuffle(Xrandom());

//     // we're gonna split the list into 2 parts,
//     // leaving the last 2 devices in a separate list

//     // these devices will be the ones that will pair with each other
//     final List<DeviceModel> pairerDevices =
//         shuffled.sublist(0, shuffled.length - 2);

//     // these ones will be lone wolves
//     final List<DeviceModel> loneDevices =
//         shuffled.sublist(shuffled.length - 2);

//     final Map<Color, List<DeviceModel>> pairMap = {};
//     final Map<Color, List<DeviceModel>> loneMap = {};
//     Map<Color, List<DeviceModel>> allMap() => {
//           ...pairMap,
//           ...loneMap,
//         };

//     int colorIndex = 0;
//     // now we wanna group pairerDevices by color in a Color, List<DeviceModel> Map
//     for (var j = 0; j < pairerDevices.length; colorIndex++, j += 2,) {
//       final color = clrs[colorIndex];
//       final devicesForColor = pairerDevices.sublist(j, j + 2);

//       pairMap[color] = devicesForColor;
//     }

//     // and then assign a single color to each loneDevice, make sure to start
//     // from the last color, by using [colorIndex]
//     for (var j = 0; j < loneDevices.length; colorIndex++, j++) {
//       final color = clrs[colorIndex];
//       final device = loneDevices[j];

//       loneMap[color] = [device];
//     }

//     // now we wanna led the devices
//     for (final entry in allMap().entries) {
//       final color = entry.key;
//       final devices = entry.value;

//       for (final device in devices) {
//         StaticGameManager.ledColor(
//           device.id,
//           SidesColorsModel.all(color),
//           isCommand: true,
//           ref: ref,
//         );
//       }
//     }

//     final Set<String> touchedDevices = {};

//     final _allDevs = pairMap.values.expand((e) => e).map((e) => e.id);
//     // now we wanna listen to touches on the devices
//     await for (final event in StaticGameManager.listenToTouchMulti(
//       _allDevs,
//       ref: ref,
//     )) {
//       if (event.isValid) {
//         touchedDevices.add(event.deviceNameId);

//         final thisPair = pairMap.values.firstWhere((e) => e.any(
//             (element) => element.deviceNameId == event.deviceNameId));

//         // final thisDev = thisPair.firstWhere(
//         //     (element) => element.deviceNameId == event.deviceNameId);

//         final pairIdx = thisPair.indexWhere(
//             (element) => element.deviceNameId != event.deviceNameId);

//         if (pairIdx != -1) {
//           final pairDev = thisPair[pairIdx];

//           // if pair is touched, then we wanna turn both off
//           if (touchedDevices
//               .any((element) => element == pairDev.deviceNameId)) {
//             for (var element in thisPair) {
//               StaticGameManager.ledOff(
//                 element.id,
//                 ref: ref,
//               );
//             }
//           }
//         }
//       }

//       if (touchedDevices.length == _allDevs.length) {
//         break;
//       }
//     }

//     // now we wanna unled the devices
//     for (final dev in pairMap.values.expand((e) => e)) {
//       StaticGameManager.ledOff(
//         dev.id,
//         ref: ref,
//       );
//     }
//   }

//   await game.setup.executeGame(
//     ref,
//     (ref) async {
//       {
//         await round(ref);
//         try {
//           // remove 2 devices each round
//           devs.removeRange(0, 2);
//         } catch (e) {
//           logger.d('could not remove 2 devices each round', e);
//         }
//       }
//     },
//     shouldStop: ((ref) async => devs.length <= 2),
//   );
// }

// XOX: execute: (ref, game) async {
//   final mainPl = game.generalPlayer;

//   final devs = mainPl?.devs;

//   assert(devs != null && devs.isNotEmpty);

//   final players = ref.read(selectedPlayersPlayersProv);
//   // caught pads ids, keyed by player id
//   final caughtPads = <String, List<String>>{};

//   int i = 0;

//   PlayerModel? winner;

//   Future<void> round(WidgetRef ref) async {
//     final currentPlayer = players[i++ % 2];

//     await for (final event in StaticGameManager.listenToTouchMulti(
//       devs!.map((e) => e.id),
//       ref: ref,
//     )) {
//       caughtPads[currentPlayer.id] ??= [];
//       caughtPads[currentPlayer.id]!.add(event.deviceNameId);

//       await StaticGameManager.ledColor(
//         event.deviceId,
//         SidesColorsModel.all(currentPlayer.clrs[0]),
//         ref: ref,
//       );

//       // we're gonna have the pads 3 x 3 from 1 to 9
//       // so winning cases would be if a player has 3 in a row,
//       // 3 in a column, or 3 in a diagonal
//       final rows = [
//         [1, 2, 3],
//         [4, 5, 6],
//         [7, 8, 9],
//       ];

//       final cols = [
//         [1, 4, 7],
//         [2, 5, 8],
//         [3, 6, 9],
//       ];

//       final diags = [
//         [1, 5, 9],
//         [3, 5, 7],
//       ];

//       final all = [...rows, ...cols, ...diags];

//       for (var player in players) {
//         final caught = caughtPads[player.id] ?? [];

//         List<int>? winnerCombination;
//         final caughtAny = all.any(
//           (combination) {
//             final containsAll = combination.every(
//               (e) => caught.contains(e.toString()),
//             );

//             if (containsAll) {
//               winnerCombination = combination;
//             }

//             return containsAll;
//           },
//         );

//         // as we have a loop in a loop, we can't just break etc.
//         if (caughtAny) {
//           final winnerDevs = devs.where(
//             (element) =>
//                 element.deviceNameId != null &&
//                 winnerCombination!.contains(
//                   int.parse(element.deviceNameId!),
//                 ),
//           );
//           winner = player;

//           // here what we're doing is that we're blinking the winner pads
//           // for 3 times just for show, this adds not at all functionality.
//           final ftrs = winnerDevs.map((e) => StaticGameManager.ledColor(
//                 e.id,
//                 SidesColorsModel.all(winner!.clrs[0]),
//                 ref: ref,
//                 duration: const Duration(milliseconds: 500),
//               ));

//           for (var i = 0; i < 3; i++) {
//             await Future.wait(ftrs);

//             await Future.delayed(
//               const Duration(milliseconds: 500),
//             );
//           }
//           //

//           break;
//         }
//       }

//       break;
//     }
//   }

//   await game.setup.executeGame(
//     ref,
//     round,
//     shouldStop: (ref) async => winner != null,
//   );
// }

// /// https://app.clickup.com/t/29xc9ax
// Standing knee pull: execute: (ref, game) async {
//   final players = ref.read(selectedPlayersPlayersProv);
//   final mainPlayer = players.first;
//   final devices = mainPlayer.devs;
//   final mainDevice = devices[0];

//   await StaticGameManager.setAccTimeout(
//     deviceId: mainDevice.id,
//     ref: ref,
//     timeout: 15,
//   );

//   Future<void> round(WidgetRef ref) async {
//     await StaticGameManager.sendIsCommand(
//       mainDevice.id,
//       ref: ref,
//     );
//     await for (final event in StaticGameManager.listenToTouch(
//       mainDevice.id,
//       ref: ref,
//     )) {
//       if (event.isValid) {
//         StaticGameManager.addScorePoint(
//           ref: ref,
//           playerId: mainPlayer.id,
//           time: event.responseTime!,
//         );
//       }
//       break;
//     }
//   }

//   await game.setup.executeGame(ref, round);
// }

// #endregion
