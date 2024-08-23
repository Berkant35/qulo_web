// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      productId: json['productId'] as String?,
      isSaleStatus: json['isSaleStatus'] as bool? ?? false,
      saleNo: json['saleNo'] as String?,
      cpId: json['cpId'] as String?,
      stickerType: json['stickerType'] as String?,
      productOwnerUserName: json['productOwnerUserName'] as String?,
      productGroupName: json['productGroupName'] as String?,
      productGroupId: json['productGroupId'] as String?,
      productOwnerId: json['productOwnerId'] as String?,
      hwVersion: json['hwVersion'] as String?,
      swVersion: json['swVersion'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      noTm: json['noTm'] as int?,
      variantId: json['variantId'] as String?,
      bleName: json['bleName'] as String?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'isSaleStatus': instance.isSaleStatus,
      'saleNo': instance.saleNo,
      'cpId': instance.cpId,
      'stickerType': instance.stickerType,
      'productOwnerUserName': instance.productOwnerUserName,
      'productGroupName': instance.productGroupName,
      'productGroupId': instance.productGroupId,
      'productOwnerId': instance.productOwnerId,
      'hwVersion': instance.hwVersion,
      'swVersion': instance.swVersion,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'noTm': instance.noTm,
      'variantId': instance.variantId,
      'bleName': instance.bleName,
    };
