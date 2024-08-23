///This class was created to provide flags for use at any time


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

/// The application uses caches and buffers to play videos. This can cause excessive RAM usage.
/// When this limit is exceeded, the phone screen turns white.To prevent this,
/// we check RAM usage every minute. If we detect low memory, we set this flag
/// to true. When we return to the wakeup button page, if this flag is true,
/// we restart the application.
class NeedRestartAppControlNotifier extends StateNotifier<bool> {
  NeedRestartAppControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;
}


/// When order iga application for events you must to use this flag
class EventIgaControlNotifier extends StateNotifier<bool> {
  EventIgaControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;
}

final eventIgaController =
    StateNotifierProvider<EventIgaControlNotifier, bool>(
  (ref) => EventIgaControlNotifier(false),
);