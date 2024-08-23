import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:device_information/device_information.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:platform_device_id/platform_device_id.dart';
part 'phone_information_model.freezed.dart';
part 'phone_information_model.g.dart';

@freezed
class PhoneInformationModel with _$PhoneInformationModel {
  const factory PhoneInformationModel({
    @JsonKey(name: 'deviceId') String? deviceId,
    @JsonKey(name: 'platformVersion') String? platformVersion,
    @JsonKey(name: 'modelName') String? modelName,
    @JsonKey(name: 'manufacturer') String? manufacturer,
    @JsonKey(name: 'cpuType') String? cpuType,
    @JsonKey(name: 'hardware') String? hardware,
    @JsonKey(name: 'apiLevel') String? apiLevel,
    @JsonKey(name: 'deviceName') String? deviceName,
    @JsonKey(name: 'productName') String? productName,
  }) = _PhoneInformationModel;

  factory PhoneInformationModel.fromJson(Map<String, Object?> json) =>
      _$PhoneInformationModelFromJson(json);




  static Future<PhoneInformationModel> initialize() async {



    final deviceId = await DeviceInformation.deviceIMEINumber ?? "default";
    final platformVersion = await DeviceInformation.platformVersion;
    final modelName = await DeviceInformation.deviceModel;
    final manufacturer = await DeviceInformation.deviceManufacturer;
    final cpuType = await DeviceInformation.cpuName;
    final hardware = await DeviceInformation.hardware;
    final apiLevel = await DeviceInformation.apiLevel;
    final deviceName = await DeviceInformation.deviceName;
    final productName = await DeviceInformation.productName;

    return PhoneInformationModel(
      deviceId: deviceId,
      platformVersion: platformVersion,
      modelName: modelName,
      manufacturer: manufacturer,
      cpuType: cpuType,
      hardware: hardware,
      apiLevel: apiLevel.toString(),
      deviceName: deviceName,
      productName: productName,
    );


  }
}
