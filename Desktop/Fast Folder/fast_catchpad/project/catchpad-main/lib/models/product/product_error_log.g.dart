// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_error_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductErrorLog _$$_ProductErrorLogFromJson(Map<String, dynamic> json) =>
    _$_ProductErrorLog(
      productId: json['productId'] as String,
      accInitError: json['accInitError'] as bool,
      dstInitError: json['dstInitError'] as bool,
      noBatOrOvpError: json['noBatOrOvpError'] as bool,
      lowBatVoltageError: json['lowBatVoltageError'] as bool,
      unKnownCounter: json['unKnownCounter'] as int,
      serialNumber: json['serialNumber'] as String,
      productOwner: json['productOwner'] as String,
      productOwnerId: json['productOwnerId'] as String,
    );

Map<String, dynamic> _$$_ProductErrorLogToJson(_$_ProductErrorLog instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'accInitError': instance.accInitError,
      'dstInitError': instance.dstInitError,
      'noBatOrOvpError': instance.noBatOrOvpError,
      'lowBatVoltageError': instance.lowBatVoltageError,
      'unKnownCounter': instance.unKnownCounter,
      'serialNumber': instance.serialNumber,
      'productOwner': instance.productOwner,
      'productOwnerId': instance.productOwnerId,
    };
