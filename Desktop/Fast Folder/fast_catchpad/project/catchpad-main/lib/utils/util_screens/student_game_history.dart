import 'package:catchpad/models/class_model.dart';
import 'package:catchpad/prov/group_players_prov.dart';
import 'package:catchpad/ui/widgets/default_bg.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_screens/student_game_history_tabbarview.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayersHistory extends ConsumerStatefulWidget {
  const PlayersHistory({super.key, required this.player});
  final Student player;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayersHistoryState();
}

class _PlayersHistoryState extends ConsumerState<PlayersHistory>
    with TickerProviderStateMixin {
  Student get player => widget.player;
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //final inst = L10n.inst(context);

    final results = ref
        .read(groupPlayersGameHistoryProvider)
        .where((res) => res.players
            .any((ply) => ply.user!.userName == player.studentNickName))
        .toList();

    final resultsonleaderboard = results
        .where((gameres) => ref
            .read(groupPlayersGameHistoryProvider.notifier)
            .isGameOnLeaderboard(gameres.gameId, ref))
        .toList();

    final resultsnotonleaderboard = results
        .where((gameres) => !ref
            .read(groupPlayersGameHistoryProvider.notifier)
            .isGameOnLeaderboard(gameres.gameId, ref))
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Players History'),
          bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
              child: DefaultTabController(
                  length: 2,
                  child: TabBar(controller: tabController, tabs: const [
                    Tab(text: 'On leaderboard'),
                    Tab(text: 'Not on leaderboard'),
                  ]))),
        ),
        body: DefaultBg(
            child: TabBarView(controller: tabController, children: [
          PlayerGameHistoryTabBarView(
              player: player, results: resultsonleaderboard),
          PlayerGameHistoryTabBarView(
              player: player, results: resultsnotonleaderboard),
        ])),
      ),
    );
  }
}
