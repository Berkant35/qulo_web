// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaLocation _$$_IgaLocationFromJson(Map<String, dynamic> json) =>
    _$_IgaLocation(
      igaLocationId: json['igaLocationId'] as String?,
      igaLocationName: json['igaLocationName'] as String?,
      periodFiveBatteryInfo: json['periodFiveBatteryInfo'] as int?,
      allPadOk: json['allPadOk'] as bool?,
      igaLocationGameCount: json['igaLocationGameCount'] as int?,
      igaLocationPhoneId: json['igaLocationPhoneId'] as String?,
      igaLastGameId: json['igaLastGameId'] as String?,
      igaLastGameInfoId: json['igaLastGameInfoId'] as String?,
      igaChatBotClickCounter: json['igaChatBotClickCounter'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_IgaLocationToJson(_$_IgaLocation instance) =>
    <String, dynamic>{
      'igaLocationId': instance.igaLocationId,
      'igaLocationName': instance.igaLocationName,
      'periodFiveBatteryInfo': instance.periodFiveBatteryInfo,
      'allPadOk': instance.allPadOk,
      'igaLocationGameCount': instance.igaLocationGameCount,
      'igaLocationPhoneId': instance.igaLocationPhoneId,
      'igaLastGameId': instance.igaLastGameId,
      'igaLastGameInfoId': instance.igaLastGameInfoId,
      'igaChatBotClickCounter': instance.igaChatBotClickCounter,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
