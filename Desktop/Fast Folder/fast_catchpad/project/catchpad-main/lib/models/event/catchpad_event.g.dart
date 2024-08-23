// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catchpad_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CatchpadEvent _$$_CatchpadEventFromJson(Map<String, dynamic> json) =>
    _$_CatchpadEvent(
      eventId: json['eventId'] as String?,
      eventCreatedAt: json['eventCreatedAt'] as String?,
      eventLastDate: json['eventLastDate'] as String?,
      eventJoinUserIdList: (json['eventJoinUserIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      eventStatus: json['eventStatus'] as bool?,
      eventGameId: json['eventGameId'] as String?,
      eventName: json['eventName'] as String?,
      eventGameName: json['eventGameName'] as String?,
      eventDescription: json['eventDescription'] as String?,
    );

Map<String, dynamic> _$$_CatchpadEventToJson(_$_CatchpadEvent instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'eventCreatedAt': instance.eventCreatedAt,
      'eventLastDate': instance.eventLastDate,
      'eventJoinUserIdList': instance.eventJoinUserIdList,
      'eventStatus': instance.eventStatus,
      'eventGameId': instance.eventGameId,
      'eventName': instance.eventName,
      'eventGameName': instance.eventGameName,
      'eventDescription': instance.eventDescription,
    };
