import 'dart:async';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/game/game_model.dart';
import '../game/select_game_screen.dart';
import 'leaderboard_game_history.dart';
import 'leaderboard_result_list.dart';

final selectedLeaderboardGame = StateProvider<GameModel?>(
  (ref) => null,
);

class LeaderBoardScreenHistoryBody extends ConsumerStatefulWidget {
  const LeaderBoardScreenHistoryBody({Key? key}) : super(key: key);

  @override
  ConsumerState<LeaderBoardScreenHistoryBody> createState() =>
      _TopGamesListState();
}

class _TopGamesListState extends ConsumerState<LeaderBoardScreenHistoryBody> {
  late List<GameModel> _games;
  late SharedPreferences _sharedPreferences;
  late StreamController<GameModel> _leaderboardController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _leaderboardController = StreamController<GameModel>();
    final games = SelectGameScreen.initGames(ref);
    _games = games.toList();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getSharedPreferences();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameModel>(
        stream: _leaderboardController.stream,
        builder: (context, snapshot) {

          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.id.isEmpty ) {
            return const SizedBox();
          }

          return ListView(
            controller: _scrollController,
            children: [
              CategoryList<GameModel>(
                  selectedOption: snapshot.data!,
                  options: _games.toSet(),
                  getTitle: (e) => e.metaData.name,
                  onSelected: (e) {
                    lastDocs.clear();
                    ref.read(selectedLeaderboardGame.notifier).state = e;
                    _leaderboardController.add(e);
                  }),
              LeaderBoardResultListGameHistory(
                scrollController: _scrollController,
                gameId: snapshot.data!.id,
              ),
            ],
          );
        });
  }

  void getSharedPreferences() async {
    final games = SelectGameScreen.initGames(ref);
    final gameList = games.toList();
    gameList.removeWhere((element) => element.onLeaderboard == false);
    _games = gameList;
    setState(() {});

    ref.read(selectedLeaderboardGame.notifier).state = _games.first;
    _leaderboardController.add(_games.first);
  }
}
