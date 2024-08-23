import 'package:catchpad/models/game/dynamic_games/dynamic_game_model.dart';
import 'package:catchpad/prov/game_result_prov.dart';
import 'package:catchpad/ui/device/debug/hold_steady_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const steadyDegree = 50.0;

enum CornerAxis {
  isBottomLeft,
  isBottomRight,
  isTopRight,
  isTopLeft,
}

enum MainAxis { isBottom, isTop, isLeft, isRight }

typedef HoldStates = Map<String, double>;

//typedef PerPlayerHoldStates
//    = Map<PlayerModel, HoldSteadyListControllerNotifier>;

typedef PerPlayerHoldStates
    = Map<PlayerModel, Map<String, Map<String, double>>>;

typedef PerPlayerAverage = Map<String, Map<String, double>>;

typedef PerPlayerDiagramState = Map<PlayerModel, Map<String, double>>;

final livePolarDiagramProvider =
    StateNotifierProvider<LivePolarDiagramNotifier, PerPlayerDiagramState>(
        (ref) => LivePolarDiagramNotifier({}));

class LivePolarDiagramNotifier extends StateNotifier<PerPlayerDiagramState> {
  LivePolarDiagramNotifier(PerPlayerDiagramState state) : super({});

  Map<PlayerModel, int> counterAverage = {};
  Map<PlayerModel, Map<String, double>> averageTotalDegreesOnAxis = {};
  PerPlayerDiagramState averageDiagram = {};

  bool once = false;

  initialize(PerPlayerDiagramState per) {
    per.forEach((key, value) {
      counterAverage.addAll({key: 1});
      averageDiagram.addAll({key: value});
      averageTotalDegreesOnAxis.addAll({key: value});
    });
  }

  void changeState(PerPlayerDiagramState per, {bool force = false}) {
    if (!once) {
      initialize(per);
      averageTotalDegreesOnAxis = {};
      averageDiagram = {};
      once = true;
      return;
    }

    per.forEach((playerKey, allAxis) {
      counterAverage.addAll({playerKey: counterAverage[playerKey] ?? 1 + 1});

      if (!averageTotalDegreesOnAxis.containsKey(playerKey)) {
        averageTotalDegreesOnAxis[playerKey] = {...allAxis};
        averageDiagram[playerKey] = {...allAxis};
      } else {
        allAxis.forEach((perAxis, value) {
          averageTotalDegreesOnAxis[playerKey]![perAxis] =
              averageTotalDegreesOnAxis[playerKey]![perAxis]! + value;
          averageDiagram[playerKey]![perAxis] =
              (averageTotalDegreesOnAxis[playerKey]![perAxis]! /
                      counterAverage[playerKey]!) *
                  0.001;
        });
      }
    });

    // Ortalamaları turn sayısına böl
    averageDiagram.forEach((playerKey, playerValues) {
      playerValues.forEach((perAxis, value) {
        averageDiagram[playerKey]![perAxis] =
            (averageTotalDegreesOnAxis[playerKey]![perAxis]! /
                    counterAverage[playerKey]!) *
                0.001;
      });
    });
    state = per;
  }

  void clear(WidgetRef ref) {
    counterAverage.clear();
    averageDiagram.clear();
    averageTotalDegreesOnAxis.clear();
    state.clear();
  }
}

final averagePolarDiagramNotifier =
    StateNotifierProvider<AveragePolarDiagramNotifier, PerPlayerDiagramState>(
        (ref) => AveragePolarDiagramNotifier({}));

class AveragePolarDiagramNotifier extends StateNotifier<PerPlayerDiagramState> {
  AveragePolarDiagramNotifier(PerPlayerDiagramState state) : super({});
  Map<String, Map<String, double>> allAxis = {};

  void changeState(PerPlayerDiagramState per, WidgetRef ref) {
    final temp = PerPlayerDiagramState.from(state);
    temp.addAll(per);
    state = temp;
  }

  void clear(WidgetRef ref) => state.clear();
}

final playerHoldStateControlProvider =
    StateNotifierProvider<PlayerHoldStateControlNotifier, PerPlayerHoldStates>(
        (ref) => PlayerHoldStateControlNotifier({}));

