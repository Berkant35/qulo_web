import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/game_model.dart';
import '../../models/game/static_game_model.dart';
import 'detail_game_prov.dart';

// across the app, 2 game model states are being distributed:
// 1. detailGameProv
// 2. currentGameProv
// please refer to documentation/game_system/delivering_the_game.md
// for the details.

final currentGameSetupProv = Provider<StaticGameSetupModel?>(
  (ref) => ref.watch(currentGameProv)?.setup,
);

final currentGameMetaDataProv = Provider<GameMetaDataModel?>(
  (ref) => ref.watch(currentGameProv)?.metaData,
);

final currentGameProv =
    StateNotifierProvider<_CurrentGameStateNotifier, StaticGameModel?>(
  (ref) => _CurrentGameStateNotifier(),
);

class _CurrentGameStateNotifier extends StateNotifier<StaticGameModel?> {
  _CurrentGameStateNotifier() : super(null);

  Future<void> init(WidgetRef ref) async {
    await state?.init(ref);
  }

  void reset(WidgetRef ref) {
    state = ref.read(detailGameProv);
  }

  void setState(StaticGameModel? value) {
    state = value;
  }

  void setSetup(StaticGameSetupModel model) {
    final copy = state?.copy();
    copy?.setup = model;
    state = copy;
  }
}
