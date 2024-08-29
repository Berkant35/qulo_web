import 'package:catchpad/models/game/dynamic_games/dynamic_game_model.dart';
import 'package:catchpad/models/game/game_model.dart';
import 'package:catchpad/models/game/player_result_model.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/game_result_prov.dart';
import 'package:catchpad/ui/game/widgets/dotted_chart_widget.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/util_widgets/util_information_cards.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../prov/game/curr_game_prov.dart';
import '../../../../../prov/game/game_curr_round_prov.dart';
import '../../../../../prov/game/selected_players_prov.dart';
import '../../../../../utils/utils.dart';

class IgaContentOfResult extends ConsumerStatefulWidget {
  const IgaContentOfResult({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaContentOfResultState();
}

class _IgaContentOfResultState extends ConsumerState<IgaContentOfResult> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(gameResultProv);

    final game = ref.watch(currentGameProv);
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
    PlayerResultModel? winnerPlayerModel;

    if (game!.id == 's1') {
      // differenct correct count
      results.sort((a, b) {
        logger.i(a.toJson());
        logger.i(b.toJson());

        return a.correctCount != b.correctCount
            ? (b.correctCount ?? 0).compareTo(a.correctCount ?? 0)
            : a.averageDuration!.compareTo(b.averageDuration!);
      });
      // same correct count
      final winnerPlayer = results.first;
      winnerPlayerModel = winnerPlayer;
    }

    results.sort((a, b) => b.playerId.compareTo(a.playerId));

    return SizedBox.expand(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: dynamicContent(game.id, results,
            winnerPlayerModel: winnerPlayerModel),
      ),
    );
  }

  List<Widget> dynamicContent(id, List<PlayerResultModel> results,
      {PlayerResultModel? winnerPlayerModel}) {
    {
      switch (id) {
        case 's16':
          return _igaFormulaDikkatDikkatDinleYakala(results);
        case 's14':
        case '84':
        case '80':
          return _igaFormulaDikkatDikkatDinleYakala(results, needCounter: true);
        case 's1':
          return _formulaYarisi(results, winnerPlayer: winnerPlayerModel);
        case 's35':
          return bulBakalim(ref, results, needCounter: true);
        case 's4':
          return _teamWork(results);
      }
      return [];
    }
  }

  List<Widget> _igaFormulaDikkatDikkatDinleYakala(List<PlayerResultModel> res,
      {bool needCounter = false}) {
    final model = res.first;
    final inst = L10n.inst(context);
    final scoreCorrect = model.correctCount,
        scoreIncorrect = model.incorrectCount;
    final flspots = model.graphSpots;
    final averageDuration =
        model.averageDuration ?? model.averageTeamHarmonyDuration;
    final minDuration = model.minDuration ?? model.minTeamHarmonyDuration;
    final maxDuration = model.maxDuration ?? model.maxTeamHarmonyDuration;

    ref.read(currentIgaResultManager.notifier).createResult(ref,
        primaryScore: averageDuration?.inMilliseconds.toDouble() ?? 0.0,
        secondaryScore: scoreCorrect?.toDouble() ?? 0,
        isMultipleAndSecondPlayer: true,
        isSinglePlayerGame: true);

    return [
      const Spacer(),
      Expanded(
        flex: 4,
        child: Center(
          child: needCounter
              ? CustomCpInformationCards.basicInformationsWithPrimaryHeaderCounters(
                  ref: ref,
                  insidePadding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                  primaryTitle: inst.iga_your_average_reaction_time,
                  primaryDescription: (averageDuration != null
                          ? ('${averageDuration.inMilliseconds}ms')
                          : "-") ??
                      "-",
                  bottomFirstBoxValue: scoreCorrect.toString() ?? "-",
                  bottomFirstBoxName: inst.score_target,
                  bottomSecondBoxName: inst.worst,
                  bottomSecondBoxValue: (maxDuration != null
                          ? ('${maxDuration.inMilliseconds}ms')
                          : "-") ??
                      "-",
                  bottomThirdBoxName: inst.best,
                  bottomThirdBoxValue: (minDuration != null
                          ? ('${minDuration.inMilliseconds}ms')
                          : "-") ??
                      "-",
                  bottomFourthBoxName: inst.activity_result_screen_total_time,
                  bottomFourthBoxValue:
                      '${ref.read(currentGameProv)!.setup.duration!.duration.inSeconds}s',
                  upperFirstBoxName: inst.score_correct,
                  upperFirstBoxValue: scoreCorrect.toString(),
                  upperSecondBoxName: inst.score_wrong,
                  upperSecondBoxValue: scoreIncorrect.toString(),
                  upperThirdBoxName: inst.score_total,
                  upperThirdBoxValue:
                      ((scoreCorrect ?? 0) - (scoreIncorrect ?? 0)).toString(),
                  paddingHorizontalDivider: 2.w,
                  paddingVerticalDivider: 2.h)
              : CustomCpInformationCards.basicInformationsWithPrimaryHeader(
                  ref: ref,
                  primaryTitle: inst.iga_your_average_reaction_time,
                  primaryDescription:
                      '${averageDuration?.inMilliseconds}ms' ?? "-",
                  bottomFirstBoxValue: scoreCorrect.toString() ?? "-",
                  bottomFirstBoxName: inst.score_target,
                  bottomSecondBoxName: inst.worst,
                  bottomSecondBoxValue:
                      '${maxDuration!.inMilliseconds}ms' ?? "-",
                  bottomThirdBoxName: inst.best,
                  bottomThirdBoxValue:
                      '${minDuration!.inMilliseconds}ms' ?? "-",
                  bottomFourthBoxName: inst.activity_result_screen_total_time,
                  bottomFourthBoxValue:
                      '${ref.read(currentGameProv)!.setup.duration!.duration.inSeconds}s',
                ),
        ),
      ),
      const Spacer(),
      Expanded(
        flex: 4,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(24.px))),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: DottedChartWidget(
                tapCount: ((scoreCorrect ?? 0) + (scoreIncorrect ?? 0)),
                averageDuration: 0,
                spots: flspots),
          ),
        ),
      ),
      const Spacer()
    ];
  }

  List<Widget> bulBakalim(
    WidgetRef ref,
    List<PlayerResultModel> res, {
    bool needCounter = false,
  }) {
    final model = res.first;
    final averageDuration =
        model.averageDuration ?? model.averageTeamHarmonyDuration;
    final scoreCorrect = model.correctCount;
    final scoreIncorrect = model.incorrectCount;
    final inst = L10n.inst(context);
    ref.read(currentIgaResultManager.notifier).createResult(ref,
        primaryScore: double.parse(Duration(
                        milliseconds: (averageDuration?.inMilliseconds ?? 0) *
                            (scoreCorrect ?? 0))
                    .formatSecondsMilli(context)
                    .replaceAll(" s", "")) *
                1000 ??
            0.0,
        secondaryScore: scoreCorrect?.toDouble() ?? 0.0,
        isMultipleAndSecondPlayer: true,
        isSinglePlayerGame: true);

    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCpInformationCards.basicRowInformationCard(
              ref: ref,
              title: L10n.inst(context).time_of_find_pad,
              description: Duration(
                          milliseconds: (averageDuration?.inMilliseconds ?? 0) *
                              (scoreCorrect ?? 0))
                      .formatSecondsMilli(context)
                      .toString() ??
                  "-"),
          CustomCpInformationCards.customDivider(2.w, 3.h, customWidth: 32.w),
          CustomCpInformationCards.fourInformation(
              scoreCorrect.toString(),
              inst.score_correct,
              ref.context,
              inst.score_wrong,
              scoreIncorrect.toString(),
              inst.score,
              ((scoreCorrect ?? 0) - (scoreIncorrect ?? 0)).toString(),
              null,
              null,
              textStyle: Theme.of(ref.context).textTheme.displaySmall!,
              boxWidth: 10.w,
              boxHeight: 8.h)
        ],
      ),
    ];
  }

  List<Widget> _teamWork(List<PlayerResultModel> res,
      {bool needCounter = false}) {
    final resX =
        res.first.averageTeamHarmonyDuration?.inMilliseconds.toString() ?? "-";
    final model = res.first;
    final inst = L10n.inst(context);
    final scoreCorrect = model.correctCount;

    final averageDuration =
        model.averageDuration ?? model.averageTeamHarmonyDuration;
    final minDuration = model.minDuration ?? model.minTeamHarmonyDuration;
    final maxDuration = model.maxDuration ?? model.maxTeamHarmonyDuration;

    ref.read(currentIgaResultManager.notifier).createResult(ref,
        primaryScore: averageDuration?.inMilliseconds.toDouble() ?? 0.0,
        secondaryScore: scoreCorrect?.toDouble() ?? 0.0,
        isMultipleAndSecondPlayer: true,
        isSinglePlayerGame: true);

    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCpInformationCards.buildCardWithImage(
              title: inst.game_result_primary_score_harmony,
              imagePath: IgaAssets.bul_bakalim.getPath,
              boxValue: '${resX}ms',
              height: 13.h,
              width: 40.w,
              context: context),
          CustomCpInformationCards.buildDetailedCard(
            bottomFirstBoxValue: '${maxDuration!.inMilliseconds}ms' ?? "-",
            bottomFirstBoxName: inst.worst,
            bottomSecondBoxName: inst.best,
            isCardTransparent: true,
            bottomSecondBoxValue: '${minDuration?.inMilliseconds}ms' ?? "-",
            bottomThirdBoxName: inst.activity_result_screen_average,
            bottomThirdBoxValue: '${averageDuration?.inMilliseconds}ms' ?? "-",
            bottomFourthBoxName: inst.activity_result_screen_total_time,
            bottomFourthBoxValue:
                '${ref.read(currentGameProv)!.setup.duration!.duration.inSeconds}s',
            upBoxWidth: 8.w,
            width: 50.w,
            dividerWidth: 36.w,
            upBoxHeight: 8.h,
            bottomBoxWidth: 8.w,
            bottomBoxHeight: 8.h,
            textStyle: Theme.of(context).textTheme.displaySmall,
            upperFirstBoxName: inst.score,
            upperFirstBoxValue: scoreCorrect.toString(),
            context: context,
          ),
        ],
      )
    ];
  }

  List<Widget> _formulaYarisi(List<PlayerResultModel> res,
      {bool needCounter = false, required PlayerResultModel? winnerPlayer}) {
    // TODO: CREATE WINNER AND ANOTHER PLAYER COMPETITIVE RESULTS

    // final model = res.first;
    // final inst = L10n.inst(context);
    // final scoreCorrect = model.correctCount,
    //     scoreIncorrect = model.incorrectCount;
    // final flspots = model.graphSpots;
    // final averageDuration = model.averageDuration ?? model.averageTeamHarmonyDuration;

    // final minDuration = model.minDuration ?? model.minTeamHarmonyDuration;
    // final maxDuration = model.maxDuration ?? model.maxTeamHarmonyDuration;

    // ref.read(currentIgaResultManager.notifier).createResult(ref,
    //     primaryScore: averageDuration?.inMilliseconds.toDouble() ?? 0.0,
    //     secondaryScore: scoreCorrect?.toDouble() ?? 0);

    final firstPlayer = res.first;
    final firstPlayerAverageDuration =
        firstPlayer.averageDuration ?? firstPlayer.averageTeamHarmonyDuration;
    final firstPlayerScoreCorrect = firstPlayer.correctCount;

    final secondPlayer = res.last;
    final secondPlayerAverageDuration =
        secondPlayer.averageDuration ?? secondPlayer.averageTeamHarmonyDuration;
    final secondPlayerScoreCorrect = secondPlayer.correctCount;

    ref.read(currentIgaResultManager.notifier).createResult(ref,
        primaryScore:
            firstPlayerAverageDuration?.inMilliseconds.toDouble() ?? 0.0,
        secondaryScore: firstPlayerScoreCorrect?.toDouble() ?? 0,
        isMultipleAndSecondPlayer: false);

    //create result for second player
    ref.read(currentIgaResultManager.notifier).createResult(ref,
        primaryScore:
            secondPlayerAverageDuration?.inMilliseconds.toDouble() ?? 0.0,
        secondaryScore: secondPlayerScoreCorrect?.toDouble() ?? 0,
        isMultipleAndSecondPlayer: true);

    return [
      ...res.map((perPlayerResultModel) {
        final model = perPlayerResultModel;
        final inst = L10n.inst(context);
        final scoreCorrect = model.correctCount,
            scoreIncorrect = model.incorrectCount;
        final flspots = model.graphSpots;
        final scorePoints = model.scorePoints?.map((e) => e.scoredAt).toList();
        final result = ref.watch(gameResultProv);
        final gamePlayers = ref.read(selectedPlayersPlayersProv);
        final players = result?.players;
        final playerColor = ref
            .read(selectedPlayersPlayersProv)
            .toList()
            .firstWhere(
                (element) => element.id == perPlayerResultModel.playerId)
            .clrs
            .first;
        final scoreLevel = model.level;
        final scoreLeft = ref.watch(gameLeftRoundCountProv);
        final game = ref.watch(currentGameProv);
        final chosenSensor = game?.setup.sensorTypes.keys
            .elementAt(game.setup.chosedSensorIndex);
        final deviceCatchCount = model.deviceCatchCountforColors;
        final averageDuration =
            model.averageDuration ?? model.averageTeamHarmonyDuration;
        final minDuration = model.minDuration ?? model.minTeamHarmonyDuration;
        final maxDuration = model.maxDuration ?? model.maxTeamHarmonyDuration;

        return Expanded(
          child: CustomCpInformationCards.buildCompetitivePlayerResultCard(
              titleOfBottomCard: inst.iga_your_average_reaction_time,
              insidePadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              valueOfBottomCard: (averageDuration != null
                      ? ('${averageDuration.inMilliseconds}ms')
                      : "-") ??
                  "-",
              upperFirstBoxName: inst.score_target,
              upperFirstBoxValue:
                  ((scoreIncorrect ?? 0).abs() + (scoreCorrect ?? 0).abs())
                      .toString(),
              maxDuration: maxDuration,
              minDuration: minDuration,
              showCrown: model.playerId == winnerPlayer?.playerId,
              bottomFirstBoxName: inst.worst,
              bottomFirstBoxValue: ('${maxDuration!.inMilliseconds}ms') ?? "-",
              bottomSecondBoxName: inst.best,
              bottomSecondBoxValue: ('${minDuration!.inMilliseconds}ms') ?? "-",
              bottomThirdBoxName: inst.activity_result_screen_average,
              bottomThirdBoxValue:
                  ('${averageDuration!.inMilliseconds}ms') ?? "-",
              playerColor: playerColor,
              inst: inst,
              context: context),
        );
      }).joinWidgetList((index) => SizedBox(
            width: 10.w,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  IgaAssets.iga_in_game_thunderbolt.getPath,
                  height: 40.h,
                  width: 12.w,
                ),
                Image.asset(
                  IgaAssets.vs.getPath,
                  height: 18.h,
                  width: 12.w,
                ),
              ],
            ),
          ))
    ];
  }
}
