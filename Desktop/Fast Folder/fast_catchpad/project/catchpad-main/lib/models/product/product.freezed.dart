// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  @JsonKey(name: 'productId')
  String? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'isSaleStatus', defaultValue: false)
  bool get isSaleStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "saleNo")
  String? get saleNo => throw _privateConstructorUsedError;
  @JsonKey(name: "cpId")
  String? get cpId => throw _privateConstructorUsedError;
  @JsonKey(name: "stickerType")
  String? get stickerType => throw _privateConstructorUsedError;
  @JsonKey(name: "productOwnerUserName")
  String? get productOwnerUserName => throw _privateConstructorUsedError;
  @JsonKey(name: "productGroupName")
  String? get productGroupName => throw _privateConstructorUsedError;
  @JsonKey(name: "productGroupId")
  String? get productGroupId => throw _privateConstructorUsedError;
  @JsonKey(name: "productOwnerId")
  String? get productOwnerId => throw _privateConstructorUsedError;
  @JsonKey(name: "hwVersion")
  String? get hwVersion => throw _privateConstructorUsedError;
  @JsonKey(name: "swVersion")
  String? get swVersion => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt")
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt")
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "noTm")
  int? get noTm => throw _privateConstructorUsedError;
  @JsonKey(name: "variantId")
  String? get variantId => throw _privateConstructorUsedError;
  @JsonKey(name: "bleName")
  String? get bleName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {@JsonKey(name: 'productId') String? productId,
      @JsonKey(name: 'isSaleStatus', defaultValue: false) bool isSaleStatus,
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
      @JsonKey(name: "bleName") String? bleName});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? isSaleStatus = null,
    Object? saleNo = freezed,
    Object? cpId = freezed,
    Object? stickerType = freezed,
    Object? productOwnerUserName = freezed,
    Object? productGroupName = freezed,
    Object? productGroupId = freezed,
    Object? productOwnerId = freezed,
    Object? hwVersion = freezed,
    Object? swVersion = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? noTm = freezed,
    Object? variantId = freezed,
    Object? bleName = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSaleStatus: null == isSaleStatus
          ? _value.isSaleStatus
          : isSaleStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      saleNo: freezed == saleNo
          ? _value.saleNo
          : saleNo // ignore: cast_nullable_to_non_nullable
              as String?,
      cpId: freezed == cpId
          ? _value.cpId
          : cpId // ignore: cast_nullable_to_non_nullable
              as String?,
      stickerType: freezed == stickerType
          ? _value.stickerType
          : stickerType // ignore: cast_nullable_to_non_nullable
              as String?,
      productOwnerUserName: freezed == productOwnerUserName
          ? _value.productOwnerUserName
          : productOwnerUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      productGroupName: freezed == productGroupName
          ? _value.productGroupName
          : productGroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      productGroupId: freezed == productGroupId
          ? _value.productGroupId
          : productGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
      productOwnerId: freezed == productOwnerId
          ? _value.productOwnerId
          : productOwnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      hwVersion: freezed == hwVersion
          ? _value.hwVersion
          : hwVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      swVersion: freezed == swVersion
          ? _value.swVersion
          : swVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      noTm: freezed == noTm
          ? _value.noTm
          : noTm // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      bleName: freezed == bleName
          ? _value.bleName
          : bleName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_ProductCopyWith(
          _$_Product value, $Res Function(_$_Product) then) =
      __$$_ProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'productId') String? productId,
      @JsonKey(name: 'isSaleStatus', defaultValue: false) bool isSaleStatus,
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
      @JsonKey(name: "bleName") String? bleName});
}

