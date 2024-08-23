import 'dart:async';

import 'package:catchpad/prov/leaderboard/leaderboard_result_prov.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/game/game_model.dart';
import '../game/select_game_screen.dart';
import 'leaderboard_result_list.dart';

final selectedLeaderboardGame = StateProvider<GameModel?>(
      (ref) => null,
);

class LeaderBoardScreenBody extends ConsumerStatefulWidget {
  const LeaderBoardScreenBody({Key? key}) : super(key: key);

  @override
  ConsumerState<LeaderBoardScreenBody> createState() => _TopGamesListState();
}

class _TopGamesListState extends ConsumerState<LeaderBoardScreenBody> {
  late List<GameModel> _games;
  late SharedPreferences _sharedPreferences;
  late StreamController<GameModel?> _leaderboardController;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
    _leaderboardController = StreamController<GameModel?>();
    _scrollController = ScrollController();
  }

  void _initializeData() {
    final games = SelectGameScreen.gamesOnLeaderboard(ref);
    _games = games.toList();
    getSharedPreferences();
  }


  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);

    return StreamBuilder<GameModel?>(
      stream: _leaderboardController.stream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SizedBox();
        }

        return RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            EasyLoading.show();
            lastDocs.clear();
            final temp = ref.read(selectedLeaderboardGame);
            ref.read(leaderBoardResultProv.notifier).clearGameId(temp!.id);
            _leaderboardController.add(_games.firstWhere((element) => element.id != temp.id));
            _leaderboardController.add(temp);
            Future.delayed(const Duration(milliseconds: 300)).then((value) => EasyLoading.dismiss());
          },
          child: Stack(
            children: [
              ListView(
                controller: _scrollController,
                children: [
                  CategoryList<GameModel>(
                    selectedOption: snapshot.data ?? _games.first,
                    options: _games.toSet(),
                    getTitle: (e) => e.metaData.name,
                    onSelected: (e) {
                      lastDocs.clear();
                      ref.read(selectedLeaderboardGame.notifier).state = e;
                      _leaderboardController.add(e);
                    },
                  ),
                  LeaderBoardResultList(
                    key: UniqueKey(),
                    scrollController: _scrollController,
                    gameId: snapshot.data?.id ?? "s16",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  void getSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final lastPlayedGames = _sharedPreferences.getStringList('lastPlayedGames');
    final games = SelectGameScreen.gamesOnLeaderboard(ref);
    final gameList = games.toList();
    final gameIdList = gameList.map((e) => e.id).toList();
    lastPlayedGames?.removeWhere((gameid) => !gameIdList.contains(gameid));
    final List<GameModel> tempGameList = [];
    if (lastPlayedGames != null && lastPlayedGames.isNotEmpty) {
      for (var gameId in lastPlayedGames) {

        tempGameList
            .add(gameList.firstWhere((element) => element.id == gameId));
        gameList.removeWhere((element) => element.id == gameId);
      }

      gameList.insertAll(0, tempGameList);
      //gameList.removeWhere((element) => !element.onLeaderboard);
      _games = gameList;
      setState(() {});
    }
    lastDocs.clear();
    ref.read(leaderBoardResultProv.notifier).clearGameId(_games.first.id);
    ref.read(selectedLeaderboardGame.notifier).state = _games.first;
    _leaderboardController.add(_games.first);
  }
}