import 'dart:async';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streamer/streamer.dart';

import '../hold_steady_game_model.dart';

// #region Hold Steady
class HoldSteadyGame extends ConsumerStatefulWidget {
  final HoldSteadyGameModel model;
  final DeviceModel device;

  const HoldSteadyGame({
    required this.model,
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HoldSteadyGame> createState() => _HoldSteadyGameState();
}

class _HoldSteadyGameState extends ConsumerState<HoldSteadyGame> {
  DeviceModel get device => widget.device;

  HoldSteadyGameModel get model {
    final model = widget.model;

    if (radius != null) {
      return model.copyWith(radius: radius!);
    }

    return model;
  }

  double? radius;

  @override
  void initState() {
    super.initState();

    radius = model.radius;
  }

  @override
  void deactivate() {
    resetGame();
    super.deactivate();
  }

  static const double minDurationSec = 2.0, maxDurationSec = 300.0;

  Duration gameDuration = const Duration(seconds: 20);
  Duration successDuration = const Duration();
  Duration passedDuration = const Duration();

  bool isOnGoing = false;
  bool get timeIsEnded => gameDuration <= passedDuration;

  Timer? timer;

  bool isPlayerAtLeastOneTime = false;

  Set<Direction> lastDirections = {};

  void setGameMode(bool value) {
    isPlayerAtLeastOneTime = true;
    if (value) {
      isOnGoing = true;
      successDuration = Duration.zero;
      passedDuration = Duration.zero;

      const period = Duration(milliseconds: 50);
      final sender = SendStreamer<bool>();
      timer = Timer.periodic(
        period,
        (Timer timer) async {
          if (!timeIsEnded && isOnGoing) {
            if (model.isSteady) {
              successDuration += period;
            }

            passedDuration += period;
            setState(() {});
            final dir = model.directions;
            final isSame = setEquals(lastDirections, dir);
            lastDirections = dir;

            if (!isSame) {
              sender.add(
                () async => await PadManager.ledColor(
                  device.id,
                  model.getColor,
                  ref: ref,
                ),
              );
            }
          } else {
            setGameMode(false);
          }
        },
      );
      setState(() {});
    } else {
      timer?.cancel();
      timer = null;
      isOnGoing = false;
      try {
        setState(() {});
      } catch (e) {
        logger.e(e);
      }
    }
  }

  void resetGame() {
    setGameMode(false);
    successDuration = Duration.zero;

    try {
      setState(() {});
    } catch (e) {
      logger.e(e);
    }
  }

  // [successSec: 30]   x
  // [secondsPassed: 40]  100
  // x = 30 * 100 / 40
  double get points {
    final sec = successDuration.inMilliseconds;

    if (sec == 0) {
      return sec + .0;
    }

    return sec * 100 / passedDuration.inMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text('Saniye'),
            ),
            Expanded(
              flex: 5,
              child: Slider.adaptive(
                value: gameDuration.inSeconds + .0,
                min: minDurationSec,
                max: maxDurationSec,
                onChanged: (val) {
                  resetGame();
                  gameDuration = Duration(seconds: val.toInt());
                  setState(() {});
                },
                divisions: (maxDurationSec - minDurationSec).toInt(),
                label: '${gameDuration.inSeconds.toInt()}',
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              child: Text('Sabitlik alanı'),
            ),
            Expanded(
              flex: 5,
              child: Slider.adaptive(
                value: model.radius,
                min: model.minRadius,
                max: 180,
                onChanged: (val) {
                  resetGame();
                  radius = val;
                  setState(() {});
                },
                divisions: (180 - model.minRadius).toInt(),
                label: '${model.radius.toInt()}',
              ),
            ),
          ],
        ),
        if (!isOnGoing) ...[
          if (isPlayerAtLeastOneTime) Text('Başarı Oranı: %$points'),
          ElevatedButton(
            onPressed: () {
              setGameMode(true);
            },
            child: const Text('Başla'),
          ),
        ] else ...[
          Text('Kalan Süre: ${(gameDuration - passedDuration).inSeconds + 1}'),
          ElevatedButton(
            onPressed: () {
              setGameMode(false);
            },
            child: const Text('Bitir'),
          ),
        ],
      ],
    );
  }
}
// #endregion
