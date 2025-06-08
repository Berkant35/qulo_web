import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:thy_lifevest_app/core/constant/app_ble_settings.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/preferences/i_pref.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_communication_cubit.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/state/app_bluetooth_state.dart';

class AppBluetoothCubit extends Cubit<AppBluetoothState> {
  AppBluetoothCubit() : super(const AppBluetoothState());
  StreamSubscription<BluetoothAdapterState>? _adapterStateStateSubscription;
  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;
  StreamSubscription<BluetoothConnectionState>?
  _connectedDeviceStateSubscription;
  StreamSubscription<bool>? _listenScanStateSubscription;

  _listenConnectedDeviceState() {
    _connectedDeviceStateSubscription = state.connectedDevice?.connectionState
        .listen((connectionState) {
          emit(state.copyWith(bleConnectionState: connectionState));
        });
  }

  _listenScanState() {
    _listenScanStateSubscription = FlutterBluePlus.isScanning.listen((
      isScanning,
    ) {
      emit(state.copyWith(isScanByFlutterBluePlus: isScanning));
    });
  }

  _listenScanResults() {
    _scanResultsSubscription = FlutterBluePlus.onScanResults.listen((results) {
      if (results.isNotEmpty) {
        emit(
          state.copyWith(
            discoveredScanResults:
                {
                  ...state.discoveredScanResults,
                  ...(results.where(
                    (perRes) =>
                        perRes.device.advName.isNotNull &&
                        perRes.device.advName.isNotEmpty,
                  )),
                }.toList(),
          ),
        );
      }
    });
  }

  _listenAdapterState() {
    emit(state.copyWith(adapterState: BluetoothAdapterState.unknown));
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((
      changeAdapterState,
    ) {
      emit(state.copyWith(adapterState: changeAdapterState));
    });
  }

  /// App açıldığında initialize olur ve singleton yapısıyla ayağa kalkar ve uygulama kill olana kadar ilgili adapter
  /// değişikliklerini günceller ve eğer bir hata ile karşılaşıldıysa da failure state kısmına bu hatanın neden
  /// kaynaklandığını [AppBluetoothCubit] teki static bilgilerle neden olduğu yazılmaya çalışır.
  Future<void> init() async {
    _listenAdapterState();
    _listenScanState();
    _logPrintConfig();
    _getAndSetLocaleDevice();
    await _isSupportedByThisDevice();
    await _turnOnBluePlus();
  }

