import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class CurrentAllConnectionStatusControlNotifier extends StateNotifier<bool> {
  CurrentAllConnectionStatusControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;
}
