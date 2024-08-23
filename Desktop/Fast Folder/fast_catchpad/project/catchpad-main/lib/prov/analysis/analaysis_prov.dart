import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/game/game_result_model.dart';
import 'package:catchpad/models/game/static_game_model.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/ui/analysis/performance_analysis_main.dart';
import 'package:catchpad/ui/game/select_game_screen.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/dynamic_games/dynamic_game_model.dart';

///This is the provider for the analysis options.This created for performance analysis

class AnalysisOptionsNotifier extends StateNotifier<AnalysisOptions?> {
  AnalysisOptionsNotifier(AnalysisOptions? state) : super(null);

  Future<List<GameResultModel>> getResults(WidgetRef ref) async {



    EasyLoading.show();


    final gms = SelectGameScreen.initGames(ref);

    final staticGame = gms.firstWhere((element) => element.id == state!.gameModel.id);

    ref.read(currentGameProv.notifier).setState(staticGame as StaticGameModel);

    final result = await FirebaseCollectionEnums.game_results.reference
        .where(
          "gameId",
          isEqualTo: state!.gameModel.id,
        )
        .where(
          "accountHolderId",
          isEqualTo: ref.read(currentUserProv)!.uid!,
        )
        .get();
    int total =  0;
    for (var perDoc in result.docs) {
      final gameResult =
          GameResultModel.fromJson(perDoc.data()! as Map<String, dynamic>);

      if (gameResult.getIndexValue != null && gameResult.createdAt != null) {
        state!.gameResultModelList.add(gameResult);
      }

      //descending createdAt order
    }

    state!.gameResultModelList.sort((a, b) => a
        .createdAt!.millisecondsSinceEpoch
        .compareTo(b.createdAt!.millisecondsSinceEpoch));

    //find max indexValue in gameResultModelList



    for (int i = 0; i < state!.gameResultModelList.length; i++) {
      if (state!.gameResultModelList[i].getIndexValue! > state!.maxY) {
        final indexValue = state!.gameResultModelList[i].getIndexValue!;
        state!.maxY = (indexValue +
                (indexValue * 0.6))
            .toInt();

      }
    }



    state!.maxX = state!.gameResultModelList.length;

    for (int i = 0; i < state!.gameResultModelList.length; i++) {

      state!.flSpots.add(FlSpot(i.toDouble(),
          state!.gameResultModelList[i].getIndexValue!.toDouble()));
      total = total + state!.gameResultModelList[i].getIndexValue!;
    }

    logger.i("Ortalama hesaplanıyor $total Length: ${state!.gameResultModelList.length}");
    if(state!.gameResultModelList.isNotEmpty){
      state!.ort = total ~/ state!.gameResultModelList.length;
    }

    state = AnalysisOptions(
      state!.gameModel,
      state!.gameResultModelList,
      state!.flSpots,
      state!.ort,
      state!.maxX,
      state!.maxY,
      state!.minX,
      state!.minY,
    );

    EasyLoading.dismiss();

    return state!.gameResultModelList;
  }

  void create(WidgetRef ref) {
    state = AnalysisOptions(
        ref.read(selectedGame.notifier).state!, [], [], 0, 0, 0, 0, 0);

    state!.gameModel = ref.read(selectedGame.notifier).state!;

    getResults(ref);
  }

  void update(WidgetRef ref, GameModel gameModel) {
    state!.gameModel = gameModel;
    getResults(ref);
  }

  void delete(WidgetRef ref) {
    state = null;
  }
}

class AnalysisOptions {
  GameModel gameModel;
  List<GameResultModel> gameResultModelList;
  List<FlSpot> flSpots;
  int ort;
  int maxX;
  int maxY;
  int minX;
  int minY;

  AnalysisOptions(this.gameModel, this.gameResultModelList, this.flSpots,
      this.ort, this.maxX, this.maxY, this.minX, this.minY);
}

final analysisOptionsProvider =
    StateNotifierProvider<AnalysisOptionsNotifier, AnalysisOptions?>((ref) {
  return AnalysisOptionsNotifier(null);
});
