import 'package:catchpad/models/game/player_result_model.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/util_widgets/util_divider.dart';
import 'package:catchpad/utils/util_widgets/util_information_cards.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/auth/register_user.dart';
import '../../../../prov/emb/emb_global_providers.dart';
import '../../../../prov/end_game_prov.dart';
import '../../../../prov/game/curr_game_prov.dart';
import '../../../../prov/game/game_curr_round_prov.dart';
import '../../../../prov/game/selected_players_prov.dart';
import '../../../../prov/game_result_prov.dart';
import '../../../../prov/global_providers.dart';
import '../../../../utils/cp_colors.dart';
import '../../../../utils/util_methods/util_methods.dart';
import '../../../../utils/util_widgets/util_texts.dart';
import '../../../game/widgets/dotted_chart_widget.dart';

class IgaGameContentScreen extends ConsumerStatefulWidget {
  const IgaGameContentScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaGameContentScreenState();
}

class _IgaGameContentScreenState extends ConsumerState<IgaGameContentScreen> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(gameResultProv);
    final game = ref.watch(currentGameProv);
    final firstActionStatus = ref.watch(currentFirstActionTimeManager) != null;
    List<PlayerResultModel> results =
        List<PlayerResultModel>.from(result?.playerResults ?? []);

    results.sort((a, b) => b.playerId.compareTo(a.playerId));

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.65.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (results.isEmpty)
            CustomCpInfoTexts.noScoreInGameWidget(
                context, game!.metaData.igaIngGameTextSpans),
          if (results.isEmpty && 's35' == game!.id)
            Text(
              ref.watch(currentBulBakalim)
                  ? L10n.inst(context).iga_pad_match_in_game_v2
                  : L10n.inst(context).iga_pad_match_in_game,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: CpColors.cpPrimary),
            ),
          if (results.isNotEmpty)
            ...results.map(IGAInGameSinglePlayerScore.new).joinWidgetList(
                  (index) => SizedBox(
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
                  ),
                ),
        ],
      ),
    );
  }
}

class IGAInGameSinglePlayerScore extends ConsumerWidget {
  const IGAInGameSinglePlayerScore(this.model, {super.key});

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
    final cBB = ref.watch(currentBulBakalim);
    late final RegisterUser? player;
    try {
      player =
          players?.firstWhere((element) => element.id == model.playerId).user;
    } catch (e) {
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
      playerColor = gamePlayers
          .firstWhere((element) => element.id == model.playerId)
          .clrs
          .first;
    } catch (e) {
      logger.d(e.toString());
    }