  Future<void> _turnOnBluePlus() async {
    if (!kIsWeb && Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  Future<void> _isSupportedByThisDevice() async {
    final isSupportedBluetooth = await FlutterBluePlus.isSupported;
    if (!isSupportedBluetooth.isEquals(true)) {
      emit(state.isSupportedByThisDevice());
    }
  }

  Future<String> getFromLocalDeviceName() async {
    final currentDeviceName = await sl<BlePref>().getBleDeviceName();
    return currentDeviceName.getValueOrDefault;
  }

  Future<String> getFromLocalDeviceId() async {
    final currentDeviceAddress = await sl<BlePref>().getBleDeviceAddress();
    return currentDeviceAddress.getValueOrDefault;
  }

  Future<bool> setLocaleDevice({
    required String deviceName,
    required String deviceAddress,
  }) async {
    if (deviceName.isEmpty || deviceAddress.isEmpty) return false;
    BluetoothDevice localBleDevice = BluetoothDevice.fromId(deviceAddress);

    emit(
      state.copyWith(
        byLocaleDevice: localBleDevice,
        byLocaleDeviceName: deviceName,
      ),
    );
    await sl<BlePref>().saveBleDeviceName(deviceName);
    await sl<BlePref>().saveBleDeviceAddress(deviceAddress);
    return true;
  }

  Future<void> _getAndSetLocaleDevice() async {
    final deviceId = await getFromLocalDeviceId();
    final deviceName = await getFromLocalDeviceName();

    if (deviceId.isEmpty) return;

    final localBleDevice = BluetoothDevice.fromId(deviceId);
    emit(
      state.copyWith(
        byLocaleDevice: localBleDevice,
        byLocaleDeviceName: deviceName.isEmpty ? null : deviceName,
      ),
    );
  }

  Future<void> startScanAndAddResults({bool refresh = false}) async {
    if (true.isEquals(refresh)) {
      clearScanResults();
    }
    _listenScanResults();
    startScan();
  }

  Future<void> startScan({Duration? timeout}) async {
    await Future.delayed(
      const Duration(seconds: AppBleConfigs.afterListenDelay),
    );
    FlutterBluePlus.startScan(
      timeout:
          timeout ?? const Duration(seconds: AppBleConfigs.scanTimeOutSecond),
    );
  }

  Future<void> connectToLocalDevice() async {
    try {
      loadingInstance();

      final device = state.byLocaleDevice;
      if (device == null) {
        idleInstance();
        return;
      }

      // Eğer zaten bağlıysa disconnect et
      if (device.isConnected) {
        await device.disconnect();
      }

      // Bağlantıyı kur
      await device.connect(autoConnect: false);

      // Connected device'ı state'e set et
      emit(
        state.copyWith(
          connectedDevice: device,
          connectedDeviceName: state.byLocaleDeviceName,
        ),
      );

      // Connection state listener'ı başlat
      _listenConnectedDeviceState();

      // 🚀 BLE Communication'ı başlat
      await _initializeCommunication(device);

      idleInstance();
    } catch (e) {
      emit(state.failureConnectDevice(e.toString()));
      idleInstance();
    }
  }

  Future<void> connectDevice(ScanResult discoverDevice) async {
    try {
      final device = discoverDevice.device;
      if (device.isConnected) {
        await device.disconnect();
      }
      await device.connect(autoConnect: false);
      FlutterBluePlus.stopScan();
      emit(
        state.copyWith(
          connectedDevice: device,
          connectedDeviceName: device.advName,
        ),
      );
      setLocaleDevice(
        deviceName: device.advName,
        deviceAddress: device.remoteId.toString(),
      );
      _listenConnectedDeviceState();

      // 🚀 BLE Communication'ı başlat
      await _initializeCommunication(device);
    } catch (e) {
      emit(state.failureConnectDevice(e.toString()));
    }
  }

  Future<void> disconnectDevice() async {
    try {
      final device = state.connectedDevice;
      if (device?.isConnected == true) {
        await device?.disconnect();
      }
      _connectedDeviceStateSubscription?.cancel();

      // 🚀 BLE Communication'ı temizle
      await _disposeCommunication();

      emit(state.copyWith(connectedDevice: null, connectedDeviceName: null));
    } catch (e) {
      emit(state.failureDisconnectDevice(e.toString()));
    }
  }

  /// BLE Communication'ı başlatır
  Future<void> _initializeCommunication(BluetoothDevice device) async {
    try {
      debugPrint("[BLE] Starting communication initialization...");
      final communicationCubit = sl<AppBluetoothCommunicationCubit>();
      await communicationCubit.initializeCommunication(device);
      debugPrint("[BLE] Communication initialization completed");
    } catch (e) {
      debugPrint("[BLE] Communication initialization failed: $e");
    }
  }

  /// BLE Communication'ı temizler
  Future<void> _disposeCommunication() async {
    try {
      debugPrint("[BLE] Disposing communication...");
      final communicationCubit = sl<AppBluetoothCommunicationCubit>();
      await communicationCubit.disposeCommunication();
      debugPrint("[BLE] Communication disposed");
    } catch (e) {
      debugPrint("[BLE] Communication dispose failed: $e");
    }
  }

  clearScanResults() {
    emit(state.copyWith(discoveredScanResults: []));
  }

  void listenBleLogs() {
    FlutterBluePlus.logs.listen((String log) {
      debugPrint("[BLE LOG] $log");
    });
  }

  void loadingInstance() {
    emit(state.copyWith(status: UIStateStatus.loading));
  }

  void idleInstance() {
    emit(state.copyWith(status: UIStateStatus.idle));
  }

  void dispose() {
    _adapterStateStateSubscription?.cancel();
    _scanResultsSubscription?.cancel();
    _listenScanStateSubscription?.cancel();
    super.close();
  }

  void _logPrintConfig() {
    if (AppBleConfigs.logOn) {
      FlutterBluePlus.setLogLevel(AppBleConfigs.logLevel, color: true);
      listenBleLogs();
    }
  }

  bool get isScanningBle {
    return FlutterBluePlus.isScanningNow == true;
  }
}
