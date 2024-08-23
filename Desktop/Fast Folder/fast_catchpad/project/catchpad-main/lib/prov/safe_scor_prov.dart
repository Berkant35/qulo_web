import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimePoints {
  action,
  command,
  phoneDiff,
  padDiff,
}

class SafeActionAndCommandScoreNotifier
    extends StateNotifier<Map<String, double>> {
  SafeActionAndCommandScoreNotifier(Map<String, double> state)
      : super({
          TimePoints.action.name: 0.0,
          TimePoints.command.name: 0.0,
          TimePoints.phoneDiff.name: 0.0,
          TimePoints.padDiff.name: 0.0,
        });

  List<double> currentDiffTimes = [];

  void initialize() => state.clear();

  void setActionTime(double actionByMillisecond) {
    Map<String, double> temp = Map<String, double>.from(state);
    temp.update(TimePoints.action.name, (value) => actionByMillisecond);
    state = temp;
  }

  void setCommandTime(double commandByMillisecond) {
    Map<String, double> temp = Map<String, double>.from(state);
    temp.update(TimePoints.command.name, (value) => commandByMillisecond);
    state = temp;
  }

  bool isSafeDifferent(double padDifferentTime) {
    final phoneDiffTime =
        state[TimePoints.action.name]! - state[TimePoints.command.name]!;

    final diffPadFromPhone = (padDifferentTime - phoneDiffTime).abs();

    Map<String, double> temp = Map<String, double>.from(state);

    temp.update(TimePoints.padDiff.name, (value) => padDifferentTime);
    temp.update(TimePoints.phoneDiff.name, (value) => phoneDiffTime);

    state = temp;

    currentDiffTimes.add(diffPadFromPhone);

    return false;
  }
}
