import 'package:flutter_riverpod/flutter_riverpod.dart';

/// this guy specifies the number
/// of the current round
final gameCurrRoundProv = StateNotifierProvider<GameRoundNotifier, int>(
  (ref) => GameRoundNotifier(),
);

/// this guy specifies how many
/// rounds are in the current played game
final gameRoundCountProv = StateNotifierProvider<GameRoundNotifier, int>(
  (ref) => GameRoundNotifier(),
);

final gameLeftRoundCountProv = StateProvider<int>(
  (ref) {
    final roundCount = ref.watch(gameRoundCountProv);
    final currRound = ref.watch(gameCurrRoundProv);

    return roundCount - currRound;
  },
);

/// this guy specifies how much duration
/// has passed since the current game
/// started
final gameCurrDurationProv =
    StateNotifierProvider<GameDurationNotifier, Duration>(
  (ref) => GameDurationNotifier(),
);

/// this guy specifies how long
/// the current game's duration is.
final gameDurationCountProv =
    StateNotifierProvider<GameDurationNotifier, Duration>(
  (ref) => GameDurationNotifier(),
);

class GameRoundNotifier extends StateNotifier<int> {
  GameRoundNotifier() : super(0);

  void setTo(int n) => state = n;

  void increment() => state++;

  void decrement() => state--;

  void reset() => state = 0;
}

class GameDurationNotifier extends StateNotifier<Duration> {
  GameDurationNotifier() : super(Duration.zero);

  void setTo(Duration n) => state = n;

  void increaseBy(Duration n) => state += n;

  void decreaseBy(Duration n) => state -= n;

  void reset() => state = Duration.zero;
}
