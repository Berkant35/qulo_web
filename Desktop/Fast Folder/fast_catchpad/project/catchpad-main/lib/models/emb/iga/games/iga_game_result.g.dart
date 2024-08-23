// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_game_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaGameResult _$$_IgaGameResultFromJson(Map<String, dynamic> json) =>
    _$_IgaGameResult(
      igaGameResultId: json['igaGameResultId'] as String?,
      primaryScore: (json['primaryScore'] as num?)?.toDouble(),
      secondaryScore: (json['secondaryScore'] as num?)?.toDouble(),
      igaUsername: json['igaUsername'] as String?,
      igaUserCountry: json['igaUserCountry'] as String?,
      igaUserCountryCode: json['igaUserCountryCode'] as String?,
      igaUserId: json['igaUserId'] as String?,
      igaGameId: json['igaGameId'] as String?,
      igaLocationId: json['igaLocationId'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$_IgaGameResultToJson(_$_IgaGameResult instance) =>
    <String, dynamic>{
      'igaGameResultId': instance.igaGameResultId,
      'primaryScore': instance.primaryScore,
      'secondaryScore': instance.secondaryScore,
      'igaUsername': instance.igaUsername,
      'igaUserCountry': instance.igaUserCountry,
      'igaUserCountryCode': instance.igaUserCountryCode,
      'igaUserId': instance.igaUserId,
      'igaGameId': instance.igaGameId,
      'igaLocationId': instance.igaLocationId,
      'createdAt': instance.createdAt,
    };