/// @nodoc
class __$$_ProductCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$_Product>
    implements _$$_ProductCopyWith<$Res> {
  __$$_ProductCopyWithImpl(_$_Product _value, $Res Function(_$_Product) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? isSaleStatus = null,
    Object? saleNo = freezed,
    Object? cpId = freezed,
    Object? stickerType = freezed,
    Object? productOwnerUserName = freezed,
    Object? productGroupName = freezed,
    Object? productGroupId = freezed,
    Object? productOwnerId = freezed,
    Object? hwVersion = freezed,
    Object? swVersion = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? noTm = freezed,
    Object? variantId = freezed,
    Object? bleName = freezed,
  }) {
    return _then(_$_Product(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSaleStatus: null == isSaleStatus
          ? _value.isSaleStatus
          : isSaleStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      saleNo: freezed == saleNo
          ? _value.saleNo
          : saleNo // ignore: cast_nullable_to_non_nullable
              as String?,
      cpId: freezed == cpId
          ? _value.cpId
          : cpId // ignore: cast_nullable_to_non_nullable
              as String?,
      stickerType: freezed == stickerType
          ? _value.stickerType
          : stickerType // ignore: cast_nullable_to_non_nullable
              as String?,
      productOwnerUserName: freezed == productOwnerUserName
          ? _value.productOwnerUserName
          : productOwnerUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      productGroupName: freezed == productGroupName
          ? _value.productGroupName
          : productGroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      productGroupId: freezed == productGroupId
          ? _value.productGroupId
          : productGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
      productOwnerId: freezed == productOwnerId
          ? _value.productOwnerId
          : productOwnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      hwVersion: freezed == hwVersion
          ? _value.hwVersion
          : hwVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      swVersion: freezed == swVersion
          ? _value.swVersion
          : swVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      noTm: freezed == noTm
          ? _value.noTm
          : noTm // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      bleName: freezed == bleName
          ? _value.bleName
          : bleName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Product implements _Product {
  const _$_Product(
      {@JsonKey(name: 'productId') this.productId,
      @JsonKey(name: 'isSaleStatus', defaultValue: false)
      this.isSaleStatus = false,
      @JsonKey(name: "saleNo") this.saleNo,
      @JsonKey(name: "cpId") this.cpId,
      @JsonKey(name: "stickerType") this.stickerType,
      @JsonKey(name: "productOwnerUserName") this.productOwnerUserName,
      @JsonKey(name: "productGroupName") this.productGroupName,
      @JsonKey(name: "productGroupId") this.productGroupId,
      @JsonKey(name: "productOwnerId") this.productOwnerId,
      @JsonKey(name: "hwVersion") this.hwVersion,
      @JsonKey(name: "swVersion") this.swVersion,
      @JsonKey(name: "createdAt") this.createdAt,
      @JsonKey(name: "updatedAt") this.updatedAt,
      @JsonKey(name: "noTm") this.noTm,
      @JsonKey(name: "variantId") this.variantId,
      @JsonKey(name: "bleName") this.bleName});

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$$_ProductFromJson(json);

  @override
  @JsonKey(name: 'productId')
  final String? productId;
  @override
  @JsonKey(name: 'isSaleStatus', defaultValue: false)
  final bool isSaleStatus;
  @override
  @JsonKey(name: "saleNo")
  final String? saleNo;
  @override
  @JsonKey(name: "cpId")
  final String? cpId;
  @override
  @JsonKey(name: "stickerType")
  final String? stickerType;
  @override
  @JsonKey(name: "productOwnerUserName")
  final String? productOwnerUserName;
  @override
  @JsonKey(name: "productGroupName")
  final String? productGroupName;
  @override
  @JsonKey(name: "productGroupId")
  final String? productGroupId;
  @override
  @JsonKey(name: "productOwnerId")
  final String? productOwnerId;
  @override
  @JsonKey(name: "hwVersion")
  final String? hwVersion;
  @override
  @JsonKey(name: "swVersion")
  final String? swVersion;
  @override
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @override
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @override
  @JsonKey(name: "noTm")
  final int? noTm;
  @override
  @JsonKey(name: "variantId")
  final String? variantId;
  @override
  @JsonKey(name: "bleName")
  final String? bleName;

  @override
  String toString() {
    return 'Product(productId: $productId, isSaleStatus: $isSaleStatus, saleNo: $saleNo, cpId: $cpId, stickerType: $stickerType, productOwnerUserName: $productOwnerUserName, productGroupName: $productGroupName, productGroupId: $productGroupId, productOwnerId: $productOwnerId, hwVersion: $hwVersion, swVersion: $swVersion, createdAt: $createdAt, updatedAt: $updatedAt, noTm: $noTm, variantId: $variantId, bleName: $bleName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Product &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.isSaleStatus, isSaleStatus) ||
                other.isSaleStatus == isSaleStatus) &&
            (identical(other.saleNo, saleNo) || other.saleNo == saleNo) &&
            (identical(other.cpId, cpId) || other.cpId == cpId) &&
            (identical(other.stickerType, stickerType) ||
                other.stickerType == stickerType) &&
            (identical(other.productOwnerUserName, productOwnerUserName) ||
                other.productOwnerUserName == productOwnerUserName) &&
            (identical(other.productGroupName, productGroupName) ||
                other.productGroupName == productGroupName) &&
            (identical(other.productGroupId, productGroupId) ||
                other.productGroupId == productGroupId) &&
            (identical(other.productOwnerId, productOwnerId) ||
                other.productOwnerId == productOwnerId) &&
            (identical(other.hwVersion, hwVersion) ||
                other.hwVersion == hwVersion) &&
            (identical(other.swVersion, swVersion) ||
                other.swVersion == swVersion) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.noTm, noTm) || other.noTm == noTm) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.bleName, bleName) || other.bleName == bleName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      isSaleStatus,
      saleNo,
      cpId,
      stickerType,
      productOwnerUserName,
      productGroupName,
      productGroupId,
      productOwnerId,
      hwVersion,
      swVersion,
      createdAt,
      updatedAt,
      noTm,
      variantId,
      bleName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      __$$_ProductCopyWithImpl<_$_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {@JsonKey(name: 'productId') final String? productId,
      @JsonKey(name: 'isSaleStatus', defaultValue: false)
      final bool isSaleStatus,
      @JsonKey(name: "saleNo") final String? saleNo,
      @JsonKey(name: "cpId") final String? cpId,
      @JsonKey(name: "stickerType") final String? stickerType,
      @JsonKey(name: "productOwnerUserName") final String? productOwnerUserName,
      @JsonKey(name: "productGroupName") final String? productGroupName,
      @JsonKey(name: "productGroupId") final String? productGroupId,
      @JsonKey(name: "productOwnerId") final String? productOwnerId,
      @JsonKey(name: "hwVersion") final String? hwVersion,
      @JsonKey(name: "swVersion") final String? swVersion,
      @JsonKey(name: "createdAt") final String? createdAt,
      @JsonKey(name: "updatedAt") final String? updatedAt,
      @JsonKey(name: "noTm") final int? noTm,
      @JsonKey(name: "variantId") final String? variantId,
      @JsonKey(name: "bleName") final String? bleName}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override
  @JsonKey(name: 'productId')
  String? get productId;
  @override
  @JsonKey(name: 'isSaleStatus', defaultValue: false)
  bool get isSaleStatus;
  @override
  @JsonKey(name: "saleNo")
  String? get saleNo;
  @override
  @JsonKey(name: "cpId")
  String? get cpId;
  @override
  @JsonKey(name: "stickerType")
  String? get stickerType;
  @override
  @JsonKey(name: "productOwnerUserName")
  String? get productOwnerUserName;
  @override
  @JsonKey(name: "productGroupName")
  String? get productGroupName;
  @override
  @JsonKey(name: "productGroupId")
  String? get productGroupId;
  @override
  @JsonKey(name: "productOwnerId")
  String? get productOwnerId;
  @override
  @JsonKey(name: "hwVersion")
  String? get hwVersion;
  @override
  @JsonKey(name: "swVersion")
  String? get swVersion;
  @override
  @JsonKey(name: "createdAt")
  String? get createdAt;
  @override
  @JsonKey(name: "updatedAt")
  String? get updatedAt;
  @override
  @JsonKey(name: "noTm")
  int? get noTm;
  @override
  @JsonKey(name: "variantId")
  String? get variantId;
  @override
  @JsonKey(name: "bleName")
  String? get bleName;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      throw _privateConstructorUsedError;
}
