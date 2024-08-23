

import 'package:catchpad/models/feedback/traces/ble/command_time_tracker.dart';
import 'package:catchpad/models/feedback/traces/play/meta_trace.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_flow_tracker.freezed.dart';
part 'ble_flow_tracker.g.dart';

@freezed
class BleFlowTracker  with _$BleFlowTracker {
  const factory BleFlowTracker({
     @JsonKey(name: "bleFlowTrackerId") String? bleFlowTrackerId,
     @JsonKey(name: "metaTrace") MetaTrace? metaTrace,
     @JsonKey(name: "commandTimeTrackerList")
     @Default(<CommandTimeTracker>[])
     List<CommandTimeTracker> commandTimeTrackerList,
  }) = _BleFlowTracker;

  factory BleFlowTracker.fromJson(Map<String, Object?> json) =>
      _$BleFlowTrackerFromJson(json);
}