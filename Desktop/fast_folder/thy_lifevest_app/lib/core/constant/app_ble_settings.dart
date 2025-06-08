import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppBleConfigs {
  static const logOn = true;

  /*
  ⚫ = function name

  🟣 = args to platform

  🟡 = data from platform
  */
  static const logLevel = LogLevel.error;

  static const errorCodeNotSupported = 0x0001;
  static const errorCodeNotSupportedTitle = "Not Supported";
  static const errorCodeNotSupportedDescription =
      "This device does not support Bluetooth Low Energy (BLE).";
  static const scanTimeOutSecond = 10;
  static const afterListenDelay = 1;

  static const errorCodeConnectionFailed = 0x0002;
  static const errorCodeConnectionFailedTitle = "Connection Failed";
  static const errorCodeConnectionFailedDescription =
      "Failed to connect to the device.";

  static const errorCodeDisconnectionFailedTitle = 0x0003;
  static const errorCodeDisconnectionFailed = "Disconnection Failed";
  static const errorCodeDisconnectionFailedDescription =
      "Failed to disconnect from the device.";
}
