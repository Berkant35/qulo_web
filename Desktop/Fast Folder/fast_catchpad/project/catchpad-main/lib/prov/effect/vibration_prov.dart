import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnableVibrationManagerNotifier extends StateNotifier<bool> {
  EnableVibrationManagerNotifier(bool state) : super(false);

  void changeState() => state = !state;
}

final currentVibrationDegree =
    StateNotifierProvider<EnableVibrationManagerNotifier, bool>(
        (_) => EnableVibrationManagerNotifier(false));
