import 'dart:async';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:catchpad/data/api/game_result_api.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/models/event/catchpad_event_result.dart';
import 'package:catchpad/models/game/game_model.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/hold_steady_prov.dart';
import 'package:catchpad/prov/leaderboard/leaderboard_result_prov.dart';
import 'package:catchpad/ui/game/setup_widgets/threshhold_value_setup_widget.dart';
import 'package:catchpad/ui/widgets/inputs/game_end_note_input.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:screenshot/screenshot.dart';
import 'package:streamer/streamer.dart';

import '../../../prov/game_result_prov.dart';
import '../../../utils/utils.dart';
import '../../catch_pad_icons_v2.dart';
import '../../models/bottom_bar_item.dart';
import '../../models/device/device_shuffler.dart';
import '../../models/game/static_game_model.dart';
import '../../prov/auth/current_user_prov.dart';
import '../../prov/cancel_stream_prov.dart';
import '../../prov/current_loading_error_prov.dart';
import '../../prov/end_game_prov.dart';
import '../../prov/game/curr_game_prov.dart';
import '../../prov/game/detail_game_prov.dart';
import '../../prov/game/game_curr_round_prov.dart';
import '../../prov/game/round_prov.dart';
import '../../prov/game/selected_players_prov.dart';
import '../../prov/global_providers.dart';
import '../../prov/quiz_provider.dart';
import '../../ui/game/game_screen.dart';
import '../../ui/game/widgets/game_final_score_widget.dart';
import '../../ui/widgets/cp_dialog.dart';
import '../../utils/cp_colors.dart';
import '../../utils/util_methods/util_methods.dart';
import '../../utils/widgets/error_snackbar.dart';
import '../static_game_manager.dart';
import '../static_games_list.dart';

typedef GameDialogFunction = Future<bool> Function({
  required BuildContext context,
  required WidgetRef ref,
});

