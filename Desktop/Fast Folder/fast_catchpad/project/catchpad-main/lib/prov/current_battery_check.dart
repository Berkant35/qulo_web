import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class CurrentDeviceBatteryChargingStatusNotifier extends StateNotifier<Map<String, bool>> {
  CurrentDeviceBatteryChargingStatusNotifier(Map<String, bool> state) : super({});

  void create(WidgetRef ref,String deviceId,{bool forceValue = false}) {
    state.addAll({deviceId:forceValue});
  }

  void update(WidgetRef ref,String deviceId,{required bool forceValue }) {
    if(state.containsKey(deviceId)){
      state.update(deviceId, (value) => forceValue);
    }else{
      create(ref, deviceId,forceValue: forceValue);
    }
  }

  void remove(WidgetRef ref,String deviceId) {
    state.remove(deviceId);
  }
  void clear(){
    state = {};
  }
}
