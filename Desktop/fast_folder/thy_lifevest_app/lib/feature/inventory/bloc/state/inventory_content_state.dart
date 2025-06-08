


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';

part 'inventory_content_state.freezed.dart';

enum InventoryContentFilters{
  all,
  valid,
  nearExpiry,
  expired,
  pending,
}

@freezed
abstract class InventoryContentState with _$InventoryContentState {
  const factory InventoryContentState({
    @Default(InventoryContentFilters.all) InventoryContentFilters selectedFilter,
    String? accessToken,
    @Default([]) List<LifevestTagModel> waitingToSendLifevestTags,
    @Default([]) List<LifevestTagModel> lifevestTags,
  }) = _InventoryContentState;

  const InventoryContentState._();
}