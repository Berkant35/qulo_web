import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';

part 'app_bluetooth_communication_state.freezed.dart';

/// BLE cihazı ile communication yapabilmek için gerekli characteristic'lerin
/// discover edilmesi ve initialize edilmesi durumunu yönetir
@freezed
abstract class AppBluetoothCommunicationState
    with _$AppBluetoothCommunicationState {
  const factory AppBluetoothCommunicationState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    Failure? failure,

    // Services & Characteristics Discovery
    @Default([]) List<BluetoothService> discoveredServices,
    @Default({}) Map<String, BluetoothCharacteristic> availableCharacteristics,

    // Notification Management
    @Default({}) Map<String, bool> notificationStates,
    @Default({}) Map<String, StreamSubscription> notificationStreams,

    // Reader Specific Characteristics (THY Lifevest)
    BluetoothCharacteristic? readerDataCharacteristic,
    BluetoothCharacteristic? readerControlCharacteristic,
    BluetoothCharacteristic? readerStatusCharacteristic,
    BluetoothCharacteristic? readerConfigCharacteristic,

    // Communication Data
    @Default({}) Map<String, List<int>> lastReceivedData,
    @Default(false) bool isInitialized,
    @Default(false) bool isReaderReady,

    // Connection Status
    BluetoothDevice? connectedDevice,
  }) = _AppBluetoothCommunicationState;

  const AppBluetoothCommunicationState._();

  /// Characteristic discovery tamamlandı mı?
  bool get isDiscoveryComplete => discoveredServices.isNotEmpty;

  /// Notification'lar aktif mi?
  bool get hasActiveNotifications =>
      notificationStates.values.any((isActive) => isActive);

  /// Reader için gerekli characteristic'ler mevcut mu?
  bool get hasReaderCharacteristics =>
      readerDataCharacteristic != null ||
      readerControlCharacteristic != null ||
      readerStatusCharacteristic != null;

  @useResult
  AppBluetoothCommunicationState setFailure(
    int code,
    String errorTitle,
    String errorText,
  ) {
    return copyWith(
      failure: Failure(
        code: code,
        errorTitle: errorTitle,
        errorText: errorText,
      ),
      status: UIStateStatus.error,
    );
  }

  @useResult
  AppBluetoothCommunicationState clearFailure() {
    return copyWith(failure: null, status: UIStateStatus.idle);
  }
}
