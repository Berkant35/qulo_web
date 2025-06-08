

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/feature/inventory/data/param/inventory_item_entity.dart';

class InventoryGetItemsParam{
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'epc_list')
  @Default([])
  final List<InventoryItemEntity> itemList;
  InventoryGetItemsParam({
    required this.accessToken,
    List<InventoryItemEntity>? itemList,
  }) : itemList = itemList ?? [];
  
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'epc_list': itemList.map((e) => e.toJson()).toList(),
    };
  }
}