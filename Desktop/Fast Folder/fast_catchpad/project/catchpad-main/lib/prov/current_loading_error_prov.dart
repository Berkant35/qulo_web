import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BreakPoints {
  bp1,
  bp2,
  bp3,
  bp4,
  bp5,
  bp6,
  bp7,
  bp8,
  bp9,
  bp10,
  bp11,
  g1,
  g2,
  g3,
  g4,
  g5,
  g6,
  g7,
  g8,
  g9,
  g10,
  g11,
  g12,
  g13,
  g14,
  g15,
  g16,
  g17,
  g18,
  g19,
  g20,
  g21,
  g22,
  g23,
  g24,
  g25,
  g26,
  g27,
  g28,
  g29,
  g30,
  eG1,
  eG2,
  eG3,
  eG4,
  eG5,
  eG6,
  eG7,
  eG8,
  eG9,
  eG10,
  eG11,
  eG12,
  eG13,
  eG14,
  eG15,
  eG16,
  eG17,
  eG18,
  eG19,
  eG20,
  eG21,
  eG22,
  eG23,
  eG24,
  eG25,
  eG26,
}

final currentEasyLoadingBreakPoints =
    StateNotifierProvider<LoadingErrorControlNotifier, Map<String, bool>>(
        (_) => LoadingErrorControlNotifier(currentBreakPointsBefore()));

class LoadingErrorControlNotifier extends StateNotifier<Map<String, bool>> {
  LoadingErrorControlNotifier(Map<String, bool> state)
      : super(currentBreakPointsBefore());

  void refresh() => state = currentBreakPointsBefore();

  void changeState(Map<String, bool> val) => state = val;

  void updateBreakPoint(BreakPoints breakPoints, bool val) {
    final temp = state;
    temp.update(breakPoints.name, (value) => val);
    state = temp;
  }
}

final currentGameInitializeBreakPoints = StateNotifierProvider<
        GameInitializeErrorControlNotifier, Map<String, bool>>(
    (_) => GameInitializeErrorControlNotifier(
        currentBreakPointsForInitializeGame()));

class GameInitializeErrorControlNotifier
    extends StateNotifier<Map<String, bool>> {
  GameInitializeErrorControlNotifier(Map<String, bool> state)
      : super(currentBreakPointsForInitializeGame());

  void refresh() => state = currentBreakPointsForInitializeGame();

  void changeState(Map<String, bool> val) => state = val;

  void updateBreakPoint(BreakPoints breakPoints, bool val) {
    final temp = state;
    temp.update(breakPoints.name, (value) => val);
    state = temp;
  }
}

final endGameBreakPoints = StateNotifierProvider<
    EndGameInitializeErrorControlNotifier, Map<String, bool>>(
    (_) => EndGameInitializeErrorControlNotifier(
        currentBreakPointsForEndGame()));

class EndGameInitializeErrorControlNotifier
    extends StateNotifier<Map<String, bool>> {
  EndGameInitializeErrorControlNotifier(Map<String, bool> state)
      : super(currentBreakPointsForEndGame());

  void refresh() => state = currentBreakPointsForEndGame();

  void changeState(Map<String, bool> val) => state = val;

  void updateBreakPoint(BreakPoints breakPoints, bool val) {
    final temp = state;
    temp.update(breakPoints.name, (value) => val);
    state = temp;
  }
}

Map<String, bool> currentBreakPointsBefore() {
  return {
    BreakPoints.bp1.name: false,
    BreakPoints.bp2.name: false,
    BreakPoints.bp3.name: false,
    BreakPoints.bp4.name: false,
    BreakPoints.bp5.name: false,
    BreakPoints.bp6.name: false
  };
}

Map<String, bool> currentBreakPointsForInitializeGame() {
  return {
    BreakPoints.g1.name: false,
    BreakPoints.g2.name: false,
    BreakPoints.g3.name: false,
    BreakPoints.g4.name: false,
    BreakPoints.g5.name: false,
    BreakPoints.g6.name: false,
    BreakPoints.g7.name: false,
    BreakPoints.g8.name: false,
    BreakPoints.g9.name: false,
    BreakPoints.g10.name: false,
    BreakPoints.g11.name: false,
    BreakPoints.g12.name: false,
    BreakPoints.g13.name: false,
    BreakPoints.g14.name: false,
    BreakPoints.g15.name: false,
    BreakPoints.g16.name: false,
    BreakPoints.g17.name: false,
    BreakPoints.g18.name: false,
    BreakPoints.g19.name: false,
    BreakPoints.g20.name: false,
    BreakPoints.g21.name: false,
    BreakPoints.g22.name: false,
    BreakPoints.g23.name: false,

  };
}


Map<String, bool> currentBreakPointsForEndGame() {
  return {
    BreakPoints.eG1.name: true,
    BreakPoints.eG2.name: true,
  };
}
