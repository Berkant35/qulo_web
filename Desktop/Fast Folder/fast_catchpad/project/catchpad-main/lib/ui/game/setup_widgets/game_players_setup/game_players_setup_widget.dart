import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/game/player/player_model.dart';
import '../../../../models/game/player/selected_player_model.dart';
import '../../../../prov/default_color_prov.dart';
import '../../../../prov/game/curr_game_prov.dart';
import '../../../../prov/game/detail_game_prov.dart';
import '../../../../prov/game/selected_players_prov.dart';
import 'add_remove_player_buttons.dart';
import 'single_player_setup_widget/single_player_setup_widget.dart';

class GamePlayersSetupWidget extends ConsumerStatefulWidget {
  const GamePlayersSetupWidget({
    super.key,
  });

  @override
  ConsumerState<GamePlayersSetupWidget> createState() =>
      _GamePlayersSelectionWidgetState();
}

class _GamePlayersSelectionWidgetState
    extends ConsumerState<GamePlayersSetupWidget> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {

        ref.read(currentDefaultColorManager.notifier).refresh();
        ref.read(selectedPlayersProv.notifier).empty();

        final selectedOnes = ref.read(selectedPlayersProv);
        final selectedCount = selectedOnes.length;

        final setup = ref.read(detailGameSetupProv);

        if (setup == null) {
          assert(false);
          return;
        }

        final playerCountRange = setup.playerCount!;

        final minPlayerCount = playerCountRange.min;

        final stagedPlayer = setup.stagedPlayerModel;
        final generalStagedPlayer = setup.generalStagedPlayerModel;

        if (stagedPlayer == null && generalStagedPlayer == null) {
          assert(false);
          return;
        }

        // if the state does not have enoguh players added,
        // which has to be at this moment, we wanna initialize
        // empty players.
        if (selectedCount < minPlayerCount && stagedPlayer != null) {
          ref.read(selectedPlayersProv.notifier).setTo({});

          for (var i = selectedCount; i < minPlayerCount; i++) {

            final player = PlayerModel.id();

            final selectedPlayer = SelectedPlayerModel(
              player: player,
              staged: stagedPlayer,
            );

            ref.read(selectedPlayersProv.notifier).add(selectedPlayer);
          }
        }

        //
        var stagedGeneralPlayer = setup.generalStagedPlayerModel;
        if (stagedGeneralPlayer != null) {

          final generalPlayerProv = ref.read(selectedGeneralPlayerProv);

          if (generalPlayerProv == null) {
            final player = PlayerModel.general();

            final gamePadCount = setup.padCount!;

            if (stagedGeneralPlayer.hasDevs &&
                stagedGeneralPlayer.deviceCount == null) {
              stagedGeneralPlayer = stagedGeneralPlayer.copyWith(
                deviceCount: gamePadCount,
              );
            }

            final selectedPlayer = SelectedPlayerModel(
              player: player,
              staged: stagedGeneralPlayer,
            );

            ref.read(selectedGeneralPlayerProv.notifier).setTo(selectedPlayer);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(selectedPlayersProv);
    final generalPlayer = ref.watch(selectedGeneralPlayerProv);

    return Column(
      children: [
        ...players.map(
          (player) {
            return SinglePlayerSetupWidget(id: player.id);
          },
        ),
        const AddRemovePlayerButtons(),
        if (generalPlayer != null) const SingleGeneralPlayerSetupWidget(),
      ],
    );
  }
}
