import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../enums/game/event_type.dart';
import 'instruction_model.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  // final EventExecutionType executionType;
  final EventType type;
  final List<InstructionModel> instructions;

  EventModel({
    required this.type,
    // required this.executionType,
    required this.instructions,
  });

  Future<bool> execute(WidgetRef ref, InstructionModel parent) async {
    switch (type) {
      case EventType.touch:
        {
          final devs = parent.getDevices(ref);

          if (devs == null || devs.isEmpty) {
            assert(false);
            return false;
          }

          await for (final i in PadSensorManager.listenToTouchMulti(
            devs.map((e) => e.id),
            ref: ref,
          )) {
            logger.d('top secret touch event $i');

            // DYNAMIC_GAME_TODO: handle [executionType]
            // if (executionType == EventExecutionType.firstEvent) {}

            break;
          }

          for (final ins in instructions) {
            await ins.execute(ref, parent);
          }
          break;
        }
    }

    return true;
  }

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
