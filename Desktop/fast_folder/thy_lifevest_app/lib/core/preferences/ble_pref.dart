part of 'i_pref.dart';

enum BleSharedKeys { bleDeviceName, bleDeviceAddress }

base class BlePref extends IPref {
  Future<bool> saveBleDeviceName(String bleName) async {
    try {
      await super._set(BleSharedKeys.bleDeviceName.name, bleName);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getBleDeviceName() async {
    return await super._get(BleSharedKeys.bleDeviceName.name) as String?;
  }

  Future<bool> saveBleDeviceAddress(String bleAddress) async {
    try {
      await super._set(BleSharedKeys.bleDeviceAddress.name, bleAddress);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getBleDeviceAddress() async {
    return await super._get(BleSharedKeys.bleDeviceAddress.name) as String?;
  }
}
