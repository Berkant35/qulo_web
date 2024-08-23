import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../catch_pad_icons.dart';
import '../../../prov/game/detail_game_prov.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/cp_icons.dart';
import '../../../utils/utils.dart';

class GameDetailProperties extends ConsumerWidget {
  const GameDetailProperties({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(detailGameProv);

    if (game == null) {
      assert(false);
      return const SizedBox();
    }

    final meta = game.metaData;

    return Column(
      children: [
        Row(
          children: {
            L10n.inst(context).game_ui_pad_count:
                '${meta.gamePadCount != null ? meta.gamePadCount!.rangeStr : meta.padCount.rangeStr} ${L10n.inst(context).game_ui_pad_count_pad}',
            L10n.inst(context).game_ui_player_count:
                '${meta.playerCount.rangeStr} ${L10n.inst(context).game_ui_player_count_player}',
          }.entries.map(
            (e) {
              return gameAttributeRow(e.key, e.value, context);
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Text(
                      e.key,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Center(
                        child: Text(
                          e.value,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                ],
              );*/
            },
          ).joinWidgetList(
            (e) => SizedBox(width: 2.w),
          ),
        ),
        SizedBox(
          width: 100.w,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: meta.earnings
                .map((earning) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: Chip(
                        label: Text(earning.textNotation(context),style: TextStyle(
                          fontSize: 14.sp
                        ),),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  /* BuildContext context, GameModel game, IconData iconData, */
  Row gameAttributeRow(String keyVal, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          keyVal == L10n.inst(context).game_ui_pad_count
              ? CatchPadIcons.cpCircle
              : CpIcons.profile,
          size: Theme.of(context).textTheme.titleLarge?.fontSize,
        ),
        SizedBox(width: 2.w),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: CpColors.defTextColor,
              ),
        ),
        SizedBox(width: 3.w),
        if (keyVal == L10n.inst(context).game_ui_pad_count)
          Text("\u2022",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: CpColors.defTextColor,
                  )),
      ],
    );
  }
}
/*L10n.inst(context).game_ui_earnings: meta.earnings
            .map((earning) => earning.textNotation(context))
            .join(', ')*/
