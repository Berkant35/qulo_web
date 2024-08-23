import 'dart:convert';

import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/enums/game/game_score_type.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/ui/game/widgets/in_game_score_widgets/game_split_time_widget.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/auth/register_user.dart';
import '../../../models/game/game_model.dart';
import '../../../prov/end_game_prov.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/selected_players_prov.dart';
import '../../../prov/game_result_prov.dart';
import '../../../prov/global_providers.dart';
import '../../../utils/util_methods/util_methods.dart';
import '../../../utils/utils.dart';
import 'dotted_chart_widget.dart';
import 'in_game_score_widget.dart';
import 'in_game_score_widgets/device_catch_count_by_colors_widget.dart';
import 'in_game_score_widgets/game_chronometer_widget.dart';
import 'in_game_score_widgets/game_polar_chart_widget.dart';
import 'in_game_score_widgets/game_score_result_widget.dart';
import 'in_game_score_widgets/game_show_score_widget.dart';
import 'in_game_score_widgets/game_timer_widget.dart';

class GameFinalScoreWidget extends ConsumerWidget {
  final GameResultMap resultsMap;
  final Map<String, int> resultsforgame;

  const GameFinalScoreWidget({
    required this.resultsMap,
    required this.resultsforgame,
    super.key,
  });


  // This list gives us all the competitive games, in previous scenarios
  // the ranking was done based on reaction time, but this
  // It was causing the user to be in second place even though he scored more in a certain time
  // we decided to make a small manipulation to prevent the reason for this illogicality
  // that's why now the games listed below will not be sorted by reaction time
  // and ranking will be done based on score only.

  static const competitiveGames = ['s1','73'];



