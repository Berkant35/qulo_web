import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

// if any device is disconnect flag turn true
class IGACheckDisconnectingFlagControlNotifier extends StateNotifier<bool> {
  IGACheckDisconnectingFlagControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;
}