    bool dynamicScoreShowingEnabled =
        player?.userName != inst.mentor_controls_state_mentor &&
            (scoreCorrect != null || scoreIncorrect != null);

    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: dynamicContent(game!.id,
            context: context,
            averageDuration: averageDuration,
            scoreCorrect: scoreCorrect,
            scoreIncorrect: scoreIncorrect,
            showV2Text: ref.watch(currentBulBakalim),
            inst: inst,
            flspots: flspots,
            playerColor: playerColor,
            dynamicScoreShowingEnabled: dynamicScoreShowingEnabled,
            ref: ref),
      ),
    );
  }

  List<Widget> dynamicContent(String gameId,
      {BuildContext? context,
      Duration? averageDuration,
      int? scoreCorrect,
      int? scoreIncorrect,
      List<FlSpot>? flspots,
      bool? dynamicScoreShowingEnabled,
      AppLocalizations? inst,
      Color? playerColor,
      required WidgetRef ref,
      bool showV2Text = false}) {
    switch (gameId) {
      case 's16':
        return _igaFormula(context!, scoreCorrect ?? 0, averageDuration,
            scoreIncorrect ?? 0, flspots ?? []);
      case 's14':
        return _dikkatDikkatAndListenAndCatch(
            averageDuration,
            scoreCorrect,
            scoreIncorrect,
            flspots!,
            dynamicScoreShowingEnabled!,
            inst!,
            context!);
      case 's1':
        return _formulaYarisi(averageDuration, scoreCorrect, scoreIncorrect,
            flspots!, context!, inst!, playerColor);
      case '80':
      case '84':
        return _dikkatDikkatAndListenAndCatch(
            averageDuration,
            scoreCorrect,
            scoreIncorrect,
            flspots!,
            dynamicScoreShowingEnabled!,
            inst!,
            context!);
      case 's35':
        return scoreCounts(scoreCorrect, inst!, context!, scoreIncorrect,
            ref: ref, showV2Text: showV2Text);
      case 's4':
        return _teamWork(context!, scoreCorrect, averageDuration, ref);
    }
    return [];
  }

  List<Widget> _teamWork(BuildContext context, int? scoreCorrect,
      Duration? averageDuration, WidgetRef ref) {
    return [
      const Spacer(),
      Expanded(
          flex: 8,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: L10n.inst(context).iga_tap_pad_same_time.capitalize(),
                    style: Theme.of(ref.context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: CpColors.cpPrimary, fontSize: 15.sp)),
                textAlign: TextAlign.center,
              ),
              Gap(2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCpInformationCards.buildCardWithIcon(
                      iconPath: IgaAssets.pad.getPath,
                      title: L10n.inst(context).iga_catch_count,
                      size: 24.w,
                      context: context,
                      result: scoreCorrect.toString()),
                  CustomCpInformationCards.buildCardWithIcon(
                      iconPath: IgaAssets.high_five.getPath,
                      title:
                          L10n.inst(context).game_result_primary_score_harmony,
                      size: 24.w,
                      context: context,
                      result: averageDuration != null
                          ? '${averageDuration.inMilliseconds}ms'
                          : "-"),
                ],
              ),
            ],
          )),
      const Spacer(),
    ];
  }

  List<Widget> _formulaYarisi(
      Duration? averageDuration,
      int? scoreCorrect,
      int? scoreIncorrect,
      List<FlSpot> flspots,
      BuildContext context,
      AppLocalizations inst,
      Color? playerColor) {
    return [
      if (averageDuration != null &&
          (scoreCorrect != null || scoreIncorrect != null) &&
          flspots.isNotEmpty)
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCpInfoTexts.targetCounter(scoreCorrect.toString(),
                L10n.inst(context).score_target, context),
            SizedBox(height: 2.h),
            CustomDivider.gradientDivider(
                gradient: const LinearGradient(
                    colors: [CpColors.cpSecondary, CpColors.cpPrimary]),
                height: 0.5.h,
                width: 28.w),
            SizedBox(height: 2.h),
            CustomCpInformationCards.buildCardWithImage(
                title: inst.iga_your_average_reaction_time,
                boxValue: '${averageDuration.inMilliseconds}ms' ?? "-",
                height: 14.h,
                cardColor: CpColors.cpPrimary,
                width: 30.w,
                iconColor: fakeColorGenerator(playerColor!),
                context: context),
          ],
        ),
    ];
  }

  List<Widget> _dikkatDikkatAndListenAndCatch(
      Duration? averageDuration,
      int? scoreCorrect,
      int? scoreIncorrect,
      List<FlSpot> flspots,
      bool dynamicScoreShowingEnabled,
      AppLocalizations inst,
      BuildContext context) {
    return [
      Expanded(
        flex: 4,
        child: DottedChartWidget(
            tapCount: ((scoreCorrect ?? 0) + (scoreIncorrect ?? 0)),
            averageDuration:

                /// The above code is a comment in Dart programming language. Comments
                /// are used to provide explanations or notes within the code for
                /// better understanding. In Dart, single-line comments start with `//`
                /// and multi-line comments start with `/*` and end with `*/`.
                0,
            spots: flspots),
      ),
      if (dynamicScoreShowingEnabled)
        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCpInformationCards.buildCardWithImage(
                    title: inst.iga_your_average_reaction_time,
                    boxValue:
                        '${averageDuration != null ? '${averageDuration.inMilliseconds}ms' : "-"} ',
                    height: 15.h,
                    width: 44.w,
                    context: context),
                Column(
                  children: [
                    // Text(
                    //   inst.iga_pad_match_in_game,
                    //   style:
                    //       Theme.of(context).textTheme.headlineMedium!.copyWith(
                    //             color: CpColors.cpPrimary,
                    //           ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: scoreCounts(
                          scoreCorrect, inst, context, scoreIncorrect),
                    ),
                  ],
                ),
              ],
            )),
    ];
  }

  List<Widget> scoreCounts(int? scoreCorrect, AppLocalizations inst,
      BuildContext context, int? scoreIncorrect,
      {WidgetRef? ref, bool showV2Text = false}) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          () {
            if (showV2Text && !ref!.watch(currentShowTimerWidget)) {
              return Text(
                L10n.inst(context).iga_pad_match_in_game_v2,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: CpColors.cpPrimary),
              );
            } else {
              return  SizedBox(height: 12.h,);
            }
          }(),
          Row(
            children: [
              CustomCpInformationCards.buildBasicBox(
                  boxText: (scoreCorrect ?? 0).toString(),
                  boxName: inst.score_correct,
                  isColored: false,
                  insidePadding: dikkatDikkatBoxEdge(),
                  context: context),
              CustomCpInformationCards.buildBasicBox(
                  boxText: (scoreIncorrect ?? 0).toString(),
                  boxName: inst.score_wrong,
                  insidePadding: dikkatDikkatBoxEdge(),
                  isColored: false,
                  context: context),
              CustomCpInformationCards.buildBasicBox(
                  boxText:
                      ((scoreCorrect ?? 0) - (scoreIncorrect ?? 0)).toString(),
                  boxName: inst.score_total,
                  insidePadding: dikkatDikkatBoxEdge(),
                  forceTextColor: CpColors.cpPrimary,
                  isColored: false,
                  context: context),
            ],
          ),
        ],
      ),
    ];
  }

  EdgeInsets dikkatDikkatBoxEdge() =>
      EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 3.h);

  // ShowScoreDynamicallyWidget(
  //     correctCount: scoreCorrect,
  //     incorrectCount: scoreIncorrect,
  //     isTrueFalseGame: scoreIncorrect == null ? true : false,
  //     averageDuration: averageDuration?.formatSecondsMilli(context),
  //     maxDuration: maxDuration?.formatSecondsMilli(context),
  //     minDuration: minDuration?.formatSecondsMilli(context),
  //     totalTimeElapsed: null,
  //     game: game!),

  List<Widget> _igaFormula(BuildContext context, int? scoreCorrect,
      Duration? averageDuration, int? scoreIncorrect, List<FlSpot> flspots) {
    return [
      CustomCpInformationCards.buildCardWithIcon(
          iconPath: IgaAssets.pad.getPath,
          title: L10n.inst(context).iga_catch_count,
          size: 28.w,
          context: context,
          result: scoreCorrect.toString()),
      Gap(2.w),
      if (averageDuration != null &&
          (scoreCorrect != null || scoreIncorrect != null) &&
          flspots.isNotEmpty)
        DottedChartWidget(
            tapCount: ((scoreCorrect ?? 0) + (scoreIncorrect ?? 0)),
            averageDuration: 0,
            spots: flspots),
      Gap(2.w),
      CustomCpInformationCards.buildCardWithIcon(
          iconPath: IgaAssets.lightning.getPath,
          title: L10n.inst(context).iga_your_average_reaction_time,
          size: 28.w,
          context: context,
          result: '${averageDuration!.inMilliseconds}ms'),
    ];
  }
}
