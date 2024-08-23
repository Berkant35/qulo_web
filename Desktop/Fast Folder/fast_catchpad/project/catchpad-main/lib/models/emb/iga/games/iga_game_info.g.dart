// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_game_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaGameInfo _$$_IgaGameInfoFromJson(Map<String, dynamic> json) =>
    _$_IgaGameInfo(
      igaGameId: json['igaGameId'] as String?,
      primaryAverage: (json['primaryAverage'] as num?)?.toDouble(),
      igaLastGameId: json['igaLastGameId'] as String?,
      secondaryAverage: (json['secondaryAverage'] as num?)?.toDouble(),
      gameCount: json['gameCount'] as int?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$_IgaGameInfoToJson(_$_IgaGameInfo instance) =>
    <String, dynamic>{
      'igaGameId': instance.igaGameId,
      'primaryAverage': instance.primaryAverage,
      'igaLastGameId': instance.igaLastGameId,
      'secondaryAverage': instance.secondaryAverage,
      'gameCount': instance.gameCount,
      'createdAt': instance.createdAt,
    };
