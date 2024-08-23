import 'package:battery_plus/battery_plus.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/models/feedback/traces/play/pre_trace.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/traces/play/trace_base.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentPreTraceNotifier extends StateNotifier<PreTrace?>
    implements TraceBase {
  CurrentPreTraceNotifier(PreTrace? state) : super(null);

  DateTime? preStartDate;

  @override
  Future<void> create(WidgetRef ref) async {

    final date = DateTime.now();

    preStartDate = date;

    final createdAt = date.toString().substring(0, 18);

    await ref.read(currentLocationProvider.notifier).getLocationAndUpdate(ref);

    final batteryCharge = await getPhoneBatteryLevel();

    if(ref.context.mounted){
      await ref.read(currentBatteryOfPadsManager.notifier).setBatteryVoltage(ref);
    }



    Map<String, dynamic> devList = {};

    if(ref.context.mounted){
      ref.read(currentDevicesManagerProvider).forEach((key, value) {
        devList.addAll({key: {
          "bleName" : value.bleName,
          "cpId" : value.cpId,
          "macId" : value.macId,
        }
        });
      });
    }


    if(!ref.context.mounted) return;

    final preTrace = PreTrace(
      padBatteryMapStart: ref.read(currentBatteryOfPadsManager),
      //ref.read(currentDevicesProductManager) burdaki değerler map şeklinde ayarlanılacak
      padList: devList,
      phoneChargeStartPercent: batteryCharge,
      locationData: {
        "lat": ref.read(currentLocationProvider)!.latitude ?? 0.0,
        "long": ref.read(currentLocationProvider)!.longitude ?? 0.0
      },
      createdAt: createdAt,
      createdMillisecondEpoch: preStartDate!.millisecondsSinceEpoch.toString()
    );

    state = preTrace;

    ref.read(currentPlayTraceManager.notifier).updateCurrentPlayTrace(ref);
  }

  @override
  void calculateDiffTimeWithEndState(WidgetRef ref) {
    final diff = DateTimeRange(start: preStartDate!, end: DateTime.now());
    if(state != null){
      state = state!.copyWith(
        passedTime: diff.duration.inSeconds,
      );
    }

  }

  Future<int> getPhoneBatteryLevel() async => await Battery().batteryLevel;

  @override
  void incrementClickCount(){
    if(state == null){
      return;
    }
    state =
        state!.copyWith(clickToScreenCount: (state!.clickToScreenCount ?? 0) + 1);
  }

  Future<void> finishToPreState(
      {required bool enterGameValue, required WidgetRef ref}) async {
    calculateDiffTimeWithEndState(ref);
    state = state?.copyWith(isEnterToGame: enterGameValue);
    if (enterGameValue) {
      ref
          .read(currentPlayTraceStateManager.notifier)
          .changState(PlayTraceStates.game);
    } else {
      ref
          .read(currentPlayTraceStateManager.notifier)
          .changState(PlayTraceStates.idle);
    }
  }
  void updateState(PreTrace preTrace) => state = preTrace;
  @override
  void disposeCurrentTrace() => state = null;
}
