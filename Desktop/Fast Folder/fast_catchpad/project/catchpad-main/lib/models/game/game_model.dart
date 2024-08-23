import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../managers/cp_audio_player.dart';
import '../../managers/static_game_manager.dart';
import '../../prov/current_loading_error_prov.dart';
import '../../prov/game/game_curr_round_prov.dart';
import '../enums/game/game_score_type.dart';
import 'metadata/game_metadata_model.dart';
import 'player/player_model.dart';

export 'metadata/game_metadata_model.dart';
export 'player/player_model.dart';

abstract class GameModel {
  final String id;
  final bool enabled;
  final GameMetaDataModel metaData;

  /// TODO: this is a temp thing to show
  /// our working games at the top
  final bool prioritized;

  // final List<StagedPlayerModel>? stagedPlayers;
  // StagedPlayerModel? generalStagedPlayer;

  @JsonKey(ignore: true)
  List<PlayerModel> players = [];
  PlayerModel? generalPlayer;
  @Default(false)
  bool onLeaderboard;

  GameModel({
    required this.id,
    required this.metaData,
    // this.generalStagedPlayer,
    // required this.stagedPlayers,
    this.enabled = true,
    this.prioritized = false,
    this.onLeaderboard = false,
  })
  // :
  // assert(
  //   isPresentationApp ||
  //       generalStagedPlayer != null ||
  //       (stagedPlayers != null && stagedPlayers.isNotEmpty),
  //   'rule 1: there should be at least 1 player',
  // ),
  // assert(
  //   isPresentationApp ||
  //       generalStagedPlayer != null ||
  //       (stagedPlayers != null &&
  //           (stagedPlayers.length == 1 ||
  //               stagedPlayers.every(
  //                 (element) {
  //                   return element.deviceCount != null &&
  //                       element.deviceCount! > 0;
  //                 },
  //               )
  //           //
  //           )

  //       //
  //       ),
  //   'rule 2: if this is multiplayer game, each player should specify its device count.',
  // )
  //
  ;

  String get title => metaData.name;

  List<PlayerModel> get allPlayers {
    return [
      ...players,
      if (generalPlayer != null) generalPlayer!,
    ];
  }

  List<DeviceModel> get allDevices {
    return allPlayers
        .expand(
          (element) => element.devs,
        )
        .toList();
  }

  Future<bool> _turnAllOff(WidgetRef ref) async {

    return StaticGameManager.ledAllOffNoDelay(ref: ref);
  }

  @mustCallSuper
  Future<void> init(WidgetRef ref) async {
    var gameInitializeBreakPointProv = ref.read(currentGameInitializeBreakPoints.notifier);
    ref.read(gameCurrRoundProv.notifier).reset();
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g22, true);
    _turnAllOff(ref);

    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g23, true);

  }

  @mustCallSuper
  Future<void> execute(WidgetRef ref) async {}

  @mustCallSuper
  Future<void> dispose(WidgetRef ref) async {
    try {
      ref.read(cpAudioPlayerProv).dispose();
    } catch (e) {
      logger.d('error disposing audio player: $e');
    }
    /* try {
      await _turnAllOff(ref);
    } catch (e) {
      logger.d('error turning all off: $e');
    } */
  }

  @mustCallSuper
  GameModel copy();

  GameScoreType get getScoreType;
}
