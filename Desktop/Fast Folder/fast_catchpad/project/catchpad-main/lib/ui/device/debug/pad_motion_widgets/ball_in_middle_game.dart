import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../hold_steady_game_model.dart';

// #region Ball In Middle
class BallInMiddleGame extends StatefulWidget {
  final HoldSteadyGameModel model;

  const BallInMiddleGame({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  State<BallInMiddleGame> createState() => _BallInMiddleGameState();
}

class _BallInMiddleGameState extends State<BallInMiddleGame> {
  int counter = 0;

  HoldSteadyGameModel get model => widget.model;

  double get _rx => model.x;
  double get _ry => model.y;

  static const smallBallSize = 10.0;

  // the box in the middle of the screen is not always 360, it differs depending
  // on the screen size
  double positionByBigBallSize(double pos) => pos / 360 * bigBallSize;
  double get smallBallStartX => positionByBigBallSize(_rx - smallBallSize / 2);
  double get smallBallStartY => positionByBigBallSize(_ry - smallBallSize / 2);
  double get smallBallEndX => positionByBigBallSize(_rx + smallBallSize / 2);
  double get smallBallEndY => positionByBigBallSize(_ry + smallBallSize / 2);

  // in some devices the square is too big
  // and only part of it is visible
  double? _bigBallSize;
  double get bigBallSize {
    if (_bigBallSize == null) {}
    _bigBallSize = min(
        360.0,
        min(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ) /
            2);

    return _bigBallSize!;
  }

  double get middle => bigBallSize / 2;

  double smallAreaSize = 15.0;
  double get smallAreaStart => middle - smallAreaSize / 2;
  double get smallAreaEnd => middle + smallAreaSize / 2;

  bool get inArea =>
      smallBallEndX <= smallAreaEnd &&
      smallBallEndY <= smallAreaEnd &&
      smallBallStartX >= smallAreaStart &&
      smallBallStartY >= smallAreaStart;

  bool get counting => counter > 0;

  Timer? timer;
  void setCounting() {
    if (inArea) {
      timer ??= Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          if (inArea) {
            counter++;
            setState(() {});
          } else {
            setCounting();
          }
        },
      );
    } else {
      timer?.cancel();
      timer = null;
      counter = 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    setCounting();

    const min = smallBallSize;
    const max = smallBallSize * 10;

    return Column(
      children: [
        Wrap(
          children: [
            const Text('Ortadaki topun hacmi'),
            Expanded(
              child: Slider.adaptive(
                value: smallAreaSize,
                min: min,
                max: max,
                onChanged: (value) {
                  setState(() {
                    smallAreaSize = value;
                  });
                },
                divisions: (max - min).toInt(),
                label: '$smallAreaSize',
              ),
            ),
          ],
        ),
        // if (counting)
        Text('Performans: $counter Saniye'),
        Container(
          height: bigBallSize,
          width: bigBallSize,
          color: Colors.blue,
          child: Stack(
            children: [
              Positioned(
                left: smallAreaStart,
                top: smallAreaStart,
                child: Container(
                  height: smallAreaSize,
                  width: smallAreaSize,
                  decoration: BoxDecoration(
                    color: inArea ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: smallBallStartX,
                top: smallBallStartY,
                child: Container(
                  height: smallBallSize,
                  width: smallBallSize,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// #endregion
