import 'dart:async';

import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/emb/iga/iga_consts.dart';
import '../../global_providers.dart';
import '../emb_global_providers.dart';

class IgaIsThereAnyCustomerControlNotifier extends StateNotifier<bool> {
  IgaIsThereAnyCustomerControlNotifier(bool state) : super(false);

  late Timer? timer;

  late DateTime? dateTime;

  // Update the timeout duration, default is 60 seconds
  void updateTimeout({int second = 60}) =>
      dateTime = DateTime.now().add(Duration(seconds: second));

  // Change the state and start the timer if the state is true
  void changState(bool val, WidgetRef ref) {
    updateTimeout();
    if (state == false && val) startPeriod(ref);
    state = val;
  }

  // Start a periodic timer that checks if the customer is still there
  void startPeriod(WidgetRef ref) {
    timer = null;
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final now = DateTime.now();
      if (dateTime == null) {
        cancelTimer(ref);
        return;
      }
      final diff = now.difference(dateTime!);

      // Cancel the timer if the difference exceeds the timeout value
      if (diff.inSeconds.abs() > (IgaConsts.hasCustomerOnPlatformTimeoutSec)) {
        cancelTimer(ref);
      }
    });
  }

  // Cancel the timer, reset the state, and perform necessary cleanup
  Future<void> cancelTimer(WidgetRef ref) async {
    state = false;
    timer?.cancel();
    ref.read(currentSafeInGameToggleState.notifier).changState(true, ref);

    final ftr = <Future>[];

    // Reset settings for each connected BLE device
    ref.read(bleConPr).keys.forEach((perDiscoveredDevice) {
      ftr.add(PadManager.resetDeviceSettings(perDiscoveredDevice.id, ref: ref));
    });

    await Future.wait(ftr);

    // Change the state to the home page
    ref
        .read(currentIgaPageManager.notifier)
        .changState(IGAStates.home, ref: ref);
  }
}
