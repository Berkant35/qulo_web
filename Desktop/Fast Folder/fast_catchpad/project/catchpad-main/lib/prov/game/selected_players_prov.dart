import 'dart:math' as math;
import 'dart:math';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game/player/staged_player_model.dart';
import '../../models/auth/register_user.dart';
import '../../models/game/game_model.dart';
import '../../models/game/player/selected_player_model.dart';
import 'curr_game_prov.dart';

typedef SelectedPlayersSet = Set<SelectedPlayerModel>;
typedef PlayersSet = Set<PlayerModel>;
typedef StagedPlayersSet = Set<StagedPlayerModel>;
typedef ColorSet = Set<Color>;
typedef DeviceSet = Set<DeviceModel>;

extension SelPlImpl on SelectedPlayersSet {
  SelectedPlayerModel? operator [](String id) {
    try {
      final element = firstWhere((element) => element.id == id);
      return element;
    } catch (e) {
      return null;
    }
  }

  SelectedPlayersSet selectedPlayersOtherThan(String id) {
    return where((element) => element.id != id).toSet();
  }

  PlayersSet playersOtherThan(String id) {
    return selectedPlayersOtherThan(id).players;
  }

  StagedPlayersSet stagedPlayersOtherThan(String id) {
    return selectedPlayersOtherThan(id).stagedPlayers;
  }

  PlayersSet get players => map((e) => e.player).toSet();

  StagedPlayersSet get stagedPlayers => map((e) => e.staged).toSet();

  bool get allPlayersSatisfyConditions =>
      every((e) => e.playerSatisfiesConditions);

  bool allPlayersSatisfyConditionsWithWidgetRef(WidgetRef ref,
          {bool isIga = false}) =>
      every((e) => e.playerSatisfiesConditionsWithWidgetRef(ref, isIga: isIga));

  DeviceSet get devices => players.devices;

  ColorSet get colors => players.colors;
}

extension PlImpl on PlayersSet {
  /// gives us the maximum device count attached to a player.
  /// [player(dev: 3), player(dev: 4), player(dev: 1)] => 4
  int get maxPlayerDeviceCount {
    // this ridicilous condition is because for some reason crashes
    // when you call reduce on an empty Iterable.
    if (isEmpty) {
      return 0;
    }

    return reduce(
      (value, element) {
        return value.devCount > element.devCount ? value : element;
      },
    ).devCount;
  }

  DeviceSet get devices =>
      map((e) => e.devs).expand((element) => element).toSet();

  ColorSet get colors =>
      map((e) => e.clrs).expand((element) => element).toSet();
}

SelectedPlayersSet _newPlayersSet() => <SelectedPlayerModel>{};

final allUsersProv = StateProvider<List<RegisterUser>>((_) => []);

final selectedPlayersProv = StateNotifierProvider.autoDispose<
    SelectedPlayersProvNot, SelectedPlayersSet>(
  SelectedPlayersProvNot.new,
);

final selectedPlayersPlayersProv = StateProvider.autoDispose<PlayersSet>(
  (ref) {
    ref.keepAlive();
    return ref.watch(selectedPlayersProv).map((e) => e.player).toSet();
  },
);

class SelectedPlayersProvNot extends StateNotifier<SelectedPlayersSet> {
  final AutoDisposeStateNotifierProviderRef ref;

  SelectedPlayersProvNot(this.ref) : super({});

  void empty() {
    state = {};
  }

  void setTo(SelectedPlayersSet pl) {
    updateState(pl);
  }

  void add(SelectedPlayerModel entry) {
    final SelectedPlayersSet newState = {};

    newState.add(entry);

    for (final element in state) {
      if (element == entry) {
        continue;
      }

      newState.add(element);
    }

    updateState(newState);
  }

