
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'product_group.freezed.dart';
part 'product_group.g.dart';

@freezed
class ProductGroup with _$ProductGroup {
  const factory ProductGroup({
    @JsonKey(name: 'productGroupId' ) String? productGroupId,
    @JsonKey(name: 'productGroupName',defaultValue: "") String? productGroupName,
    @JsonKey(name: 'productGroupOwnerUserName',defaultValue: "") String? productGroupOwnerUserName,
    @JsonKey(name: 'productGroupOwnerUserId',defaultValue: "") String? productGroupOwnerUserId,
    @JsonKey(name: 'productMacIdList',defaultValue: []) List<String>? productMacIdList,
    @JsonKey(name: 'productSerialNumberList',defaultValue: []) List<String>? productSerialNumberList,
    @JsonKey(name: 'productGroupProductIdList',defaultValue: []) List<String>? productGroupProductIdList,
  }) = _ProductGroup;

  factory ProductGroup.fromJson(Map<String, Object?> json) =>
      _$ProductGroupFromJson(json);
}
