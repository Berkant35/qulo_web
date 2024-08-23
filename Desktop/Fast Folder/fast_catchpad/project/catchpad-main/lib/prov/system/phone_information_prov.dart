/*

    final deviceId = await PlatformDeviceId.getDeviceId;
    final platformVersion = await DeviceInformation.platformVersion;
    final modelName = await DeviceInformation.deviceModel;
    final manufacturer = await DeviceInformation.deviceManufacturer;
    final cpuType = await DeviceInformation.cpuName;
    final hardware = await DeviceInformation.hardware;
    final apiLevel = await DeviceInformation.apiLevel;
    final deviceName = await DeviceInformation.deviceName;
    final productName = await DeviceInformation.productName;

*/

import 'package:catchpad/models/system/phone_information_model.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneInformationNotifier extends StateNotifier<PhoneInformationModel?> {
  PhoneInformationNotifier(PhoneInformationModel? state) : super(null);

  Future<void> initialize(WidgetRef ref) async {
    try {

      state = await PhoneInformationModel.initialize();

      // logger.w("Device Id: ${state!.deviceId}");


    } on Exception catch (e) {
      logger.e("Error: $e");
    }
  }

  void delete(WidgetRef ref) {
    state = null;
  }

  bool isIgaTablet() =>
      IgaConsts.igaTabletDevices.keys.contains(state?.deviceId);
}
