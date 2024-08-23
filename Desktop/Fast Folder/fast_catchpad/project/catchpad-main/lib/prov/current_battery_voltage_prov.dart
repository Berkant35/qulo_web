import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentBatteryVoltageNotifier extends StateNotifier<Map<String, double>> {
  CurrentBatteryVoltageNotifier(Map<String, double> state) : super({});

  Future<void> setBatteryVoltage(WidgetRef ref) async {
    Map<String, double> mapOfBatteryVoltage = {};
    ref.read(currentDevicesManagerProvider).keys.forEach((deviceId) async {
      final model = await PadManager.readBattery(deviceId, ref: ref);

      if (model != null) {
        mapOfBatteryVoltage.addAll({
          deviceId: (model.voltage != null ? model.voltage!.toDouble() : 0.0)
        });
      }
    });

    state = mapOfBatteryVoltage;
  }

  Future<void> remove(WidgetRef ref, String deviceId) async {
    Map<String, double> mapOfBatteryVoltage = state;
    print("Before Remove $deviceId $state");
    mapOfBatteryVoltage.remove(deviceId);
    print("Removed $deviceId $state");
    state = mapOfBatteryVoltage;
  }

  void clear(){
    state = {};
  }
  Future<void> updateBatteryVoltage(
      WidgetRef ref, String deviceId, double voltage) async {
    Map<String, double> mapOfBatteryVoltage = state;
    if(!mapOfBatteryVoltage.containsKey(deviceId)){
      mapOfBatteryVoltage.addAll({deviceId: voltage});
    }
    mapOfBatteryVoltage.update(deviceId, (value) => voltage);
    state = mapOfBatteryVoltage;
  }
}
