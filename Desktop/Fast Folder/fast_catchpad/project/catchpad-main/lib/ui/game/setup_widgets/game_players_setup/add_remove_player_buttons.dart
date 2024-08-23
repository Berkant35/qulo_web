import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/ui/game/special_conditions_for_games.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/game/player/player_model.dart';
import '../../../../models/game/player/selected_player_model.dart';
import '../../../../prov/game/detail_game_prov.dart';
import '../../../../prov/game/selected_players_prov.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/buttons/cp_button_1.dart';
import '../../../widgets/buttons/cp_button_2.dart';

class AddRemovePlayerButtons extends ConsumerWidget {
  const AddRemovePlayerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(selectedPlayersProv);
    final setup = ref.watch(detailGameSetupProv);

    if (setup == null) {
      assert(false);
      return const SizedBox();
    }
    final staged = setup.stagedPlayerModel;

    final playerCountRange = setup.playerCount!;

    final minPlayerCount = playerCountRange.min;
    final maxPlayerCount = playerCountRange.max;
    final playerCount = players.length;
    final unfilledSlot = maxPlayerCount - playerCount;
    final filledSlot = playerCount - minPlayerCount;
    final game = ref.watch(detailGameProv);


    return Row(
      children: [
        if (staged != null &&
            unfilledSlot > 0 &&
            checkSpecialCondition(game!.id, ref))
          CpButton2(
            fullWidth: true,
            onPressed: () {
              ref.read(selectedPlayersProv.notifier).add(
                    SelectedPlayerModel(
                      player: PlayerModel.id(),
                      staged: staged,
                    ),
                  );
            },
            child: Text(L10n.inst(context).game_ui_add_player),
          ),
        if (filledSlot > 0)
          CpButton1(
            fullWidth: true,
            onPressed: () {
              ref.read(selectedPlayersProv.notifier).removeLast();
            },
            child: Text(L10n.inst(context).game_ui_remove_player),
          ),
      ]
          .map(
            (e) => Expanded(child: e),
          )
          .joinWidgetList(
            (e) => const SizedBox(
              width: defPaddingSize,
            ),
          ),
    );
  }
}
class AddRemovePlayerButtonsV2 extends ConsumerWidget {
  const AddRemovePlayerButtonsV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(selectedPlayersProv);
    final setup = ref.watch(detailGameSetupProv);

    if (setup == null) {
      assert(false);
      return const SizedBox();
    }
    final staged = setup.stagedPlayerModel;

    final playerCountRange = setup.playerCount!;

    final minPlayerCount = playerCountRange.min;
    final maxPlayerCount = playerCountRange.max;
    final playerCount = players.length;
    final unfilledSlot = maxPlayerCount - playerCount;
    final filledSlot = playerCount - minPlayerCount;
    final game = ref.watch(detailGameProv);


    return Row(
      children: [
        if (staged != null &&
            unfilledSlot > 0 &&
            checkSpecialCondition(game!.id, ref))
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.5.w),
            child: CustomCatchpadButtons.buildBorderButton(
              ref: ref,
              onPressed: () {
                ref.read(selectedPlayersProv.notifier).add(
                  SelectedPlayerModel(
                    player: PlayerModel.id(),
                    staged: staged,
                  ),
                );
              },
              height: 6.h,
              borderColor: CpColors.cpChineseBlack,
              borderRadius: 4.w,
              text: L10n.inst(context).game_ui_add_player+" +",
            ),
          ),
        if (filledSlot > 0)
          CustomCatchpadButtons.buildBorderButton(
            ref: ref,
            onPressed: () {
              ref.read(selectedPlayersProv.notifier).removeLast();
            },
            text: L10n.inst(context).game_ui_remove_player,
          ),
      ]
          .map(
            (e) => Expanded(child: e),
      )
          .joinWidgetList(
            (e) => const SizedBox(
          width: defPaddingSize,
        ),
      ),
    );
  }
}