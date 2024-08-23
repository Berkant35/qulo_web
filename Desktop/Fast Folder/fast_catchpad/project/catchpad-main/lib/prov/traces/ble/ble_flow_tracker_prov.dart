import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/feedback/traces/ble/ble_flow_tracker.dart';
import 'package:catchpad/models/feedback/traces/ble/command_time_tracker.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/async.dart';

class BleFlowTrackerNotifier extends StateNotifier<BleFlowTracker?> {
  BleFlowTrackerNotifier(BleFlowTracker? state) : super(null);

  Future<void> initialize(WidgetRef ref) async {
    final currentMetaTracer = ref.read(currentMetaTraceManager)!;

    final traceId = await nanoid(24);

    state = BleFlowTracker(
      bleFlowTrackerId: traceId,
      metaTrace: currentMetaTracer,
    );
  }

  void update(WidgetRef ref, BleFlowTracker bleFlowTracker) =>
      state = bleFlowTracker;

  Future<void> addCommandTracker(
      WidgetRef ref, CommandTimeTracker commandTimeTracker) async {
    if (state != null) {
      state = state?.copyWith(commandTimeTrackerList: [
        ...state!.commandTimeTrackerList,
        commandTimeTracker
      ]);
    }
  }

  void refresh(WidgetRef ref) {
    try {
      if (state!.commandTimeTrackerList.isNotEmpty) {
        logger.w(
            "Current State Json Refresh Status And Sent to Firebase: ${state!.toJson()}");
        /*FirebaseCollectionEnums.main_traces.reference
            .doc('ble_traces')
            .collection(FirebaseCollectionEnums.ble_flow_tracker.name)
            .doc(state!.bleFlowTrackerId)
            .set(state!.toJson());*/
      }
    } catch (e) {
      logger.e(e);
    }

    state = null;
  }
}
