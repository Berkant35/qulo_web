import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/game_model.dart';
import '../../models/game/static_game_model.dart';
import 'curr_game_prov.dart';

// across the app, 2 game model states are being distributed:
// 1. detailGameProv
// 2. currentGameProv
// please refer to documentation/game_system/delivering_the_game.md
// for the details.

final detailGameSetupProv = Provider<StaticGameSetupModel?>(
  (ref) => ref.watch(detailGameProv)?.setup,
);

final detailGameProv =
    StateNotifierProvider<_DetailGameStateNotifier, StaticGameModel?>(
  _DetailGameStateNotifier.new,
);

class _DetailGameStateNotifier extends StateNotifier<StaticGameModel?> {
  final StateNotifierProviderRef ref;
  _DetailGameStateNotifier(this.ref) : super(null);

  void setState(StaticGameModel? game)
  {
    state = game;

    PlayerModel.resetId();

    ref.read(currentGameProv.notifier).setState(game);
    
  }
}
