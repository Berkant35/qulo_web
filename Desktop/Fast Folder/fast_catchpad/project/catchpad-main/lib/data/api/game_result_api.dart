import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/enums/firebase/collenction_enums.dart';
import '../../prov/game_result_prov.dart';

class GameResultApi {
  GameResultApi._();

  static final GameResultApi _instance = GameResultApi._();

  static GameResultApi get instance => _instance;

  CollectionReference<Map<String, dynamic>> results() =>
      FirebaseFirestore.instance
          .collection(FirebaseCollectionEnums.game_results.name);

  Future<bool> addToFirestore(GameResultModel result, WidgetRef ref) async {
    logger.w('RESULT JSON: ${result.playerResults.first.toJson()}');

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (!result.isValid ||
        (connectivityResult != ConnectivityResult.mobile &&
            connectivityResult != ConnectivityResult.wifi)) {
      return false;
    }

    try {
      final json = result.toJson();
      logger.d('RESULT JSON $json');
      try {
        await results().add(json).timeout(
              const Duration(seconds: 10),
            );
        logger.d('RESULT ADDED');
        return true;
      } catch (e) {
        logger.d('RESULT NOT ADDED');
        logger.e(e);
      }

      return true;
    } catch (e) {
      logger.e('RESULT NOT CONVERTED TO JSON $e');
      return false;
    }
  }

  Query<Map<String, dynamic>> resultsForGame(
      String gameId, String userId, bool globalLeaderBoard) {
    Query<Map<String, dynamic>> resultX;

    if (globalLeaderBoard) {
      resultX = results()
          .where(
            'gameId',
            isEqualTo: gameId,
          )
          .orderBy('indexValue');
    } else {
      resultX = results()
          .where(
            'gameId',
            isEqualTo: gameId,
          )
          .where('accountHolderId', isEqualTo: userId)
          .orderBy('indexValue');
    }

    return resultX;
  }

  Query<Map<String, dynamic>> resultsForGameForPlayer(
      String gameId, String playerid) {
    var resultss = results().where(
      'gameId',
      isEqualTo: gameId,
    );
    var newResults = resultss
        .where('winnerPlayerId', isEqualTo: playerid)
        .orderBy('indexValue');
    return newResults;
  }
}
