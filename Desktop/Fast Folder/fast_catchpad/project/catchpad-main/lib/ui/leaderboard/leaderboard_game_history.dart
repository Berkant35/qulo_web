import 'package:catchpad/ui/game/select_game_screen.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paginationer/paginationer.dart';

import '../../data/api/game_result_api.dart';
import '../../models/game/game_model.dart';
import '../../models/game/game_result_model.dart';
import '../../prov/auth/current_user_prov.dart';
import '../../prov/game/selected_players_prov.dart';
import '../../prov/leaderboard/leaderboard_result_prov.dart';
import '../../utils/consts.dart';
import '../widgets/loading_widget.dart';
import 'leaderboard_result_item.dart';

Map<String, QueryDoc> lastDocsHistory = {};

class LeaderBoardResultListGameHistory extends ConsumerStatefulWidget {
  final ScrollController? scrollController;
  final String gameId;

  const LeaderBoardResultListGameHistory({
    this.scrollController,
    required this.gameId,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultsListState();
}

class _ResultsListState
    extends ConsumerState<LeaderBoardResultListGameHistory> {
  late final Set<GameModel> games;
  late final GameModel currentGame;

  @override
  void initState() {
    super.initState();
    logger.i(".GAME ID....${widget.gameId}");
    games = SelectGameScreen.gamesOnLeaderboard(ref);
    currentGame = games.firstWhere((element) => element.id == gameId);
  }

  static const _pageSize = 15;

  Future<List<GameResultModel>?> _getResults(int _size) async {
    try {
      var selectedpid = ref.read(currentUserProv)?.uid;
      Query<Map<String, dynamic>> queryLimit;
      ref.read(selectedPlayersPlayersProv);
      final resQuery = GameResultApi.instance
          .resultsForGameForPlayer(gameId, selectedpid ?? '');
      queryLimit = resQuery.limit(_size);
      final lastDoc = lastDocsHistory[gameId];
      if (lastDoc != null) {
        queryLimit = queryLimit.startAfterDocument(lastDoc);
      }

      final query = await queryLimit.get();

      final docs = query.docs;

      if (docs.isNotEmpty) {
        lastDocsHistory = {};
        lastDocsHistory[gameId] = docs.last;
      }

      final res = ref
          .read(leaderBoardHistoryResultProv.notifier)
          .resultsFromDocs(docs, gameId);
      res.map((e) => debugPrint(e.winnerPlayer?.user?.userName ?? ""));
      res.removeWhere((result) => result.indexValue == null);
      /* for (var result in res) {
        if (currentGame.getScoreType.isDescending) {
          int length = result.indexValue.toString().length;
          if (length == 2) {
            res[res.indexOf(result)] = result.copyWith(
                indexValue: int.parse(result.indexValue.toString() + '0'));
          } else if (length == 1) {
            res[res.indexOf(result)] = result.copyWith(
                indexValue: int.parse(result.indexValue.toString() + '00'));
          }
        }
      }
       */


      if (['s22', '39', 's35'].contains(gameId)) {



        res.sort((a, b) => b.indexValue!.compareTo(a.indexValue!));

      }
      return res;
    } catch (e) {
      logger.d("firestore get results for leaderboard error: $e");
      return null;
    }
  }

  List<GameResultModel> filterResults(List<GameResultModel> res) {
    final r = <GameResultModel>[];

    final uids = <String>{};
    for (final item in res) {
      if (item.players.isEmpty) {
        continue;
      }
      if (ref.read(currentUserProv) != null) {
        if (item.winnerPlayerId != ref.read(currentUserProv)?.uid) {
          continue;
        }
      }

      if (item.calculateWinnerPlayer == null) {
        continue;
      }
      uids.add(item.calculateWinnerPlayer!.user!.uid!);
      r.add(item);
    }

    return r;
  }

  Future<bool> _fetchPage(int pageKey) async {
    // so here a critic thing for us is not to have the same user
    // twice in the same page. what we're gonna do is basically
    // remove the matching users (keeping the one coming first
    // as they are the highest score), and refetching twice the
    // count of repeated user. when we refetch, we'll have the
    // redo the same check, if in total we have the same user
    // twice again more than the previous time (we have that much
    // limit as we fetched 2x the count of repeated user)
    final ress = await _getResults(_pageSize);

    logger.i("Fetch Page: ${ress?.length}");

    if (ress == null) {
      return false;
    }

    if (ress.isEmpty) {
      return false;
    }

    var res = ress;
    var currentDif = 0;

    while (true) {
      final filteredRes = filterResults(res);

      res = List.from(filteredRes);

      final allUsers = res.map((r) => r.players[0].user?.uid);
      final filteredUsers = filteredRes.map((r) => r.players[0].user?.uid);

      if (filteredUsers.length == allUsers.length) {
        break;
      }

      var dif = allUsers.length - filteredUsers.length;

      if (dif <= currentDif) {
        break;
      }

      currentDif = dif;

      dif = dif * 2;

      final newRes = await _getResults(dif);

      if (newRes == null) {
        return false;
      }

      res = [
        ...res,
        ...List.from(newRes),
      ];
      logger.i(".....");
    }

    ref.read(leaderBoardResultProv.notifier).addAll(res, gameId);
    return true;
  }

  String get gameId => widget.gameId;

  @override
  Widget build(BuildContext context) {
    final map = ref.watch(leaderBoardResultProv);

    final list = map[gameId] ?? [];

    return Container(
      margin: const EdgeInsets.only(top: defPaddingSize * 2),
      child: StatelessPaginationer(
        key: Key(gameId),
        controller: widget.scrollController,
        emptyChildren: const
          [
            Center(child: CircularProgressIndicator.adaptive(),)
          ],
        future: _fetchPage,
        builder: (context, index) => LeaderBoardResultItem(
          rank: index + 1,
          result: list[index],
          id: gameId,
        ),
        items: list,
      ),
    );
  }
}
