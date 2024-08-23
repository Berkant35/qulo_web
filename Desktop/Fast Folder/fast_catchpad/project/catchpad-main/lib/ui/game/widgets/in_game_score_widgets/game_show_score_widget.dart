import 'package:auto_size_text/auto_size_text.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/game/static_game_model.dart';
import '../../../../utils/cp_colors.dart';
import '../../../../utils/utils.dart';

class ShowScoreDynamicallyWidget extends ConsumerWidget {
  const ShowScoreDynamicallyWidget(
      {super.key,
      this.correctCount,
      this.incorrectCount,
      required this.game,
      required this.isTrueFalseGame,
      required this.averageDuration,
      required this.minDuration,
      required this.maxDuration,
      required this.totalTimeElapsed});

  final int? correctCount, incorrectCount;
  final StaticGameModel game;
  final bool isTrueFalseGame;
  final String? averageDuration;
  final String? minDuration;
  final String? maxDuration;
  final String? totalTimeElapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNewVersion = ref.read(currentNewVersionState);
    final inst = L10n.inst(context);
    String averagetext = game.setup.scoreTypeParam1 == GameScoreType.teamHarmony
        ? inst.game_result_primary_score_harmony
        : inst.activity_result_screen_average;
    var bigScoreRowWidgetList = [
      Flexible(
        child: BigScoreRowWidget(
          count: '${maxDuration ?? '0'}s',
          subtitle: inst.activity_result_screen_maximum,
        ),
      ),
      Flexible(
        child: BigScoreRowWidget(
          count: '${minDuration ?? '0'}s',
          subtitle: inst.activity_result_screen_minimum,
        ),
      ),
      Flexible(
        child: BigScoreRowWidget(
          count: '${averageDuration ?? '0'}s',
          subtitle: averagetext,
        ),
      ),
      if (game.setup.isScore)
        Flexible(
            child: BigScoreRowWidget(
                count: ((correctCount ?? 0) + (incorrectCount ?? 0)).toString(),
                subtitle: inst.activity_result_screen_total_hits)),
      if (totalTimeElapsed != null)
        Flexible(
          child: BigScoreRowWidget(
            count: totalTimeElapsed!,
            subtitle: inst.activity_result_screen_total_time,
          ),
        ),
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: defPaddingSize),
      child: Container(
        padding: const EdgeInsets.all(defPaddingSize),
        decoration: BoxDecoration(
            color: ref.read(currentEmbModeManager) == 0 && !isNewVersion
                ? const Color(0xFF333846).withOpacity(0.8)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(defPaddingSize)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (game.setup.isScore) ...[
                  Flexible(
                    child: ScoreShowerWidget(
                      count: (correctCount ?? 0).toString(),
                      subtitle: (game.getScoreType == GameScoreType.teamHarmony)
                          ? inst.score_target
                          : inst.score_correct,
                    ),
                  ),
                  Flexible(
                    child: ScoreShowerWidget(
                      count: (incorrectCount ?? 0).toString(),
                      subtitle: inst.score_wrong,
                    ),
                  ),
                  Flexible(
                    child: ScoreShowerWidget(
                      count: (((correctCount ?? 0) - (incorrectCount ?? 0)) > 0
                              ? ((correctCount ?? 0) - (incorrectCount ?? 0))
                              : 0)
                          .toString(),
                      subtitle: inst.score_total,
                    ),
                  )
                ],
                if (!game.setup.isScore) ...[
                  Flexible(
                    child: ScoreShowerWidget(
                      count: (correctCount ?? 0).toString(),
                      subtitle: inst.score_target,
                    ),
                  )
                ]
              ].joinWidgetList(
                  (index) => const SizedBox(width: defPaddingSize)),
            ),
            if (averageDuration != null &&
                minDuration != null &&
                maxDuration != null) ...[
              () {
                return ref.read(currentEmbModeManager) == 0
                    ? Divider(
                        color:
                            isNewVersion ? CpColors.cpPrimary : Colors.white70,
                        thickness: 1.25,
                        indent: 12,
                        endIndent: 12)
                    : Container(
                        height: 1.25,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              CpColors.cpPrimary,
                              CpColors.cpDividerGradient
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      );
              }(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: bigScoreRowWidgetList.joinWidgetList((index) =>
                    SizedBox(
                        width: (bigScoreRowWidgetList.length > 3) ? 3 : 30)),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class ScoreShowerWidget extends ConsumerWidget {
  const ScoreShowerWidget(
      {super.key, required this.count, required this.subtitle});
  final String count;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNewVersion = ref.read(currentNewVersionState);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(isNewVersion ? 10 : defPaddingSize),
          decoration: BoxDecoration(
              color:
                  isNewVersion ? Colors.grey.withOpacity(0.2) : CpColors.bgGC2,
              borderRadius: BorderRadius.circular(defPaddingSize)),
          width: MediaQuery.of(context).size.width / 4.5,
          alignment: Alignment.center,
          child: Text(
            count,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
        ),
        Text(subtitle)
      ],
    );
  }
}

class BigScoreRowWidget extends ConsumerWidget {
  const BigScoreRowWidget(
      {super.key, required this.count, required this.subtitle});
  final String count;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNewVersion = ref.read(currentNewVersionState);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(isNewVersion ? 8 : 3),
          decoration: BoxDecoration(
              color:
                  isNewVersion ? Colors.grey.withOpacity(0.2) : CpColors.bgGC2,
              borderRadius: BorderRadius.circular(defPaddingSize)),
          alignment: Alignment.center,
          child: Text(count.replaceAll(' s', ''),
              textDirection: TextDirection.ltr, textAlign: TextAlign.center),
        ),
        AutoSizeText(
          subtitle,
          softWrap: true,
          textScaleFactor: 0.7,
          maxLines: 1,
        )
      ],
    );
  }
}
