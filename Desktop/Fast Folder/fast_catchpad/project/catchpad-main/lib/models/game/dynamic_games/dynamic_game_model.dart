import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../prov/game_prov.dart';
import '../../enums/game/game_end_type.dart';
import '../../enums/game/game_score_type.dart';
import '../game_model.dart';
import '../player/staged_player_model.dart';
import 'instruction_model.dart';

export '../../enums/game/game_end_type.dart';
export '../../enums/game/game_score_type.dart';
export '../game_model.dart';
export 'instruction_model.dart';

part 'dynamic_game_model.g.dart';

@JsonSerializable()
class DynamicGameModel extends GameModel {
  final List<InstructionModel> instructions;

  final GameEndType gameEndType;
  final GameScoreType scoreTypeParam1;
  final GameScoreType? scoreTypeParam2;

  DynamicGameModel({
    required String id,
    List<StagedPlayerModel>? stagedPlayers,
    required this.instructions,
    required this.gameEndType,
    required this.scoreTypeParam1,
    this.scoreTypeParam2,
    required final GameMetaDataModel metaData,
    bool enabled = true,
  }) : super(
          metaData: metaData,
          id: id,
          enabled: enabled,
          // stagedPlayers: stagedPlayers,
        )
  //
  ;

  @override
  Future<void> execute(WidgetRef ref) async {
    await super.execute(ref);

    for (final ins in instructions) {
      await ins.execute(ref, null);
    }
  }

  @override
  Future<void> init(WidgetRef ref) async {
    await super.init(ref);

    ref.read(gameProv.notifier).setNotEnded();

    // if (players.isEmpty) {
    //   // assign devices to players

    //   final devices = ref.read(bleConPr).keys;

    //   final st = <StagedPlayerModel>[
    //     ...(stagedPlayers ?? []),
    //     if (generalStagedPlayer != null) generalStagedPlayer!,
    //   ];
    //   // rule 2
    //   if (st.length == 1) {
    //     final p = st[0];
    //     players = [p.toRandomPlayer(devices.toList())];
    //   } else {
    //     int i = 0;
    //     players = st.map(
    //       (p) {
    //         final cnt = p.deviceCount!;
    //         i += cnt;
    //         return p.toRandomPlayer(
    //           devices.skip(i).take(cnt).toList(),
    //         );
    //       },
    //     ).toList();
    //   }
    // }

    // ref.read(gameResultProv.notifier).init(
    //       GameResultModel(
    //         type: gameEndType,
    //         players: players,
    //         gameId: id,
    //         createdAt: DateTime.now(),
    //         scoreTypeParam1: scoreTypeParam1,
    //         scoreTypeParam2: scoreTypeParam2,
    //       ),
    //     );

    // ref.read(gameProv.notifier).setTo(this);
  }

  @override
  Future<void> dispose(WidgetRef ref) async {
    await super.dispose(ref);
  }

  factory DynamicGameModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicGameModelFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicGameModelToJson(this);

  @override
  GameModel copy() {
    return DynamicGameModel(
      id: id,
      metaData: metaData,
      // stagedPlayers: stagedPlayers,
      instructions: instructions,
      gameEndType: gameEndType,
      scoreTypeParam1: scoreTypeParam1,
    );
  }

  @override
  GameScoreType get getScoreType => scoreTypeParam1;
}

extension CpColorExt on Color {
  String toJson() => '$alpha,$red,$green,$blue';

  static Color fromJson(String json) {
    final List<String> parts = json.split(',');
    return Color.fromARGB(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
      int.parse(parts[3]),
    );
  }
}
