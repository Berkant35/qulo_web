import 'package:catchpad/models/class_model.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/class_provider.dart';
import 'package:catchpad/prov/quiz_provider.dart';
import 'package:catchpad/ui/game/select_game_screen.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paginationer/paginationer.dart';

import '../../data/api/game_result_api.dart';
import '../../models/game/game_model.dart';
import '../../prov/game_result_prov.dart';
import '../../prov/leaderboard/leaderboard_result_prov.dart';
import '../../utils/utils.dart';
import 'leaderboard_result_item.dart';

Map<String, QueryDoc> lastDocs = {};

class LeaderBoardResultList extends ConsumerStatefulWidget {
  final ScrollController? scrollController;
  final String gameId;

  const LeaderBoardResultList({
    this.scrollController,
    required this.gameId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultsListState();
}

class _ResultsListState extends ConsumerState<LeaderBoardResultList> {
  static const _pageSize = 30;
  late final Set<GameModel> games;
  late final GameModel currentGame;

  @override
  void initState() {
    super.initState();
    games = SelectGameScreen.gamesOnLeaderboard(ref);
    currentGame = games.firstWhere((element) => element.id == gameId);
  }

  Future<List<GameResultModel>?> _getResults(int _size) async {
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];

      Query<Map<String, dynamic>> queryLimit;

      var fillToList = true;

      List<GameResultModel> currentList = [];

      while (fillToList) {
        final resQuery = GameResultApi.instance.resultsForGame(gameId,
            ref.read(currentUserProv)!.uid!, ref.watch(groupFilterProvider));

        queryLimit = resQuery.limit(_size);

        final lastDoc = lastDocs[gameId];
        if (lastDoc != null) {
          queryLimit = queryLimit.startAfterDocument(lastDoc);
        }

        final query = await queryLimit.get();
        docs = query.docs;
        if (docs.isNotEmpty) {
          lastDocs = {};
          lastDocs[gameId] = docs.last;
        } else {
          fillToList = false;
        }

        final res = ref
            .read(leaderBoardResultProv.notifier)
            .resultsFromDocs(docs, gameId);

        res.map((e) => debugPrint(e.winnerPlayer?.user?.userName ?? ""));

        if (res.length < 30) {
          fillToList = false;
        }
        //TODO OPEN COMMENT LINE
        //res.removeWhere((result) => (result.indexValue == null));
        final filterNewList = filterResults(res);

        currentList = [...currentList, ...filterNewList];

        logger.i("Filter Length: ${currentList.length}");

        if (currentList.length > 10) {
          return currentList;
        }
      }

      /* for (var result in res) {
        if (currentGame.getScoreType.isDescending) {
          int length = result.indexValue.toString().length;
          /* if (length == 2) {
            res[res.indexOf(result)] = result.copyWith(
                indexValue: int.parse(result.indexValue.toString() + '0'));
          } else if (length == 1) {
            res[res.indexOf(result)] = result.copyWith(
                indexValue: int.parse(result.indexValue.toString() + '00'));
          } */
        }
      } */
      /* if (currentGame.getScoreType.isDescending) {
        res.sort((a, b) => a.indexValue!.compareTo(b.indexValue!));
      } */
      /* if (['s22', '39', 's35'].contains(gameId)) {
        res.sort((a, b) => b.indexValue!.compareTo(a.indexValue!));
      } */
      return currentList;
    } catch (e) {
      logger.d("firestore get results for leaderboard error: $e");
      return null;
    }
  }

  List<GameResultModel> filterResults(List<GameResultModel> res) {
    final r = <GameResultModel>[];

    final groupPlayers = ref.read(selectedClassProvider)?.students ?? [];

    final curuser = ref.read(currentUserProv);

    if (curuser != null) {
      groupPlayers.add(Student(
        firstName: curuser.fName ?? '',
        lastName: curuser.lName ?? '',
        studentNumber: '',
        studentClass: '',
        studentNickName: curuser.userName,
        createdAt: curuser.createdAt ?? DateTime.now(),
      ));
    }

    for (final item in res) {
      if (item.players.isEmpty) {
        continue;
      }

      for (var mainP in item.players) {
        if (!ref.watch(groupFilterProvider)) {
          if (!groupPlayers.any((gp) {
            return ((mainP.user?.userName.toLowerCase().replaceAll(" ", "") ==
                    gp.studentNickName.toLowerCase().replaceAll(" ", "")) &&
                ref
                        .read(currentUserProv)!
                        .userName
                        .toLowerCase()
                        .replaceAll(" ", "") !=
                    mainP.user?.userName.toLowerCase().replaceAll(" ", ""));
          })) {
            continue;
          }
        }

        if (ref.read(leaderBoardResultProv)[gameId] != null) {
          if (ref.read(leaderBoardResultProv)[gameId]!.any((result) =>
              result.winnerPlayer?.user?.userName ==
              item.winnerPlayer?.user?.userName)) {
            logger.i("Contiune 3");
            continue;
          }
        }

        r.add(item);
      }
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

    if (ress == null) {
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
    }
    Set<String> listOfNames = {};
    List<GameResultModel> removeList = [];
    for (var perRes in res) {
      logger.i(perRes.getIndexValue);
      if (!listOfNames.contains(perRes.players.first.playerName)) {
        listOfNames.add(perRes.players.first.playerName ?? "-");
      } else {
        removeList.add(perRes);
      }
    }
    for (var perRes in removeList) {
      res.remove(perRes);
    }
    ref.read(leaderBoardResultProv.notifier).addAll(res, gameId);
    return true;
  }

  String get gameId => widget.gameId; //ref.watch(selectedLeaderboardGame)!.id;

  @override
  Widget build(BuildContext context) {
    final map = ref.watch(leaderBoardResultProv);

    final list = map[gameId] ?? [];

    return Container(
      margin: const EdgeInsets.only(top: defPaddingSize * 2),
      child: StatelessPaginationer(
        key: Key(gameId),
        controller: widget.scrollController,
        emptyChildren: const [
          Center(
            child: CircularProgressIndicator.adaptive(),
          )
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
    // #region demo data
    // final list = [
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 23,
    //     players: [
    //       PlayerModel(
    //         id: '113',
    //         user: RegisterUser(userName: 'ahmet113'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '113'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 23,
    //     players: [
    //       PlayerModel(
    //         id: '13',
    //         user: RegisterUser(userName: 'halit23'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '13'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 23,
    //     players: [
    //       PlayerModel(
    //         id: '3',
    //         user: RegisterUser(userName: 'adnan63'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '3'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 19,
    //     players: [
    //       PlayerModel(
    //         id: '10',
    //         user: RegisterUser(userName: 'muhammet3'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '10'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 19,
    //     players: [
    //       PlayerModel(
    //         id: '5',
    //         user: RegisterUser(userName: 'cerena'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '5'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 15,
    //     players: [
    //       PlayerModel(
    //         id: '2',
    //         user: RegisterUser(userName: 'ahmet134'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '2'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 12,
    //     players: [
    //       PlayerModel(
    //         id: '2',
    //         user: RegisterUser(userName: 'aleeyna'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '1'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 10,
    //     players: [
    //       PlayerModel(
    //         id: '1',
    //         user: RegisterUser(userName: 'cankaya'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '1'),
    //     ],
    //   ),
    //   GameResultModel(
    //     type: GameEndType.duration,
    //     gameId: gameId,
    //     createdAt: DateTime.now(),
    //     scoreType: GameScoreType.averageDistance,
    //     indexValue: 3,
    //     players: [
    //       PlayerModel(
    //         id: '4',
    //         user: RegisterUser(userName: 'fatih00'),
    //       ),
    //     ],
    //     playerResults: [
    //       const PlayerResultModel(playerId: '4'),
    //     ],
    //   ),
    // ];
    // #endregion
  }
}
