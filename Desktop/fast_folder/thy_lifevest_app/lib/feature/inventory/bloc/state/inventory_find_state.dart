import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';

part 'inventory_find_state.freezed.dart';

@freezed
abstract class InventoryFindState with _$InventoryFindState {
  const factory InventoryFindState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    @Default(InventoryFindStatus.idle) InventoryFindStatus findStatus,
    Failure? failure,
    LifevestTagModel? setTagModel,
    @Default(0) int signalStrength,
    @Default(false) bool isTargetFound,
    @Default(0) int searchDuration, // Saniye cinsinden
  }) = _InventoryFindState;

  const InventoryFindState._();
}

enum InventoryFindStatus {
  idle(label: AppStrings.findTag),
  searching(label: AppStrings.getSignalByEpc),
  found(label: AppStrings.letsKeepToFind),
  timeout(label: AppStrings.findTag),
  error(label: AppStrings.error);

  final String label;

  const InventoryFindStatus({required this.label});
}
