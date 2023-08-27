import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceInfoManagerNotifier extends StateNotifier<AndroidDeviceInfo?> {
  DeviceInfoManagerNotifier(AndroidDeviceInfo? state) : super(null);

  void set(WidgetRef ref, AndroidDeviceInfo deviceInfoPlugin) =>
      state = deviceInfoPlugin;


}