abstract class GameManager {
  static Future<bool> showConnectedDevicesDialog({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final devs = DeviceShuffler.readDevices(ref);
    if (devs.isEmpty) {
      ErrorSnackbar(
        L10n.inst(context).activity_not_enough_devices,
        action: SnackBarAction(
          label: L10n.inst(context).activity_not_enough_devices_connect_to_pads,
          onPressed: () {
            ref
                .read(bottomBarProvider.notifier)
                .setBottomBarItem(BottomBarItemIndex.search.index, ref);

            Navigator.pop(context);

            //GoRouter.of(context).goNamed(RouteTable.rHomeScreen);
          },
        ),
      ).show(context);
      return false;
    }

    return true;
  }

  static Future<bool> resetEverythingAfterGameEnds(WidgetRef ref,
      List<DiscoveredDevice> devs, List<DiscoveredDevice> devsForLight) async {
    // if (!ref.context.mounted) return true;
    try {
      // logger.d("point0");
      ref.read(isCurrentQuizdone.notifier).reset();

      ref.read(currentQuestionProv.notifier).reset();
    } catch (e) {
      logger.d('Could not reset current question/quiz: $e');
    }

    ref.read(boolValueProvider.notifier).enableResetEverythingAfterGameEnds();

    // logger.d("point1");

    try {
      final ftrList = <Future>[];

      for (var dev in devs) {
        ftrList.add(PadSensorManager.deactivateAll(ref: ref, deviceId: dev.id));
        ftrList.add(PadManager.resetDeviceSettings(
          dev.id,
          ref: ref,
        ));
      }

      await Future.wait(ftrList);

      await Future.delayed(const Duration(milliseconds: 200));

      if (!ref.read(currentFinishControlManager)) {
        for (var i = 0; i < 3; i++) {
          final ftrs = [];
          for (var dev in devsForLight) {
            ftrs.add(() => PadManager.toggleLight(dev.id, ref: ref));
          }

          await Future.wait(ftrs.map((e) => e()));
          await Future.delayed(const Duration(milliseconds: 400));
          await StaticGameManager.ledAllOffNoDelay(ref: ref, devs: devsForLight)
              .then((value) {});
        }
      }
      ref.read(currentFinishControlManager.notifier).changState(false);

      await Future.delayed(const Duration(milliseconds: 100));
      final ftrToggle = <Future>[];
      for (var dev in devsForLight) {
        ftrToggle.add(PadManager.toggleInGame(dev.id, ref: ref, inGame: false));
        if (ref.read(currentGameSetupProv)!.vibrationActivate) {
          PadManager.toggleVibration(dev.id, ref: ref, vibrationOn: false);
        }
      }
      Future.wait(ftrToggle);
    } catch (e) {
      logger.e(e);
    }

    return true;
  }

  static Future showScoreDialog(
      BuildContext context,
      WidgetRef ref,
      StaticGameModel game,
      Map<String, int> resultsforgame,
      bool gonnapop) async {
    ref.read(currentShareController.notifier).disposeState(ref);
    TextEditingController controller = TextEditingController();

    ref
        .read(currentShareController.notifier)
        .initialize(ref, ScreenshotController());

    final screenShotController = ref.read(currentShareController);

    final inst = L10n.inst(context);

    final res = ref.read(gameResultProv);

    final isNewVersion = ref.read(currentNewVersionState);

    if (res == null) {
      final game = ref.read(currentGameProv);

      await game?.dispose(ref);

      ref.read(currentGameProv.notifier).reset(ref);

      ref.read(gameRoundProv.notifier).setDisabled();

      return;
    }
    final metadata = ref.read(currentGameMetaDataProv);

    final singlePlayerListingCb =
        metadata?.singlePlayerListing ?? res.defaultSinglePlayerListing;

    res.resultsMap(context, res.defaultSinglePlayerListing, ref);

    final resultsMap = res.resultsMap(context, singlePlayerListingCb, ref);

    if (resultsMap.isEmpty) {
      return;
    }

    saveToLastPlayedGames(game, ref);

    // for some reason this is being called during pop,
    // so we have to await until scheduled stuff is done
    // https: //stackoverflow.com/a/55622474/12555423
    //SchedulerBinding.instance.addPostFrameCallback(
    //(_) async {
    /*
    if (gonnapop) {
          Navigator.pop(context);
    }
        */

    bool response = false;
    if (ref.read(currentEmbModeManager) == 0) {
      await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => SafeArea(
              child: InkWell(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Consumer(
                  builder: (context, ref, child) {
                    final boolprovreset = ref
                        .watch(boolValueProvider)
                        .resetEverythingAfterGameEnds;
                    return Material(
                        child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(20),
                        color: CpColors.bgGC2,
                        child: SafeArea(
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(defPaddingSize),
                                child: Screenshot(
                                  controller: screenShotController,
                                  child: Container(
                                    color: CpColors.bgGC2,
                                    child: IntrinsicWidth(
                                      child: Column(children: [
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                icon: const Icon(Icons.cancel),
                                                onPressed: () async {
                                                  Navigator.pop(context);

                                                  FocusScope.of(context)
                                                      .unfocus();

                                                  final game =
                                                      ref.read(currentGameProv);
                                                  await game?.dispose(ref);

                                                  if (ref.read(
                                                          currentEmbModeManager) ==
                                                      0) {
                                                    await ref
                                                        .read(
                                                            currentPlayTraceManager
                                                                .notifier)
                                                        .changePlayTraceState(
                                                            PlayTraceStates
                                                                .idle,
                                                            ref);
                                                    ref
                                                        .read(
                                                            currentPlayTraceManager
                                                                .notifier)
                                                        .initializePlayTrace(
                                                            ref);
                                                  }

                                                  /* ref
                                                            .read(
                                                                currentGameProv.notifier)
                                                            .reset(ref); */
                                                  ref
                                                      .read(gameRoundProv
                                                          .notifier)
                                                      .setDisabled();
                                                  ref
                                                      .read(
                                                          currentFirstActionTimeManager
                                                              .notifier)
                                                      .cancelAndClear();
                                                })),
                                        GameFinalScoreWidget(
                                          resultsMap: resultsMap,
                                          resultsforgame: resultsforgame,
                                        ),
                                        GameEndNoteInput(
                                          controller: controller,
                                        ),
                                        const SizedBox(
                                          height: defPaddingSize,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    fixedSize: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.2,
                                                        defPaddingSize * 3),
                                                    backgroundColor:
                                                        const Color(0xFF30374F),
                                                    disabledForegroundColor:
                                                        const Color(0xFF30374F)
                                                            .withOpacity(0.38),
                                                    disabledBackgroundColor:
                                                        const Color(0xFF30374F)
                                                            .withOpacity(0.12),
                                                    shadowColor:
                                                        const Color(0xFF30374F),
                                                    //make color or elevated button transparent
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    GoRouter.of(context).pop();
                                                  },
                                                  child: Text(inst
                                                      .game_ui_go_back_to_the_games)),
                                            ),
                                            Flexible(
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Color(0xFF12A8E8),
                                                          Color(0xFF2359E3),
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    boxShadow: const <BoxShadow>[
                                                      BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.57),
                                                          //shadow for button
                                                          blurRadius: 5)
                                                      //blur radius of shadow
                                                    ]),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      fixedSize: Size(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.2,
                                                          defPaddingSize * 3),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      disabledForegroundColor:
                                                          Colors.transparent
                                                              .withOpacity(
                                                                  0.38),
                                                      disabledBackgroundColor:
                                                          Colors.transparent
                                                              .withOpacity(
                                                                  0.12),
                                                      shadowColor:
                                                          Colors.transparent,
                                                      //make color or elevated button transparent
                                                    ),
                                                    onPressed: () async {
                                                      if (boolprovreset) {
                                                        Navigator.pop(context);

                                                        ref
                                                            .read(
                                                                currentResultTraceManager
                                                                    .notifier)
                                                            .againButtonTrigger(
                                                                ref);

                                                        ref
                                                            .read(
                                                                currentPlayTraceManager
                                                                    .notifier)
                                                            .initializePlayTrace(
                                                                ref);

                                                        ref
                                                            .read(
                                                                currentFirstActionTimeManager
                                                                    .notifier)
                                                            .cancelAndClear();

                                                        response = true;

                                                        ref
                                                            .read(
                                                                currentPlayTraceManager
                                                                    .notifier)
                                                            .changePlayTraceState(
                                                                PlayTraceStates
                                                                    .game,
                                                                ref);

                                                        /* ref
                                                          .read(
                                                              currentPlayTraceManager
                                                                  .notifier).againButtonInitializePlayTrace(ref);*/

                                                        /* final setup = ref.watch(
                                                              currentGameSetupProv)!;
                                                          final allOptionsSelected =
                                                              setup
                                                                  .allOptionsSelected(
                                                                      ref);
                                                          if (!allOptionsSelected) {
                                                            return null;
                                                          }
                                                          return () async {
                                                            isManuallyChanged = true;
                                                            await GameManager
                                                                .pushGame(
                                                                    context: context,
                                                                    ref: ref,
                                                                    gonnapop: true);
                                                            return;
                                                          }; */
                                                      }
                                                    },
                                                    child: Text(
                                                        inst.game_ui_restart)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: defPaddingSize,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                              gradient:
                                                  const LinearGradient(colors: [
                                                CpColors.bgGC2,
                                                CpColors.bottomBarColor,
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: const <BoxShadow>[
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.57),
                                                    //shadow for button
                                                    blurRadius: 5)
                                                //blur radius of shadow
                                              ]),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.2,
                                                    defPaddingSize * 3),
                                                backgroundColor:
                                                    Colors.transparent,
                                                disabledForegroundColor: Colors
                                                    .transparent
                                                    .withOpacity(0.38),
                                                disabledBackgroundColor: Colors
                                                    .transparent
                                                    .withOpacity(0.12),
                                                shadowColor: Colors.transparent,
                                                //make color or elevated button transparent
                                              ),
                                              onPressed: () =>
                                                  CatchPadFeedBackDialog
                                                      .feedBackDialogAboutGame(
                                                          game.id, ref),
                                              child: Text(inst.game_feed_back)),
                                        ),
                                        const SizedBox(
                                          height: defPaddingSize,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: const <BoxShadow>[
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.57),
                                                    //shadow for button
                                                    blurRadius: 1)
                                                //blur radius of shadow
                                              ]),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.2,
                                                    defPaddingSize * 3),
                                                backgroundColor:
                                                    Colors.transparent,
                                                disabledForegroundColor: Colors
                                                    .transparent
                                                    .withOpacity(0.38),
                                                disabledBackgroundColor: Colors
                                                    .transparent
                                                    .withOpacity(0.12),
                                                shadowColor: Colors.transparent,
                                                //make color or elevated button transparent
                                              ),
                                              onPressed: () async {
                                                ref
                                                    .watch(
                                                        currentShareController
                                                            .notifier)
                                                    .captureCurrentResultAndFillCurrentFile(
                                                        ref, ref.context);
                                              },
                                              child: const Icon(Icons.share)),
                                        ),
                                        const SizedBox(
                                          height: defPaddingSize,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  boxShadow: const <BoxShadow>[
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.57),
                                                        //shadow for button
                                                        blurRadius: 1)
                                                    //blur radius of shadow
                                                  ]),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    disabledForegroundColor:
                                                        Colors.transparent
                                                            .withOpacity(0.38),
                                                    disabledBackgroundColor:
                                                        Colors.transparent
                                                            .withOpacity(0.12),
                                                    shadowColor:
                                                        Colors.transparent,
                                                    //make color or elevated button transparent
                                                  ),
                                                  onPressed: () async {
                                                    ref
                                                        .read(
                                                            currentShareController
                                                                .notifier)
                                                        .createPdf(
                                                            ref, resultsMap,
                                                            reviewText:
                                                                controller
                                                                    .text);
                                                  },
                                                  child: const Icon(
                                                      Icons.picture_as_pdf)),
                                            ),
                                            Gap(2.h),
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  boxShadow: const <BoxShadow>[
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.57),
                                                        //shadow for button
                                                        blurRadius: 1)
                                                    //blur radius of shadow
                                                  ]),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    disabledForegroundColor:
                                                        Colors.transparent
                                                            .withOpacity(0.38),
                                                    disabledBackgroundColor:
                                                        Colors.transparent
                                                            .withOpacity(0.12),
                                                    shadowColor:
                                                        Colors.transparent,
                                                    //make color or elevated button transparent
                                                  ),
                                                  onPressed: () async {
                                                    ref
                                                        .read(
                                                            currentShareController
                                                                .notifier)
                                                        .createExcel(
                                                            ref, resultsMap,
                                                            reviewText:
                                                                controller
                                                                    .text);
                                                  },
                                                  child: CatchpadIconsV2.excel
                                                      .copyWith(
                                                          iconColor:
                                                              Colors.white,
                                                          width: 5.w,
                                                          height: 5.w,
                                                          customBoxFit:
                                                              BoxFit.cover)),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  },
                ),
              ),
            ),
          );
        },
      );
      if (response) {
        //
        final setup = ref.watch(currentGameSetupProv)!;
        final allOptionsSelected = setup.allOptionsSelected(ref);
        if (allOptionsSelected) {
          isManuallyChanged = true;
          try {
            await GameManager.pushGame(
                context: context, ref: ref, gonnapop: true);
          } catch (e) {
            FirebaseCollectionEnums.logs.reference
                .doc("loading_state")
                .set({"errorText": e.toString()});
            EasyLoading.dismiss();
            final conDevs =
                ref.read(bleConenctionStateProv).value?.keys.toList();
            GameManager.resetEverythingAfterGameEnds(ref, conDevs ?? [], []);
          }

          return;
        }
      }
    } else {
      ref
          .read(currentIgaPageManager.notifier)
          .changState(IGAStates.result, ref: ref);
    }

    //},
    //);
  }

  static Future<void> pushGame(
      {required BuildContext context,
      required WidgetRef ref,
      bool gonnapop = false}) async {
    //is this iga tablet
    if (ref.read(currentEmbModeManager) == 1) {
      // circularShowWithReportIssue(
      //     ref, () => initializeErrorHandelEasyLoadingShow(ref));

      ref.read(currentSafeInGameToggleState.notifier).changState(true, ref);
      ref.read(forceEndProvider.notifier).changState(false);
      ref.read(playerHoldStateControlProvider.notifier).clear(ref);
      await ref.read(currentGameProv.notifier).init(ref);

      final selectedPlayersSet = ref.read(selectedPlayersProv);

      var selectedPlayers = selectedPlayersSet.map((e) => e.player).toList();

      final generalPlayer = ref.read(selectedGeneralPlayerProv)?.player;

      final inst = L10n.inst(context);

      for (var player in selectedPlayers) {
        if (player.user != null && player.user!.userName.isEmpty) {
          player.user?.userName =
              '${selectedPlayers.indexOf(player)}. ${inst.player}';
        }
      }

      final g = ref.read(currentGameProv);

      ref.read(currentIgaLeaderboardManager.notifier).changeState(ref, g!.id);

      final gm = g!.copy();

      gm.players = selectedPlayers;

      gm.generalPlayer = generalPlayer;

      ref.read(currentGameProv.notifier).setState(gm);

      ref.read(gameResultProv.notifier).setPlayers(gm.players);

      EasyLoading.dismiss();

      final deviceIdList =
          g.setup.getGameDevicesForConfig(ref).map((e) => e.id).toList();
      final ftr = <Future>[];

      for (var dev in deviceIdList) {
        ftr.add(PadManager.toggleInGame(dev, ref: ref, inGame: true));
      }
      Future.wait(ftr);

      ref.read(currentEffectConditionManager.notifier).setGameScoreType(
          ref.read(currentGameProv)!.id,
          ref.read(currentGameProv)!.setup.gameScoreTypes);

      logger.d("Start Game");

      // ref.read(currentIgaPageManager.notifier).changState(IGAStates.inGame, ref: ref);

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GameScreen()),
      );

      logger.d("End Game!");

      await resetEverythingAfterGameEnds(
              ref, ref.watch(bleConPr).keys.toList(), gm.allDevices)
          .timeout(const Duration(seconds: 4));

      ref
          .read(currentIgaPageManager.notifier)
          .changState(IGAStates.result, ref: ref);

      if (ref.read(gameResultProv)!.playerResults.isEmpty ||
          ref
              .read(gameResultProv)!
              .playerResults
              .any((playerRes) => playerRes.score == 0)) {
        ref.read(detailGameProv.notifier).setState(
            ref.watch(currentIgaPlayerModeManager) ==
                    IGAPlayerModes.singlePlayer
                ? StaticGamesList.formula(ref)
                : StaticGamesList.formulaYarisiSecond(ref));
        ref
            .read(currentIgaPageManager.notifier)
            .changState(IGAStates.onBoardingFour, ref: ref);
      } else {
        ref
            .read(currentIgaPageManager.notifier)
            .changState(IGAStates.result, ref: ref);
      }

      final Map<String, int> scorers = {};

      final devs = ref.watch(bleConPr).keys.toList();
      // DeviceShuffler.readDevices(ref);

      // circularShowWithReportIssue(ref, () => gameEndErrorHandlingError(ref));

      try {
        if (ref.context.mounted) {
          await StaticGameManager.ledAllOffNoDelay(
                  ref: ref, devs: gm.allDevices)
              .timeout(const Duration(seconds: 4));
          if (ref.read(catchPadEventManager) != null &&
              g.id == ref.read(catchPadEventManager)!.eventGameId &&
              ref.read(catchpadEventCompetitorManager) != null &&
              ref.read(currentPlayTraceManager)?.gameTrace!.isEnterToResult ==
                  true) {
            final catchpadEventResult = CatchpadEventResult(
                eventId: ref.read(catchPadEventManager)!.eventId,
                gameId: g.id,
                userId: ref.read(catchpadEventCompetitorManager)!.email,
                userFullName:
                    ref.read(catchpadEventCompetitorManager)!.username,
                userPrimaryScore: ref
                        .read(gameResultProv)!
                        .playerResults
                        .first
                        .averageDuration!
                        .inMilliseconds
                        .toDouble() *
                    0.001,
                userSecondaryScore:
                    ref.read(gameResultProv)!.playerResults.first.correctCount);

            ref
                .read(catchPadEventManager.notifier)
                .addResultUser(ref, result: catchpadEventResult);
          }

          await StaticGameManager.ledAllOffNoDelay(
                  ref: ref, devs: gm.allDevices)
              .timeout(const Duration(seconds: 4));
        }
      } catch (e) {
        logger.e("Error:", e);
      } finally {
        EasyLoading.dismiss();
      }
      if (ref.context.mounted) {
        ref.read(currentEffectConditionManager.notifier).setGameFree();
        ref
            .read(buzzerManagerProvider.notifier)
            .changeBuzzerStatus(ref, customValue: false);
      }

      if (!ref.read(forceEndProvider)) {
        if (ref.read(gameResultProv)!.playerResults.isEmpty ||
            ref.read(gameResultProv)!.playerResults.first.correctCount == 0) {
          ref.read(detailGameProv.notifier).setState(
              ref.watch(currentIgaPlayerModeManager) ==
                      IGAPlayerModes.singlePlayer
                  ? StaticGamesList.formula(ref)
                  : StaticGamesList.formulaYarisiSecond(ref));
          ref
              .read(currentIgaPageManager.notifier)
              .changState(IGAStates.onBoardingFour, ref: ref);
          return;
        } else {
          ref
              .read(currentIgaLeaderboardManager.notifier)
              .changeState(ref, g.id);
          ref
              .read(currentIgaPageManager.notifier)
              .changState(IGAStates.result, ref: ref);

          await showScoreDialog(context, ref, g, scorers, gonnapop);
        }
        await StaticGameManager.ledAllOffNoDelay(ref: ref, devs: gm.allDevices)
            .timeout(const Duration(seconds: 4));
        return;
      }

      ref.read(currentSafeInGameToggleState.notifier).changState(false, ref);
    } else {
      logger.i("Start Game");
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      ref
          .read(currentSafeInGameToggleState.notifier)
          .changState(true, ref)
          .timeout(const Duration(milliseconds: 10), onTimeout: () {
        FirebaseCollectionEnums.custom_errors.reference.add(
            {
              "error": "Timeout(Waiting 10 ms) currentSafeInGameToggleState start game",
              "time": DateTime.now().toIso8601String(),
              "user" : user?.email,
            }
        );
      });

      ref.read(forceEndProvider.notifier).changState(false);
      ref.read(playerHoldStateControlProvider.notifier).clear(ref);
      ref.read(gameScreenWidgetProv.notifier).state = null;



      if (user == null && ref.read(currentEmbModeManager) == 0) {
        final res = await showOkCancelAlertDialog(
          context: context,
          title: L10n.inst(context).login_required,
          message: L10n.inst(context).login_required_for_activity,
          okLabel: L10n.inst(context).login_required_continue,
          cancelLabel: L10n.inst(context).cancel,
        );

        if (res == OkCancelResult.ok) {
          ref.read(currentUserProv.notifier).logOut(ref);
        }

        return;
      }

      ref.read(currentEasyLoadingBreakPoints.notifier).refresh();
      ref.read(currentGameInitializeBreakPoints.notifier).refresh();

      // var breakPoints = ref.read(currentEasyLoadingBreakPoints);

      // circularShowWithReportIssue(
      //     ref, () => initializeErrorHandelEasyLoadingShow(ref));

      // if the data is valid, we wanna set the players to the game
      // This func does set current sensors,current players and current game type

      await ref.read(currentGameProv.notifier).init(ref).timeout(
        const Duration(seconds: 2),
        onTimeout: (){
          FirebaseCollectionEnums.custom_errors.reference.add(
              {
                "error": "Timeout(Waiting 2 sec) init game",
                "time": DateTime.now().toIso8601String(),
                "user" : user?.email,
              }
          );
        }
      );

      final selectedPlayersSet = ref.read(selectedPlayersProv);
      var selectedPlayers = selectedPlayersSet.map((e) => e.player).toList();
      final generalPlayer = ref.read(selectedGeneralPlayerProv)?.player;
      final inst = L10n.inst(context);
      for (var player in selectedPlayers) {
        if (player.user!.userName.isEmpty) {
          player.user!.userName =
              '${selectedPlayers.indexOf(player)}. ${inst.player}';
        }
      }
      final g = ref.read(currentGameProv);
      final gm = g!.copy();
      gm.players = selectedPlayers;
      gm.generalPlayer = generalPlayer;
      /* final devs = [
      ...g.players.expand((element) => element.devs),
      if (generalPlayer != null) ...generalPlayer.devs
    ]; */
      ref.read(currentGameProv.notifier).setState(gm);
      ref.read(gameResultProv.notifier).setPlayers(gm.players);
      EasyLoading.dismiss();

      // GoRouter.of(context).pushNamed(RouteTable.rGameScreen);

      final resQuery = GameResultApi.instance.resultsForGame(
          g.id,
          ref.read(currentUserProv)!.uid!,
          ref.read(appSettingsToggleProvider).enableLeaderboardViewer);

      late QuerySnapshot<Map<String, dynamic>> query;

      final deviceIdList =
          g.setup.getGameDevicesForConfig(ref).map((e) => e.id).toList();

      final ftr = <Future>[];

      for (var dev in deviceIdList) {
        ftr.add(PadManager.toggleInGame(dev, ref: ref, inGame: true));
      }

      Future.wait(ftr).timeout(
        const Duration(seconds: 2),
        onTimeout: () async {
          logger.e("Timeout(Waiting 2 sec) toggleInGame on all pads");
          FirebaseCollectionEnums.custom_errors.reference.add(
            {
              "error": "Timeout(Waiting 2 sec) toggleInGame on all pads",
              "time": DateTime.now().toIso8601String(),
              "user" : user?.email,
            }
          );
          return [];
        }
      );

      bool showBatteryWarning = false;

      var cancelPushGame = false;

      for (var deviceId in deviceIdList) {
        final padBattery = await PadManager.readBattery(deviceId, ref: ref)
            .timeout(const Duration(seconds: 1));
        if (padBattery != null && padBattery.percentage < 10) {
          showBatteryWarning = true;
        }
      }

      if (showBatteryWarning) {
        await AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            dismissOnTouchOutside: false,
            animType: AnimType.bottomSlide,
            title:
                L10n.inst(context).game_ui_dialog_title_anypad_battery_warning,
            desc: L10n.inst(context).game_ui_dialog_desc_anypad_battery_warning,
            btnOkOnPress: () => cancelPushGame = false,
            btnOkText: L10n.inst(context).form_continue,
            btnCancelText: L10n.inst(context).form_cancel,
            btnCancelOnPress: () => cancelPushGame = true).show();
      }

      if (cancelPushGame) {
        return;
      }

      final phoneBattery = Battery();

      int batteryLevel = await phoneBattery.batteryLevel;

      if (batteryLevel < 10) {
        await AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            title:
                L10n.inst(context).game_ui_dialog_title_phone_battery_warning,
            desc: L10n.inst(context).game_ui_dialog_desc_phone_battery_warning,
            btnOkOnPress: () => cancelPushGame = false,
            btnOkText: L10n.inst(context).form_continue,
            btnCancelText: L10n.inst(context).form_cancel,
            btnCancelOnPress: () => cancelPushGame = true).show();
      }

      if (cancelPushGame) {
        return;
      }
      ref.read(currentAutoDisposeTimerManager.notifier).changeAtGame(true);
      ref.read(currentEffectConditionManager.notifier).setGameScoreType(
          ref.read(currentGameProv)!.id,
          ref.read(currentGameProv)!.setup.gameScoreTypes);

      Future.wait([
        resQuery.get(),
      ])
          .then((values) => values.forEach((element) {
                query = element;
              }))
          .timeout(const Duration(seconds: 5), onTimeout: () {
        FirebaseCollectionEnums.custom_errors.reference.add(
            {
              "error": "Timeout(Waiting 5 sec) get results for game",
              "time": DateTime.now().toIso8601String(),
              "user" : user?.email,
            }
        );
        return null;
      });

      logger.d("Start Game2");
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GameScreen()),
      );
      // logger.d("End Game2");
      gameChronometer.stop();

      // Future(() {
      //   ref.read(gameEndingProvider.notifier).chronometerStop();
      // });

      final Map<String, int> scorers = {};

      var connectivityResult = await (Connectivity().checkConnectivity())
          .timeout(const Duration(milliseconds: 400));

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi &&
              query.docs.isNotEmpty) {
        try {
          final docs = query.docs;
          final res = ref
              .read(leaderBoardResultProv.notifier)
              .resultsFromDocs(docs, g.id);

          for (var r in res) {
            if (r.indexValue != null) {
              final playerid = r.playerResults.first.playerId;

              final placementModel =
                  r.players.firstWhere((plyr) => plyr.id == playerid);

              scorers.addAll({
                placementModel.user?.userName ??
                    (r.players.first.user != null
                        ? r.players.first.user!.userName
                        : "PlayerXX"): r.indexValue!
              });
            }
          }
        } catch (e) {
          logger.e("Error: $e");
        }
      }
      // logger.d("End Game3");

      final devs = DeviceShuffler.readDevices(ref);

      ref
          .read(currentPlayTraceManager.notifier)
          .changePlayTraceState(PlayTraceStates.result, ref);
      // logger.d("End Game4");

      final breakProv = ref.watch(endGameBreakPoints.notifier);
      // circularShowWithReportIssue(ref, () => gameEndErrorHandlingError(ref));

      try {
        // logger.i("FORMULA!!");
        if (ref.context.mounted) {
          await resetEverythingAfterGameEnds(ref, devs, gm.allDevices)
              .timeout(const Duration(seconds: 4));

          if (ref.read(catchPadEventManager) != null &&
              g.id == ref.read(catchPadEventManager)!.eventGameId &&
              ref.read(catchpadEventCompetitorManager) != null &&
              ref.read(currentPlayTraceManager)?.gameTrace!.isEnterToResult ==
                  true) {
            final catchpadEventResult = CatchpadEventResult(
                eventId: ref.read(catchPadEventManager)!.eventId,
                gameId: g.id,
                userId: ref.read(catchpadEventCompetitorManager)!.email,
                userFullName:
                    ref.read(catchpadEventCompetitorManager)!.username,
                userPrimaryScore: ref
                        .read(gameResultProv)!
                        .playerResults
                        .first
                        .averageDuration!
                        .inMilliseconds
                        .toDouble() *
                    0.001,
                userSecondaryScore:
                    ref.read(gameResultProv)!.playerResults.first.correctCount);

            ref
                .read(catchPadEventManager.notifier)
                .addResultUser(ref, result: catchpadEventResult);
          }

          await StaticGameManager.ledAllOffNoDelay(
                  ref: ref, devs: gm.allDevices)
              .timeout(const Duration(seconds: 4));
        }
      } catch (e) {
        logger.e("Error:", e);
      } finally {
        EasyLoading.dismiss();
      }
      logger.i(ref.read(forceEndProvider));
      if (!ref.read(forceEndProvider)) {
        await showScoreDialog(context, ref, g, scorers, gonnapop);
      }

      ref.read(currentPeriodicallyQueueManager.notifier).changState({});

      ref.read(currentPeriodColorQueueManager.notifier).changeState({});

      ref.read(currentEffectConditionManager.notifier).setGameFree();

      ref.read(currentAutoDisposeTimerManager.notifier).changeAtGame(false);

      ref
          .read(buzzerManagerProvider.notifier)
          .changeBuzzerStatus(ref, customValue: false);

      ref.read(currentSafeInGameToggleState.notifier).changState(false, ref);

      return;
    }
  }

  static Future<void> circularShowWithReportIssue(
      WidgetRef ref, Function? onPressed) {
    return EasyLoading.show(
        indicator: Column(
      children: [
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        TextButton(
            onPressed: () async => onPressed != null ? onPressed() : {},
            child: Text(
              L10n.inst(ref.context).report_an_issue,
              style: Theme.of(ref.context).textTheme.bodyMedium,
            )),
      ],
    ));
  }

  static Future<void> initializeErrorHandelEasyLoadingShow(
      WidgetRef ref) async {
    final map = ref.watch(currentEasyLoadingBreakPoints);
    final gameInitialize = ref.watch(currentGameInitializeBreakPoints);

    map.addAll(gameInitialize);

    await FirebaseCollectionEnums.logs.reference
        .doc("loading_crash")
        .collection(ref.read(currentMetaTraceManager)?.phoneModel.toString() ??
            "unknownPhoneModel")
        .doc(DateTime.now().toString())
        .set(map);

    EasyLoading.dismiss(animation: false);
  }

  static Future<void> gameEndErrorHandlingError(WidgetRef ref) async {
    final map = ref.watch(endGameBreakPoints);
    logger.e("Game End Error Handling Error");
    await FirebaseCollectionEnums.logs.reference
        .doc("loading_crash")
        .collection(ref.read(currentMetaTraceManager)?.phoneModel.toString() ??
            "unknownPhoneModel")
        .doc(DateTime.now().toString())
        .set(map);

    EasyLoading.dismiss(animation: false);
  }

  /// write what u wanna do during countdown
  static Future<void> countDownAction(WidgetRef ref) async {
    final devs = DeviceShuffler.readDevices(ref);

    const baseClr = CpColors.cpSidesColorsModel;
    // this will led them together, so first yellow,
    // then red will be added, then blue will be added
    // and finally green will be added at that moment
    // the 4 colors will be led together. if you want
    // to change this, and make only one led at the time,
    // use [SidesColorsModel.off().copyWith()] as a
    // constructor
    final colors = [
      SidesColorsModel(tr: baseClr.tr),
      SidesColorsModel(tl: baseClr.br),
      SidesColorsModel(br: baseClr.bl),
      SidesColorsModel(bl: baseClr.tl),
    ];
    int i = 0;

    final sender = SendStreamer();

    Timer.periodic(
      // our current [gameCountDownDuration] is 3 seconds
      // we dont want the app to led a color each .75 second
      // because that is a future and will not execute right
      // away, so we put a margin, and divide with 4.5, so
      // each led will take .66 seconds to turn on, which they
      // all add up to about 3 seconds, leaving us a .36 second
      // margin.
      gameCountDownDuration / 4.5,
      (timer) async {
        final clr = colors[i++];
        sender.add(
          () async {
            final ftrs = <Future<bool>>[];
            for (final dev in devs) {
              ftrs.add(
                PadManager.ledColor(
                  dev.id,
                  clr,
                  ref: ref,
                ),
              );
            }

            await Future.wait(ftrs);
          },
        );

        if (i == colors.length) {
          timer.cancel();
        }
      },
    );
  }

  static Future<void> playForDuration({
    required WidgetRef ref,
    required Future Function(WidgetRef ref) cb,
    required Future<bool> Function(WidgetRef ref)? additionalStopCondition,
    required Future<bool?> Function(WidgetRef ref) disposeCb,
  }) async {
    // for [gameDuration], do [round]
    bool isRunning = true;

    final duration = ref.read(gameDurationCountProv);
    Timer(duration, () {
      isRunning = false;
    });

    whileCondition(WidgetRef ref) async {
      bool ret = true;

      if (additionalStopCondition != null) {
        ret = ret && !await additionalStopCondition(ref);
      }

      ret = ret && isRunning;

      return ret;
    }

    bool cbIsRunning = false;

    await Future.doWhile(
      () async {
        await Future.delayed(Duration.zero);

        if (!await whileCondition(ref) || ref.watch(gameEndingProvider)) {
          await disposeCb.call(ref);
          return false;
        }

        if (!cbIsRunning) {
          cbIsRunning = true;
          cb(ref).then(
            (value) {
              cbIsRunning = false;
            },
          );
        }

        return true;
      },
    );
  }

  static bool isRoundCountOver(WidgetRef ref) =>
      ref.read(gameLeftRoundCountProv) <= 0;

  static Future<void> playForRoundCount({
    required WidgetRef ref,
    required Future Function(WidgetRef ref) cb,
    required Future<bool> Function(WidgetRef ref)? additionalStopCondition,
    // TODO: process disposeCb (see how from playForDuration).
    required Future<bool?> Function(WidgetRef ref) disposeCb,
  }) async {
    whileCondition(WidgetRef ref) async {
      bool ret = true;

      if (additionalStopCondition != null) {
        ret = ret && !await additionalStopCondition(ref);
      }

      ret = ret && !isRoundCountOver(ref);

      return (ret);
    }

    while (await whileCondition(ref)) {
      await cb(ref);
    }
  }

  static Future<void> playWhile({
    required WidgetRef ref,
    required Future Function(WidgetRef ref) cb,
    required Future<bool> Function(WidgetRef ref) shouldStop,
    required Future<bool> Function(WidgetRef ref)? additionalStopCondition,
    // TODO: process disposeCb (see how from playForDuration).
    required Future<bool?> Function(WidgetRef ref) disposeCb,
  }) async {
    final stop = ref.watch(gameEndingProvider);

    ref.read(currentDevicesManagerProvider).keys.forEach((deviceId) {
      ref
          .read(currentAutoDisposeTimerManager.notifier)
          .restartTimer(deviceId, ref);
    });

    label:
    while (!(await shouldStop(ref))) {
      //TODO Fix ending prov
      // to not block main thread
      await Future.delayed(Duration.zero);
      await cb(ref);
    }
  }
}
