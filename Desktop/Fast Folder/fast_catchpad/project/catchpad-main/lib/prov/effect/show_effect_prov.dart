import 'package:catchpad/managers/asset_manager.dart';
import 'package:catchpad/models/enums/game/game_score_type.dart';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../managers/cp_audio_player.dart';

typedef EffectConditionMap = Map<String, num>;
typedef GameEffectCondition = Map<String, List<GameScoreType>>;

enum EffectStates {
  excellent,
  good,
  notBad,
  perfect,
  bad;

  static String getEffectPath(EffectStates effectState) {
    switch (effectState) {
      case EffectStates.excellent:
      case EffectStates.good:
        return AssetManager.excellentAnimation;

      case EffectStates.perfect:
        return AssetManager.perfectAnimation;
      case EffectStates.bad:
        return AssetManager.badAnimation;
      case EffectStates.notBad:
        return AssetManager.notBadAnimation;
    }
  }
}

/*This manager does handle all effects sometimes we want show effects and of course
* we should these actions with some conditions. This class generally uses  by 'gameresultprov' */

class EnableEffectManagerNotifier extends StateNotifier<bool> {
  EnableEffectManagerNotifier(bool state) : super(false);

  void changeState({bool? effectForce}) => state = effectForce ?? !state;
}
final currentEffectEnableManager =
    StateNotifierProvider<EnableEffectManagerNotifier, bool>(
        (_) => EnableEffectManagerNotifier(false));

class EffectConditionManagerProvider extends StateNotifier<EffectConditionMap> {
  EffectConditionManagerProvider(EffectConditionMap state) : super({});

  bool isExcellentState = false;
  bool playAmazing = false;

  //These game ids show which games can use effects.
  List<String> gameIdList = ['s16', 's14'];

  static const List<GameScoreType> conditionAscending = [
    GameScoreType.maxDistance,
    GameScoreType.level
  ];

  static const List<GameScoreType> conditionDescending = [
    GameScoreType.minDuration,
    GameScoreType.teamHarmony,
    GameScoreType.averageDuration
  ];

  GameEffectCondition gameEffectCondition = {};
  EffectConditionMap gameDownEffectCondition = {};

  //This function must call before pushGame and so we will know which has condition type
  void setGameScoreType(String gameId, List<GameScoreType> gameScoreTypeList) {
    gameEffectCondition.addAll({gameId: gameScoreTypeList});


  }

  void setGameFree() {

    gameEffectCondition.clear();
    gameDownEffectCondition.clear();
    state.clear();
  }

  void setCurrentValueForShowEffect(String gameId, WidgetRef ref,
      {dynamic value}) {
    if (ref.watch(currentEffectEnableManager)) {
      var showEffectCondition = false;
      bool? lookToAscending;

      for (var currentGameCondition in gameEffectCondition[gameId]!) {
        var tempCondition = false;

        tempCondition = conditionAscending.any((ascendingLookCondition) {
          return currentGameCondition == ascendingLookCondition;
        });

        if (tempCondition) {
          showEffectCondition = tempCondition;
          lookToAscending = true;
          continue;
        }

        tempCondition = conditionDescending.any((descendingLookCondition) =>
            currentGameCondition == descendingLookCondition);

        if (tempCondition) {
          showEffectCondition = tempCondition;
          lookToAscending = false;
          continue;
        }
      }

      var valueOfValue = value.runtimeType == Duration
          ? (value as Duration).inMilliseconds
          : value;

      logger.i(
          "Value Of Value:$valueOfValue Current Record: ${state[gameId]} Current Bad Record: ${gameDownEffectCondition[gameId]}");

      if (!state.containsKey(gameId)) {
        state.addAll({gameId: valueOfValue});
        gameDownEffectCondition.addAll({gameId: valueOfValue});
      } else {
        if (showEffectCondition) {
          var isAscending = valueOfValue > state[gameId];
          var isDescending = valueOfValue < gameDownEffectCondition[gameId];

          logger.i("isDescending: $isAscending");

          if (lookToAscending! && isAscending) {
            logger
                .i("Look To Ascending $lookToAscending true ise büyükse güzel");

            showEffect(ref.context, EffectStates.excellent,
                refX: ref, isSvg: false);
            if (state.containsKey(gameId)) {
              state[gameId] = valueOfValue;
            }
          } else if (!lookToAscending && !isAscending) {
            logger.i(
                "Look To Ascending $lookToAscending false ise küçükse güzel");
            showEffect(ref.context, EffectStates.excellent,
                refX: ref, isSvg: false);
            if (state.containsKey(gameId)) {
              state[gameId] = valueOfValue;
            }
          } else if (lookToAscending && isDescending) {
            if (gameDownEffectCondition.containsKey(gameId)) {
              gameDownEffectCondition[gameId] = valueOfValue;
            }

            showEffect(ref.context, EffectStates.bad,
                isSvg: true, path: AssetManager.badPng, refX: ref);
          } else if (!lookToAscending && !isDescending) {
            if (gameDownEffectCondition.containsKey(gameId)) {
              gameDownEffectCondition[gameId] = valueOfValue;
            }

            showEffect(ref.context, EffectStates.bad,
                isSvg: true, path: AssetManager.badPng, refX: ref);
          }
        }
      }
    }
  }

