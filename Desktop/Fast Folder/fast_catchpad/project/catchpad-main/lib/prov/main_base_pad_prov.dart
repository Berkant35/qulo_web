import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/cp_colors.dart';

class MainBasePadControlNotifier extends StateNotifier<DiscoveredDevice?> {
  MainBasePadControlNotifier(DiscoveredDevice? state) : super(null);

  void changState(DiscoveredDevice? val, {required WidgetRef ref}) {
    if (state == null) {
      state = val;
      selectedPadShow(ref);
    } else {
      state = val;
    }
  }

  Future<void> selectedPadShow(WidgetRef ref) async {
    if (state == null) return;

    PadManager.ledColor(
        state!.id,
        SidesColorsModel.all(CpColors.green),
        ref: ref
    );

    await Future.delayed(
        const Duration(milliseconds: 500)
    );

    PadManager.ledOff(
        state!.id,
        ref: ref);
  }
}
