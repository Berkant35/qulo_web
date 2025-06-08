import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:thy_lifevest_app/core/constant/app_ble_constants.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/state/app_bluetooth_communication_state.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/cubit/reader_cubit.dart';

/// BLE cihazı ile communication için characteristic discovery,
/// notification management ve data exchange işlemlerini yönetir
class AppBluetoothCommunicationCubit
    extends Cubit<AppBluetoothCommunicationState> {
  AppBluetoothCommunicationCubit()
    : super(const AppBluetoothCommunicationState());

  /// Connected device'tan sonra çağrılır. Tüm service ve characteristic'leri discover eder
  Future<void> initializeCommunication(BluetoothDevice device) async {
    try {
      loadingInstance();

      emit(state.copyWith(connectedDevice: device));
      debugPrint(
        "[BLE COMM] Starting communication initialization for device: ${device.advName}",
      );

      // Services'leri discover et
      await _discoverServices(device);

      // Reader-specific characteristic'leri initialize et
      await _initializeReaderCharacteristics();

      // Notification'ları enable et
      await _enableNotifications();

      // Initialize tamamlandı
      emit(
        state.copyWith(
          isInitialized: true,
          isReaderReady: state.hasReaderCharacteristics,
        ),
      );

      idleInstance();
      debugPrint(
        "[BLE COMM] Communication initialization completed successfully",
      );
    } catch (e) {
      emit(
        state.setFailure(
          AppBleConstants.errorCodeDiscoveryFailedCode,
          AppStrings.error,
          'Communication initialization failed: $e',
        ),
      );
      debugPrint("[BLE COMM] Communication initialization failed: $e");
    }
  }

  /// Tüm service'leri discover eder ve state'e kaydeder
  Future<void> _discoverServices(BluetoothDevice device) async {
    debugPrint("[BLE COMM] Discovering services...");

    final services = await device.discoverServices();
    final Map<String, BluetoothCharacteristic> characteristics = {};

    for (final service in services) {
      debugPrint("[BLE COMM] Found service: ${service.uuid}");

      for (final characteristic in service.characteristics) {
        final uuid = characteristic.uuid.toString().toLowerCase();
        characteristics[uuid] = characteristic;
        debugPrint(
          "[BLE COMM] Found characteristic: $uuid - Properties: ${characteristic.properties}",
        );
      }
    }

    emit(
      state.copyWith(
        discoveredServices: services,
        availableCharacteristics: characteristics,
      ),
    );

    debugPrint(
      "[BLE COMM] Service discovery completed. Found ${services.length} services, ${characteristics.length} characteristics",
    );
  }

  /// Reader-specific characteristic'leri initialize eder
  Future<void> _initializeReaderCharacteristics() async {
    debugPrint("[BLE COMM] Initializing reader characteristics...");

    final chars = state.availableCharacteristics;

    final readerData = chars[AppBleConstants.readerDataCharUuid];
    final readerControl = chars[AppBleConstants.readerControlCharUuid];
    final readerStatus = chars[AppBleConstants.readerStatusCharUuid];
    final readerConfig = chars[AppBleConstants.readerConfigCharUuid];

    emit(
      state.copyWith(
        readerDataCharacteristic: readerData,
        readerControlCharacteristic: readerControl,
        readerStatusCharacteristic: readerStatus,
        readerConfigCharacteristic: readerConfig,
      ),
    );

    if (readerData != null) {
      debugPrint("[BLE COMM] Reader Data characteristic found");
    }
    if (readerControl != null) {
      debugPrint("[BLE COMM] Reader Control characteristic found");
    }
    if (readerStatus != null) {
      debugPrint("[BLE COMM] Reader Status characteristic found");
    }
    if (readerConfig != null) {
      debugPrint("[BLE COMM] Reader Config characteristic found");
    }
  }

  /// Mevcut characteristic'ler için notification'ları enable eder
  Future<void> _enableNotifications() async {
    debugPrint("[BLE COMM] Enabling notifications...");

    final Map<String, bool> notificationStates = {};
    final Map<String, StreamSubscription> notificationStreams = {};

    // Reader Data characteristic için notification enable et
    if (state.readerDataCharacteristic != null) {
      await _enableNotificationForCharacteristic(
        state.readerDataCharacteristic!,
        notificationStates,
        notificationStreams,
      );
    }

    // Reader Status characteristic için notification enable et
    if (state.readerStatusCharacteristic != null) {
      await _enableNotificationForCharacteristic(
        state.readerStatusCharacteristic!,
        notificationStates,
        notificationStreams,
      );
    }

    emit(
      state.copyWith(
        notificationStates: notificationStates,
        notificationStreams: notificationStreams,
      ),
    );

    debugPrint(
      "[BLE COMM] Notifications enabled for ${notificationStates.length} characteristics",
    );
  }

  /// Tek bir characteristic için notification enable eder
  Future<void> _enableNotificationForCharacteristic(
    BluetoothCharacteristic characteristic,
    Map<String, bool> notificationStates,
    Map<String, StreamSubscription> notificationStreams,
  ) async {
    try {
      final uuid = characteristic.uuid.toString().toLowerCase();

      if (characteristic.properties.notify ||
          characteristic.properties.indicate) {
        await characteristic.setNotifyValue(true);

        final stream = characteristic.onValueReceived.listen((data) {
          _handleNotificationData(uuid, data);
        });

        notificationStates[uuid] = true;
        notificationStreams[uuid] = stream;

        debugPrint("[BLE COMM] Notification enabled for characteristic: $uuid");
      }
    } catch (e) {
      debugPrint(
        "[BLE COMM] Failed to enable notification for ${characteristic.uuid}: $e",
      );
    }
  }

  /// Notification'dan gelen data'yı handle eder
  void _handleNotificationData(String characteristicUuid, List<int> data) {
   

    final Map<String, List<int>> lastReceivedData = Map.from(
      state.lastReceivedData,
    );
    lastReceivedData[characteristicUuid] = data;

    emit(state.copyWith(lastReceivedData: lastReceivedData));

    // Reader-specific data handling
    if (characteristicUuid == AppBleConstants.readerDataCharUuid) {
      _handleReaderData(data);
    } else if (characteristicUuid == AppBleConstants.readerStatusCharUuid) {
      _handleReaderStatus(data);
    }
  }

  /// Reader'dan gelen data'yı işler
  void _handleReaderData(List<int> data) {
    // Reader cubit'e data'yı forward et
    try {
      final readerCubit = sl<ReaderCubit>();
      readerCubit.handleReceivedData(Uint8List.fromList(data));
    } catch (e) {
      debugPrint("[BLE COMM] Failed to forward data to reader: $e");
    }
  }

  /// Reader status data'sını işler
  void _handleReaderStatus(List<int> data) {
    final hexData =
        data
            .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
            .join()
            .toUpperCase();
    debugPrint("[BLE COMM] Processing reader status: $data (HEX: $hexData)");
    // TODO: Reader status processing
    // Battery level, connection quality, error states vs.
  }

  /// Characteristic'e data yazar (enhanced version with chunking)
  Future<bool> writeToCharacteristic(
    String characteristicUuid,
    List<int> data,
  ) async {
    try {
      final characteristic =
          state.availableCharacteristics[characteristicUuid.toLowerCase()];

      final hexData =
          data
              .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
              .join()
              .toUpperCase();
      debugPrint(
        "[BLE COMM] Writing to characteristic: $characteristicUuid with data: $hexData (${data.length} bytes)",
      );

      if (characteristic == null) {
        debugPrint("[BLE COMM] Characteristic not found: $characteristicUuid");
        return false;
      }

      if (!characteristic.properties.write &&
          !characteristic.properties.writeWithoutResponse) {
        debugPrint(
          "[BLE COMM] Characteristic not writable: $characteristicUuid",
        );
        return false;
      }

      // Veriyi 20 byte'lık parçalara böl (BLE MTU limitation)
      const int maxChunkSize = 20;

      if (data.length <= maxChunkSize) {
        // Küçük data için direkt gönder
        if (characteristic.properties.writeWithoutResponse) {
          await characteristic.write(data, withoutResponse: true);
        } else {
          await characteristic.write(data);
        }
        debugPrint(
          "[BLE COMM] Small data written directly to $characteristicUuid",
        );
      } else {
        // Büyük data için chunk'lara böl
        debugPrint(
          "[BLE COMM] Large data detected (${data.length} bytes), splitting into chunks",
        );

        for (int i = 0; i < data.length; i += maxChunkSize) {
          final int end =
              (i + maxChunkSize < data.length) ? i + maxChunkSize : data.length;
          final List<int> chunk = data.sublist(i, end);

          final chunkHex =
              chunk
                  .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
                  .join()
                  .toUpperCase();
          debugPrint(
            "[BLE COMM] Writing chunk ${(i / maxChunkSize).floor() + 1}/${(data.length / maxChunkSize).ceil()}: $chunkHex (${chunk.length} bytes)",
          );

          if (characteristic.properties.writeWithoutResponse) {
            await characteristic.write(chunk, withoutResponse: true);
          } else {
            await characteristic.write(chunk);
          }

          // İşletim sistemine ve Bluetooth stack'e zaman tanı
          if (end < data.length) {
            await Future.delayed(const Duration(milliseconds: 25));
          }
        }
        debugPrint(
          "[BLE COMM] All chunks written successfully to $characteristicUuid",
        );
      }

      return true;
    } catch (e) {
      emit(
        state.setFailure(
          AppBleConstants.errorCodeWriteFailedCode,
          AppStrings.error,
          'Failed to write to characteristic $characteristicUuid: $e',
        ),
      );
      debugPrint("[BLE COMM] Write failed for $characteristicUuid: $e");
      return false;
    }
  }

  /// Characteristic'den data okur
  Future<List<int>?> readFromCharacteristic(String characteristicUuid) async {
    try {
      final characteristic =
          state.availableCharacteristics[characteristicUuid.toLowerCase()];

      if (characteristic == null) {
        debugPrint("[BLE COMM] Characteristic not found: $characteristicUuid");
        return null;
      }

      if (!characteristic.properties.read) {
        debugPrint(
          "[BLE COMM] Characteristic not readable: $characteristicUuid",
        );
        return null;
      }

      final data = await characteristic.read();
      debugPrint("[BLE COMM] Data read from $characteristicUuid: $data");
      return data;
    } catch (e) {
      emit(
        state.setFailure(
          AppBleConstants.errorCodeReadFailedCode,
          AppStrings.error,
          'Failed to read from characteristic $characteristicUuid: $e',
        ),
      );
      debugPrint("[BLE COMM] Read failed for $characteristicUuid: $e");
      return null;
    }
  }

  /// Reader'a command gönderir
  Future<bool> sendReaderCommand(List<int> command) async {
    if (state.readerControlCharacteristic == null) {
      debugPrint("[BLE COMM] Reader control characteristic not available");
      return false;
    }

    return await writeToCharacteristic(
      AppBleConstants.readerControlCharUuid,
      command,
    );
  }

  /// Reader config'ini günceller
  Future<bool> updateReaderConfig(List<int> config) async {
    if (state.readerConfigCharacteristic == null) {
      debugPrint("[BLE COMM] Reader config characteristic not available");
      return false;
    }

    return await writeToCharacteristic(
      AppBleConstants.readerConfigCharUuid,
      config,
    );
  }

  /// Communication'ı kapatır ve cleanup yapar
  Future<void> disposeCommunication() async {
    debugPrint("[BLE COMM] Disposing communication...");

    // Notification stream'leri cancel et
    for (final stream in state.notificationStreams.values) {
      await stream.cancel();
    }

    // Notification'ları disable et
    for (final entry in state.notificationStates.entries) {
      if (entry.value) {
        final characteristic = state.availableCharacteristics[entry.key];
        if (characteristic != null) {
          try {
            await characteristic.setNotifyValue(false);
          } catch (e) {
            debugPrint(
              "[BLE COMM] Failed to disable notification for ${entry.key}: $e",
            );
          }
        }
      }
    }

    // State'i temizle
    emit(const AppBluetoothCommunicationState());
    debugPrint("[BLE COMM] Communication disposed successfully");
  }

  void loadingInstance() {
    emit(state.copyWith(status: UIStateStatus.loading));
  }

  void idleInstance() {
    emit(state.copyWith(status: UIStateStatus.idle));
  }

  void clearFailure() {
    emit(state.clearFailure());
  }

  @override
  Future<void> close() {
    disposeCommunication();
    return super.close();
  }
}
