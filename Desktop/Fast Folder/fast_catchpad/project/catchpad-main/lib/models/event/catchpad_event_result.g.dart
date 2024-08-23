// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catchpad_event_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CatchpadEventResult _$$_CatchpadEventResultFromJson(
        Map<String, dynamic> json) =>
    _$_CatchpadEventResult(
      eventId: json['eventId'] as String?,
      gameId: json['gameId'] as String?,
      userId: json['userId'] as String?,
      userFullName: json['userFullName'] as String?,
      userPrimaryScore: (json['userPrimaryScore'] as num?)?.toDouble(),
      userSecondaryScore: json['userSecondaryScore'] as int?,
    );

Map<String, dynamic> _$$_CatchpadEventResultToJson(
        _$_CatchpadEventResult instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'gameId': instance.gameId,
      'userId': instance.userId,
      'userFullName': instance.userFullName,
      'userPrimaryScore': instance.userPrimaryScore,
      'userSecondaryScore': instance.userSecondaryScore,
    };
