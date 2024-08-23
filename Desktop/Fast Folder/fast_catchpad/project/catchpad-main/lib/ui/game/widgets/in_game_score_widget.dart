import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/game/widgets/in_game_score_widgets/game_chronometer_widget.dart';
import 'package:catchpad/utils/util_widgets/util_information_cards.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/auth/register_user.dart';
import '../../../models/game/player_result_model.dart';
import '../../../models/game/static_game_model.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/game_curr_round_prov.dart';
import '../../../prov/game/selected_players_prov.dart';
import '../../../prov/game_result_prov.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/util_methods/util_methods.dart';
import '../../../utils/utils.dart';
import 'dotted_chart_widget.dart';
import 'in_game_score_widgets/device_catch_count_by_colors_widget.dart';
import 'in_game_score_widgets/game_polar_chart_widget.dart';
import 'in_game_score_widgets/game_show_score_widget.dart';
import 'in_game_score_widgets/game_split_time_widget.dart';
import 'in_game_score_widgets/game_timer_widget.dart';

class InGameScoreWidget extends ConsumerStatefulWidget {
  const InGameScoreWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InGameScoreWidgetState();
}

class _InGameScoreWidgetState extends ConsumerState<InGameScoreWidget> {
/*
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    logger.d("Intercepted In Game Screen"); // Do some stuff.
    return false;
  } */

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(gameResultProv);
    final inst = L10n.inst(context);
    final game = ref.watch(currentGameProv);

    final firstActionStatus = ref.watch(currentFirstActionTimeManager) != null;
    /* Widget adaptiveScreenWidget = StreamBuilder(
      stream: mystream.stream,
      builder: (context, AsyncSnapshot<int?> state) {
        if (state.data != null) {
          return Row(
            children: [
              Text(
                  'Round ${(state.data ?? 0) + 1} of ${game?.setup.roundCount}',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          );
        } else {
          return Row(
            children: [
              Text(
                  'Round ${(state.data ?? 0) + 1} of ${game?.setup.roundCount}',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          );
        }
      },
    );*/

    /* mystream.listen((event) {
      logger.d('currentRound: $event totalRound: $totalRound');

      adaptiveScreenWidget = Row(
        children: [
          Text('Round $currentround of ${game?.setup.roundCount}',
              style: Theme.of(context).textTheme.headlineSmall),
        ],
      );
    }); */

    List<PlayerResultModel> results =
        List<PlayerResultModel>.from(result?.playerResults ?? []);

    if (results.length > 1 &&
        results.any((element) => element.correctCount != null)) {
      results.sort((a, b) {
        if (a.correctCount != null && b.correctCount != null) {
          return b.correctCount!.compareTo(a.correctCount!);
        } else {
          return 0.compareTo(0);
        }
      });
    }

    /*if (game != null) { // for future use to update user interface
      if (game.setup.roundCount != null) {
      } else {
        switch (game.setup.type) {
          case GameEndType.duration:
            break;
          case GameEndType.score:
            break;
          case GameEndType.instructions:
            break;
          default:
        }
      }
    }*/

