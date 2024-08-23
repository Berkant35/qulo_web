import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;
import '../../models/game/game_result_model.dart';
import '../../utils/cp_colors.dart';
import '../../utils/utils.dart';

class LeaderBoardResultItem extends StatelessWidget {
  final GameResultModel result;
  final int rank;
  final String id;

  const LeaderBoardResultItem({
    required this.result,
    required this.rank,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWinner = rank <= 3;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: defPaddingSize,
        vertical: halfDefPaddingSize,
      ),
      decoration: BoxDecoration(
        color: CpColors.resultTileColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: badges.Badge(
          badgeColor: isWinner
              ? CpColors.resultTileWinnerTrophyColor
              : CpColors.resultTileUnWinnerTrophyColor,
          badgeContent: AutoSizeText(
            "$rank",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          child: Icon(FontAwesomeIcons.trophy,
              color: (isWinner) ? null : CpColors.resultTileTrophybgColor),
          /* child: Container(
            decoration: const BoxDecoration(
              color: CpColors.resultTileTrophybgColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(FontAwesomeIcons.trophy),
          ), */
        ),
        /* leading: SizedBox(
          width: 100,
          child: Stack(
            children: [

              /* Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                    decoration: const BoxDecoration(
                      color: CpColors.resultTileTrophybgColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(defPaddingSize),
                    child: const Icon(FontAwesomeIcons.trophy),
                  ),
                ],
              ),
              Container(
                width: 35,
                decoration: BoxDecoration(
                  color: isWinner
                      ? CpColors.resultTileWinnerTrophyColor
                      : CpColors.resultTileUnWinnerTrophyColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: halfDefPaddingSize,
                  vertical: defPaddingSize,
                ),
                child: Text(
                  "$rank",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ), */
            ],
          ),
        ), */
        title: Text(
          result.winnerPlayer != null
              ? result.winnerPlayer!.user?.userName ?? ''
              : (result.players.length < 2 && result.players.isNotEmpty)
                  ? result.players.first.user!.userName
                  : '',
          maxLines: 3,
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: result.indexValue == null
            ? const SizedBox()
            : Text(
                result.indexValueStr(context,
                    convertMsToSec: (id != '47' && id != '48'))!,
                style: Theme.of(context).textTheme.headline6,
              ),
      ),
    );
  }
}
