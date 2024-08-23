import 'package:catchpad/models/game/game_model.dart';
import 'package:catchpad/models/game/game_result_model.dart';
import 'package:catchpad/ui/game/select_game_screen.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums/game/game_score_type.dart';

final groupPlayersGameHistoryProvider = StateNotifierProvider<
    GroupPlayersGameHistoryProvider, List<GameResultModel>>(
  (_) => GroupPlayersGameHistoryProvider([]),
);

class GroupPlayersGameHistoryProvider
    extends StateNotifier<List<GameResultModel>> {
  GroupPlayersGameHistoryProvider(List<GameResultModel> state) : super(state);

  void setTo(List<GameResultModel> g) => state = g;

  String getGameName(String gameid, WidgetRef ref) {
    final games = SelectGameScreen.initGames(ref);
    final game = games.firstWhere((game) => game.id == gameid);
    return game.title;
  }

  GameModel getGame(String gameid, WidgetRef ref) {
    final games = SelectGameScreen.initGames(ref);
    final game = games.firstWhere((game) => game.id == gameid);
    return game;
  }

  GameScoreType getGameScoreType(String gameid, WidgetRef ref) {
    final games = SelectGameScreen.initGames(ref);
    final game = games.firstWhere((game) => game.id == gameid);
    return game.getScoreType;
  }

  bool isGameOnLeaderboard(String gameid, WidgetRef ref)
  {
    final games = SelectGameScreen.initGames(ref);
    final game = games.firstWhere((gamex) => (gamex.id == gameid));
    return game.onLeaderboard;
  }

  List<GameResultModel> getPlayerHistory(String username) {
    logger.d(state
        .where((gameres) =>
            gameres.players.any((ply) => ply.user!.userName == username))
        .toList());
    return state
        .where((gameres) =>
            gameres.players.any((ply) => ply.user!.userName == username))
        .toList();
  }
}
