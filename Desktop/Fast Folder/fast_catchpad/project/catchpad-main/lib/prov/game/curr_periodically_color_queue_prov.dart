import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef DeviceSetColor = Map<String, Color?>;

class CurrentPeriodicallyColorQueueNotifier
    extends StateNotifier<DeviceSetColor> {
  CurrentPeriodicallyColorQueueNotifier(DeviceSetColor state) : super({});

  void changeState(DeviceSetColor colorState) => state = colorState;

  void add(WidgetRef ref,
      {required String deviceId, Color? color, required int queue}) {
    logger.i("Added new color");
    final curMap = state;
    if (!curMap.containsKey(deviceId + queue.toString())) {
      curMap.addAll({deviceId + queue.toString(): color});
      if(color != null){
        PadManager.ledColor(deviceId, SidesColorsModel.all(color!), ref: ref);
        Future.delayed(Duration(milliseconds: 500),()=> PadManager.ledOff(deviceId, ref: ref));
      }

    } else {
      curMap.update(deviceId + queue.toString(), (value) => color);
      if(color != null){
        PadManager.ledColor(deviceId, SidesColorsModel.all(color!), ref: ref);
        Future.delayed(const Duration(milliseconds: 500),()=> PadManager.ledOff(deviceId, ref: ref));
      }
    }
    state = curMap;

  }

  void delete(WidgetRef ref, {required String deviceId, required int queue}) {
    final curMap = state;
    curMap[deviceId + queue.toString()] = null;
    state = curMap;
  }
}
