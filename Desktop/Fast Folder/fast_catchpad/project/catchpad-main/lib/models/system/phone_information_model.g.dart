// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PhoneInformationModel _$$_PhoneInformationModelFromJson(
        Map<String, dynamic> json) =>
    _$_PhoneInformationModel(
      deviceId: json['deviceId'] as String?,
      platformVersion: json['platformVersion'] as String?,
      modelName: json['modelName'] as String?,
      manufacturer: json['manufacturer'] as String?,
      cpuType: json['cpuType'] as String?,
      hardware: json['hardware'] as String?,
      apiLevel: json['apiLevel'] as String?,
      deviceName: json['deviceName'] as String?,
      productName: json['productName'] as String?,
    );

Map<String, dynamic> _$$_PhoneInformationModelToJson(
        _$_PhoneInformationModel instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'platformVersion': instance.platformVersion,
      'modelName': instance.modelName,
      'manufacturer': instance.manufacturer,
      'cpuType': instance.cpuType,
      'hardware': instance.hardware,
      'apiLevel': instance.apiLevel,
      'deviceName': instance.deviceName,
      'productName': instance.productName,
    };
