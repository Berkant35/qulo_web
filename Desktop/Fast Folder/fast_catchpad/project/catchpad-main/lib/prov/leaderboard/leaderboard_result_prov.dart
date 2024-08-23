import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game_result_prov.dart';

typedef ResultMap = Map<String, List<GameResultModel>>;
typedef HistoryResultMap = Map<String, List<GameResultModel>>;
typedef QueryDoc = QueryDocumentSnapshot<Map<String, dynamic>>;

final leaderBoardResultProv =
    StateNotifierProvider<ResultsProviderNotifier, ResultMap>(
  (ref) => ResultsProviderNotifier(),
);

final leaderBoardHistoryResultProv =
    StateNotifierProvider<ResultsHistoryProviderNotifier, HistoryResultMap>(
  (ref) => ResultsHistoryProviderNotifier(),
);

class ResultsHistoryProviderNotifier extends StateNotifier<HistoryResultMap> {
  ResultsHistoryProviderNotifier() : super({});

  void empty() {
    state = {};
  }

  List<GameResultModel> resultsFromDocs(List<QueryDoc> docs, String gameId) {
    final res = docs.map(
      (doc) {
        final data = doc.data();
        return GameResultModel.fromJson(data);
      },
    );
    final ls = res.toList();
    return ls;
  }

  void addAllDocs(List<QueryDoc> docs, String gameId) {
    final res = resultsFromDocs(docs, gameId);
    addAll(res, gameId);
  }

  void addAll(List<GameResultModel> res, String gameId) {
    final list = List<GameResultModel>.from(state[gameId] ?? []);

    // filter doc from any duplicates with state
    final newDoc = res
        .where(
          (element) => !list.any((e) => e.createdAt == element.createdAt),
        )
        .toList();

    list.addAll(newDoc);

    state = {
      gameId: list,
    };
  }
}

class ResultsProviderNotifier extends StateNotifier<ResultMap> {
  ResultsProviderNotifier() : super({});

  void empty() {
    state = {};
  }

  void clearGameId(String gameId) {
    state = {
      ...state,
      gameId: [],
    };
  }

  List<GameResultModel> resultsFromDocs(List<QueryDoc> docs, String gameId) {
    final res = docs.map(
      (doc) {
        final data = doc.data();
        return GameResultModel.fromJson(data);
      },
    );

    final ls = res.toList();


    return ls;
  }

  void addAllDocs(List<QueryDoc> docs, String gameId) {
    final res = resultsFromDocs(docs, gameId);
    addAll(res, gameId);
  }

  void addAll(List<GameResultModel> res, String gameId) {
    final list = List<GameResultModel>.from(state[gameId] ?? []);

    // filter doc from any duplicates with state
    final newDoc = res
        .where(
          (element) => !list.any((e) => e.createdAt == element.createdAt),
        )
        .toList();

    list.addAll(newDoc);

    state = {
      gameId: list,
    };
  }
}
