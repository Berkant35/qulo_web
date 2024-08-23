import 'package:auto_size_text/auto_size_text.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../models/game/game_result_model.dart';
import '../../../../utils/cp_colors.dart';
import '../../../../utils/utils.dart';

class DynamicGameScoreWidget extends ConsumerWidget {
  const DynamicGameScoreWidget(
      {super.key,
      required this.score,
      this.primaryScoreOverRuleString,
      this.onleaderboard,
      this.showFlag = false,
      required this.index,
      required this.indexvalues});
  final String score;
  final int? index;
  final bool showFlag;
  final List<int>? indexvalues;
  final bool? onleaderboard;
  final String? primaryScoreOverRuleString;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNewVersion = ref.read(currentNewVersionState);
    final inst = L10n.inst(context);
    return Container(
      padding: EdgeInsets.all(isNewVersion ? 10 : defPaddingSize),
      decoration: BoxDecoration(
          color: isNewVersion
              ? Colors.grey.withOpacity(0.2)
              : const Color(0xFF333846).withOpacity(0.8),
          borderRadius: BorderRadius.circular(isNewVersion
              ? 28 : defPaddingSize)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (index != null &&
                  index != 0 &&
                  onleaderboard == true &&
                  showFlag)
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Container(
                            decoration: const BoxDecoration(
                              color: CpColors.red,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(defPaddingSize),
                            child: const Icon(FontAwesomeIcons.trophy),
                          ),
                        ],
                      ),
                      Container(
                        width: 35,
                        decoration: BoxDecoration(
                          color: index! <= 3
                              ? CpColors.resultTileWinnerTrophyColor
                              : CpColors.resultTileUnWinnerTrophyColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: halfDefPaddingSize,
                          vertical: defPaddingSize,
                        ),
                        child: Text(
                          "$index",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ]),
              if ((index == null || index == 0) && !showFlag)
                const Icon(Icons.flag_sharp),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      (primaryScoreOverRuleString ?? primaryScoreString),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                          padding: const EdgeInsets.all(defPaddingSize),
                          width: MediaQuery.of(context).size.width / 3.5,
                          height: MediaQuery.of(context).size.height / 13,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: CpColors.bgGC2,
                              borderRadius: BorderRadius.circular(
                                  isNewVersion ? 28 : defPaddingSize)),
                          child: AutoSizeText(
                            score,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: isNewVersion
                                        ? CpColors.cpPrimary
                                        : Colors.amber),
                          )),
                    ),
                    Flexible(
                        child: Text(inst.activity_default_scores_total_score)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
