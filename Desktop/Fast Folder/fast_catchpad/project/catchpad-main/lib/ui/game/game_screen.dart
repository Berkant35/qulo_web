import 'dart:async';

import 'package:catchpad/managers/cp_audio_player.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/ui/emb/iga/game/iga_game_screen.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/enums/background_enums.dart';
import 'package:catchpad/utils/widgets/cp_counter.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:loading/loading.dart';
import 'package:logger/logger.dart' as lgr;
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data/api/game_result_api.dart';
import '../../prov/end_game_prov.dart';
import '../../prov/game/curr_game_prov.dart';
import '../../prov/game/round_prov.dart';
import '../../prov/game_result_prov.dart';
import '../../prov/global_providers.dart';
import '../../utils/emb/iga/iga_enums.dart';
import '../../utils/util_methods/util_methods.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/cp_headline_with_icon.dart';
import '../widgets/countdown.dart';
import '../widgets/default_bg.dart';
import 'widgets/in_game_score_widget.dart';
import 'widgets/in_game_score_widgets/game_leave_button_widget.dart';
import 'widgets/in_game_score_widgets/game_stop_play_btn.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(currentDevicesManagerProvider).keys.forEach((deviceId) {
      ref
          .read(currentAutoDisposeTimerManager.notifier)
          .restartTimer(deviceId, ref);
    });

    final audioPlayer = ref.read(cpAudioPlayerProv);
    final toggleprov = ref.read(appSettingsToggleProvider);

    if (ref.read(currentEmbModeManager) == 1) audioPlayer.playCountDown();

    if (toggleprov.enableTriggerSound) {
      audioPlayer.triggerStart(context);
    }

    return WillPopScope(
      onWillPop: () async {
        // prevent back button to leave only leave game button works for popping
        return false;
      },
      child: Scaffold(
        appBar: ref.read(currentNewVersionState)
            ? null
            : PreferredSize(
                preferredSize: Size.zero,
                child: Container(),
              ),
        resizeToAvoidBottomInset: false,
        body: const _GCountDown(),
        floatingActionButton:
            ref.watch(appSettingsToggleProvider).enableShowGameLog
                ? FloatingActionButton.small(
                    onPressed: () {
                      //LogConsole.wrap(innerOutput: ConsoleOutput());
                      //LogConsole.openLogConsole(context);
                    },
                  )
                : null,
      ),
    );
  }
}

class _GCountDown extends ConsumerStatefulWidget {
  const _GCountDown({super.key});

  @override
  ConsumerState<_GCountDown> createState() => _GCountDownState();
}

class _GCountDownState extends ConsumerState<_GCountDown> {
  bool isPopping = false;

  Future<bool> onWillPop(context) async {
    if (isPopping) {
      return false;
    }
    EasyLoading.show();
    isPopping = true;
    final game = ref.read(currentGameProv);
    await game?.dispose(ref);
    ref.read(gameRoundProv.notifier).setDisabled();
    final result = ref.read(gameResultProv);

    //logger.i("CC Result: ${result?.toJson()}");

    if (result != null &&
            ref
                .watch(appSettingsToggleProvider)
                .enableAddingToFirestore /* &&
        result.winnerPlayer != null */
        ) {
      try {
        if (ref.read(currentEmbModeManager) == 1) {
          EasyLoading.dismiss();
          return true;
        }
        await GameResultApi.instance.addToFirestore(result, ref);
      } catch (e) {
        logger.d(
            'RESULT IS NOT ADDED TO THE FIRESTORE WITH ADD TO FIRESTORE METHOD $e');
      }
    } else {
      logger.d('RESULT NOT ADDED DUE TO UNREGISTERED USERNAME REASON');
    }
    EasyLoading.dismiss();
    return true;
  }

