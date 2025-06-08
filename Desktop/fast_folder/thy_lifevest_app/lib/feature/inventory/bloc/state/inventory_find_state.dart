import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';

part 'inventory_find_state.freezed.dart';


enum InventoryFindStatus{
  idle(label:AppStrings.findTag),
  gettingSignal(label: AppStrings.getSignalByEpc),
  keepContinue(label: AppStrings.letsKeepToFind);
  final String label;
  const InventoryFindStatus({required this.label});
}

@freezed
abstract class InventoryFindState with _$InventoryFindState {
  const factory InventoryFindState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    @Default(InventoryFindStatus.idle) InventoryFindStatus findStatus,
    Failure? failure,
  }) = _InventoryFindState;

  const InventoryFindState._();
}