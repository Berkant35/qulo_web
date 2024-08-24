import 'package:flutter_riverpod/flutter_riverpod.dart';

class WaveAnimationControlNotifier extends StateNotifier<bool> {
  WaveAnimationControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;
}
