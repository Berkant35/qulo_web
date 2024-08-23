import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game/dynamic_games/dynamic_game_model.dart';

final gameProv =
    StateNotifierProvider<GameNotifier, DynamicGameModel?>(GameNotifier.new);

class GameNotifier extends StateNotifier<DynamicGameModel?> {
  final StateNotifierProviderRef ref;
  GameNotifier(this.ref) : super(null);

  void setNotEnded() => _setEn(false);
  void setEnded() => _setEn(true);

  void _setEn(bool b) => ref.read(gameEndedProv.notifier).state = b;

  void setTo(DynamicGameModel g) => state = g;
}

final gameEndedProv = StateProvider<bool>((ref) => false);
