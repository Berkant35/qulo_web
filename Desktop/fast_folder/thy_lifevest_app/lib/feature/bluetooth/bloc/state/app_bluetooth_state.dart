import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/constant/app_ble_settings.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';

part 'app_bluetooth_state.freezed.dart';

@freezed
abstract class AppBluetoothState with _$AppBluetoothState {
  const factory AppBluetoothState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    Failure? failure,
    BluetoothAdapterState? adapterState,
    BluetoothDevice? connectedDevice,
    String? connectedDeviceName,
    BluetoothDevice? byLocaleDevice,
    String? byLocaleDeviceName,
    BluetoothConnectionState? bleConnectionState,
    @Default(false) isScanByFlutterBluePlus,
    @Default([]) List<ScanResult> discoveredScanResults,
  }) = _AppBluetoothState;

  const AppBluetoothState._();

  @useResult
  AppBluetoothState isSupportedByThisDevice() {
    return copyWith(
      failure: const Failure(
        code: AppBleConfigs.errorCodeNotSupported,
        errorText: AppBleConfigs.errorCodeNotSupportedDescription,
        errorTitle: AppBleConfigs.errorCodeNotSupportedTitle,
      ),
    );
  }

  @useResult
  AppBluetoothState failureDisconnectDevice(String errorText) {
    return copyWith(
      failure: Failure(
        code: AppBleConfigs.errorCodeDisconnectionFailedTitle,
        errorText: errorText,
        errorTitle: AppBleConfigs.errorCodeDisconnectionFailed,
      ),
      connectedDevice: null,
      connectedDeviceName: null,
    );
  }

  @useResult
  AppBluetoothState failureConnectDevice(String errorText) {
    return copyWith(
      failure: Failure(
        code: AppBleConfigs.errorCodeConnectionFailed,
        errorText: errorText,
        errorTitle: AppBleConfigs.errorCodeConnectionFailedTitle,
      ),
      connectedDevice: null,
      connectedDeviceName: null,
    );
  }
}
