import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';

part 'reader_state.freezed.dart';

/// Reader işlemleri için state yönetimi
@freezed
abstract class ReaderState with _$ReaderState {
  const factory ReaderState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    Failure? failure,

    // Connection durumu
    @Default(false) bool isConnected,
    @Default(false) bool isReconnecting,
    String? connectedDeviceAddress,

    // Inventory durumu
    @Default(false) bool isInventoryRunning,
    @Default([]) List<ReaderTag> discoveredTags,
    @Default(0) int remainingTagsInBuffer,
    @Default(false) bool waitingTagBuffer,

    // Reader ayarları
    @Default(ReaderSettings()) ReaderSettings settings,

    // Button events
    @Default(0) int buttonClickCount,
    @Default(false) bool lastButtonWasDoubleClick,

    // Son okunan data
    Map<String, List<int>>? lastReceivedData,

    // Find mode
    @Default(false) bool isFindMode,
    String? findTargetEpc,

    // Work state
    @Default(ReaderWorkState.idle) ReaderWorkState workState,
  }) = _ReaderState;

  const ReaderState._();



  /// Inventory çalışıyor ve etiket bekliyor mu?
  bool get isActiveInventory => isInventoryRunning && !waitingTagBuffer;

  @useResult
  ReaderState setFailure(
    int errorCode,
    String errorTitle,
    String errorText,
  ) {
    return copyWith(
      failure: Failure(
        code: errorCode,
        errorTitle: errorTitle,
        errorText: errorText,
      ),
      status: UIStateStatus.error,
    );
  }

  @useResult
  ReaderState clearFailure() {
    return copyWith(failure: null, status: UIStateStatus.idle);
  }
}

/// Reader tag bilgileri
@freezed
abstract class ReaderTag with _$ReaderTag {
  const factory ReaderTag({
    String? pc,
    int? epcLen,
    String? epc,
    String? tid,
    String? userData,
    int? userDataOffset,
    int? userDataSize,
    double? rssi,
    int? antenna,
    DateTime? readTime,
  }) = _ReaderTag;

  const ReaderTag._();

  Map<String, dynamic> toMap() {
    return {
      'pc': pc,
      'epc_len': epcLen,
      'epc': epc,
      'tid': tid,
      'user_data': userData,
      'user_data_offset': userDataOffset,
      'user_data_size': userDataSize,
      'rssi': rssi,
      'antenna': antenna,
      'read_time': readTime?.toIso8601String(),
    };
  }
}

/// Reader ayarları
@freezed
abstract class ReaderSettings with _$ReaderSettings {
  const factory ReaderSettings({
    @Default(2000) int readPower,
    @Default(2000) int writePower,
    @Default(false) bool buzzerEnabled,
    ReaderInventoryMode? inventoryMode,
  }) = _ReaderSettings;
}

/// Reader çalışma durumu
enum ReaderWorkState { idle, scanAndRead, find }

/// Reader inventory modu
@freezed
abstract class ReaderInventoryMode with _$ReaderInventoryMode {
  const factory ReaderInventoryMode({
    @Default(ReaderInventoryBank.epc) ReaderInventoryBank bank,
    @Default(0) int userOffset,
    @Default(0) int userLength,
  }) = _ReaderInventoryMode;
}

/// Reader inventory bank türleri
enum ReaderInventoryBank { epc, epcTid, epcTidUser }

/// Memory bank türleri
enum ReaderMemoryBank {
  epc(0x01),
  tid(0x02),
  user(0x03);

  final int value;
  const ReaderMemoryBank(this.value);
}
