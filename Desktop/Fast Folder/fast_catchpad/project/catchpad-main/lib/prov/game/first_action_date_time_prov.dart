import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class FirstActionDateTimeControlNotifier extends StateNotifier<DateTime?> {
  FirstActionDateTimeControlNotifier(DateTime? state) : super(null);
  final stopWatch = Stopwatch();
  final roundPoints = <Duration>[];
  final allResponseTimes = <Duration>[];

  void changState(DateTime? val) {
    stopWatch.start();
    state = val;
  }

  void addRoundPoint(Duration duration) {
    allResponseTimes.add(duration);
    int total = 0;
    for (var perDuration in allResponseTimes)
    {
      total += perDuration.inMilliseconds;
    }

    roundPoints.add(Duration(milliseconds: total));
  }

  void endStopWatch() {
    stopWatch.stop();

  }

  void cancelAndClear() {
    stopWatch.reset();
    allResponseTimes.clear();
    roundPoints.clear();
    if(state != null){
      state = null;

    }

  }
}

class FirstActionStateControlNotifier extends StateNotifier<bool> {
  FirstActionStateControlNotifier(bool state) : super(true);

  void changState(bool val) => state = val ;
}
