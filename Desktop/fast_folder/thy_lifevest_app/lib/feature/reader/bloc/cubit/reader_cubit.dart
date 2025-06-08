import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_ble_constants.dart';
import 'package:thy_lifevest_app/core/constant/app_reader_constants.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/list_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_communication_cubit.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/state/reader_state.dart';

/// RFID Reader işlemlerini yöneten cubit
/// BLE communication için AppBluetoothCommunicationCubit'i kullanır
class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit() : super(const ReaderState());

  // Dependencies
  AppBluetoothCommunicationCubit get _communicationCubit => sl<AppBluetoothCommunicationCubit>();

  // Timers
  Timer? _inventoryTimer;
  Timer? _buttonTimer;

  // Response handling
  final Map<int, Completer<Uint8List?>> _pendingCommands = {};
  StreamSubscription? _dataSubscription;
  final List<int> _dataBuffer = [];

  // Error codes
  static const String _errorCodeInventoryFailed = 'READER_INVENTORY_FAILED';
  static const String _errorCodeCommandFailed = 'READER_COMMAND_FAILED';
  static const String _errorCodeReadFailed = 'READER_READ_FAILED';

  /// Reader'ı initialize eder ve bağlantı durumunu dinler
  Future<void> initialize() async {
    try {
      debugPrint("[READER] Initializing reader...");

      // Communication state'ini dinle
      _communicationCubit.stream.listen((commState) {
        final isConnected = commState.isInitialized && commState.isReaderReady;

        if (state.isConnected != isConnected) {
          emit(
            state.copyWith(
              isConnected: isConnected,
              connectedDeviceAddress: commState.connectedDevice?.remoteId.toString(),
            ),
          );

          if (isConnected) {
            _onReaderConnected();
          } else {
            _onReaderDisconnected();
          }
        }
      });

      debugPrint("[READER] Reader initialized successfully");
    } catch (e) {
      debugPrint("[READER] Reader initialization failed: $e");
    }
  }

  /// Reader bağlandığında çağrılır
  Future<void> _onReaderConnected() async {
    debugPrint("[READER] Reader connected");

    // Buzzer'ı kapat
    await setBuzzer(false);

    // Default power ayarlarını uygula
    await setPower(state.settings.readPower, state.settings.writePower);

    // Inventory filter'ını temizle
    await clearInventoryFilter();

    // Inventory mode'unu al
    await getInventoryMode();

    // Work state'e göre işlem yap
    switch (state.workState) {
      case ReaderWorkState.scanAndRead:
        await startInventory();
        break;
      case ReaderWorkState.find:
        if (state.findTargetEpc != null) {
          await startFindMode(state.findTargetEpc!);
        }
        break;
      case ReaderWorkState.idle:
        break;
    }
  }

  /// Reader bağlantısı kesildiğinde çağrılır
  void _onReaderDisconnected() {
    debugPrint("[READER] Reader disconnected");
    _stopInventoryTimer();
    debugPrint("[READER] 🛑 Timer stopped");
    emit(state.copyWith(isInventoryRunning: false, waitingTagBuffer: false));
  }

  /// BLE communication'dan gelen data'yı handle eder
  void handleReceivedData(Uint8List data) {
    try {
      final hexData = _bytesToHex(data);

      debugPrint("[READER] Received data: $hexData");

      // Buffer'a ekle
      _dataBuffer.addAll(data);

      // Complete frame'leri process et
      _processDataBuffer();
    } catch (e) {
      debugPrint("[READER] Failed to handle received data: $e");
    }
  }

  /// Data buffer'ını process eder ve complete frame'leri tespit eder
  void _processDataBuffer() {
    while (_dataBuffer.length >= 8) {
      // Minimum frame size
      // Frame başlangıcını ara
      int frameStart = -1;
      for (int i = 0; i <= _dataBuffer.length - 2; i++) {
        if (_dataBuffer[i] == 0xA5 && _dataBuffer[i + 1] == 0x5A) {
          frameStart = i;
          break;
        }
      }

      if (frameStart == -1) {
        // Frame başlangıcı bulunamadı, buffer'ı temizle
        _dataBuffer.clear();
        break;
      }

      // Frame başlangıcından önceki verileri at
      if (frameStart > 0) {
        _dataBuffer.removeRange(0, frameStart);
      }

      // Frame length'i kontrol et
      if (_dataBuffer.length < 4) break;

      final frameLen = (_dataBuffer[2] << 8) | _dataBuffer[3];
      if (_dataBuffer.length < frameLen) break; // Tam frame gelmemiş

      // Frame'i çıkar
      final frame = Uint8List.fromList(_dataBuffer.take(frameLen).toList());
      _dataBuffer.removeRange(0, frameLen);

      // Frame'i process et
      _processFrame(frame);
    }
  }

  /// Tek bir frame'i process eder
  void _processFrame(Uint8List frame) {
    try {
      if (frame.length < 8) return;

      final command = frame[4];
      final hexFrame = _bytesToHex(frame);
      debugPrint(
        "[READER] Processing frame - Command: 0x${command.toRadixString(16).padLeft(2, '0').toUpperCase()}, Data: $hexFrame",
      );

      // Command'e göre handling
      switch (command) {
        case 0xE1: // Tag buffer response (0xE0 + 1)
          _handleTagBufferResponse(frame);
          break;
        case 0x83: // Inventory start response (0x82 + 1)
          _handleInventoryStartResponse(frame);
          break;
        case 0x8D: // Inventory stop response (0x8C + 1)
          _handleInventoryStopResponse(frame);
          break;
        case 0x6F: // Filter respose (0x6E + 1)
          _handleGenericResponse(frame);
          break;
        case 0x73: // Inventory mode response (0x72 + 1)
          _handleInventoryModeResponse(frame);
          break;
        case 0x11: // Power set response (0x10 + 1)
        case 0x13: // Power get response (0x12 + 1)
        case 0xE5: // Buzzer response (0xE4 + 1)
        case 0x85: // Read tag response (0x84 + 1)
          _handleGenericCommandResponse(command, frame);
          break;
        default:
          debugPrint("[READER] Unknown command response: 0x${command.toRadixString(16).padLeft(2, '0').toUpperCase()}");
          _handleGenericCommandResponse(command, frame);
          break;
      }
    } catch (e) {
      debugPrint("[READER] Failed to process frame: $e");
    }
  }

  /// Tag buffer response'unu handle eder
  void _handleTagBufferResponse(Uint8List frame) {
    try {
      if (frame.length < 8) {
        debugPrint("[READER] Tag buffer frame too short: ${frame.length}");
        return;
      }

      final hexFrame = _bytesToHex(frame);
      debugPrint("[READER] Processing tag buffer frame: $hexFrame");

      // Frame: A5 5A [LEN_H] [LEN_L] [CMD] [DATA...] [BCC] 0D 0A
      // Response data başlangıcı: frame[5] (CMD'den sonra)
      final responseData = frame.sublist(5, frame.length - 3); // BCC ve footer'ı çıkar

      debugPrint("[READER] Tag buffer response data: ${_bytesToHex(responseData)}");

      if (responseData.length >= 3) {
        final remainingTags = (responseData[0] << 8) | responseData[1];
        final reportedTagCount = responseData[2];

        debugPrint("[READER] Tag buffer: $remainingTags remaining, $reportedTagCount reported");

        emit(state.copyWith(remainingTagsInBuffer: remainingTags, waitingTagBuffer: false));

        if (reportedTagCount > 0 && responseData.length > 3) {
          // Tag data'sı var
          final tagData = responseData.sublist(3); // İlk 3 byte'ı atla
          _parseTagDataFromBuffer(tagData, reportedTagCount);
        } else {
          debugPrint("[READER] No tag data in buffer response");
        }
      } else {
        debugPrint("[READER] Invalid tag buffer response length: ${responseData.length}");
      }
    } catch (e) {
      debugPrint("[READER] Failed to handle tag buffer response: $e");
    }
  }

  /// Inventory start response'unu handle eder
  void _handleInventoryStartResponse(Uint8List frame) {
    debugPrint("[READER] Inventory start response received");
    // Success response handling
  }

  /// Inventory stop response'unu handle eder
  void _handleInventoryStopResponse(Uint8List frame) {
    debugPrint("[READER] Inventory stop response received");
    _stopInventoryTimer();
    emit(state.copyWith(isInventoryRunning: false, waitingTagBuffer: false));
  }

  /// Generic response'ları handle eder (error codes vs.)
  void _handleGenericResponse(Uint8List frame) {
    try {
      if (frame.length < 8) return;

      final responseData = frame.sublist(5, frame.length - 3);
      final command = frame[4];

      if (responseData.isNotEmpty) {
        final statusCode = responseData[0];
        debugPrint(
          "[READER] Generic response 0x${command.toRadixString(16).padLeft(2, '0').toUpperCase()}: status=${statusCode}",
        );

        if (statusCode != 0x01) {
          debugPrint("[READER] Command failed with status: ${statusCode}");
        }
      }

      // Pending command'ı tamamla
      _handleGenericCommandResponse(command, frame);
    } catch (e) {
      debugPrint("[READER] Failed to handle generic response: $e");
    }
  }

  /// Inventory mode response'unu handle eder
  void _handleInventoryModeResponse(Uint8List frame) {
    try {
      final responseData = frame.sublist(5, frame.length - 3);

      if (responseData.length >= 4 && responseData[0] == 1) {
        final bankValue = responseData[1];
        final userOffset = responseData[2];
        final userLength = responseData[3];

        if (bankValue < ReaderInventoryBank.values.length) {
          final bank = ReaderInventoryBank.values[bankValue];

          final inventoryMode = ReaderInventoryMode(bank: bank, userOffset: userOffset, userLength: userLength);

          emit(state.copyWith(settings: state.settings.copyWith(inventoryMode: inventoryMode)));

          debugPrint("[READER] Inventory mode updated: $bank, offset: $userOffset, length: $userLength");
        }
      }

      // Pending command'ı tamamla
      _handleGenericCommandResponse(0x73, frame);
    } catch (e) {
      debugPrint("[READER] Failed to handle inventory mode response: $e");
    }
  }

  /// Generic command response'unu handle eder
  void _handleGenericCommandResponse(int command, Uint8List frame) {
    // Pending command'ı tamamla
    if (_pendingCommands.containsKey(command)) {
      final completer = _pendingCommands.remove(command);
      final responseData = frame.sublist(5, frame.length - 3);
      completer?.complete(responseData);
    }
  }

  // ===========================================
  // INVENTORY OPERATIONS
  // ===========================================

  /// Inventory işlemini başlatır
  Future<void> startInventory({int maxEmptyCount = 5}) async {
    try {
      debugPrint("[READER] Starting inventory...");

      emit(
        state.copyWith(
          isInventoryRunning: true,
          workState: ReaderWorkState.scanAndRead,
          discoveredTags: [], // Yeni inventory için temizle
        ),
      );
      // Inventory start komutu gönder
      final command = _buildCommand(0x82, null);
      _sendCommand(command);

      // Inventory loop'unu başlat
      _startInventoryLoop(maxEmptyCount);

      debugPrint("[READER] Inventory started successfully");
    } catch (e) {
      emit(
        state.setFailure(
          AppReaderConstants.startInventoryFailedCode,
          AppStrings.error,
          'Failed to start inventory: $e',
        ),
      );
    }
  }

  /// Inventory işlemini durdurur
  Future<void> stopInventory({int sendCommandCount = 2}) async {
    try {
      debugPrint("[READER] 🛑 STOPPING INVENTORY - Current state: ${state.isInventoryRunning}");

      final command = _buildCommand(0x8C, null);

      await _sendCommandAndGetResponse(command, timeout: const Duration(seconds: 1));
      
      if (state.isInventoryRunning.isEquals(true)){
        return await stopInventory();
      }
    } catch (e) {
      debugPrint("[READER] Failed to stop inventory: $e");
      // Error durumunda da state'i güncelle
      emit(state.copyWith(isInventoryRunning: false, waitingTagBuffer: false));
    }
  }

  /// Find mode'unu başlatır
  Future<void> startFindMode(String targetEpc) async {
    try {
      // Find filter'ını ayarla
      await setInventoryFilter(bank: ReaderMemoryBank.epc, address: 0x20, dataHex: targetEpc);

      emit(state.copyWith(isFindMode: true, findTargetEpc: targetEpc, workState: ReaderWorkState.find));

      // Inventory'yi yüksek tekrarla başlat
      await startInventory(maxEmptyCount: 20);
    } catch (e) {
      emit(state.setFailure(AppReaderConstants.startFindFailedCode, AppStrings.error, 'Failed to start find mode: $e'));
    }
  }

  /// Find mode'unu durdurur
  Future<void> stopFindMode() async {
    await clearInventoryFilter();
    emit(state.copyWith(isFindMode: false, findTargetEpc: null, workState: ReaderWorkState.idle));
    await stopInventory();
  }

  /// Inventory loop'unu başlatır
  void _startInventoryLoop(int maxEmptyCount) {
    int emptyCount = 0;

    _inventoryTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) async {
      // State kontrolü - inventory durdurulduysa timer'ı iptal et ve çık
      if (!state.isInventoryRunning) {
        debugPrint("[READER] 🛑 Loop detected stop state - canceling timer");
        debugPrint("[READER] Inventory loop stopped - isInventoryRunning: false");
        timer.cancel();
        _inventoryTimer?.cancel();
        _inventoryTimer = null;
        return;
      }

      // Empty count limitine ulaştıysak yeniden başlat
      if (emptyCount > maxEmptyCount) {
        final command = _buildCommand(0x82, null);
        _sendCommand(command);
        emptyCount = 0;
        return;
      }

      // Buffer bekleniyorsa veya find mode'daysa devam et
      if (!state.waitingTagBuffer || state.isFindMode) {
        emit(state.copyWith(waitingTagBuffer: true));

        // Tag buffer'ını oku
        if (!state.isInventoryRunning) {
          _inventoryTimer?.cancel();
          _inventoryTimer = null;
          return;
        }
        final command = _buildCommand(0xE0, null);

        final data = await _sendCommandAndGetResponse(command);
        if (!state.isInventoryRunning) {
          _inventoryTimer?.cancel();
          _inventoryTimer = null;
          return;
        }

        emptyCount++;

        if (data == null || data.length < 3) {
          emit(state.copyWith(waitingTagBuffer: false));
          return;
        }

        final remainingTags = (data[0] << 8) | data[1];
        final reportedTagCount = data[2];

        emit(state.copyWith(remainingTagsInBuffer: remainingTags, waitingTagBuffer: false));

        // Tag'leri parse et
        _parseTagDataFromBuffer(data, reportedTagCount);

        if (reportedTagCount > 0) {
          emptyCount = 0;
        }
      }
    });
  }

  /// Tag data'sını buffer'dan parse eder
  void _parseTagDataFromBuffer(Uint8List data, int reportedTagCount) {
    try {
      int mainCursor = 0; // Buffer başından başla
      final List<ReaderTag> newTags = [];

      for (int i = 0; i < reportedTagCount; i++) {
        if (mainCursor >= data.length) {
          break;
        }

        final rawLen = data[mainCursor];
        mainCursor++;

        if (rawLen == 0 || mainCursor + rawLen > data.length) {
          break;
        }

        final rawTag = data.sublist(mainCursor, mainCursor + rawLen);
        mainCursor += rawLen;

        final tag = _parseRawTag(rawTag);
        if (tag != null) {
          newTags.add(tag);
          debugPrint("[READER] ✅ Parsed tag ${i + 1}: EPC=${tag.epc}, RSSI=${tag.rssi}");
        } else {
          debugPrint("[READER] ❌ Failed to parse tag ${i + 1}");
        }
      }

      if (newTags.isNotEmpty) {
        final updatedTags = [...state.discoveredTags, ...newTags];
        emit(state.copyWith(discoveredTags: updatedTags));

        debugPrint("[READER] 🏷️ Successfully parsed ${newTags.length} new tags. Total: ${updatedTags.length}");

        // Find mode için kontrol
        if (state.isFindMode && state.findTargetEpc != null) {
          final foundTarget = newTags.any((tag) => tag.epc == state.findTargetEpc);
          if (foundTarget) {
            debugPrint("[READER] 🎯 Find mode: Target EPC found!");
            _playFindBuzzer();
          }
        }
      } else {
        debugPrint("[READER] ⚠️ No valid tags parsed from buffer");
      }
    } catch (e) {
      debugPrint("[READER] ❌ Failed to parse tag data from buffer: $e");
    }
  }

  /// Find mode için buzzer çalar
  void _playFindBuzzer() async {
    try {
      await setBuzzer(true);
      await Future.delayed(const Duration(milliseconds: 200));
      await setBuzzer(false);
    } catch (e) {
      debugPrint("[READER] Failed to play find buzzer: $e");
    }
  }

  /// Ham tag data'sını ReaderTag'e dönüştürür
  ReaderTag? _parseRawTag(Uint8List rawTag) {
    try {
      if (rawTag.length < 4) {
        debugPrint("[READER] Raw tag too short: ${rawTag.length} bytes");
        return null;
      }

      final hexRawTag = _bytesToHex(rawTag);

      // PC word (Protocol Control) - first 2 bytes
      final pc = _bytesToHex(rawTag.sublist(0, 2));
      final epcLen = rawTag[0] >> 3; // EPC length in words

      String? epc;
      if (2 + epcLen * 2 <= rawTag.length) {
        epc = _bytesToHex(rawTag.sublist(2, 2 + epcLen * 2));
      }
      // RSSI usually at the end (last 2 bytes)
      double? rssi;
      if (rawTag.length >= 2) {
        final rssiBytes = rawTag.sublist(rawTag.length - 2);
        final rssiRaw = (rssiBytes[0] << 8) | rssiBytes[1];
        rssi = (rssiRaw - 0x10000) / 10.0;
      }

      if (epc != null && epc.isNotEmpty) {
        final tag = ReaderTag(pc: pc, epcLen: epcLen, epc: epc, rssi: rssi, readTime: DateTime.now());

        return tag;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("[READER] ❌ Failed to parse raw tag: $e");
      return null;
    }
  }

  void _stopInventoryTimer() {
    debugPrint("[READER] Stopping inventory timer...");
    _inventoryTimer?.cancel();
    _inventoryTimer = null;
    debugPrint("[READER] Inventory timer stopped");
  }

  // ===========================================
  // READER CONFIGURATION
  // ===========================================

  /// Reader power ayarlarını yapar
  Future<bool> setPower(int readPower, int writePower, {bool save = true}) async {
    try {
      final data = [
        save ? 0x02 : 0x00,
        0x01,
        (readPower >> 8) & 0xFF,
        readPower & 0xFF,
        (writePower >> 8) & 0xFF,
        writePower & 0xFF,
      ];

      final command = _buildCommand(0x10, data);
      final response = await _sendCommandAndGetResponse(command);

      final success = response != null && response.isNotEmpty && response[0] == 0x01;

      if (success) {
        emit(state.copyWith(settings: state.settings.copyWith(readPower: readPower, writePower: writePower)));
        debugPrint("[READER] Power set successfully: read=$readPower, write=$writePower");
      }

      return success;
    } catch (e) {
      debugPrint("[READER] Failed to set power: $e");
      return false;
    }
  }

  /// Reader power ayarlarını getirir
  Future<Map<String, int?>?> getPower() async {
    try {
      final command = _buildCommand(0x12, null);
      final response = await _sendCommandAndGetResponse(command);

      if (response == null || response.length < 6) {
        return {"read_power": null, "write_power": null};
      }

      final firstWord = (response[0] << 8) | response[1];
      if (firstWord != 0x0000) {
        return {"read_power": null, "write_power": null};
      }

      final readPower = (response[2] << 8) | response[3];
      final writePower = (response[4] << 8) | response[5];

      return {"read_power": readPower, "write_power": writePower};
    } catch (e) {
      debugPrint("[READER] Failed to get power: $e");
      return null;
    }
  }

  /// Buzzer ayarını yapar
  Future<bool> setBuzzer(bool enabled) async {
    try {
      final data = [0x03, enabled ? 0x01 : 0x00];
      final command = _buildCommand(0xE4, data);
      final response = await _sendCommandAndGetResponse(command);

      final success = response != null && response.isNotEmpty && response[0] == 0x01;

      if (success) {
        emit(state.copyWith(settings: state.settings.copyWith(buzzerEnabled: enabled)));
        debugPrint("[READER] Buzzer set successfully: $enabled");
      }

      return success;
    } catch (e) {
      debugPrint("[READER] Failed to set buzzer: $e");
      return false;
    }
  }

  /// Inventory mode'unu getirir
  Future<void> getInventoryMode() async {
    try {
      final command = _buildCommand(0x72, null);
      final response = await _sendCommandAndGetResponse(command);

      if (response != null && response.isNotEmpty && response[0] == 1) {
        final bank = ReaderInventoryBank.values[response[1]];
        final userOffset = response[2];
        final userLength = response[3];

        final inventoryMode = ReaderInventoryMode(bank: bank, userOffset: userOffset, userLength: userLength);

        emit(state.copyWith(settings: state.settings.copyWith(inventoryMode: inventoryMode)));

        debugPrint("[READER] Inventory mode: $bank, offset: $userOffset, length: $userLength");
      }
    } catch (e) {
      debugPrint("[READER] Failed to get inventory mode: $e");
    }
  }

  /// Inventory filter'ını ayarlar
  Future<bool> setInventoryFilter({
    required ReaderMemoryBank bank,
    required int address,
    required String dataHex,
  }) async {
    try {
      final List<int> dataList = [0x00];

      final filterBitLength = dataHex.isNotEmpty ? dataHex.length * 4 : 0;

      dataList.addAll([bank.value, address >> 8, address & 0xFF, filterBitLength >> 8, filterBitLength & 0xFF]);

      if (dataHex.isNotEmpty) {
        dataList.addAll(_hexStringToBytes(dataHex));
      }

      final command = _buildCommand(0x6E, dataList);
      final response = await _sendCommandAndGetResponse(command);

      final success = response != null && response.isNotEmpty && response[0] == 0x01;

      if (success) {
        debugPrint("[READER] Inventory filter set successfully");
      }

      return success;
    } catch (e) {
      debugPrint("[READER] Failed to set inventory filter: $e");
      return false;
    }
  }

  /// Inventory filter'ını temizler
  Future<bool> clearInventoryFilter() async {
    try {
      final dataList = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
      final command = _buildCommand(0x6E, dataList);
      final response = await _sendCommandAndGetResponse(command);

      final success = response != null && response.isNotEmpty && response[0] == 0x01;

      if (success) {
        debugPrint("[READER] Inventory filter cleared");
      }

      return success;
    } catch (e) {
      debugPrint("[READER] Failed to clear inventory filter: $e");
      return false;
    }
  }

  // ===========================================
  // TAG OPERATIONS
  // ===========================================

  /// Tag'den veri okur
  Future<Uint8List?> readTag({
    required ReaderMemoryBank bank,
    required int address,
    required int length,
    required ReaderMemoryBank filterBank,
    required int filterAddress,
    required String filterData,
    String accessPassword = "00000000",
  }) async {
    try {
      final List<int> dataList = [];

      final filterBitLength = filterData.isNotEmpty ? filterData.length * 4 : 0;

      // Access password
      dataList.addAll(_hexStringToBytes(accessPassword));

      // Filter
      dataList.addAll([
        filterBank.value,
        filterAddress >> 8,
        filterAddress & 0xFF,
        filterBitLength >> 8,
        filterBitLength & 0xFF,
      ]);

      if (filterData.isNotEmpty) {
        dataList.addAll(_hexStringToBytes(filterData));
      }

      // Bank to read
      dataList.addAll([bank.value, address >> 8, address & 0xFF, length >> 8, length & 0xFF]);

      final command = _buildCommand(0x84, dataList);
      final response = await _sendCommandAndGetResponse(command);

      if (response != null && response.isNotEmpty && response[0] == 0x01) {
        return response.sublist(4);
      }

      return null;
    } catch (e) {
      emit(state.setFailure(AppReaderConstants.readFailedCode, AppStrings.error, 'Failed to read tag: $e'));
      return null;
    }
  }

  /// Tag'in user memory'sini tamamen okur
  Future<Map<String, dynamic>?> readFullUserMemory(String epc) async {
    try {
      // İlk 4 kelimeyi oku
      final firstChunk = await readTag(
        bank: ReaderMemoryBank.user,
        address: 0,
        length: 4,
        filterBank: ReaderMemoryBank.epc,
        filterAddress: 32,
        filterData: epc,
      );

      if (firstChunk == null || firstChunk.length < 8) {
        debugPrint("[READER] Failed to read first user memory chunk");
        return null;
      }

      Uint8List fullData = Uint8List.fromList(firstChunk);

      // Toplam uzunluğu al
      final totalWords = (firstChunk[6] << 8) | firstChunk[7];

      if (totalWords <= 4) {
        return _bruteForceUserMemorySearch(_bytesToHex(fullData.sublist(0, totalWords * 2)));
      }

      // Kalan verileri oku
      int remainingWords = totalWords - 4;
      int readAddress = 4;

      while (remainingWords > 0) {
        final readLen = remainingWords > 32 ? 32 : remainingWords;
        final chunk = await readTag(
          bank: ReaderMemoryBank.user,
          address: readAddress,
          length: readLen,
          filterBank: ReaderMemoryBank.epc,
          filterAddress: 32,
          filterData: epc,
        );

        if (chunk == null) {
          debugPrint("[READER] Failed to read user memory chunk at address $readAddress");
          break;
        }

        fullData = Uint8List.fromList([...fullData, ...chunk]);
        remainingWords -= readLen;
        readAddress += readLen;
      }

      if (fullData.length < totalWords * 2) {
        return null;
      }

      return _bruteForceUserMemorySearch(_bytesToHex(fullData.sublist(0, totalWords * 2)));
    } catch (e) {
      debugPrint("[READER] Failed to read full user memory: $e");
      return null;
    }
  }

  // ===========================================
  // BUTTON EVENTS
  // ===========================================

  /// Button basma event'ini handle eder
  void handleButtonPressed() {
    final newClickCount = state.buttonClickCount + 1;
    emit(state.copyWith(buttonClickCount: newClickCount));

    if (newClickCount == 1) {
      _startButtonTimer();
    }
  }

  void _startButtonTimer() {
    _buttonTimer?.cancel();
    _buttonTimer = Timer(const Duration(milliseconds: 900), () {
      final clickCount = state.buttonClickCount;

      if (clickCount == 1) {
        _handleSingleClick();
      } else if (clickCount >= 2) {
        _handleDoubleClick();
      }

      emit(state.copyWith(buttonClickCount: 0));
    });
  }

  void _handleSingleClick() {
    debugPrint("[READER] Single click detected");
    // TODO: Single click action
  }

  void _handleDoubleClick() {
    debugPrint("[READER] Double click detected");
    emit(state.copyWith(lastButtonWasDoubleClick: true));
    // TODO: Double click action
  }

  // ===========================================
  // COMMAND MANAGEMENT
  // ===========================================

  /// Komut oluşturur
  Uint8List _buildCommand(int command, List<int>? data) {
    final header = [0xa5, 0x5a];
    final footer = [0x0d, 0x0a];

    final frameLen = 8 + (data?.length ?? 0);
    final List<int> buffer = [];

    buffer.addAll(header);
    buffer.addAll([frameLen >> 8, frameLen & 0xFF, command]);

    if (data != null) buffer.addAll(data);

    buffer.add(_calcBcc(buffer.sublist(2)));
    buffer.addAll(footer);

    return Uint8List.fromList(buffer);
  }

  /// BCC hesaplar
  int _calcBcc(List<int> data) {
    int result = 0;
    for (final byte in data) {
      result ^= byte;
    }
    return result;
  }

  /// Komut gönderir
  Future<bool> _sendCommand(Uint8List command) async {
    try {
      final success = await _communicationCubit.writeToCharacteristic(
        AppBleConstants.readerControlCharUuid,
        command.toList(),
      );

      if (success) {
        debugPrint("[READER] Command sent successfully: ${_bytesToHex(command)}");
      }

      return success;
    } catch (e) {
      debugPrint("[READER] Failed to send command: $e");
      return false;
    }
  }

  /// Komut gönderir ve response bekler
  Future<Uint8List?> _sendCommandAndGetResponse(
    Uint8List command, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      final commandCode = command[4];
      final expectedResponseCode = commandCode + 1; // Response = Request + 1

      // Pending command olarak kaydet
      final completer = Completer<Uint8List?>();
      _pendingCommands[expectedResponseCode] = completer;

      // Command'ı gönder
      final success = await _sendCommand(command);
      if (!success) {
        _pendingCommands.remove(expectedResponseCode);
        return null;
      }

      // Response'ı bekle
      final response = await completer.future.timeout(
        timeout,
        onTimeout: () {
          _pendingCommands.remove(expectedResponseCode);
          debugPrint(
            "[READER] Command timeout: 0x${commandCode.toRadixString(16).padLeft(2, '0').toUpperCase()} (expected response: 0x${expectedResponseCode.toRadixString(16).padLeft(2, '0').toUpperCase()})",
          );
          return null;
        },
      );

      return response;
    } catch (e) {
      debugPrint("[READER] Failed to send command and get response: $e");
      return null;
    }
  }

  // ===========================================
  // DATA PROCESSING
  // ===========================================

  /// User memory'den keyword ara
  Map<String, dynamic>? _bruteForceUserMemorySearch(String hexstring, {String keyword = "MFR "}) {
    try {
      // Temizle
      hexstring = hexstring.trim().toLowerCase().replaceAll("0x", "").replaceAll(" ", "");

      if (hexstring.length % 2 != 0) {
        throw ArgumentError("Hex string must represent full 16-bit words");
      }

      List<int> byteList = _hexStringToBytes(hexstring);
      int attempt = 0;

      while (byteList.isNotEmpty) {
        final bitstream = byteList.map((w) => w.toRadixString(2).padLeft(8, '0')).join();
        final decoded = _decode6bitAsciiFromBits(bitstream);

        if (decoded.contains(keyword)) {
          final Map<String, String> fields = {};
          final parts = decoded.split('*');

          for (final part in parts) {
            if (part.contains(' ')) {
              final partsList = part.split(' ');
              final k = partsList[0];
              final v = partsList.length > 1 ? partsList.sublist(1).join(' ') : '';
              if (v.isNotEmpty) {
                fields[k] = v;
              }
            }
          }

          return {
            "attempts": attempt,
            "start_offset_word": attempt,
            "decoded_string": decoded,
            "parsed_fields": fields,
            "user_data": hexstring,
          };
        }

        byteList = byteList.sublist(1);
        attempt++;
      }

      return {"attempts": attempt, "start_offset_word": null, "decoded_string": null, "parsed_fields": {}};
    } catch (e) {
      debugPrint("[READER] User memory search failed: $e");
      return null;
    }
  }

  /// 6-bit ASCII decode
  String _decode6bitAsciiFromBits(String bits) {
    final List<String> chunks = [];
    for (int i = 0; i < bits.length; i += 6) {
      if (i + 6 <= bits.length) {
        chunks.add(bits.substring(i, i + 6));
      }
    }

    final List<String> result = [];
    for (final b in chunks) {
      if (b.length < 6) continue;

      final val = int.parse(b, radix: 2);
      if (val == 0x00) {
        break;
      } else if (0x20 <= val && val <= 0x3F) {
        result.add(String.fromCharCode(val));
      } else if (0x01 <= val && val <= 0x1F) {
        result.add(String.fromCharCode(val + 0x40));
      } else {
        result.add('?');
      }
    }

    return result.join();
  }

  // ===========================================
  // UTILITY METHODS
  // ===========================================

  /// Bytes'ı hex string'e çevirir
  String _bytesToHex(Uint8List bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Hex string'i bytes'a çevirir
  List<int> _hexStringToBytes(String hex) {
    final List<int> bytes = [];
    for (int i = 0; i < hex.length; i += 2) {
      if (i + 2 <= hex.length) {
        bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
      }
    }
    return bytes;
  }

  /// State management helper methods
  void loadingInstance() {
    emit(state.copyWith(status: UIStateStatus.loading));
  }

  void idleInstance() {
    emit(state.copyWith(status: UIStateStatus.idle));
  }

  void clearFailure() {
    emit(state.clearFailure());
  }

  /// Clear discovered tags
  void clearDiscoveredTags() {
    debugPrint("[READER] Clearing discovered tags - current count: ${state.discoveredTags.length}");
    emit(state.copyWith(discoveredTags: []));
    debugPrint("[READER] Discovered tags cleared - new count: ${state.discoveredTags.length}");
  }

  /// Set work state
  void setWorkState(ReaderWorkState workState) {
    emit(state.copyWith(workState: workState));
  }

  // ===========================================
  // EPC DECODING METHODS (reader.dart'tan eklenen)
  // ===========================================

  /// GS1 ADI EPC'yi decode eder
  /// reader.dart'tan eklenen fonksiyon
  Map<String, dynamic> decodeGs1AdiEpc(String epcHex) {
    try {
      // Hex string'i binary'ye çevir
      final bytes = <int>[];

      for (int i = 0; i < epcHex.length; i += 2) {
        bytes.add(int.parse(epcHex.substring(i, i + 2), radix: 16));
      }

      final bits = bytes.map((b) => b.toRadixString(2).padLeft(8, '0')).join();

      int ptr = 0;

      // Header kontrolü
      final header = int.parse(bits.substring(ptr, ptr + 8), radix: 2);
      ptr += 8;

      if (header != 59) {
        throw Exception('Header is not correct');
      }

      // Filter value
      final filterValue = int.parse(bits.substring(ptr, ptr + 6), radix: 2);
      ptr += 6;

      // CAGE code
      final cageBits = bits.substring(ptr, ptr + 36);
      final cageCode = decodeGs16Bit(cageBits);
      ptr += 36;

      /// NULL-terminated 6-bit string field okuyucu helper
      MapEntry<String, int> readField(String bits, int start) {
        final chunks = <String>[];
        while (start + 6 <= bits.length) {
          final chunk = bits.substring(start, start + 6);
          if (chunk == '000000') {
            return MapEntry(chunks.join(), start + 6);
          }
          chunks.add(chunk);
          start += 6;
        }
        return MapEntry(chunks.join(), start);
      }

      final firstFieldBits = readField(bits, ptr);
      final firstField = decodeGs16Bit(firstFieldBits.key);
      final newPtr = firstFieldBits.value;

      final secondFieldBits = readField(bits, newPtr);
      final secondField = decodeGs16Bit(secondFieldBits.key);

      final mfr = cageCode.trim();

      int construct;
      String? ser, pno, seq;

      if (firstField.isEmpty && secondField.isNotEmpty) {
        construct = 1;
        ser = secondField;
        pno = null;
        seq = null;
      } else {
        construct = 2;
        ser = null;
        pno = firstField;
        seq = secondField;
      }

      final result = {
        'construct': construct,
        'filter_value': filterValue,
        'MFR': mfr,
        'SER': ser,
        'PNO': pno,
        'SEQ': seq,
      };

      return result;
    } catch (e) {
      return {
        'error': e.toString(),
        'construct': null,
        'filter_value': null,
        'MFR': null,
        'SER': null,
        'PNO': null,
        'SEQ': null,
      };
    }
  }

  /// GS1 16-bit encoding'i decode eder
  /// reader.dart'tan eklenen fonksiyon
  String decodeGs16Bit(String bits) {
    try {
      final chars = <String>[];

      for (int i = 0; i < bits.length; i += 6) {
        if (i + 6 > bits.length) break;

        final chunk = bits.substring(i, i + 6);
        final val = int.parse(chunk, radix: 2);

        if (val == 0x00) {
          break;
        } else if (val >= 0x20 && val <= 0x3F) {
          chars.add(String.fromCharCode(val));
        } else if (val >= 0x01 && val <= 0x1F) {
          chars.add(String.fromCharCode(val + 0x40));
        } else {
          chars.add('?');
        }
      }

      final result = chars.join();

      return result;
    } catch (e) {
      debugPrint("[READER] Failed to decode GS1 16-bit: $e");
      return '';
    }
  }

  /// User memory'den brute force ile veri arar (geliştirilmiş versiyon)
  /// reader.dart'tan eklenen fonksiyon
  Map<String, dynamic>? bruteForceUserMemorySearchFromHexstring(String hexstring, {String keyword = "MFR "}) {
    try {
      // Hex string'i temizle
      hexstring = hexstring.trim().toLowerCase().replaceAll("0x", "").replaceAll(" ", "");

      if (hexstring.length % 2 != 0) {
        throw ArgumentError("Hex stringi tam 16-bit kelimeler (4 hex karakter/kelime) temsil etmelidir.");
      }

      List<int> byteList = _hexStringToBytes(hexstring);
      int attempt = 0;

      debugPrint("[READER] Brute force search starting for keyword: '$keyword'");

      while (byteList.isNotEmpty) {
        final bitstream = byteList.map((w) => w.toRadixString(2).padLeft(8, '0')).join();
        final decoded = _decode6bitAsciiFromBits(bitstream);

        debugPrint("[READER] Attempt $attempt: '$decoded'");

        if (decoded.contains(keyword)) {
          final Map<String, String> fields = {};
          final parts = decoded.split('*');

          for (final part in parts) {
            if (part.contains(' ')) {
              final partsList = part.split(' ');
              final k = partsList[0];
              final v = partsList.length > 1 ? partsList.sublist(1).join(' ') : '';
              if (v.isNotEmpty) {
                fields[k] = v;
              }
            }
          }

          final result = {
            "attempts": attempt,
            "start_offset_word": attempt,
            "decoded_string": decoded,
            "parsed_fields": fields,
            "user_data": hexstring,
          };

          debugPrint("[READER] ✅ Brute force search successful: $result");
          return result;
        }

        byteList = byteList.sublist(1);
        attempt++;
      }

      debugPrint("[READER] ⚠️ Brute force search completed without finding keyword");
      return {
        "attempts": attempt,
        "start_offset_word": null,
        "decoded_string": null,
        "parsed_fields": <String, dynamic>{},
      };
    } catch (e) {
      debugPrint("[READER] ❌ Brute force search failed: $e");
      return {
        "error": e.toString(),
        "attempts": 0,
        "start_offset_word": null,
        "decoded_string": null,
        "parsed_fields": <String, dynamic>{},
      };
    }
  }

  @override
  Future<void> close() {
    _inventoryTimer?.cancel();
    _buttonTimer?.cancel();
    return super.close();
  }
}
