// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductGroup _$$_ProductGroupFromJson(Map<String, dynamic> json) =>
    _$_ProductGroup(
      productGroupId: json['productGroupId'] as String?,
      productGroupName: json['productGroupName'] as String? ?? '',
      productGroupOwnerUserName:
          json['productGroupOwnerUserName'] as String? ?? '',
      productGroupOwnerUserId: json['productGroupOwnerUserId'] as String? ?? '',
      productMacIdList: (json['productMacIdList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      productSerialNumberList:
          (json['productSerialNumberList'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      productGroupProductIdList:
          (json['productGroupProductIdList'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
    );

Map<String, dynamic> _$$_ProductGroupToJson(_$_ProductGroup instance) =>
    <String, dynamic>{
      'productGroupId': instance.productGroupId,
      'productGroupName': instance.productGroupName,
      'productGroupOwnerUserName': instance.productGroupOwnerUserName,
      'productGroupOwnerUserId': instance.productGroupOwnerUserId,
      'productMacIdList': instance.productMacIdList,
      'productSerialNumberList': instance.productSerialNumberList,
      'productGroupProductIdList': instance.productGroupProductIdList,
    };
