import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class PlayTraceStateControlNotifier extends StateNotifier<PlayTraceStates> {
  PlayTraceStateControlNotifier(PlayTraceStates state)
      : super(PlayTraceStates.idle);

  void changState(PlayTraceStates val) {
    state = val;
   ;
  }
}
