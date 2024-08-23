import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../prov/game/selected_players_prov.dart';

bool playerBiggerEqualGeneralPlayerDevLength(WidgetRef ref) {
  // player length needs to be lesser than device count / atleast 1 less
  final playerLength = ref.watch(selectedPlayersProv).length;
  final devLength = ref.watch(selectedGeneralPlayerProv)?.player.devCount ?? 1;
  if (playerLength < devLength-1) {
    return true;
  }
  return false;
}

bool checkSpecialCondition(String gameId, WidgetRef ref) {
  // if true can not press start game
  switch (gameId) {
    case 's1':
      return playerBiggerEqualGeneralPlayerDevLength(ref);
    case '73':
      return playerBiggerEqualGeneralPlayerDevLength(ref);
    default:
      return true;
  }
}