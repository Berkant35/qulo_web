import 'package:catchpad/models/feedback/traces/play/game_trace.dart';
import 'package:catchpad/prov/traces/play/trace_base.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/enums/traces/play_traces_enum.dart';
import '../../global_providers.dart';

class CurrentGameTraceNotifier extends StateNotifier<GameTrace?>
    implements TraceBase {
  CurrentGameTraceNotifier(GameTrace? state) : super(null);

  DateTime? gameStartDate;

  @override
  Future<void> create(WidgetRef ref) async {
    gameStartDate = DateTime.now();

    final gameTrace = GameTrace(
      createdTime: gameStartDate!.toString().substring(0, 18),
      createdMillisecondEpoch: gameStartDate!.millisecondsSinceEpoch.toString()
    );

    state = gameTrace;
    ref.read(currentPlayTraceManager.notifier).updateCurrentPlayTrace(ref);
  }

  @override
  void calculateDiffTimeWithEndState(WidgetRef ref) {
    if(gameStartDate == null || state == null) return;
    final endTime = DateTime.now();
    final diff = DateTimeRange(start: gameStartDate!, end: endTime);

    state = state!.copyWith(
        passedTime: diff.duration.inSeconds - 3 > 0 ? diff.duration.inSeconds - 3 : 0,
        endTime: endTime.toString().substring(0, 18));
  }

  @override
  void incrementClickCount() => state =
      state!.copyWith(clickToScreenCount: state!.clickToScreenCount! + 1);

  Future<void> finishToGameState(
      {required bool enterToResult, required WidgetRef ref}) async {
    calculateDiffTimeWithEndState(ref);

    if(state != null){
      state = state?.copyWith(isEnterToResult: enterToResult);
    }

    if (enterToResult) {
      ref
          .read(currentPlayTraceStateManager.notifier)
          .changState(PlayTraceStates.result);
    } else {
      ref
          .read(currentPlayTraceStateManager.notifier)
          .changState(PlayTraceStates.idle);
    }

    ref.read(currentPlayTraceManager.notifier).updateCurrentPlayTrace(ref);
  }

  void forceEnd() {

    if(state != null) state = state!.copyWith(isEnterToResult: false);

  }

  void updateState(GameTrace gameTrace) => state = gameTrace;


  @override
  void disposeCurrentTrace() => state = null;


}
