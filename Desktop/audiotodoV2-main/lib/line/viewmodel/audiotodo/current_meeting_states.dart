import 'package:audiotodo/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

enum CurrentMeetStates { idle, stop, contiune }

class CurrentMeetManagerControlNotifier
    extends StateNotifier<CurrentMeetStates> {
  CurrentMeetManagerControlNotifier(CurrentMeetStates state)
      : super(CurrentMeetStates.idle);

  void changState(CurrentMeetStates val) {
    state = val;
  }
}