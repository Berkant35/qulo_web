import 'package:catchpad/managers/asset_manager.dart';
import 'package:catchpad/prov/effect/show_effect_prov.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums/game/game_score_type.dart';
import '../models/game/game_result_model.dart';
import '../models/game/player/player_model.dart';
import '../models/game/player_result_model.dart';
import '../models/game/score_point_model.dart';
import 'current_loading_error_prov.dart';
import 'game/curr_game_prov.dart';
import 'global_providers.dart';

export '../models/game/game_result_model.dart';

final gameResultProv =
    StateNotifierProvider<GameResultNotifier, GameResultModel?>(
  GameResultNotifier.new,
);

class GameResultNotifier extends StateNotifier<GameResultModel?> {
  final StateNotifierProviderRef ref;
  late WidgetRef? widgetRef;
  int counterLocale = 0;
  GameResultNotifier(this.ref) : super(null);

  void init(GameResultModel g,WidgetRef ref) {
    counterLocale = 0;
    var gameInitializeBreakPointProv = ref.read(currentGameInitializeBreakPoints.notifier);
    widgetRef = ref;
    final currGame = ref.read(currentGameProv);
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g5, true);
    final players = currGame?.players;
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g6, true);
    if (players == null)
    {
      logger.e("Players Null!!");
      state = g;
      gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g7, true);
      return;
    }
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g8, true);
    final newG = g.copyWith(players: players);
    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g9, true);
    state = newG;

    gameInitializeBreakPointProv.updateBreakPoint(BreakPoints.g10, true);
  }

  @override
  void dispose() {
    state = null;
    super.dispose();
  }

  bool get _stateCheck {
    assert(state != null);
    return state != null;
  }

  PlayerResultModel? getPlayer(String id) {

    if (!_stateCheck) return null;

    final res = state!.playerResults;


    final idx = res.indexWhere((element) => element.playerId == id);


    if (idx < 0 || idx >= res.length) {
      counterLocale++;
      final pl = PlayerResultModel(
          playerId: id,
          userName:
              state!.players.firstWhere((ply) => ply.id == id).user?.userName ?? "$counterLocale. ${L10n.inst(widgetRef!.context).player}");
      updatePlayer(pl);
      return pl;
    }

    return state!.playerResults[idx];
  }

  void setPlayers(List<PlayerModel> players) {

    if (!_stateCheck) {
      logger.e("_stateCheck: false");
      return;
    }

    state = state!.copyWith(players: players);
  }

  void increaseCatchCountWithColor(String playerId, String color,
      [int score = 1]) {
    if (!_stateCheck) return;
    var ongoingMap =
        Map.of((getPlayer(playerId)?.playerColorCatchCount ?? {color: 0}));

    ongoingMap.forEach((k, v) {
      if (k == color) {
        ongoingMap[k] = v + score;
      }
    });
    if (!ongoingMap.containsKey(color)) {
      ongoingMap[color] = score;
    }
    setScoreWithDeviceColor(
      playerId,
      incomingMap: ongoingMap,
    );
  }

  void resetScore(String playerId) {
    if (!_stateCheck) return;

    setScore(
      playerId,
      correctCount: 0,
    );
  }

  void addFlSpot(String playerId, FlSpot spot) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    player = player.copyWith(graphSpots: [...player.graphSpots, spot]);

    updatePlayer(player);
  }

  int? voidGetScore(String playerId) {
    if (!_stateCheck) return null;

    var player = getPlayer(playerId);

    if (player == null) return null;

    return (player.correctCount ?? 0) + (player.incorrectCount ?? 0);
  }

  void increaseScore(WidgetRef ref, String playerId, [int score = 1]) {
    if (!_stateCheck) return;

    setScore(
      playerId,
      correctCount: (getPlayer(playerId)?.correctCount ?? 0) + score,
    );
    final increaseScoreConditionForLevel = ref
        .read(currentGameProv)!
        .setup
        .gameScoreTypes
        .contains(GameScoreType.level);

    if (increaseScoreConditionForLevel &&
        ref
            .read(currentEffectConditionManager.notifier)
            .gameIdList
            .contains(ref.read(currentGameProv)!.id)) {
      ref
          .read(currentEffectConditionManager.notifier)
          .setCurrentValueForShowEffect(ref.read(currentGameProv)!.id, ref,
              value: score);
    }
  }

  void decreaseScore(String playerId) {
    if (!_stateCheck) return;

    setScore(
      playerId,
      incorrectCount: (getPlayer(playerId)?.incorrectCount ?? 0) + 1,
    );
  }

  void increaseLevel(String playerId, [int score = 1]) {
    if (!_stateCheck) return;

    setLevel(
      playerId: playerId,
      level: (getPlayer(playerId)?.level ?? 0) + score,
    );
  }

  void decreaseLevel(String playerId) {
    if (!_stateCheck) return;

    setLevel(
      playerId: playerId,
      level: (getPlayer(playerId)?.level ?? 0) - 1,
    );
  }

  void updatePlayer(PlayerResultModel player) {
    if (!_stateCheck) return;

    final newList = <PlayerResultModel>[];

    bool added = false;

    for (var i = 0; i < state!.playerResults.length; i++) {
      final pl = state!.playerResults[i];

      if (pl.playerId == player.playerId) {
        newList.add(player);
        added = true;
      } else {
        newList.add(pl);
      }
    }

    if (!added) {
      newList.add(player);
    }

    final game = ref.read(currentGameProv);

    var gameScoreType = game?.getScoreType;

    if ((game != null && game.setup.playerCount != null)
        ? game.setup.playerCount!.max > 1
        : true) {
      //TODO Fix order of the players based on in game screen widget gameScoreTypes
      switch (gameScoreType) {

        case GameScoreType.totalDuration:
          if (newList.any((element) => element.totalDuration == null)) {
            break;
          }
          try {
            newList.sort((a, b) => b.totalDuration!.inMilliseconds
                .compareTo(a.totalDuration!.inMilliseconds));
          } catch (e) {
            logger.d(e.toString());
          }

          break;
        case GameScoreType.averageDuration:
          if (newList.any((element) => element.averageDuration == null)) {
            break;
          }
          try {
            newList.sort((a, b) => b.averageDuration!.inMilliseconds
                .compareTo(a.averageDuration!.inMilliseconds));
          } catch (e) {
            logger.d(e.toString());
          }
          break;
        case GameScoreType.correctCount:
          if (newList.any((element) => element.correctCount == null)) {
            break;
          }
          try {
            newList.sort((a, b) {
              if (a.correctCount == b.correctCount &&
                  !newList.any((element) => element.averageDuration == null)) {
                return a.averageDuration!.inMilliseconds
                    .compareTo(b.averageDuration!.inMilliseconds);
              }
              return b.correctCount!.compareTo(a.correctCount!);
            });
          } catch (e) {
            logger.d(e.toString());
          }
          break;
        case GameScoreType.score:
          try {
            newList.sort((a, b) {
              if (a.score == b.score &&
                  !newList.any((element) => element.averageDuration == null)) {
                return a.averageDuration!.inMilliseconds
                    .compareTo(b.averageDuration!.inMilliseconds);
              }
              return b.correctCount!.compareTo(a.correctCount!);
            });
          } catch (e) {
            logger.d(e.toString());
          }
          break;
        default:
      }
    }

    state = state!.copyWith(playerResults: newList);
  }

  void setLevel({
    required String playerId,
    required int level,
  }) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    player = player.copyWith(level: level);

    updatePlayer(player);

    logger.d(
      "LEVEL NOW IS " + player.level.toString(),
    );
  }

  void setScoreWithDeviceColor(
    String playerId, {
    Map<String, int>? incomingMap,
  }) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;
    player = player.copyWith(
        playerColorCatchCount: incomingMap ?? player.playerColorCatchCount);

    updatePlayer(player);
    String logString = "";
    if (incomingMap != null) {
      incomingMap.forEach((key, value) {
        logString += "$key: $value, \n";
      });
    }

  }

  void setScore(
    String playerId, {
    int? correctCount,
    int? incorrectCount,
  }) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    player = player.copyWith(
      correctCount: correctCount ?? player.correctCount,
      incorrectCount: incorrectCount ?? player.incorrectCount,
    );

    updatePlayer(player);
  }

  void setPlayerStartTime({required String playerId, DateTime? time}) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    player = player.copyWith(startTime: time ?? DateTime.now());

    updatePlayer(player);
  }

  void setPlayerEndTime({required String playerId, DateTime? time}) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    player = player.copyWith(endTime: time ?? DateTime.now());

    updatePlayer(player);
  }

  @Deprecated('player.timeSpans is deprecated. use addScorePoint instead')
  void addTimeStamp({required String playerId, required Duration time}) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    player = player.copyWith(
      timeSpans: [
        ...(player.timeSpans ?? []),
        time,
      ],
    );

    updatePlayer(player);
  }

  void addScorePoint(WidgetRef ref,
      {required String playerId,
      required Duration time,
      required String gameId}) {

    if (!_stateCheck) return;
    var player = getPlayer(playerId);
    if (player == null) return;

    final point = GameScorePointModel(
      duration: time,
      scoredAt: DateTime.now(),
    );

    player = player.copyWith(
      timeSpans: [],
      scorePoints: [
        ...(player.scorePoints ?? []),
        point,
      ],
    );

    updatePlayer(player);

    if (ref
        .read(currentEffectConditionManager.notifier)
        .gameIdList
        .contains(ref.read(currentGameProv)!.id))
    {
      final list = player.scorePoints!.toList();

      final lastScore = player.scorePoints!.length - 2;
      final lastOfLastScore = player.scorePoints!.length - 3;
      final lastOfLastOfLastScore = player.scorePoints!.length - 4;

      ref
          .read(currentEffectConditionManager.notifier)
          .setCurrentValueForShowEffect(gameId, ref, value: time);

      /*if (list.length > 3 &&
          (list[lastScore].duration.inMilliseconds <
                  list.last.duration.inMilliseconds &&
              list[lastOfLastScore].duration.inMilliseconds <
                  list[lastScore].duration.inMilliseconds)) {
        ref.read(currentEffectConditionManager.notifier).showEffect(
            ref.context, EffectStates.bad,
            isSvg: true, path: AssetManager.badPng, refX: ref);
      }*/

      if (list.length > 4 &&
          (list[lastScore].duration.inMilliseconds >
                  list.last.duration.inMilliseconds &&
              list[lastOfLastScore].duration.inMilliseconds >
                  list[lastScore].duration.inMilliseconds &&
              list[lastOfLastOfLastScore].duration.inMilliseconds >
                  list[lastOfLastScore].duration.inMilliseconds)) {
        ref.read(currentEffectConditionManager.notifier).showEffect(
            ref.context, EffectStates.good,
            isSvg: true, path: AssetManager.goodPng, refX: ref);
      }
    }
  }

  void addChartSpot({required String playerId, required Duration time}) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    final point = GameScorePointModel(
      duration: time,
      scoredAt: DateTime.now(),
    );

    player = player.copyWith(
      timeSpans: [],
      scorePoints: [
        ...(player.scorePoints ?? []),
        point,
      ],
    );

    updatePlayer(player);
  }

  void addTeamHarmonyPoint(WidgetRef ref,
      {required String playerId, required Duration time}) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    final point = GameScorePointModel(
      scoredAt: DateTime.now(),
      duration: time,
    );

    player = player.copyWith(
      teamHarmonyPoints: [
        ...(player.teamHarmonyPoints ?? []),
        point,
      ],
    );

    updatePlayer(player);

    if (ref
        .read(currentEffectConditionManager.notifier)
        .gameIdList
        .contains(ref.read(currentGameProv)!.id)) {

      ref
          .read(currentEffectConditionManager.notifier)
          .setCurrentValueForShowEffect(ref.read(currentGameProv)!.id, ref,
              value: time);

      final list = player.scorePoints!.toList();

      final lastScore = player.scorePoints!.length - 2;
      final lastOfLastScore = player.scorePoints!.length - 3;
      final lastOfLastOfLastScore = player.scorePoints!.length - 4;

      /*if (list.length > 3 &&
          (list[lastScore].duration.inMilliseconds <
                  list.last.duration.inMilliseconds &&
              list[lastOfLastScore].duration.inMilliseconds <
                  list[lastScore].duration.inMilliseconds)) {
        ref.read(currentEffectConditionManager.notifier).showEffect(
            ref.context, EffectStates.bad,
            isSvg: true, path: AssetManager.badPng, refX: ref);
      }*/

      if (list.length > 3 &&
          (list[lastScore].duration.inMilliseconds >
                  list.last.duration.inMilliseconds &&
              list[lastOfLastScore].duration.inMilliseconds >
                  list[lastScore].duration.inMilliseconds &&
              list[lastOfLastOfLastScore].duration.inMilliseconds >
                  list[lastOfLastScore].duration.inMilliseconds)) {
        ref.read(currentEffectConditionManager.notifier).showEffect(
            ref.context, EffectStates.good,
            isSvg: false, path: AssetManager.goodAnimation, refX: ref);
      }
    }
  }

  void addDistance(
      {required String playerId, required DistanceModel distance}) {
    if (!_stateCheck) return;

    var player = getPlayer(playerId);

    if (player == null) return;

    player = player.copyWith(
      distances: [
        ...(player.distances ?? []),
        distance,
      ],
    );

    updatePlayer(player);
  }
}