  @override
  Widget build(BuildContext context, ref) {
    const double dummyAvarageReactionTime = 913.0;
    final inst = L10n.inst(context);
    final result = ref.watch(gameResultProv);

    final players = result?.players;

    final game = ref.watch(currentGameProv);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(ref.read(currentGameProv)!.title,
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        if (resultsMap.isNotEmpty)
          ...resultsMap.entries.map(
            (id) {
              late final RegisterUser? player;
              try {
                player =
                    players?.firstWhere((element) => element.id == id.key).user;
              } catch (e) {
                player =
                    RegisterUser(userName: inst.mentor_controls_state_mentor);
              }
              bool isCatchCountorCorrectCountIn = false;

              final result = id.value;
              final playerResModel =
                  PlayerResultModel.fromRawJson(result[inst.player_model]!);
              final playerAvarageDuration =
                  playerResModel.averageDuration?.inMilliseconds.toDouble();

              return Column(
                children: result.entries.where(
                  (e) {
                    return e.value != null;
                  },
                ).map(
                  (e) {

                    if ((e.key == inst.activity_default_scores_catch_count ||
                            e.key ==
                                inst.activity_default_scores_correct_count
                        || (e.key == inst.score && competitiveGames.contains(game!.id))
                    ) &&
                        (!isCatchCountorCorrectCountIn)) {
                      isCatchCountorCorrectCountIn = true;
                      bool isTrueFalseGame = false;
                      int? inc = int.tryParse(e.value!.split('-').last);
                      if (e.value!.contains('-') == false) {
                        inc = null;
                        isTrueFalseGame = true;
                      }
                      String? averageTeamHarmonyDuration = playerResModel
                          .averageTeamHarmonyDuration
                          ?.formatSecondsMilli(context);
                      String? minTeamHarmonyDuration = playerResModel
                          .minTeamHarmonyDuration
                          ?.formatSecondsMilli(context);
                      String? maxTeamHarmonyDuration = playerResModel
                          .maxTeamHarmonyDuration
                          ?.formatSecondsMilli(context);
                      String? averageDuration =
                          result[inst.activity_default_scores_average_duration];
                      if (result[inst.activity_default_scores_total_score] !=
                              null &&
                          result[inst.activity_default_scores_total_score]!
                              .contains(' s')) {
                        averageDuration =
                            result[inst.activity_default_scores_total_score];
                      }
                      String? minDuration =
                          result[inst.activity_default_scores_minimum_duration];
                      String? maxDuration =
                          result[inst.activity_default_scores_maximum_duration];

                      final gameTime = game?.setup.duration?.def;

                      String? totalTimeElapsed = (game != null &&
                              game.metaData.duration != null &&
                              game.metaData.duration!.def != null &&
                              gameChronometer.elapsed.inSeconds >
                                  game.metaData.duration!.def!.toInt())
                          ? '${game!.metaData.duration!.def!.toInt() ~/ 60}:${game.metaData.duration!.def!.toInt() % 60}'
                          : '${gameChronometer.elapsed.inSeconds ~/ 60}:${gameChronometer.elapsed.inSeconds % 60}';
                      ////////////////////////////////////////////////////////////////////
                      final number = (100 -
                          ((playerAvarageDuration ??
                                  0.0 / dummyAvarageReactionTime) *
                              100));
                      final double fixedNumber = number > 0 ? number : -number;
                      final formattedNumber = fixedNumber.toStringAsFixed(0);

                      if (gameTime != null) {
                        if (gameChronometer.elapsed.inSeconds > gameTime) {}
                      }
                      int? correctCount = int.tryParse(
                              result[inst.activity_default_scores_correct_count]
                                  .toString()) ??
                          int.tryParse(
                              result[inst.activity_default_scores_catch_count]
                                  .toString()) ??
                          int.tryParse(e.value != null
                              ? e.value!.split('-').first
                              : "0");

                      correctCount ??= 0;

                      int? incorrectCount = int.tryParse(result[
                                  inst.activity_default_scores_incorrect_count]
                              .toString()) ??
                          (inc == 0 ? null : inc);

                      incorrectCount ??= 0;


                      return Padding(
                        padding: const EdgeInsets.all(defPaddingSize),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShowScoreDynamicallyWidget(
                                correctCount: correctCount,
                                incorrectCount: incorrectCount,
                                averageDuration: averageDuration ??
                                    averageTeamHarmonyDuration,
                                minDuration:
                                    minDuration ?? minTeamHarmonyDuration,
                                maxDuration:
                                    maxDuration ?? maxTeamHarmonyDuration,
                                totalTimeElapsed: totalTimeElapsed,
                                game: game!,
                                isTrueFalseGame: isTrueFalseGame),
                          ],
                        ),
                      );
                    }
                    if (e.key ==
                        inst.activity_default_scores_catch_count_for_every_color) {
                      return Padding(
                        padding: const EdgeInsets.all(defPaddingSize),
                        child: DeviceCatchCountByColorsWidget(
                            catchedDevicesByColor: e.value!),
                      );
                    }
                    if (e.key == inst.activity_default_scores_total_score) {
                      String scoreText = e.value.toString();

                      int? indexValue = int.tryParse(resultsMap
                              .entries.first.value[
                          '${inst.activity_default_scores_total_score}raw']!);

                      late int first, second;

                      if (scoreText.contains('-')) {
                        first = int.tryParse(scoreText.split('-').first) ?? 0;
                        second = int.tryParse(scoreText.split('-').last) ?? 0;
                        scoreText = (first - second).toString();
                        indexValue = int.tryParse(scoreText);
                      }

                      if (game?.setup.needChronometer == true) {
                        final results = ref.read(gameResultProv)!.playerResults;

                        final laps = results.isNotEmpty
                            ? results.first.scorePoints
                                ?.map((e) => e.scoredAt)
                                .toList()
                            : <DateTime>[];

                        return (laps != null &&
                                laps.isNotEmpty &&
                                ref.context.mounted)
                            ? Column(
                                children: [
                                  if (ref
                                      .read(currentFirstActionTimeManager
                                          .notifier)
                                      .roundPoints
                                      .isNotEmpty)
                                    ProChronometerWidget(
                                      endMillisecond: ref
                                          .read(currentFirstActionTimeManager
                                              .notifier)
                                          .roundPoints
                                          .last
                                          .inMilliseconds,
                                    ),
                                  (!game!.setup.gameScoreTypes
                                              .contains(GameScoreType.speed) &&
                                          game.id != '49')
                                      ? SplitTimeWidget(
                                          dateTimes: laps,
                                        )
                                      : game.id == '49'
                                          ? ClassicDividerWidget(
                                              title: L10n.inst(context)
                                                  .game_earning_speed,
                                              text:
                                                  '${((int.parse(game.setup.keyboardValue.toString()) * 0.001) / (ref.read(currentFirstActionTimeManager.notifier).roundPoints.last.inMilliseconds * 2.7777777777777776e-7)).toStringAsFixed(1)} ${L10n.inst(context).game_result_primary_score_meter_div_sec}')
                                          : const SizedBox()
                                ],
                              )
                            : const SizedBox();
                      }

                      if (game?.setup.isPercentage == true) {
                        int? gameDur = game?.setup.duration!.def;

                        bool setOneHundred = false;

                        double parsed = double.tryParse(
                                e.value.toString().replaceAll(' s', '')) ??
                            1.0;

                        scoreText =
                            '%${(100 * parsed / gameDur!).toStringAsFixed(2)}';

                        //logger.d((100 * parsed / gameDur).toStringAsFixed(0));

                        //This code stupid i know but i must to arrive to ahmet we come back to again here!

                        if (setOneHundred || parsed == 1) {
                          scoreText = '%100.0';
                        }

                        if (int.tryParse((100 * parsed / gameDur)
                                    .toStringAsFixed(0))! >
                                100 ||
                            (100 * parsed / gameDur) > 97) {
                          scoreText = '%100';
                        }

                        if (scoreText == '%0') {
                          FirebaseCollectionEnums.logs.reference
                              .doc("denge_skor_bug")
                              .collection(ref.read(currentUserProv)!.email ??
                                  ref.read(currentUserProv)!.uid ??
                                  "WTF")
                              .doc(DateTime.now().toString().substring(0, 18))
                              .set({
                            "parsed": parsed,
                            "gameDur": gameDur,
                            "setOneHundred": setOneHundred
                          });
                        }

                        indexValue =
                            (double.tryParse(scoreText.replaceAll('%', ''))! *
                                    100)
                                .toInt();
                      }

                      if (game?.id == 's13' || game?.id == 's18') {
                        bool missable = game?.id == 's13';
                        int? index;
                        final indexvalues = resultsforgame.values.toList();
                        if (indexValue != null) {
                          if (game!.getScoreType ==
                                  GameScoreType.averageDuration &&
                              ref
                                  .read(appSettingsToggleProvider)
                                  .enableEnvironmentSelection) {
                            //indexValue *= 10;
                          }
                          indexvalues.add(indexValue);
                          if (game.getScoreType.isDescending) {
                            indexvalues.sort((a, b) => a.compareTo(b));
                          } else {
                            indexvalues.sort((a, b) => b.compareTo(a));
                          }
                          index = indexvalues.indexOf(indexValue);
                        }
                        bool showFlag = players?.first.user?.uid == player?.uid;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(defPaddingSize),
                              child: DynamicGameScoreWidget(
                                  score: scoreText,
                                  indexvalues: indexvalues,
                                  showFlag: showFlag,
                                  index: index,
                                  onleaderboard: game?.onLeaderboard,
                                  primaryScoreOverRuleString:
                                      game?.metaData.primaryScoreString),
                            ),
                            ClassicDividerWidget(
                              title: (missable)
                                  ? inst.activity_default_scores_missed
                                  : inst.score_wrong,
                              text: second.toString(),
                            ),
                            ClassicDividerWidget(
                              title: (missable)
                                  ? inst.activity_default_scores_catched
                                  : inst.score_correct,
                              text: first.toString(),
                            ),
                          ],
                        );
                      } else {
                        if (game?.id == 's20' || game?.id == '19') {
                          scoreText =
                              "%${(int.parse(scoreText) * 100 / 42).toStringAsFixed(2)}";
                          indexValue =
                              (double.tryParse(scoreText.replaceAll('%', ''))! *
                                      100)
                                  .toInt();
                        }
                        int? index;
                        final indexvalues = resultsforgame.values.toList();
                        if (game!.getScoreType ==
                                GameScoreType.averageDuration &&
                            ref
                                .read(appSettingsToggleProvider)
                                .enableEnvironmentSelection) {
                          //indexValue *= 10;
                        }

                        if (indexValue != null) {
                          indexvalues.add(indexValue);
                        }
                        if (game.getScoreType.isDescending) {
                          indexvalues.sort((a, b) => a.compareTo(b));
                        } else {
                          indexvalues.sort((a, b) => b.compareTo(a));
                        }
                        if (indexValue != null && indexvalues.length > 1) {
                          index = indexvalues.indexOf(indexValue);
                        } else {
                          index = -1;
                        }

                        return Padding(
                          padding: const EdgeInsets.all(defPaddingSize),
                          child: Column(
                            children: [
                              if (game.id == '53' && players != null)
                                PolarChartWidget(false,
                                    playerModel: players.firstWhere((element) =>
                                        element.id == playerResModel.playerId)),
                              DynamicGameScoreWidget(
                                  score: scoreText,
                                  index: index + 1,
                                  indexvalues: indexvalues,
                                  onleaderboard: game.onLeaderboard,
                                  primaryScoreOverRuleString:
                                      game.metaData.primaryScoreString),
                            ],
                          ),
                        );
                      }
                    }
                    if (e.key == inst.activity_default_scores_incorrect_count) {
                      return const SizedBox();
                    }
                    if (e.key == inst.activity_default_scores_level) {
                      return ClassicDividerWidget(
                        title: inst.game_result_primary_score_average_strength,
                        text: e.value!,
                      );
                    }
                    if (e.key == inst.activity_default_scores_total_duration) {
                      if (e.value.toString() != 'null' &&
                          e.value.toString().contains(' s')) {
                        String time =
                            '${gameChronometer.elapsed.inSeconds ~/ 60}:${gameChronometer.elapsed.inSeconds % 60}';
                        return TimerWidget(
                            inGameTime: false, lastTotalDuration: time);
                      } else {
                        return const SizedBox();
                      }
                    }
                    if (e.key == inst.game_ui_graph) {
                      List<FlSpot> spots = spotFromJson(json.decode(e.value!));
                      final spotJson = json.decode(e.value!);
                      late final int? tapCount;
                      try {
                        tapCount = spots.length;
                      } catch (e) {
                        tapCount = int.tryParse(
                            spotJson[inst.activity_result_screen_total_hits]);
                      }
                      return DottedChartWidget(
                          tapCount: tapCount ?? 0,
                          averageDuration: 2,
                          spots: spots);
                    }
                    if (e.key ==
                        inst.activity_default_scores_average_duration && !competitiveGames.contains(game!.id)) {
                      return ClassicDividerWidget(
                        title: inst.activity_default_scores_average_duration,
                        text: e.value!,
                      );
                    }
                    if (e.key == inst.player_name) {
                      Color? playerColor;
                      final gamePlayers = ref.read(selectedPlayersPlayersProv);
                      final currentPlayer = (gamePlayers
                              .where((element) =>
                                  element.user!.userName == player!.userName)
                              .isNotEmpty)
                          ? gamePlayers
                              .where((element) =>
                                  element.user!.userName == player!.userName)
                              .first
                          : null;

                      if (currentPlayer == null) return const SizedBox();

                      if (ref.context.mounted &&
                          game?.setup.stagedPlayerModel!.minClrCount == 1 &&
                          game?.setup.stagedPlayerModel!.maxClrCount == 1 &&
                          currentPlayer.clrs.length == 1) {
                        playerColor = currentPlayer.clrs.first;
                        playerColor = fakeColorGenerator(playerColor);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(defPaddingSize),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(player?.userName ?? "-"),
                            if (playerColor != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: defPaddingSize),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.aspectRatio *
                                          30,
                                  width:
                                      MediaQuery.of(context).size.aspectRatio *
                                          30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: fakeColorGenerator(playerColor)),
                                ),
                              )
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ).toList(),
              );
            },
          ),
      ],
    );
  }
}
