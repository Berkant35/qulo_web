import 'dart:async';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameChronometer = Stopwatch();

final gameEndingProvider = StateNotifierProvider<EndingGameProvider, bool>(
      (_) => EndingGameProvider(false),
);

final forceEndProvider = StateNotifierProvider<ForceEndControlNotifier, bool>(
      (_) => ForceEndControlNotifier(false),
);

class ForceEndControlNotifier extends StateNotifier<bool> {
  ForceEndControlNotifier(state) : super(false);

  void changState(bool val) => state = val;
}

final currentShowTimerWidget =
StateNotifierProvider<ForceEndControlNotifier, bool>(
      (_) => ForceEndControlNotifier(false),
);

class CurrentShowTimerWidgetNotifier extends StateNotifier<bool> {
  CurrentShowTimerWidgetNotifier(state) : super(false);

  void changState(bool val) => state = val;
}

class EndingGameProvider extends StateNotifier<bool> {
  EndingGameProvider(super.state);

  //For checking periodically
  late Timer? _timer;

  //Start point is created for different time from endTime
  late DateTime? _currentMovePointDurationTime;

  Duration remainDuration = Duration.zero;

  Future<void> start() async {
    state = false;

    //We are waiting for init process and 3 seconds, which equals 7 seconds.

    gameChronometer.reset();
    gameChronometer.start();
  }
  Future<void> chronometerStop() async {
    state = false;
    gameChronometer.stop();
  }

  void updateMovePointDuration() =>
      _currentMovePointDurationTime = DateTime.now();


  void startTimeOut(
      {required WidgetRef ref,
        required int timeOutDurationSecond,
        int intervalCheckSecond = 1,
        int showTimerWidgetSecond = 5}) {
    final intervalDuration = Duration(seconds: intervalCheckSecond);

    _currentMovePointDurationTime = DateTime.now();

    _timer = Timer.periodic(intervalDuration, (timer) {
      final diffFromLastMoveDurationTime =
      DateTime.now().difference(_currentMovePointDurationTime!);

      if (diffFromLastMoveDurationTime.inSeconds.abs() >
          timeOutDurationSecond) {
        end(ref: ref);
      }

      if (diffFromLastMoveDurationTime.inSeconds.abs() >
          showTimerWidgetSecond) {
        ref.read(currentShowTimerWidget.notifier).changState(true);
        remainDuration = Duration(seconds: timeOutDurationSecond - diffFromLastMoveDurationTime.inSeconds.abs());
      }else{
        ref.read(currentShowTimerWidget.notifier).changState(false);
      }
    });
  }

  void end({WidgetRef?  ref}) {

    state = true;
  }

  void resetGameEndingParameters({WidgetRef? ref}){
    _timer!.cancel();
    _timer = null;
    remainDuration = Duration.zero;
    _currentMovePointDurationTime = null;
    ref?.read(currentShowTimerWidget.notifier).changState(false);
    gameChronometer.reset();
    gameChronometer.stop();
  }
}