import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// We use for  switch between pages
class IgaPageControlNotifier extends StateNotifier<IGAStates> {
  IgaPageControlNotifier(IGAStates state) : super(IGAStates.home);

  late PageController? pageController;

  void initializePageController() {
    pageController = PageController();
  }

  Future<void> changState(IGAStates val,
      {int intervalMs = 30,
      IGAStates? nextIgaState,
      required WidgetRef ref}) async {
    state = val;
    pageController!.jumpToPage(val.index);

    switch (val) {
      case IGAStates.home:
        ref
            .read(currentIgaTraceStateManager.notifier)
            .changState(IgaPlayTraceStates.idle, ref: ref);
      case IGAStates.onBoardingOne:
        ref
            .read(currentIgaTraceStateManager.notifier)
            .changState(IgaPlayTraceStates.pre, ref: ref);
      case IGAStates.onBoardingTwo:
      case IGAStates.onBoardingThree:
      case IGAStates.onBoardingFour:
        break;
      case IGAStates.result:
        ref
            .read(currentIgaTraceStateManager.notifier)
            .changState(IgaPlayTraceStates.result, ref: ref);
      case IGAStates.lastRegister:
      case IGAStates.seeLeaderboard:
        break;
    }
  }
}
