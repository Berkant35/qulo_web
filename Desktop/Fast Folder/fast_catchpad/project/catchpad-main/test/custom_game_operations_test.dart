import 'package:catchpad/managers/game/custom_game_operations.dart';
import 'package:catchpad/models/enums/game/math_operation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Custom Game Operations:', () {
    test(
      'numberCombinations',
      () {
        final comAdd = CustomGameOperations.numberCombinations(
          [1, 3, 4, 6, 7],
          MathOperation.add,
        );

        expect(
          comAdd.key,
          MathOperation.add,
        );

        expect(
          comAdd.value,
          [
            [1, 3],
            [1, 6],
            [3, 4],
          ],
        );

        final comSub = CustomGameOperations.numberCombinations(
          [1, 3, 4, 6, 7],
          MathOperation.subtract,
        );

        expect(
          comSub.key,
          MathOperation.subtract,
        );

        expect(
          comSub.value,
          [
            [7, 6],
            [7, 4],
            [7, 3],
            [7, 1],
            [6, 3],
            [4, 3],
            [4, 1],
          ],
        );

        final comMul = CustomGameOperations.numberCombinations(
          [1, 2, 3, 4, 6, 7, 8],
          MathOperation.multiply,
        );

        expect(
          comMul.key,
          MathOperation.multiply,
        );

        expect(
          comMul.value,
          [
            [1, 2],
            [1, 3],
            [1, 4],
            [1, 6],
            [1, 7],
            [1, 8],
            [2, 3],
            [2, 4],
          ],
        );

        final comDiv = CustomGameOperations.numberCombinations(
          [1, 2, 3, 4, 6, 7, 8],
          MathOperation.divide,
        );

        expect(
          comDiv.key,
          MathOperation.divide,
        );

        expect(
          comDiv.value,
          [
            [8, 4],
            [8, 2],
            [8, 1],
            [7, 1],
            [6, 3],
            [6, 2],
            [6, 1],
            [4, 2],
            [4, 1],
            [3, 1],
            [2, 1],
          ],
        );
      },
    );
  });
}
