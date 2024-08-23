import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';
import '../widgets/default_bg.dart';
import 'leaderboard_screen_body.dart';

class LeaderBoardScreen extends ConsumerWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: (ref.read(appSettingsToggleProvider).enableLeaderboardViewer)
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(L10n.inst(context).game_result_title),
              actions: const [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: AutoSizeText('Global'),
                    ),
                  ],
                )
              ],
            ),
      body: const DefaultBg(
        child: LeaderBoardScreenBody(),
      ),
    );
  }
}