    return ref.read(currentNewVersionState) == true
        ? SizedBox(
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TimerWidget(),
                ...results.map((e) {
                  return Column(
                    children: [
                      const TimerWidget(),
                      ...results.map((e) {
                        return Column(
                          children: [
                            CustomCpInformationCards.buildDetailedCard(
                                isNewVersion: false,
                                upperFirstBoxName: inst.score_target,
                                boxType: BoxType.ms,
                                isBold: true,
                                isCardTransparent: true,
                                upperFirstBoxValue: ((e.correctCount ?? 0) +
                                        (e.incorrectCount ?? 0))
                                    .toString(),
                                bottomFirstBoxName:
                                    inst.activity_result_screen_maximum,
                                bottomFirstBoxValue:
                                    e.maxDuration!.inMilliseconds.toString(),
                                bottomSecondBoxName:
                                    inst.activity_result_screen_minimum,
                                bottomSecondBoxValue:
                                    e.minDuration!.inMilliseconds.toString(),
                                bottomThirdBoxName:
                                    inst.activity_result_screen_average,
                                bottomThirdBoxValue: e
                                    .averageDuration!.inMilliseconds
                                    .toString(),
                                context: context),
                            if (!(results.isEmpty))
                              ...results.map((e) => DottedChartWidget(
                                  tapCount: e.score,
                                  averageDuration: e
                                      .averageDuration!.inMilliseconds
                                      .toDouble(),
                                  spots: e.graphSpots)),
                          ],
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(defPaddingSize),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(ref.read(currentGameProv)!.title,
                          style: Theme.of(context).textTheme.headlineSmall),
                      if (game != null && !game.setup.needChronometer)
                        const TimerWidget(),
                      if (game != null &&
                          firstActionStatus &&
                          game.setup.needChronometer)
                        const ProChronometerWidget(
                          endMillisecond: null,
                        ),
                      if (results.isEmpty)
                        () {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            ...game!.players.map((e) {
                              final player = e.user;
                              return Padding(
                                padding: const EdgeInsets.all(defPaddingSize),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(e.playerName ?? "-"),
                                    if (e.clrs.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: defPaddingSize),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .aspectRatio *
                                              30,
                                          width: MediaQuery.of(context)
                                              .size
                                              .aspectRatio *
                                              30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: fakeColorGenerator(
                                                  e.clrs.first)),
                                        ),
                                      )
                                  ],
                                ),
                              );
                            }),
                          ]);
                        }(),

                      if (!(results.isEmpty))
                        ...results
                            .map(InGameSinglePlayerScore.new)
                            .joinWidgetList(
                              (index) => const SizedBox(height: defPaddingSize),
                            ),
                    ])),
          );
  }
}

class InGameSinglePlayerScore extends ConsumerWidget {
  const InGameSinglePlayerScore(this.model, {super.key});

  final PlayerResultModel model;

