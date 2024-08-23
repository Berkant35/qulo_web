import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';


@freezed
class Product with _$Product{
  const factory Product({
   @JsonKey(name: 'productId') String? productId,
   @JsonKey(name: 'isSaleStatus', defaultValue: false)
   @Default(false) bool isSaleStatus,
   @JsonKey(name: "saleNo") String? saleNo,
   @JsonKey(name: "cpId") String? cpId,
   @JsonKey(name: "stickerType") String? stickerType,
   @JsonKey(name: "productOwnerUserName") String? productOwnerUserName,
   @JsonKey(name: "productGroupName") String? productGroupName,
   @JsonKey(name: "productGroupId") String? productGroupId,
   @JsonKey(name: "productOwnerId") String? productOwnerId,
   @JsonKey(name: "hwVersion") String? hwVersion,
   @JsonKey(name: "swVersion") String? swVersion,
   @JsonKey(name: "createdAt") String? createdAt,
   @JsonKey(name: "updatedAt") String? updatedAt,
   @JsonKey(name: "noTm") int? noTm,
   @JsonKey(name: "variantId") String? variantId,
   @JsonKey(name: "bleName") String? bleName,
  }) = _Product;

  factory Product.fromJson(Map<String,dynamic> jsonData) => _$$_ProductFromJson(jsonData);
}

