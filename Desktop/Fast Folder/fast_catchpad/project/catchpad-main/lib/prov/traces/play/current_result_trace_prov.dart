import 'package:battery_plus/battery_plus.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/models/feedback/traces/play/result_trace.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/traces/play/trace_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentResultTraceNotifier extends StateNotifier<ResultTrace?>
    implements TraceBase {
  CurrentResultTraceNotifier(ResultTrace? state) : super(null);

  DateTime? resultStartDate;

  @override
  void calculateDiffTimeWithEndState(WidgetRef ref) {
    resultStartDate ??= DateTime.parse(
        ref.read(currentPlayTraceManager)!.metaTrace!.createdAt!.toString());

    final sec = ref.read(currentGameProv)!.setup.duration?.duration.inSeconds;
    final endTime = DateTime.now();
    final diff = DateTimeRange(
        start: resultStartDate ?? endTime.add(Duration(seconds: -(sec ?? 20))),
        end: endTime);
    state = state?.copyWith(
        passedTime: diff.duration.inSeconds,
        endTime: endTime.toString().substring(0, 18));
  }

  @override
  void incrementClickCount() => state =
      state?.copyWith(clickToScreenCount: (state?.clickToScreenCount ?? 0) + 1);

  @override
  Future<void> create(WidgetRef ref) async {
    resultStartDate = DateTime.now();

    final batteryCharge = await getPhoneBatteryLevel();

    await ref.read(currentBatteryOfPadsManager.notifier).setBatteryVoltage(ref);

    final resultTrace = ResultTrace(
        padBatteryMapStop: ref.read(currentBatteryOfPadsManager),
        phoneChargeStartPercent: batteryCharge,
        createdTime: resultStartDate.toString().substring(0,20),
        createdMillisecondEpoch: resultStartDate!.millisecondsSinceEpoch.toString()
    );

    state = resultTrace;

    ref.read(currentPlayTraceManager.notifier).updateCurrentPlayTrace(ref);
  }

  Future<int> getPhoneBatteryLevel() async => await Battery().batteryLevel;

  void againButtonTrigger(WidgetRef ref) {
    if (state != null) {
      state = state?.copyWith(againButtonTrigger: true);
    }
    finishToResultState(ref: ref);
  }

  Future<void> finishToResultState({required WidgetRef ref}) async {
    calculateDiffTimeWithEndState(ref);
    if (state == null) {
      return;
    }

    final batteryLevel = await getPhoneBatteryLevel();

    state = state?.copyWith(phoneChargeEndPercent: batteryLevel);

    ref
        .read(currentPlayTraceStateManager.notifier)
        .changState(PlayTraceStates.idle);
  }
  void updateState(ResultTrace resultTrace) => state = resultTrace;
  @override
  void disposeCurrentTrace() => state = null;
}

/*@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
    @Default(0)
    int? clickToScreenCount,

    /// Represents the amount of time passed during the game, measured
    /// in some unit (e.g., seconds).
    @JsonKey(name: 'passedTime', defaultValue: 0)
    @Default(0)
    @Default(0)
    int? passedTime,

    /// Indicates whether the "Again" button was triggered or not.
    @JsonKey(name: 'againButtonTrigger', defaultValue: false)
    @Default(false)
    bool? againButtonTrigger,

    /// Represents the initial battery charge percentage of the phone.
    @JsonKey(name: 'phoneChargeStartPercent')
    @Default(0)
    int? phoneChargeStartPercent,

    /// Represents the final battery charge percentage of the phone.
    @JsonKey(name: 'phoneChargeEndPercent')
    @Default(0)
    int? phoneChargeEndPercent,

    /// Represents a mapping of pad IDs to their battery levels.
    @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
    @Default({})
    Map<String, double>? padBatteryMapStop*/