  @override
  Widget build(BuildContext context, ref) {
    final inst = L10n.inst(context);
    // TODO
    // final name = model.name;
    final scoreCorrect = model.correctCount,
        scoreIncorrect = model.incorrectCount;
    final flspots = model.graphSpots;
    final scorePoints = model.scorePoints?.map((e) => e.scoredAt).toList();
    final result = ref.watch(gameResultProv);
    final gamePlayers = ref.read(selectedPlayersPlayersProv);
    final players = result?.players;

    late final RegisterUser? player;
    try {
      player =
          players?.firstWhere((element) => element.id == model.playerId).user;
    } catch (e) {
      logger.e("Buraya mı düşüyor ${e.toString()}");
      player = RegisterUser(userName: inst.mentor_controls_state_mentor);
    }
    final scoreLevel = model.level;
    final scoreLeft = ref.watch(gameLeftRoundCountProv);
    final game = ref.watch(currentGameProv);
    final chosenSensor =
        game?.setup.sensorTypes.keys.elementAt(game.setup.chosedSensorIndex);
    final deviceCatchCount = model.deviceCatchCountforColors;
    final averageDuration =
        model.averageDuration ?? model.averageTeamHarmonyDuration;
    final minDuration = model.minDuration ?? model.minTeamHarmonyDuration;
    final maxDuration = model.maxDuration ?? model.maxTeamHarmonyDuration;

    joiner(e) => const SizedBox(
          width: defPaddingSize,
          height: defPaddingSize,
        );
    Color? playerColor;
    try {
      final currentPlayer = gamePlayers
          .where((element) => element.user?.userName == player?.userName)
          .first;
      if (game?.setup.stagedPlayerModel!.minClrCount == 1 &&
          game?.setup.stagedPlayerModel!.maxClrCount == 1 &&
          currentPlayer.clrs.length == 1) {
        playerColor = currentPlayer.clrs.first;
      }
    } catch (e) {
      logger.d(e.toString());
    }
    /* late double dataForChart;
    if (averageDuration != null) {
      dataForChart = double.parse(averageDuration
          .formatSecondsMilli(context)
          .substring(
              0, averageDuration.formatSecondsMilli(context).length - 2));
    } */
    bool dynamicScoreShowingEnabled =
        player?.userName != inst.mentor_controls_state_mentor &&
            (scoreCorrect != null || scoreIncorrect != null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (player?.userName != inst.mentor_controls_state_mentor)
          Padding(
            padding: const EdgeInsets.all(defPaddingSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(player?.userName ?? model.userName),
                if (playerColor != null)
                  Padding(
                    padding: const EdgeInsets.only(left: defPaddingSize),
                    child: Container(
                      height: MediaQuery.of(context).size.aspectRatio * 30,
                      width: MediaQuery.of(context).size.aspectRatio * 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fakeColorGenerator(playerColor)),
                    ),
                  )
              ],
            ),
          ),
        if (game?.id == '53' && players != null)
          PolarChartWidget(true,
              playerModel: players
                  .firstWhere((element) => element.id == model.playerId)),
        // Bir oyuna özgü yapıldı şu an
        scorePoints != null &&
                scorePoints.isNotEmpty &&
                game!.setup.needChronometer
            ? SplitTimeWidget(
                dateTimes: scorePoints,
              )
            : const SizedBox(),
        const SizedBox(height: halfDefPaddingSize),
        if (deviceCatchCount != null)
          Flexible(
            child: DeviceCatchCountByColorsWidget(
                catchedDevicesByColor: deviceCatchCount),
          ),
        if (dynamicScoreShowingEnabled)
          ShowScoreDynamicallyWidget(
              correctCount: scoreCorrect,
              incorrectCount: scoreIncorrect,
              isTrueFalseGame: scoreIncorrect == null ? true : false,
              averageDuration: averageDuration?.formatSecondsMilli(context),
              maxDuration: maxDuration?.formatSecondsMilli(context),
              minDuration: minDuration?.formatSecondsMilli(context),
              totalTimeElapsed: null,
              game: game!),
        /* if (totalDuration != null && chosenSensor == UsedSensorsType.motion)
          ClassicDividerWidget(
            title: inst.activity_default_scores_total_duration,
            text: totalDuration.formatSecondsMilli(context),
          ), */
        if (averageDuration != null &&
            chosenSensor != UsedSensorsType.motion &&
            game!.getScoreType != GameScoreType.teamHarmony &&
            !dynamicScoreShowingEnabled)
          ClassicDividerWidget(
            title: inst.activity_default_scores_average_duration,
            text: averageDuration.formatSecondsMilli(context),
          ),
        if (averageDuration != null &&
            (scoreCorrect != null || scoreIncorrect != null) &&
            flspots.isNotEmpty)
          DottedChartWidget(
              tapCount: ((scoreCorrect ?? 0) + (scoreIncorrect ?? 0)),
              averageDuration: 0,
              spots: flspots),
        /* Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (scoreCorrect != null)
                    ScoreMetricItem(
                      title: L10n.inst(context).score_correct,
                      value: scoreCorrect.toString(),
                      valueColor: CpColors.success,
                    ),
                  if (scoreIncorrect != null)
                    ScoreMetricItem(
                      title: L10n.inst(context).score_wrong,
                      value: scoreIncorrect.toString(),
                      valueColor: CpColors.error,
                    ),
                  if (isScoreBased)
                    ScoreMetricItem(
                      title: L10n.inst(context).score_left,
                      value: scoreLeft.toString(),
                    ),
                  if (scoreLevel != null)
                    ScoreMetricItem(
                      title: L10n.inst(context).score_level,
                      value: scoreLevel.toString(),
                    ),
                ].joinWidgetList(joiner),
              ),
            ].joinWidgetList(joiner),
          ),
        ), */
      ],
    );
  }
}

class ClassicDividerWidget extends StatelessWidget {
  const ClassicDividerWidget({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defPaddingSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(color: Color(0xFF30374F)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: const Color(0xFFB1B8C5)),
                ),
              ),
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFF30374F)),
        ],
      ),
    );
  }
}

class ScoreMetricItem extends StatelessWidget {
  final String title;
  final String value;
  final bool fullWidth;
  final Color? valueColor;

  const ScoreMetricItem({
    required this.title,
    required this.value,
    this.fullWidth = false,
    this.valueColor = CpColors.defTextColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const rad = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rad),
        border: Border.all(
          color: CpColors.gameScoreBorderColor,
          width: 1,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(quarterDefPaddingSize),
        child: Column(
          children: [
            Text('$title:'),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(rad),
                color: CpColors.gameScoreBorderColor,
              ),
              padding: const EdgeInsets.all(defPaddingSize * 1.5),
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor,
                ),
              ),
            ),
          ].joinWidgetList(
            (e) => const SizedBox(height: halfDefPaddingSize),
          ),
        ),
      ),
    );
  }
}
