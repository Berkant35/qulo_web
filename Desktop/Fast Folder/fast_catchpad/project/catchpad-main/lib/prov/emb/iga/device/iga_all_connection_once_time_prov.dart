import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

/// check the all pad is connected when app first run
class IGAAllConnectionOnceTimeControlNotifier extends StateNotifier<bool> {
  IGAAllConnectionOnceTimeControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;
}