  void removeLast() {
    final SelectedPlayersSet newState = {};
    if (state.isNotEmpty) {
      for (final element in state) {
        if (element == state.last) {
          // we're decreasing the player id,
          // so when we regnerate another player
          // we'd get the arrangement right.
          // 1, 2, 3 -> generatedId = 3
          // removeLast(), decreaseId() -> generatedId = 2
          // 1, 2 -> generatedId = 2
          // addPlayer()
          // 1, 2, 3 -> generatedId = 3
          PlayerModel.decreaseId();
          continue;
        }

        newState.add(element);
      }
    }

    updateState(newState);
  }

  void setPlayer(PlayerModel newPlayer, {int? currentDevCount}) {

    //
    //
    // final currentDevCount2 = ref.watch(selectedPlayersProv).players.first.devs.length;
    // logger.i("Current Dev Count: $currentDevCount Current Dev Count 2: $currentDevCount2");
    // logger.d(currentDevCount);
    final newSelectedPlayer = SelectedPlayerModel(
      player: newPlayer,
      staged: state[newPlayer.id]!.staged.copyWith(
        // if the color count is not null, then we must force the color count
        colorCount: state[newPlayer.id]!.staged.colorDeviceDifference != null
            ? NumRange.padCount(
            min: (currentDevCount ?? 0) - (state[newPlayer.id]!.staged.colorDeviceDifference!),
            max: (currentDevCount ?? 0) - (state[newPlayer.id]!.staged.colorDeviceDifference!))
            : state[newPlayer.id]!.staged.colorCount,
      ),
    );

    add(newSelectedPlayer);
  }

  /// this method has gotten too long
  void updateState(SelectedPlayersSet newState) {
    final setup = ref.read(currentGameSetupProv)!;

    var devsAll = ref.read(bleConPr).keys.toList();

    devsAll.sort((a, b) => a.deviceNameId!.compareTo(b.deviceNameId!));
    final allDevs = devsAll.toSet();

    final setupPadCount = setup.padCount!;
    final setupPlayerCount = setup.playerCount!;

    /// as the comment above [GameMetaDataModel.padCount], the calculation
    /// done here is to calculate min required pad count for each player.
    final minPadForPlayer = setupPadCount.min ~/ setupPlayerCount.min;

    /// a brand empty value, that we're gonna assign to the state at the
    /// end of this method.
    final newMap = _newPlayersSet();

    /// the count of the players that are added to the current setup. by
    /// default we'll fill empty players as much as min player count. the
    /// user will have the option to add a player until max player count.
    /// so minPlayerCount <= chosenPlayersCount <= maxPlayerCount.
    final chosenPlayersCount = newState.length;

    /// we're gonna loop each player and update their mins, maxs, default
    /// devs etc.
    for (var selectedPlayer in newState) {
      final generalStaged =
          ref.read(currentGameSetupProv)?.generalStagedPlayerModel;

      final id = selectedPlayer.id;
      final otherSelectedPlayers = newState.selectedPlayersOtherThan(id);
      final otherPlayers = newState.playersOtherThan(id);

      final otherPlayersCount = otherSelectedPlayers.length;

      final maxOtherPlayerDeviceCount = otherPlayers.maxPlayerDeviceCount;

      final allOtherDevs = otherPlayers.devices;
      final unselectedDevs = allDevs.difference(allOtherDevs);

      var newPlayer = selectedPlayer.player.copyWith();
      var newStaged = selectedPlayer.staged.copyWith();

      NumRange? devCount = newStaged.deviceCount;

      if (devCount == null) {
        if (generalStaged == null || !generalStaged.hasDevs) {
          devCount = NumRange.padCount(min: 0, max: 0);
        }
      }

      if (devCount != null) {
        var newMin = minPadForPlayer;
        newMin = math.max(maxOtherPlayerDeviceCount, newMin);

        var newMax = (setupPadCount.max / chosenPlayersCount).floor();
        if (otherPlayersCount > 0) {
          newMax -= newMax % chosenPlayersCount;
          newMax = math.max(newMax, newMin);
        }

        newStaged = newStaged.copyWith(
          deviceCount: devCount.copyWith(
            min: newMin,
            max: newMax,
          ),
        );

        // if the player's dev count exceeds the max,
        // then we need to reduce it.
        // this may happen when the max count changes.
        if (newPlayer.devCount > newMax) {
          newPlayer = newPlayer.copyWith(
            devices: newPlayer.devs.sublist(0, newMin),
          );
        }

        // newPlayer.devCount == 0 means this is the first time
        // the player is being added. so we wanna initially
        // select default devices as much as the min device count
        // or if there is not enough devices available, the count
        // of left unselected devices.
        if (newPlayer.devCount == 0 && unselectedDevs.isNotEmpty) {
          newPlayer = newPlayer.copyWith(
            devices: unselectedDevs.toList().sublist(
                  0,
                  math.min(unselectedDevs.length, newMin),
                ),
          );
        }
      }

      newMap.add(
        SelectedPlayerModel(
          player: newPlayer,
          staged: newStaged,
        ),
      );
    }

    /// adding and removing operations in a set, change the order.
    /// when that happens our ui changes, e.g. first and second
    /// widgets may be swapped. so we need to sort the list.
    newMap.removeWhere((element) => element.player.createdAt == null);
    final sorted = newMap.toList()
      ..sort(
        (a, b) {
          return a.player.createdAt!.compareTo(b.player.createdAt!);
        },
      );
    final set = sorted.toSet();

    state = set;
  }
}

