import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class BulBakalimControlNotifier extends StateNotifier<bool> {
  BulBakalimControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;
}

class RemainTimeBulBakalimControlNotifier extends StateNotifier<bool> {
  RemainTimeBulBakalimControlNotifier(bool state) : super(false);

  void changState(bool val){
    state = val;
  }
}
