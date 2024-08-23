import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../catch_pad_icons.dart';
import '../ui/auth/profile_screen.dart';
import '../ui/device/device_ls.dart';
import '../ui/game/select_game_screen.dart';
import '../ui/leaderboard/leaderboard_screen.dart';
import '../utils/cp_icons.dart';

enum BottomBarItemIndex {
  home,
  search,
  leaderboard,
  profile /*    */;

  bool get isSearch => this == BottomBarItemIndex.search;
}

class BottomBarItem {
  final BottomBarItemIndex indexEnum;
  final IconData icon;
  final Widget body;

  const BottomBarItem({
    required this.indexEnum,
    required this.icon,
    required this.body,
  });

  int get index => indexEnum.index;
  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is BottomBarItem &&
          runtimeType == other.runtimeType &&
          indexEnum == other.indexEnum;

  @override
  int get hashCode => indexEnum.hashCode;
}

final bottomBarProvider =
    StateNotifierProvider<BottomBarNotifier, BottomBarItem>(
  (ref) => BottomBarNotifier(),
);

class BottomBarNotifier extends StateNotifier<BottomBarItem> {
  BottomBarNotifier() : super(bottomBarItems[0]);

  void setBottomBarItem(int index, WidgetRef ref) {
    EasyLoading.dismiss();

    final connectedCount = ref
        .watch(bleConPr)
        .values
        .where((element) =>
            element.connectionState == DeviceConnectionState.connected)
        .length;



    final isConnectionContinue = ref.watch(connectingStateControlProv);

    Set<String> deadListKey = ref.read(currentDeadListManager).toSet();
    Set<String> batteryMap = ref.read(currentBatteryOfPadsManager).keys.toSet();

    final differenceDeviceKeys = batteryMap.difference(deadListKey);

    final knownBatteriesCount = differenceDeviceKeys.length;

    /*if (ref.watch(currentAllConnectionStates)) {
      CustomDialogs.connectionNotCompleted(ref,
          desc2:
              L10n.inst(ref.context).connection_not_completed_dialogue_content_2);
      return;
    }*/
    
    

    if (knownBatteriesCount != connectedCount && state.index == 1 ||
        isConnectionContinue) {
      CustomDialogs.connectionNotCompleted(ref);
      return;
    }

    state = bottomBarItems[index];
    if (index == 1) {
      //Dispose Auto Connect Because Maybe forcing to disconnect
      ref.read(bleAutoConnectStateNotifierProv.notifier).changState(false);
    } else {
      //Enable Auto Connect
      ref.read(bleAutoConnectStateNotifierProv.notifier).changState(true);
    }
  }
}

const bottomBarItems = [
  BottomBarItem(
    indexEnum: BottomBarItemIndex.home,
    icon: CpIcons.home,
    body: SelectGameScreen(),
  ),
  BottomBarItem(
    indexEnum: BottomBarItemIndex.search,
    icon: CatchPadIcons.cpCircle,
    body: DeviceLS(),
  ),
  BottomBarItem(
    indexEnum: BottomBarItemIndex.leaderboard,
    icon: CpIcons.leaderboard,
    body: LeaderBoardScreen(),
  ),
  BottomBarItem(
    indexEnum: BottomBarItemIndex.profile,
    icon: CpIcons.profile,
    body: ProfileScreen(),
  ),
  /* BottomBarItem(
    indexEnum: BottomBarItemIndex.create,
    icon: CpIcons.createGame,
    body: CreateGameScreen(),
  ), */
];
