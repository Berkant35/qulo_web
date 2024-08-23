import 'package:catchpad/prov/cancel_stream_prov.dart';
import 'package:catchpad/prov/current_loading_error_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../prov/end_game_prov.dart';
import '../../prov/game/selected_players_prov.dart';
import '../../prov/game_prov.dart';
import 'game_model.dart';
import 'static_game_setup_model.dart';

export '../enums/game/mentor_controls_state.dart';
export 'static_game_setup_model.dart';

typedef StaticGameExecutor = Future<void> Function(
    WidgetRef ref, StaticGameModel game);

class StaticGameModel extends GameModel {
  final StaticGameExecutor _execute;
  final StaticGameExecutor? _init;
  StaticGameSetupModel setup;

  StaticGameModel({
    required super.id,
    required StaticGameExecutor execute,
    StaticGameExecutor? init,
    required StaticGameSetupModel setup,
    required super.metaData,
    super.onLeaderboard,
    super.enabled,
    super.prioritized,
  })  : _execute = execute,
        _init = init,

        /// there are common attributes between metadata and setup,
        /// such as padcount, playercount, duration, distance, etc.
        /// so we need to merge them together.
        setup = setup.copyWithMetadata(metaData)
  //
  ;

  @override
  Future<void> execute(WidgetRef ref) async {
    final firstActionDateTimeController =
        ref.read(currentFirstActionTimeManager.notifier);
    firstActionDateTimeController.cancelAndClear();
    assert(ref.read(allSelectedPlayersProv).isNotEmpty);
    List<DiscoveredDevice> devs = [];

    if (ref.watch(selectedGeneralPlayerProv) == null) {
      devs = setup.getGameDevices(ref);
    } else {
      devs = ref.watch(selectedGeneralPlayerProv)!.player.devs;
    }

    for (var dev in devs) {
      await PadManager.isCommandRefresh(dev.id, ref: ref)
          .timeout(const Duration(milliseconds: 500));
    }

    await super.execute(ref);

    await _execute(ref, this);
  }

  @override
  Future<void> init(WidgetRef ref) async {
    final gameInitializeBreakPointProv = ref.read(currentGameInitializeBreakPoints.notifier);

    //g22-g23
    await super.init(ref);

    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g1, true);
    ref.read(boolValueProvider.notifier).disableResetEverythingAfterGameEnds();

    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g2, true);

    await _init?.call(ref, this);


    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g3, true);

    ref.read(gameProv.notifier).setNotEnded();


    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g4, true);

    //4-19
    await setup.init(
      ref: ref,
      game: this,
    );


    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g20, true);


    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g21, true);

  }

  @override
  Future<void> dispose(WidgetRef ref) async {
    await super.dispose(ref);
    try {
      ref.read(gameEndingProvider.notifier).end();
    } catch (e) {
      logger.d('game ended in dispose error: $e');
    }
    try {
      ref.read(gameProv.notifier).setEnded();
    } catch (e) {
      logger.d('error in dispose: $e');
    }
  }

  @override
  StaticGameModel copy() {
    final cp = StaticGameModel(
      id: id,
      onLeaderboard: onLeaderboard,
      metaData: metaData,
      execute: _execute,
      init: _init,
      setup: setup,
    );
    return cp;
  }

  @override
  GameScoreType get getScoreType => setup.scoreTypeParam1;
}
