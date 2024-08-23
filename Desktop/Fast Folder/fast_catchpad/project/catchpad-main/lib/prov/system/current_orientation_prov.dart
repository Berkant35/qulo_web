import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentOrientationBlockControlNotifier extends StateNotifier<bool> {
  CurrentOrientationBlockControlNotifier(bool state) : super(false);

  Future<void> setBlock() async {
    state = true;
    await Future.delayed(const Duration(seconds: 2));
    state = false;
  }
}