final selectedGeneralPlayerProv = StateNotifierProvider.autoDispose<
    SelectedGeneralPlayerProvNot, SelectedPlayerModel?>(
  SelectedGeneralPlayerProvNot.new,
);

class SelectedGeneralPlayerProvNot extends StateNotifier<SelectedPlayerModel?> {
  final Ref ref;

  SelectedGeneralPlayerProvNot(this.ref) : super(null);

  void setTo(SelectedPlayerModel? newPlayer) {
    if (newPlayer == null) {
      state = newPlayer;
      return;
    }

    var player = newPlayer.player;
    final staged = newPlayer.staged;

    if (player.devCount == 0) {
      if (staged.hasDevs) {
        final allDevs = ref.read(bleConPr).keys.toList();

        // this has been initialized in GamePlayersSetupWidget.initState
        final devCount = staged.deviceCount;

        // but still make a null check
        if (devCount == null) {
          assert(false);
        } else {
          // final minDevCount = devCount.min;
          final maxDevCount = devCount.max;

          final newDevs = allDevs.sublist(
            0,
            min(allDevs.length, maxDevCount),
          );

          player = player.copyWith(devices: newDevs);
        }
      }
    }
    player = player.copyWith(
        colors: newPlayer.player.clrs, name: newPlayer.player.name);

    state = SelectedPlayerModel(player: player, staged: newPlayer.staged);
  }

  void setPlayer(PlayerModel newPlayer, {int? currentDevCount}) {

    final newSelectedPlayer = SelectedPlayerModel(
      player: newPlayer,
      staged: state!.staged.copyWith(
        // if the color count is not null, then we must force the color count
        colorCount: state!.staged.colorDeviceDifference != null && currentDevCount != null
            ? NumRange.padCount(
                min: (currentDevCount!) - (state!.staged.colorDeviceDifference!),
                max: (currentDevCount!) - (state!.staged.colorDeviceDifference!))
            : state!.staged.colorCount,
      ),
    );

    setTo(newSelectedPlayer);
  }
}

final allSelectedPlayersProv = StateProvider<SelectedPlayersSet>(
  (ref) {
    final selectedPlayers = ref.read(selectedPlayersProv);
    final selectedGeneralPlayer = ref.read(selectedGeneralPlayerProv);
    return {
      ...selectedPlayers,
      if (selectedGeneralPlayer != null) selectedGeneralPlayer,
    };
  },
);
