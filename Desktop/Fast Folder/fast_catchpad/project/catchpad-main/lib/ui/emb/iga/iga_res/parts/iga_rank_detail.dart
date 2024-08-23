import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/util_widgets/util_information_cards.dart';
import '../../../../../utils/util_widgets/util_localizations.dart';

class RankDetail extends StatelessWidget {
  final double? height;
  final String name;

  final String? countryCode;
  final String gameId;
  final int reactionTime;
  final int percentage;
  final bool isPercentageAbove;

  const RankDetail({
    super.key,
    this.height,
    required this.name,
    required this.reactionTime,
    required this.countryCode,
    required this.gameId,
    required this.percentage,
    required this.isPercentageAbove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 35.h,
      decoration: BoxDecoration(
          color: CpColors.cpChineseBlack,
          border: Border.all(
            width: 0.2,
            color: CpColors.cpDavysGrey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    Container(
                        child: UtilLocalizations.getCountryFlag(
                            countryCode ?? "TR")),
                    const Gap(10),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: CustomCpInformationCards.buildBasicBox(
                        boxText: reactionTime.toString(),
                        width: 8.w,
                        height: 8.h,
                        textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 12.sp
                        ),
                        backgroundColor: CpColors.cpDavysGrey,
                        isColored: false,
                        boxType: BoxType.ms,
                        isNewVersion: true,
                        context: context),
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
          const Gap(25),
          Expanded(
              child: RichText(
                  text: TextSpan(children: [

            TextSpan(
                text: L10n.inst(context).avarage_comparison_first_part,
                style: Theme.of(context).textTheme.headlineMedium),
            const TextSpan(text: '      '),
            TextSpan(
              text: '%$percentage',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: percentage == 0
                        ? Colors.grey
                        : isPercentageAbove
                            ? Colors.green
                            : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const TextSpan(text: '      '),
            TextSpan(
                text: isPercentageAbove || percentage == 0
                    ? L10n.inst(context).avarage_comparison_second_part_above
                    :  L10n.inst(context).avarage_comparison_second_part_below,
                style: Theme.of(context).textTheme.headlineMedium!),
          ]))),
          const Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }
}
