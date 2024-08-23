

import 'package:catchpad/managers/game/game_manager.dart';
import 'package:catchpad/models/game/game_result_model.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/ui/analysis/performance_analysis_main.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameResultCard extends ConsumerWidget {
  final GameResultModel gameResultModel;
  const GameResultCard({super.key,required this.gameResultModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {


      },
      child: Container(
        margin:  const EdgeInsets.symmetric(
          vertical: halfDefPaddingSize,
        ),
        decoration: BoxDecoration(
          color: CpColors.resultTileColor,
          border: Border.all(color: CpColors.yellow),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            "Primary Score",
            maxLines: 3,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            gameResultModel.createdAt.toString().substring(0,20),
            maxLines: 3,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: Text(
            gameResultModel.getIndexValue.toString(),
            style: Theme.of(context).textTheme.headline6,
          )
        ),
      ),
    );
  }
}
