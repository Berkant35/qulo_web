import 'dart:async';

import 'package:catchpad/models/game/game_model.dart';
import 'package:catchpad/prov/analysis/analaysis_prov.dart';
import 'package:catchpad/prov/leaderboard/leaderboard_result_prov.dart';
import 'package:catchpad/ui/analysis/personality_or_group_body.dart';
import 'package:catchpad/ui/analysis/personality_or_group_tab_bar.dart';
import 'package:catchpad/ui/game/select_game_screen.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final selectedGame = StateProvider<GameModel?>(
  (ref) => null,
);
Map<String, QueryDoc> lastDocs = {};

class PerformanceAnalysis extends ConsumerStatefulWidget {
  const PerformanceAnalysis({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PerformanceAnalysisState();
}

class _PerformanceAnalysisState extends ConsumerState<PerformanceAnalysis>
    with TickerProviderStateMixin {
  late List<GameModel> _games;
  late SharedPreferences _sharedPreferences;

  late StreamController<GameModel> _leaderboardController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _leaderboardController = StreamController<GameModel>();
    final games = SelectGameScreen.initGames(ref);

    _games = games.toList();

    for (var perGame in _games) {
      _leaderboardController.add(perGame);
    }
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final tabController = TabController(length: 2, vsync: this);

    return Scaffold(
        appBar: AppBar(
          title: Text(inst.profile_screen_performance_analysis),
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0) {
              tabController.animateTo(0);
              ref
                  .read(currentPersonalityGroupTabController.notifier)
                  .changState(TypesOfGroupOrPersonality.personality);
            } else if (details.primaryVelocity! < 0) {
              tabController.animateTo(1);
              ref
                  .read(currentPersonalityGroupTabController.notifier)
                  .changState(TypesOfGroupOrPersonality.group);
            }
          },
          child: StreamBuilder(
            stream: _leaderboardController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.id.isEmpty) {
                return const SizedBox();
              }
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                children: [
                  CategoryList<GameModel>(
                    selectedOption: snapshot.data!,
                    options: _games.toSet(),
                    getTitle: (e) => e.metaData.name,
                    onSelected: (cat) {
                      ref.read(selectedGame.notifier).state = cat;
                      _leaderboardController.add(cat);
                      ref.read(analysisOptionsProvider.notifier).create(ref);
                    },
                  ),
                  PersonalityOrGroupTabBar(
                    tabController: tabController,
                  ),
                  ref.watch(selectedGame.notifier).state != null
                      ? PersonalityOrGroupBody(
                          gameModel: ref.watch(selectedGame.notifier).state!,
                        )
                      : const SizedBox()
                ],
              );
            },
          ),
        ));
  }

  void getSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final lastPlayedGames = _sharedPreferences.getStringList('lastPlayedGames');
    final games = SelectGameScreen.initGames(ref);
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
    ref.read(selectedGame.notifier).state = _games.first;
    _leaderboardController.add(_games.first);
    ref.read(analysisOptionsProvider.notifier).create(ref);
  }
}
