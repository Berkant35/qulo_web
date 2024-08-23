import 'package:auto_size_text/auto_size_text.dart';
import 'package:catchpad/models/class_model.dart';
import 'package:catchpad/models/game/game_result_model.dart';
import 'package:catchpad/prov/group_players_prov.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;
import '../util_methods/util_methods.dart';



class PlayerGameHistoryTabBarView extends ConsumerWidget {
  const PlayerGameHistoryTabBarView(
      {super.key, required this.player, required this.results});
  final Student player;
  final List<GameResultModel> results;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    reusableAnswerGen(String value, String section) {
      return ListTile(
        leading: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                color: CpColors.appbarColor),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              section,
              textAlign: TextAlign.center,
            )),
        title: Text(value),
      );
    }

    return ListView(
      children: <Widget>[
        Hero(
          tag: player.studentNickName,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.hardEdge,
              child: ExpansionTile(
                backgroundColor: CpColors.defBgColor,
                collapsedBackgroundColor: CpColors.defBgColor,
                leading: const Icon(Icons.person),
                title: Text(player.firstName + ' ' + player.lastName),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableAnswerGen(
                      player.studentClass == 'uniqallusersdevcode'
                          ? inst.classes_screen_allusers
                          : player.studentClass,
                      inst.classes_screen_class),
                  reusableAnswerGen(
                      player.studentNumber, inst.classes_screen_number),
                  reusableAnswerGen(player.studentNickName,
                      inst.classes_screen_student_nickname),
                ],
              ),
            ),
          ),
        ),
        const Divider(color: CpColors.cpYellow),
        const Align(
            alignment: Alignment.center, child: AutoSizeText('Game History')),
        ...results.map((res) {
          final String gameName = ref
              .read(groupPlayersGameHistoryProvider.notifier)
              .getGameName(res.gameId, ref);
          final playerid = res.players
              .firstWhere(
                  (plyr) => plyr.user!.userName == player.studentNickName)
              .id;
          final placementModel = res.playerResults.firstWhere(
              (playerresmodel) => playerresmodel.playerId == playerid);
          int i = 0;
          final bool isdescending = ref
              .read(groupPlayersGameHistoryProvider.notifier)
              .getGameScoreType(res.gameId, ref)
              .isDescending;
          final int placement = (!isdescending)
              ? res.playerResults.indexOf(placementModel) + 1
              : res.playerResults.length -
                  res.playerResults.indexOf(placementModel);
          final List<Widget> tileChildren = res.playerResults.map((playerres) {
            i++;
            final finalScore = Index.parseIndexValue(
                playerres.indexValue,
                ref
                    .read(groupPlayersGameHistoryProvider.notifier)
                    .getGameScoreType(res.gameId, ref));
            final finalScoreStr = GameResultModel.indexValueStrForHistory(
                context,
                finalScore,
                ref
                    .read(groupPlayersGameHistoryProvider.notifier)
                    .getGameScoreType(res.gameId, ref));

            return ListTile(
              leading: badges.Badge(
                badgeColor: ((!isdescending)
                            ? i
                            : (res.playerResults.length - i + 1)) <=
                        3
                    ? CpColors.resultTileWinnerTrophyColor
                    : CpColors.resultTileUnWinnerTrophyColor,
                badgeContent: AutoSizeText(
                    '${(!isdescending) ? i : (res.playerResults.length - i + 1)}'),
                child: const Icon(FontAwesomeIcons.trophy,
                    color: CpColors.cpYellow),
              ),
              title: Text(playerres.userName),
              subtitle: Text(
                'Placement: ${(!isdescending) ? i : (res.playerResults.length - i + 1)} \nScore: $finalScoreStr',
                style: const TextStyle(color: Colors.white70),
              ),
              isThreeLine: true,
            );
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.hardEdge,
              child: ExpansionTile(
                title: AutoSizeText(gameName),
                backgroundColor: CpColors.defBgColor,
                leading: Badge(
                  backgroundColor: ((!isdescending)
                              ? i
                              : (res.playerResults.length - i + 1)) <=
                          3
                      ? CpColors.resultTileWinnerTrophyColor
                      : CpColors.resultTileUnWinnerTrophyColor,
                  label: AutoSizeText('$placement'),
                  child: const Icon(FontAwesomeIcons.trophy,
                      color: CpColors.cpYellow),
                ),
                collapsedBackgroundColor: CpColors.defBgColor,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                subtitle: AutoSizeText(
                  'Date: ${dateFormatter(res.createdAt!)}',
                  style: const TextStyle(color: Colors.white70),
                ),
                children: (!isdescending)
                    ? tileChildren
                    : tileChildren.reversed.toList(),
              ),
            ),
          );
        }).toList()
      ],
    );
  }
}
