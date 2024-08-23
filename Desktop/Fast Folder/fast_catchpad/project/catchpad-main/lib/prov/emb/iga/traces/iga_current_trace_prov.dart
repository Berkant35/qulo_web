import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// This provider holds the state of [IgaPlayTraceStates]. 
/// with this state, when state transitions, the previous and next 
/// trace models are managed.

class CurrentIgaPlayTraceStateControlNotifier
    extends StateNotifier<IgaPlayTraceStates> {
  CurrentIgaPlayTraceStateControlNotifier(IgaPlayTraceStates state)
      : super(IgaPlayTraceStates.idle);

  Future<void> changState(IgaPlayTraceStates val, {required WidgetRef ref}) async {
    final prevState = state;

    if (state == val) return;
    state = val;

    switch (state) {
      case IgaPlayTraceStates.idle:
         //This situation check pre trace
         if (prevState == IgaPlayTraceStates.pre) {
           ref
               .read(currentIgaTraceManager.notifier)
               .createPreTraceModel(ref: ref);

         } else if (prevState == IgaPlayTraceStates.result) {
           ref
               .read(currentIgaTraceManager.notifier)
               .createResultTraceModel(ref: ref);
         }
         await ref.read(currentIgaTraceManager.notifier).refresh(ref: ref);
         break;

      case IgaPlayTraceStates.pre:
        ref.read(currentIgaTraceManager.notifier).createIgaTraceModel(ref: ref);
        break;
      case IgaPlayTraceStates.game:
        ref.read(currentIgaTraceManager.notifier).createPreTraceModel(ref: ref);
        break;
      case IgaPlayTraceStates.result:

        ref
            .read(currentIgaTraceManager.notifier)
            .createGameTraceModel(ref: ref);
        break;
      case IgaPlayTraceStates.register:
        ref
            .read(currentIgaTraceManager.notifier)
            .createResultTraceModel(ref: ref);
        break;

      case IgaPlayTraceStates.leaderboard:
        ref
            .read(currentIgaTraceManager.notifier)
            .createRegisterTraceModel(ref: ref);
    }
  }
}
