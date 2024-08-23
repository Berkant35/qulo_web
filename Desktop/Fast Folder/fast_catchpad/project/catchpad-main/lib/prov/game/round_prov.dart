import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GameRoundEnum { ongoing, paused, disabled, enabled }

/// how it works:
/// when you wanna use this in a game, firstly, you have to call
/// [GameRoundProvNot.setEnabled] at the very start of your game,
/// as the game screen will not display control buttons if the state
/// is [GameRoundEnum.disabled], which is the default state, and the
/// state that we'll return to after the game is over.

final gameRoundProv = StateNotifierProvider<GameRoundProvNot, GameRoundEnum>(
  (ref) => GameRoundProvNot(),
);

class GameRoundProvNot extends StateNotifier<GameRoundEnum> {
  GameRoundProvNot() : super(GameRoundEnum.disabled);

  void _setTo(GameRoundEnum s) {
    if (state != GameRoundEnum.disabled) {
      try {
      state = s;
      } catch (e) {
        logger.d(e.toString());
      }
    }
  }

  void setPaused() => _setTo(GameRoundEnum.paused);
  void setOngoing() => _setTo(GameRoundEnum.ongoing);

  void setDisabled() => state = GameRoundEnum.disabled;
  void setEnabled() => state = GameRoundEnum.enabled;
}
