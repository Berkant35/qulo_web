import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/widgets/buttons/cp_btn.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_screens/classes_screen.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/auth/register_user.dart';
import '../../../../../models/game/player/player_model.dart';
import '../../../../../models/game/player/selected_player_model.dart';
import '../../../../../models/game/player/staged_player_model.dart';
import '../../../../../prov/auth/current_user_prov.dart';
import '../../../../../prov/class_provider.dart';
import '../../../../../prov/default_color_prov.dart';
import '../../../../../prov/game/detail_game_prov.dart';
import '../../../../../prov/game/selected_players_prov.dart';
import '../../../../../utils/util_widgets/util_selection.dart';
import '../../../../../utils/utils.dart';
import '../../../../widgets/inline_color_selector.dart';
import '../player_pad_selector.dart';

part 'single_player_name_setup_widget.dart';

class SinglePlayerSetupWidget extends ConsumerWidget {
  final String id;

  const SinglePlayerSetupWidget({
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

    return _SinglePlayerSetupWidget(id: id);
  }
}

class SingleGeneralPlayerSetupWidget extends ConsumerWidget {
  const SingleGeneralPlayerSetupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _SinglePlayerSetupWidget(id: null);
  }
}

class _SinglePlayerSetupWidget extends ConsumerWidget {
  /// if null, means this is a general player
  final String? id;

  const _SinglePlayerSetupWidget({
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
        ref
            .read(selectedGeneralPlayerProv.notifier)
            .setPlayer(player, currentDevCount: player.devCount);
      } else {
        ref
            .read(selectedPlayersProv.notifier)
            .setPlayer(player, currentDevCount: player.devCount);
      }
    }

    Future(() async {
      final res = ref
          .read(currentCacheSetupManager.notifier)
          .getCacheSelectedColorValue(ref, playerId: player.id, gameId: gameId,
              setVal: (Set<Color>? colors) {
        if (colors != null) {
          final newPlayer = player.copyWith(colors: colors.toList());
          setPlayer(newPlayer, ref);
        }
      });

      if (res == null && player.colors.isEmpty) {
        final anyAvailableColor = ref
            .read(currentDefaultColorManager.notifier)
            .getOneAvailableColor();
        if (anyAvailableColor != null) {
          final newPlayer = player.copyWith(colors: [anyAvailableColor]);
          setPlayer(newPlayer, ref);
        }
      }
    });

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (id != null) _SinglePlayerNameSetupWidget(id: id!),
        if (staged.hasColors)
          InlineColorSelector(
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
              logger.i("Select Color: $colors ${newPlayer.toJson()}");

              setPlayer(newPlayer, ref);
            },
          ),
        //Text('data'),
        if (staged.hasDevs)
          PlayerPadSelector(
            key: Key('PlayerPadSelector$id$isGeneralPlayer'),
            selectedDevs: player.devs.toSet(),
            disabledDevs: otherDevices.toSet(),
            min: staged.minDevCount,
            // we've null checked by using .hasDevs
            max: staged.maxDevCount!,
            onChange: (devs) {
              if (!devs.contains(ref.read(currentMainBaseDiscoveredState))) {
                final list = devs
                    .where((element) => element.name == mainCatchpadName)
                    .toList();
                final isThereOneCatchpad = list.isNotEmpty;
                ref.read(currentMainBaseDiscoveredState.notifier).changState(
                    isThereOneCatchpad
                        ? list.first
                        : devs.firstWhere(
                            (element) => element.name != mainCatchpadName),ref: ref);
              }

              setPlayer(player.copyWith(devices: devs.toList()), ref);
            },
          ),
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
    return const _SinglePlayerSetupWidgetV2(id: null);
  }
}

class SinglePlayerSetupWidgetV2 extends ConsumerWidget {
  final String id;

  const SinglePlayerSetupWidgetV2({
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

    return _SinglePlayerSetupWidgetV2(id: id);
  }
}

class _SinglePlayerSetupWidgetV2 extends ConsumerWidget {
  /// if null, means this is a general player
  final String? id;

  const _SinglePlayerSetupWidgetV2({
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
        ref
            .read(selectedGeneralPlayerProv.notifier)
            .setPlayer(player, currentDevCount: player.devCount);
      } else {
        ref
            .read(selectedPlayersProv.notifier)
            .setPlayer(player, currentDevCount: player.devCount);
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
    Future(() {
      ref
          .read(currentCacheSetupManager.notifier)
          .getCacheSelectedColorValue(ref, playerId: player.id, gameId: gameId,
              setVal: (Set<Color>? colors) {
        if (colors != null) {
          final newPlayer = player.copyWith(colors: colors.toList());
          setPlayer(newPlayer, ref);
        }
      });
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (id != null) _SinglePlayerNameSetupWidget(id: id!),
        if (staged.hasColors)
          CustomCatchpadSelections.dfContainerFromStatus(
              content: InlineColorSelectorV2(
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
              logger.i("Select Color: $colors ${newPlayer.toJson()}");

              setPlayer(newPlayer, ref);
            },
          )),
        if (staged.hasDevs)
          PlayerPadSelector(
            key: Key('PlayerPadSelector$id$isGeneralPlayer'),
            selectedDevs: player.devs.toSet(),
            disabledDevs: otherDevices.toSet(),
            oldSystem: false,
            min: staged.minDevCount,
            // we've null checked by using .hasDevs
            max: staged.maxDevCount!,
            onChange: (devs) {
              if (!devs.contains(ref.read(currentMainBaseDiscoveredState))) {
                final list = devs
                    .where((element) => element.name == mainCatchpadName)
                    .toList();
                final isThereOneCatchpad = list.isNotEmpty;
                ref.read(currentMainBaseDiscoveredState.notifier).changState(
                    isThereOneCatchpad
                        ? list.first
                        : devs.firstWhere(
                            (element) => element.name != mainCatchpadName),ref:ref);
              }

              setPlayer(player.copyWith(devices: devs.toList()), ref);
            },
          ),
      ],
    );
  }
}