  Future<void> showEffect(BuildContext context, EffectStates effectState,
      {bool isSvg = false, String? path, required WidgetRef refX}) async {
    if(refX.read(currentEffectEnableManager)){
      if (effectState == EffectStates.excellent) {
        isExcellentState = true;
      }

      final audioPlayer = refX.watch(cpAudioPlayerProv);

      switch (effectState) {
        case EffectStates.excellent:
          audioPlayer.playExcellent();
          break;
        case EffectStates.good:
          if (!isExcellentState) {
            if (playAmazing) {
              audioPlayer.playAmazing();
            } else {
              audioPlayer.playPerfect();
            }
            playAmazing = !playAmazing;
          }

          break;
        case EffectStates.bad:
          audioPlayer.playBad();
          break;
        case EffectStates.notBad:
          // TODO: Handle this case.
        case EffectStates.perfect:
          // TODO: Handle this case.
      }
      /**/
      final alertDialog = AlertDialog(
        backgroundColor: Colors.transparent,
        content:  Lottie.asset(
          EffectStates.getEffectPath(effectState),
          repeat: false,
          filterQuality: FilterQuality.high,
        ),
        // isSvg && !isExcellentState
        //     ? Transform.scale(
        //   scale: 1.5, // Scale factor for enlargement (adjust as needed)
        //   child: Image.asset(
        //     path!,
        //     width: context.size!.width * 0.85,
        //     height: context.size!.height * 0.55,
        //     fit: BoxFit.contain,
        //     alignment: Alignment.center,
        //     filterQuality: FilterQuality.high,
        //     semanticLabel: 'Büyük Resim',
        //   ),
        // )
        //     : Lottie.asset(
        //   EffectStates.getEffectPath(effectState),
        //   repeat: false,
        //   filterQuality: FilterQuality.high,
        // ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      );

      await Future.delayed(const Duration(milliseconds: 50));
      if(context.mounted){
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return alertDialog;
          },
        ).then((value) async {
          if (isExcellentState) {
            isExcellentState = false;
            await Future.delayed(const Duration(milliseconds: 1200));
            if(context.mounted){
              Navigator.of(context).pop();
            }
          }
        });
      }

      await Future.delayed(const Duration(milliseconds: 1200));
      isExcellentState = false;
      Navigator.of(context).pop();
    }
  }
}

//This function set which i should look condition ascending or descending.
//For example if this return true and so when come 10 and current value
//if setted 5 show effect because we have new best score
/*
  bool isDescendingOrAscendingCondition(GameScoreType gameScoreType){

    switch(gameScoreType){
      case GameScoreType.score:
        return true;
      case GameScoreType.correctCount:
        return true;
      case GameScoreType.incorrectCount:
        return true;
      case GameScoreType.totalDuration:
        return true;
      case GameScoreType.averageDuration:
        return true;
      case GameScoreType.maxDuration:
        return true;
      case GameScoreType.minDuration:
        return true;
      case GameScoreType.totalDistance:
        return true;
      case GameScoreType.averageDistance:
        return true;
      case GameScoreType.maxDistance:
        return true;
      case GameScoreType.minDistance:
        return true;
      case GameScoreType.level:
        return true;
      case GameScoreType.teamHarmony:
        return true;
      case GameScoreType.deviceCatchCount:
        return true;
      case GameScoreType.none:
        return true;
    }
  }
  */
