import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import 'global_providers.dart';

class DevLedManagerNotifier extends StateNotifier<Map<String, bool>> {
  DevLedManagerNotifier(Map<String, bool> state) : super({"all": false});

  void updateState(Map<String, bool> val) => state = val;

  //When you call this function, current led state
  //changing to opposite situation
  Future<void> onOff(WidgetRef ref, String deviceId) async {
    Map<String, bool> currentMap = {};

    state.forEach((key, value) {
      currentMap.addAll({key: value});
    });

    if (currentMap[deviceId]!) {
      await PadManager.ledOff(
        deviceId,
        ref: ref,
      );
    } else {
      await PadManager.toggleLight(
        deviceId,
        ref: ref,
      );
    }
    currentMap.update(deviceId, (value) => !value);
    logger.i("CurrentMap:$currentMap");
    updateState(currentMap);
  }

  //When you call this function, current change led state
  //changing to opposite situation
  Future<void> allOnOff(WidgetRef ref) async {
    final currentState = state['all'];
    Map<String, bool> currentMap = state;
    final keyList = ref.read(currentDevicesManagerProvider).keys;
    final futureList = <Future>[];

    for(String deviceId in keyList){
      currentMap.update(deviceId, (value) => !currentState!);

    }
    currentMap.update('all', (value) => !value);

    updateState(currentMap);

    for (String deviceId in keyList) {

      if (currentState!) {
        futureList.add(PadManager.ledOff(
          deviceId,
          ref: ref,
        ));
      } else {
        futureList.add(PadManager.toggleLight(
          deviceId,
          ref: ref,
        ));
      }

    }

    Future.wait(futureList);
  }

  //Add new pad state to watch
  void add(WidgetRef ref, String deviceId) {
    if (!state.keys.contains(deviceId)) {
      Map<String, bool> currentMap = {};
      currentMap.addAll({deviceId: false});
      state.addAll(currentMap);
    }
  }

  void delete(WidgetRef ref, String deviceId) {
    final current = state;
    current.remove(deviceId);
    state = current;
  }
}
