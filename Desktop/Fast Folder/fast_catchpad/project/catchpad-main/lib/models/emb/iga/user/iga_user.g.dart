// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iga_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IgaUser _$$_IgaUserFromJson(Map<String, dynamic> json) => _$_IgaUser(
      igaUserId: json['igaUserId'] as String?,
      igaUserEmail: json['igaUserEmail'] as String?,
      igaUserName: json['igaUserName'] as String?,
      igaGameResultId: json['igaGameResultId'] as String?,
      igaUserCreatedAt: json['igaUserCreatedAt'] as String?,
      igaUserCountry: json['igaUserCountry'] as String?,
      igaUserCountryCode: json['igaUserCountryCode'] as String?,
      isDebugUser: json['isDebugUser'] as bool?,
      isEventUser: json['isEventUser'] as bool?,
      eventName: json['eventName'] as String?,
    );

Map<String, dynamic> _$$_IgaUserToJson(_$_IgaUser instance) =>
    <String, dynamic>{
      'igaUserId': instance.igaUserId,
      'igaUserEmail': instance.igaUserEmail,
      'igaUserName': instance.igaUserName,
      'igaGameResultId': instance.igaGameResultId,
      'igaUserCreatedAt': instance.igaUserCreatedAt,
      'igaUserCountry': instance.igaUserCountry,
      'igaUserCountryCode': instance.igaUserCountryCode,
      'isDebugUser': instance.isDebugUser,
      'isEventUser': instance.isEventUser,
      'eventName': instance.eventName,
    };