  @override
  void initState() {
    super.initState();
    // GameManager.countDownAction(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Loading(
      child: WillPopScope(
        onWillPop: () async {
          return await onWillPop(context);
        },
        child: Padding(
          padding: ref.read(currentEmbModeManager) == 1 ||
                  ref.read(currentNewVersionState)
              ? EdgeInsets.zero
              : const EdgeInsets.all(defPaddingSize),
          child: CountdownFormatted(
            duration: gameCountDownDuration,
            builder: (context, rem, finished) {
              return _GBody(
                finished: finished,
                remaining: rem,
              );
            },
            formatter: (d) => d.inSeconds.toString(),
            onFinish: () async {
              final game = ref.read(currentGameProv);
              ref.read(gameRoundProv.notifier).setOngoing();
              if (kDebugMode) {
                await game?.execute(ref);
              } else {
                try {
                  await game?.execute(ref);
                } catch (e) {
                  lgr.Logger.level = Level.wtf;
                  logger.d('BIG MISTAKEEE 🚨🚨🚨🚨', e);
                  lgr.Logger.level = Level.debug;
                }
              }
              onWillPop(context).then(
                (success) {
                  if (success) {
                    //TODO Manage where the screen lands after game ends
                    Navigator.pop(context);
                    //GoRouter.of(context).pop();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

final gameScreenWidgetProv = StateProvider<Widget?>((ref) => null);

class _GBody extends ConsumerWidget {
  final String remaining;
  final bool finished;
  static const singlePlayerGames = ['s16', 's14', '80', 's35', '84'];

  const _GBody({
    required this.finished,
    required this.remaining,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final game = ref.read(currentGameProv);
    late final int? playerlength;
    try {
      playerlength = game?.players.length;
    } catch (e) {
      playerlength = 0;
    }
    final inst = L10n.inst(context);
    String titleStr = '';
    bool isGameSecond = (game!.id == 's4') && (int.parse(remaining) == 2);

    bool isGame = (game.id == 's1' ||
            game.id == 's4' ||
            game.id == 's16' ||
            game.id == 's14' ||
            game.id == '86') &&
        ((int.parse(remaining) == 2));

    switch (remaining) {
      case '3':
        titleStr = inst.game_loading_title_1;
        break;
      case '2':
        titleStr = inst.game_loading_title_2;
        break;
      case '1':
        titleStr = inst.game_loading_title_3;
        break;
      default:
    }
    if (!finished) {
      //Chronometer resetting...

      Future(() {
        ref.read(gameEndingProvider.notifier).chronometerStop();
      });

      return ref.read(currentEmbModeManager) == 0
          ? SizedBox.expand(
              child: DefaultBg(
                backgroundEnum: BackgroundEnums.old,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: ref.watch(currentNewVersionState)
                      ? [
                          const Spacer(
                            flex: 2,
                          ),
                          // headerOfCountDownText(titleStr, context,
                          //     ref: ref,
                          //     isIga: ref.read(currentEmbModeManager) == 1),
                          const Spacer(),
                          Center(
                            child: CpCounter(
                              size: 35.w,
                              centerText: remaining,
                            ),
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                        ]
                      : [
                          const Spacer(),
                          headerOfCountDownText(titleStr, context,
                              ref: ref,
                              isIga: ref.read(currentEmbModeManager) == 1),
                          const Gap(50),
                          CpCounter(
                            size: 14.w,
                            centerText: remaining,
                            currentIndex: int.parse(remaining),
                          ),
                          const Spacer(),
                          if (playerlength == 2)
                            Container(
                              padding: const EdgeInsets.all(defPaddingSize),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF333846).withOpacity(0.8),
                                  borderRadius:
                                      BorderRadius.circular(defPaddingSize)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${game.players.first.user?.userName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Container(
                                    height: MediaQuery.of(context)
                                            .size
                                            .aspectRatio *
                                        70,
                                    width: MediaQuery.of(context)
                                            .size
                                            .aspectRatio *
                                        70,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CpMainColors.cpRed),
                                    alignment: Alignment.center,
                                    child: Text('VS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .aspectRatio *
                                                35,
                                            fontStyle: FontStyle.italic,
                                            color: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.color)),
                                  ),
                                  Text('${game.players.last.user?.userName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ].joinWidgetList((index) => const SizedBox(
                                      width: 10,
                                    )),
                              ),
                            )
                          else if ((playerlength ?? 3) > 2)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defPaddingSize),
                              child: Container(
                                padding: const EdgeInsets.all(defPaddingSize),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF333846)
                                        .withOpacity(0.8),
                                    borderRadius:
                                        BorderRadius.circular(defPaddingSize)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(inst.game_loading_multiple_players),
                                    Divider(
                                      color: Colors.white.withOpacity(0.4),
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    for (final player in game.players)
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .aspectRatio *
                                                    40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .aspectRatio *
                                                    40,
                                                decoration: (player
                                                        .clrs.isEmpty)
                                                    ? null
                                                    : BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            fakeColorGenerator(
                                                                player.clrs
                                                                    .first))),
                                            Text('${player.user?.userName}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .aspectRatio *
                                                            20)),
                                          ].joinWidgetList((index) => SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .aspectRatio *
                                                  10)),
                                        ),
                                      ),
                                  ].joinWidgetList((index) => SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .aspectRatio *
                                          10)),
                                ),
                              ),
                            ),
                          if ((playerlength ?? 2) > 1) const Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                                onPressed: () async {
                                  await ref
                                      .read(currentPlayTraceManager.notifier)
                                      .changePlayTraceState(
                                          PlayTraceStates.idle, ref)
                                      .then((value) async => await ref
                                          .read(
                                              currentPlayTraceManager.notifier)
                                          .initializePlayTrace(ref)
                                          .then((value) =>
                                              Navigator.pop(context)));
                                },
                                child: Text(
                                  L10n.inst(context).cancel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                )),
                          )
                        ],
                ),
              ),
            )
          : SizedBox.expand(
              child: Stack(
                children: [
                  if (ref.read(currentEmbModeManager) == 1 &&
                      singlePlayerGames.contains(game.id))
                    Image.asset(
                      IgaAssets.background.getPath,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.fill,
                    ),
                  if (ref.read(currentEmbModeManager) == 1 &&
                      !singlePlayerGames.contains(game.id))
                    Image.asset(
                      IgaAssets.iga_in_game_background.getPath,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.fill,
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.h,
                          width: 50.w,
                          child: CpHeadlineWithIcon(
                            texts: ref
                                    .read(currentGameProv)!
                                    .metaData
                                    .igaCountDownTextSpans[
                                4 - int.parse(remaining)],
                            iconPathSecond:
                                isGameSecond ? IgaAssets.pad_tap.getPath : '',
                            iconPath: isGame ? IgaAssets.pad_tap.getPath : '',
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                          height: 40.h,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/app_icon/pad_stage_4.png',
                                fit: BoxFit.contain,
                                width: 20.w,
                                height: 25.h,
                              ),
                              Text(remaining,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    }

    final gameScreenWidget = ref.watch(gameScreenWidgetProv);

    return ref.read(currentEmbModeManager) == 0
        ? DefaultBg(
            backgroundEnum: BackgroundEnums.old,
            child: SizedBox(
              height: 100.h,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*if (game?.id != 's22' && game?.id != '39')*/
                    Padding(
                      padding: EdgeInsets.only(
                        top: ref.read(currentNewVersionState)
                            ? 24.0
                            : defPaddingSize,
                      ),
                      child: const GameLeaveButton(),
                    ),
                    if (game.setup.controlsSetup
                            .gameExerciseOpeartionsSelectionSetup ==
                        null)
                      const GameStopPlayButton(),
                    const InGameScoreWidget(),
                    if (gameScreenWidget != null) gameScreenWidget,
                  ].joinWidgetList(
                    (_) => const SizedBox(height: defPaddingSize),
                  ),
                ),
              ),
            ),
          )
        : const IgaGameScreen();
  }

  dynamic headerOfCountDownText(String titleStr, BuildContext context,
      {required WidgetRef ref, bool isIga = false}) {
    return !isIga
        ? ref.read(currentNewVersionState)
            ? RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'HAZIRLAN',
                      style: Theme.of(context).textTheme.displaySmall),
                  TextSpan(
                      text: '!',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: CpColors.cpPrimary))
                ]),
              )
            : Text(titleStr,
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Theme.of(context).textTheme.displayMedium?.color))
        : RichText(
            text: TextSpan(
                children: ref
                    .read(currentGameProv)!
                    .metaData
                    .igaCountDownTextSpans[4 - int.parse(remaining)]));
  }
}
