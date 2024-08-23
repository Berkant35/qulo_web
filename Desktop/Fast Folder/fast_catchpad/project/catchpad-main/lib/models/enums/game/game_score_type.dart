import '../../../managers/static_games_list.dart';
import '../../../models/game/game_result_model.dart';

/// IMPORTANT: WHEN YOU CHANGE THIS,
/// ALSO CHANGE [GameResultModel]'s
/// [parseIndexValue] getter.
enum GameScoreType {
  /// best score
  /// as it is never
  /// correctCount - incorrectCount
  /// sometimes it is weighed, like
  /// 4 incorrectCount will equal to
  /// 1 point etc.
  score, // descending, the higher the better

  // /// count of caught pads
  // catchCount, // descending, the higher the better

  // /// count of uncaught pads
  // uncatchCount, // ascending, the lower the better

  //Created to measure how long you've been in balance in the elapsed time
  percentage,

  ///
  speed,


  /// correct count of
  /// scores
  correctCount, // descending, the higher the better

  /// this may be used
  /// to sort
  incorrectCount, // ascending, the lower the better

  /// total duration of
  /// timespans
  totalDuration, // ascending, the lower the better

  /// average duration of
  /// timespans
  averageDuration, // ascending, the lower the better

  /// highest duration of
  /// timespans
  maxDuration, // ascending, the lower the better

  /// lowest duration of
  /// timespans
  minDuration, // ascending, the lower the better

  /// total distance
  totalDistance, // descending, the higher the better

  /// average distance
  averageDistance, // descending, the higher the better

  /// highest distance
  maxDistance, // descending, the higher the better

  /// lowest distance
  minDistance, // descending, the higher the better

  /// some games will level up every time and increase
  /// the complexity of the game. e.g. [StaticGamesList.aklindaTut]
  level, // descending, the higher the better

  /// team harmony in ms
  teamHarmony, // descending, the lower the better

  deviceCatchCount, // How many catch counts per device
  // Devices are specialized with colors so we need to now how many times each
  // device was used for their assigned colors.

  /// for now, there
  /// are games which
  /// we should not list
  /// in the score screen
  none; // none

  // TODO: temporarily we've stopped the catchCount and
  // uncatchCount, because they require additional time for
  // processing which we do not have at the moment.
  static GameScoreType get catchCount => GameScoreType.correctCount;

  static GameScoreType get uncatchCount => GameScoreType.incorrectCount;

  bool get isDescending {
    return
        //
        this == GameScoreType.maxDuration ||
            this == GameScoreType.minDuration ||
            this == GameScoreType.totalDuration ||
            this == GameScoreType.averageDuration ||
            this == GameScoreType.teamHarmony ||
            this == GameScoreType.percentage;
  }
}
