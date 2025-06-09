import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/state/reader_state.dart';

part 'inventory_state.freezed.dart';

//a55a00098d01850d0a
//a55a00098d01850d0a


typedef LifevestTagMap = Map<String, LifevestTagModel>;

/// Inventory işlemleri için state yönetimi
@freezed
abstract class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    Failure? failure,
    @Default({}) LifevestTagMap lifevestTags,
    // Inventory durumu
    @Default(false) bool isInventoryRunning,
    @Default([]) List<ReaderTag> discoveredTags,
    @Default(0) int totalTagCount,

    // Ekran state'i
    @Default(false) bool isLoading,
    String? statusMessage,

    String? connectedReaderName,
  }) = _InventoryState;

  const InventoryState._();

  /// Inventory başlatılabilir mi?
  bool get canStartInventory => !isInventoryRunning;

  /// Inventory durdurulabilir mi?
  bool get canStopInventory => isInventoryRunning;

  @useResult
  InventoryState setFailure(int errorCode, String errorTitle, String errorText) {
    return copyWith(
      failure: Failure(code: errorCode, errorTitle: errorTitle, errorText: errorText),
      status: UIStateStatus.error,
    );
  }

  @useResult
  InventoryState clearFailure() {
    return copyWith(failure: null, status: UIStateStatus.idle);
  }
}
