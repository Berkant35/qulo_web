import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/widgets/emb/iga/iga_util_widgets/color_selector.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/game/player/player_model.dart';
import '../../../../../prov/game/detail_game_prov.dart';
import '../../../../../prov/game/selected_players_prov.dart';

// A widget for setting up a single player in the IGA (Interactive Game Assistant) game.
// This widget can be used for both general players and specific players with a given ID.
class IGASinglePlayerSetupWidget extends ConsumerWidget {
  final String id;

  const IGASinglePlayerSetupWidget({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlayer = ref.watch(selectedPlayersProv)[id];
    if (selectedPlayer == null) {
      assert(false);
      return const SizedBox();
    }
    return _IGASinglePlayerSetupWidget(id: id);
  }
}

class IGASingleGeneralPlayerSetupWidget extends ConsumerWidget {
  const IGASingleGeneralPlayerSetupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _IGASinglePlayerSetupWidget(id: null);
  }
}

class _IGASinglePlayerSetupWidget extends ConsumerWidget {
  /// if null, means this is a general player
  final String? id;

  const _IGASinglePlayerSetupWidget({
    required this.id,
  });

  bool get isGeneralPlayer => id == null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.read(detailGameSetupProv);
    final gameId = ref.read(currentGameProv)!.id;

    final selectedPlayer =
        isGeneralPlayer && ref.watch(selectedGeneralPlayerProv) != null
            ? ref.watch(selectedGeneralPlayerProv)!
            : id != null
                ? ref.watch(selectedPlayersProv)[id!]!
                : ref.read(selectedPlayersProv).first;

    var player = selectedPlayer.player;
    final staged = selectedPlayer.staged;

    setPlayer(PlayerModel player, WidgetRef ref) {
      if (isGeneralPlayer) {
        ref.read(selectedGeneralPlayerProv.notifier).setPlayer(player);
      } else {
        ref.read(selectedPlayersProv.notifier).setPlayer(player);
      }
    }

    final otherPlayers = isGeneralPlayer
        ? <PlayerModel>{}
        : ref.watch(selectedPlayersProv).playersOtherThan(id!);

    final otherColors = isGeneralPlayer
        ? <Color>{}
        : (setup!.allowSameColor)
            ? <Color>{}
            : otherPlayers.colors;

    final otherDevices =
        isGeneralPlayer ? <DeviceModel>{} : otherPlayers.devices;

    final gm = ref.read(currentGameProv);

    gm!.players = ref.read(selectedPlayersProv).players.toList();

    ref.read(currentGameProv.notifier).setState(gm);

    for (var element in gm.players) {}

    Map<String, Color> mapDefaultColors = {};

    if (!setup!.allowSameColor) {
      for (int i = 0; i < gm.players.length; i++) {
        if (staged.defaultSelectedColors != null &&
            i < staged.defaultSelectedColors!.length) {
          mapDefaultColors
              .addAll({gm.players[i].id: staged.defaultSelectedColors![i]});
        }
      }
    }

    Future(() {
      if (player.colors.isEmpty &&
          staged.defaultSelectedColors != null &&
          otherColors.toList().isEmpty) {
        final newPlayer = player.copyWith(
          colors: [mapDefaultColors[player.id]!],
        );
        setPlayer(newPlayer, ref);
      } else if (player.colors.isEmpty && otherColors.toList().isEmpty) {
        final newPlayer = player.copyWith(
          colors: [defaultConstColors(ref).first],
        );
        setPlayer(newPlayer, ref);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ColorSelector(
          key: Key('InlineColorSelector$id$isGeneralPlayer'),
          selectedColors: (ref.watch(
                      currentCacheSetupManager)["${player.id}/$gameId"] !=
                  null)
              ? (ref.watch(currentCacheSetupManager)["${player.id}/$gameId"])
              : player.clrs.toSet(),
          disabledColors: otherColors.toSet(),
          min: staged.minClrCount ?? 1,
          max: staged.maxClrCount ?? 1,
          isOrdered: setup.isColorSelectOrder,
          onChange: (colors) async {
            final newPlayer = player.copyWith(
              colors: colors.toList(),
            );

            setPlayer(newPlayer, ref);
          },
        ),
        //Text('data'),
      ],
    );
  }
}

class SingleGeneralPlayerSetupWidgetV2 extends ConsumerWidget {
  const SingleGeneralPlayerSetupWidgetV2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _IGASinglePlayerSetupWidgetV2(id: null);
  }
}

class IGASinglePlayerSetupWidgetV2 extends ConsumerWidget {
  final String id;

  const IGASinglePlayerSetupWidgetV2({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlayer = ref.watch(selectedPlayersProv)[id];
    if (selectedPlayer == null) {
      assert(false);

      return const SizedBox();
    }

    return _IGASinglePlayerSetupWidgetV2(id: id);
  }
}

class _IGASinglePlayerSetupWidgetV2 extends ConsumerWidget {
  /// if null, means this is a general player
  final String? id;

  const _IGASinglePlayerSetupWidgetV2({
    required this.id,
    super.key,
  });

  bool get isGeneralPlayer => id == null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.read(detailGameSetupProv);
    final gameId = ref.read(currentGameProv)!.id;

    final selectedPlayer = isGeneralPlayer
        ? ref.watch(selectedGeneralPlayerProv)!
        : ref.watch(selectedPlayersProv)[id!]!;

    var player = selectedPlayer.player;
    final staged = selectedPlayer.staged;

    setPlayer(PlayerModel player, WidgetRef ref) {
      if (isGeneralPlayer) {
        ref.read(selectedGeneralPlayerProv.notifier).setPlayer(player);
      } else {
        ref.read(selectedPlayersProv.notifier).setPlayer(player);
      }
    }

    final otherPlayers = isGeneralPlayer
        ? <PlayerModel>{}
        : ref.watch(selectedPlayersProv).playersOtherThan(id!);

    final otherColors = isGeneralPlayer
        ? <Color>{}
        : (setup!.allowSameColor)
            ? <Color>{}
            : otherPlayers.colors;
    logger.i("Staged Has Color: ${staged.hasColors}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (staged.hasColors)
          ColorSelector(
            key: Key('InlineColorSelector$id$isGeneralPlayer'),
            selectedColors: (ref.watch(
                        currentCacheSetupManager)["${player.id}/$gameId"] !=
                    null)
                ? (ref.watch(currentCacheSetupManager)["${player.id}/$gameId"])
                : player.clrs.toSet(),
            disabledColors: otherColors.toSet(),
            min: staged.minClrCount,
            max: staged.maxClrCount,
            isOrdered: setup!.isColorSelectOrder,
            onChange: (colors) async {
              ref
                  .read(currentCacheSetupManager.notifier)
                  .setCacheSelectedColorValue(ref,
                      playerId: player.id, colors: colors, gameId: gameId);

              final newPlayer = player.copyWith(
                colors: colors.toList(),
              );

              setPlayer(newPlayer, ref);
            },
          )
      ],
    );
  }
}
