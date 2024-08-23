import '../../models/enums/game/math_operation.dart';
import '../static_games_list.dart';

abstract class CustomGameOperations {
  /// this method takes a list of integers and an [MathOperation], and
  /// returns a [MapEntry] with the key being the operation given in
  /// the parameter, and the value a list of every combinations that
  /// would be possible with the given list. For example, if the list
  /// is [1, 2, 3, 4, 5], and the operation is [MathOperation.add], then
  /// the method would3
  /// `return MapEntry(Operation.add,[[1, 2], [1, 3], [1, 4], [2, 3]])`
  ///
  /// this has been initially written for the [StaticGamesList.dortIslem]
  /// game.
  static MapEntry<MathOperation, List<List<int>>> numberCombinations(
      List<int> inp, MathOperation operation) {
    final comb = <List<int>>[];

    final len = inp.length;

    final isForward =
        operation == MathOperation.add || operation == MathOperation.multiply;

    processLoop(int i, int j) {
      final currI = inp[i];
      final currJ = inp[j];

      // the result is not guaranteed to be
      // a valid value, because we do not have one
      // if divide is not exact (e.g. 6/4 = 1.5)
      final result = operation.apply([currI, currJ]);

      if (result != null) {
        // if any item in the list is the same of the result,
        // which means the user can catch that pad.
        if (inp.contains(result)) {
          final nums = [currI, currJ];

          comb.add(nums);
        }
      }
    }

    // we go forward for adding and multiplying,
    // which are the operations that are swappable
    // e.g. 4 + 6 = 6 + 4

    // example loop:
    // [1, 3, 4, 6]
    // 1 -> 3, 4, 6
    // 3 -> 4, 6 // we already calculated the possibility of 3 + 1
    // 4 -> 6 // we already calculated the possibility of 4 + 1, 4 + 3
    // we wanna avoid unnecessary calculation of 6, because we already
    // calculated the possibility of 6 + 1, 6 + 3, 6 + 4, so we end the
    // loop at len - 1
    if (isForward) {
      for (int i = 0; i < len - 1; i++) {
        for (int j = i + 1; j < len; j++) {
          processLoop(i, j);
        }
      }
    } else {
      // we go backward for subtracting and dividing,
      // which are the operations that are not swappable
      // e.g. 4 - 6 != 6 - 4

      // we can still convert negative numbers to positive,
      // or in case of division, we can do 1/x to get the result,
      // but we do not wanna complicate the code unnecessarily.

      // example loop:
      // [1, 2, 3, 4, 6] -> [6, 4, 3, 2, 1]
      // 6 -> 4, 3, 2, 1
      // 4 -> 3, 2, 1
      // 3 -> 2, 1
      // 2 -> 1
      // we wanna avoid unnecessary calculation of 1, because
      // there is no elements left to calculate with.
      for (int i = len - 1; i > 0; i--) {
        for (int j = i - 1; j >= 0; j--) {
          processLoop(i, j);
        }
      }
    }

    return MapEntry(operation, comb);
  }
}
