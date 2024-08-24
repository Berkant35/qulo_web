import 'package:audiotodo/utilities/constants/enums/meet/player_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerStateControlNotifier extends StateNotifier<CustomPlayerStates> {
  PlayerStateControlNotifier(CustomPlayerStates state)
      : super(CustomPlayerStates.idle);

  void changState(CustomPlayerStates val) => state = val;
}
