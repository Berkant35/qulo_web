// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staged_player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StagedPlayerModel _$$_StagedPlayerModelFromJson(Map<String, dynamic> json) =>
    _$_StagedPlayerModel(
      colorCount: json['colorCount'] == null
          ? null
          : NumRange.fromJson(json['colorCount'] as Map<String, dynamic>),
      deviceCount: json['deviceCount'] == null
          ? null
          : NumRange.fromJson(json['deviceCount'] as Map<String, dynamic>),
      hasName: json['hasName'] as bool? ?? true,
      hasDevices: json['hasDevices'] as bool? ?? false,
      colorDeviceDifference: json['colorDeviceDifference'] as int?,
    );

Map<String, dynamic> _$$_StagedPlayerModelToJson(
        _$_StagedPlayerModel instance) =>
    <String, dynamic>{
      'colorCount': instance.colorCount?.toJson(),
      'deviceCount': instance.deviceCount?.toJson(),
      'hasName': instance.hasName,
      'hasDevices': instance.hasDevices,
      'colorDeviceDifference': instance.colorDeviceDifference,
    };