class PlayerHoldStateControlNotifier
    extends StateNotifier<PerPlayerHoldStates> {
  PlayerHoldStateControlNotifier(PerPlayerHoldStates state) : super({});

  PerPlayerDiagramState playersAverageCorner = {};
  PerPlayerDiagramState playersAverageMain = {};
  PerPlayerDiagramState playersAxisTotalDegree = {};
  PerPlayerDiagramState playersAllAxisSteadyTotalSec = {};
  PerPlayerDiagramState playersLiveDegrees = {};
  Map<PlayerModel, int> playersPerCounter = {};

  /// Maybe this code bullshit. My some experiences show have been
  /// getting low performance when adding all values to one list :(
  /// Each Axis have average degree and average steady status by time

  //When u want
  final averageCornerDefaults = {
    CornerAxis.isBottomLeft.name: steadyDegree,
    CornerAxis.isBottomRight.name: steadyDegree,
    CornerAxis.isTopRight.name: steadyDegree,
    CornerAxis.isTopLeft.name: steadyDegree,
  };

  final mainAverageDefaults = {
    MainAxis.isBottom.name: steadyDegree,
    MainAxis.isRight.name: steadyDegree,
    MainAxis.isLeft.name: steadyDegree,
    MainAxis.isTop.name: steadyDegree,
  };

  final allAxisTotalDefaults = {
    CornerAxis.isBottomLeft.name: steadyDegree,
    CornerAxis.isBottomRight.name: steadyDegree,
    CornerAxis.isTopRight.name: steadyDegree,
    CornerAxis.isTopLeft.name: steadyDegree,
    MainAxis.isBottom.name: steadyDegree,
    MainAxis.isRight.name: steadyDegree,
    MainAxis.isLeft.name: steadyDegree,
    MainAxis.isTop.name: steadyDegree
  };

  //Total sec steady statuses. Which axis stay balanced by total time.
  final allAxisSteadyTotalSec = {
    CornerAxis.isBottomLeft.name: 0.0,
    CornerAxis.isBottomRight.name: 0.0,
    CornerAxis.isTopRight.name: 0.0,
    CornerAxis.isTopLeft.name: 0.0,
    MainAxis.isBottom.name: 0.0,
    MainAxis.isRight.name: 0.0,
    MainAxis.isLeft.name: 0.0,
    MainAxis.isTop.name: 0.0
  };

  final liveDegree = {
    CornerAxis.isBottomLeft.name: steadyDegree,
    CornerAxis.isBottomRight.name: steadyDegree,
    CornerAxis.isTopRight.name: steadyDegree,
    CornerAxis.isTopLeft.name: steadyDegree,
    MainAxis.isBottom.name: steadyDegree,
    MainAxis.isRight.name: steadyDegree,
    MainAxis.isLeft.name: steadyDegree,
    MainAxis.isTop.name: steadyDegree
  };

  initialize(WidgetRef ref) {
    final result = ref.watch(gameResultProv);
    final players = result?.players;

    PerPlayerHoldStates temp = state;

    players?.forEach((player) {
      playersAverageCorner.addAll({player: averageCornerDefaults});
      playersAverageMain.addAll({player: mainAverageDefaults});
      playersAxisTotalDegree.addAll({player: allAxisTotalDefaults});
      playersAllAxisSteadyTotalSec.addAll({player: allAxisSteadyTotalSec});
      playersLiveDegrees.addAll({player: liveDegree});
      playersPerCounter.addAll({player: 0});

      final tempVal = {
        "playersAverageCorner": playersAverageCorner[player]!,
        "playersAverageMain": playersAverageMain[player]!,
        "playersAxisTotalDegree": playersAxisTotalDegree[player]!,
        "playersAllAxisSteadyTotalSec": playersAllAxisSteadyTotalSec[player]!,
        "playersLiveDegrees": playersLiveDegrees[player]!
      };

      temp.putIfAbsent(player, () => tempVal);

      ref.read(averagePolarDiagramNotifier.notifier).changeState({
        player: {
          ...playersAverageMain[player]!,
          ...playersAverageCorner[player]!
        }
      }, ref);
    });
    ref.read(averagePolarDiagramNotifier).keys.forEach((element) {
      debugPrint("Initialize: ${element.id}");
    });
    updateState(temp);
  }

  void addPlayerWithHoldStates(WidgetRef ref, PlayerModel playerModel,
      HoldSteadyGameModel holdSteadyGameModel, double degree) {
    //debugPrint(
    //    "Player Model${playerModel.playerName}: $degree ${holdSteadyGameModel.directions}\n ${ref.read(averagePolarDiagramNotifier)[playerModel]}");
    //
    //Detect which corner is leaned

    playersPerCounter[playerModel] = (playersPerCounter[playerModel]! + 1);

    if (holdSteadyGameModel.directions.contains(Direction.all)) {
      final definedNeighborFirst = CornerAxis.isTopRight.name;
      final definedNeighborSecond = CornerAxis.isTopLeft.name;
      final definedNeighbor2First = CornerAxis.isBottomLeft.name;
      final definedNeighbor2Second = CornerAxis.isBottomRight.name;

      final definedKey = MainAxis.isTop.name;
      final defined2Key = MainAxis.isBottom.name;
      final defined3Key = MainAxis.isLeft.name;
      final defined4Key = MainAxis.isRight.name;

      customMainSetValues(defined3Key, degree, playerModel, ref);
      customMainSetValues(defined4Key, degree, playerModel, ref);

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          true, playerModel, ref,
          isSteady: true);

      setValues(defined2Key, definedNeighbor2First, definedNeighbor2Second,
          degree, true, playerModel, ref,
          isSteady: true);

      liveSetValues([
        definedKey,
        definedNeighborFirst,
        definedNeighborSecond,
        defined2Key,
        definedNeighbor2First,
        definedNeighbor2Second,
        defined3Key,
        defined4Key
      ], 10, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.left) &&
        holdSteadyGameModel.directions.contains(Direction.top)) {
      final definedKey = CornerAxis.isTopLeft.name;
      final definedNeighborFirst = MainAxis.isLeft.name;
      final definedNeighborSecond = MainAxis.isTop.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          false, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.left) &&
        holdSteadyGameModel.directions.contains(Direction.bottom)) {
      final definedKey = CornerAxis.isBottomLeft.name;
      final definedNeighborFirst = MainAxis.isBottom.name;
      final definedNeighborSecond = MainAxis.isLeft.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          false, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.right) &&
        holdSteadyGameModel.directions.contains(Direction.top)) {
      final definedKey = CornerAxis.isTopRight.name;
      final definedNeighborFirst = MainAxis.isTop.name;
      final definedNeighborSecond = MainAxis.isRight.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          false, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.right) &&
        holdSteadyGameModel.directions.contains(Direction.bottom)) {
      final definedKey = CornerAxis.isBottomRight.name;
      final definedNeighborFirst = MainAxis.isBottom.name;
      final definedNeighborSecond = MainAxis.isRight.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          false, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.left)) {
      final definedKey = MainAxis.isLeft.name;
      final definedNeighborFirst = CornerAxis.isBottomLeft.name;
      final definedNeighborSecond = CornerAxis.isTopLeft.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          true, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.right)) {
      final definedKey = MainAxis.isRight.name;
      final definedNeighborFirst = CornerAxis.isTopRight.name;
      final definedNeighborSecond = CornerAxis.isBottomRight.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          true, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.top)) {
      final definedKey = MainAxis.isTop.name;
      final definedNeighborFirst = CornerAxis.isTopRight.name;
      final definedNeighborSecond = CornerAxis.isTopLeft.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          true, playerModel, ref);
    } else if (holdSteadyGameModel.directions.contains(Direction.bottom)) {
      final definedKey = MainAxis.isBottom.name;
      final definedNeighborFirst = CornerAxis.isBottomLeft.name;
      final definedNeighborSecond = CornerAxis.isBottomRight.name;

      setValues(definedKey, definedNeighborFirst, definedNeighborSecond, degree,
          true, playerModel, ref);
    }
  }

  void customMainSetValues(String definedKey, double degree,
      PlayerModel playerModel, WidgetRef ref) {
    final lastTotalValue = playersAxisTotalDegree[playerModel]![definedKey];

    final newTotalDegree = lastTotalValue! + degree;

    playersAxisTotalDegree[playerModel]![definedKey] = newTotalDegree;

    final newAverageForAxis = newTotalDegree / playersPerCounter[playerModel]!;

    playersAverageMain[playerModel]![definedKey] = newAverageForAxis;

    ref.read(averagePolarDiagramNotifier.notifier).changeState({
      playerModel: {
        ...playersAverageMain[playerModel]!,
        ...playersAverageCorner[playerModel]!
      }
    }, ref);
  }

  void setValues(
      String definedKey,
      String definedNeighborFirst,
      String definedNeighborSecond,
      double degree,
      bool isMainAxis,
      PlayerModel playerModel,
      WidgetRef ref,
      {bool isSteady = false}) {
    final lastTotalValue = playersAxisTotalDegree[playerModel]![definedKey];
    final lastDefineNeighborFirstKeyValue =
        playersAxisTotalDegree[playerModel]![definedNeighborFirst];
    final lastDefineNeighborSecondValue =
        playersAxisTotalDegree[playerModel]![definedNeighborSecond];

    if (!isSteady) {
      liveSetValues([
        definedKey,
        definedNeighborFirst,
        definedNeighborSecond,
      ], degree, playerModel, ref);
    }

    final newTotalDegree = lastTotalValue! + degree;
    final newTotalNeighborFirstDegree =
        lastDefineNeighborFirstKeyValue! + ((isSteady) ? degree : degree / 2);
    final newTotalNeighborSecondDegree =
        lastDefineNeighborSecondValue! + ((isSteady) ? degree : degree / 2);

    playersAxisTotalDegree[playerModel]!
        .update(definedKey, (value) => newTotalDegree);
    playersAxisTotalDegree[playerModel]!
        .update(definedNeighborFirst, (value) => newTotalNeighborFirstDegree);
    playersAxisTotalDegree[playerModel]!
        .update(definedNeighborSecond, (value) => newTotalNeighborSecondDegree);

    final newAverageForAxis = newTotalDegree / playersPerCounter[playerModel]!;
    final newAverageForLeftAxis =
        newTotalNeighborFirstDegree / playersPerCounter[playerModel]!;
    final newAverageForTopAxis =
        newTotalNeighborSecondDegree / playersPerCounter[playerModel]!;

    if (isMainAxis) {
      playersAverageMain.update(playerModel, (value) {
        value.update(definedKey, (value) => newAverageForAxis);
        return value;
      });
      playersAverageCorner[playerModel]!
        ..update(definedNeighborFirst, (value) => newAverageForLeftAxis)
        ..update(definedNeighborSecond, (value) => newAverageForTopAxis);
    } else {
      playersAverageCorner[playerModel]!
          .update(definedKey, (value) => newAverageForAxis);
      playersAverageMain[playerModel]!
        ..update(definedNeighborFirst, (value) => newAverageForLeftAxis)
        ..update(definedNeighborSecond, (value) => newAverageForTopAxis);
    }

    ref.read(averagePolarDiagramNotifier.notifier).changeState({
      playerModel: {
        ...playersAverageMain[playerModel]!,
        ...playersAverageCorner[playerModel]!
      }
    }, ref);
  }

  void updateState(PerPlayerHoldStates nState) {
    state = nState;
  }

  void liveSetValues(List<String> definedKeyList, double degree,
      PlayerModel playerModel, WidgetRef ref) {
    PerPlayerDiagramState tempLiveDegree = playersLiveDegrees;

    double predictDegree = degree;
    bool onceDivideForNeighboor = false;

    for (var definedKey in definedKeyList) {
      if (tempLiveDegree.keys.contains(playerModel) &&
          tempLiveDegree[playerModel]!.keys.contains(definedKey)) {
        tempLiveDegree[playerModel]!.addAll({definedKey: predictDegree});
        if (definedKeyList.length < 5 && !onceDivideForNeighboor) {
          predictDegree = predictDegree / 2;
          onceDivideForNeighboor = true;
        }
      }
    }

    for (var key in tempLiveDegree[playerModel]!.keys) {
      if (!definedKeyList.contains(key)) {
        tempLiveDegree[playerModel]!.addAll({key: steadyDegreeForLive()});
      }
    }

    playersLiveDegrees[playerModel] = tempLiveDegree[playerModel]!;

    ref
        .read(livePolarDiagramProvider.notifier)
        .changeState({playerModel: playersLiveDegrees[playerModel]!});
  }

  double steadyDegreeForLive() => 20;

  void clear(WidgetRef ref) {
    ref.read(livePolarDiagramProvider.notifier).clear(ref);

    state.clear();
  }
}
