import 'leaderboard_game_history_body.dart';
import '../widgets/default_bg.dart';
import '../../utils/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreenHistory extends StatelessWidget {
  const LeaderBoardScreenHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(L10n.inst(context).profile_screen_past_games),
      ),
      body: const DefaultBg(
        child: LeaderBoardScreenHistoryBody(),
      ),
    );
  }
}

/*  */