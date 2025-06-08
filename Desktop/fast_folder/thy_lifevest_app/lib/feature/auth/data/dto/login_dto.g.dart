// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => _LoginDto(
  thyToken: json['thy_token'] as String?,
  accessToken: json['access_token'] as String?,
  appVersion: json['app_version'] as String?,
  serverVersion: json['server_version'] as String?,
);

Map<String, dynamic> _$LoginDtoToJson(_LoginDto instance) => <String, dynamic>{
  'thy_token': instance.thyToken,
  'access_token': instance.accessToken,
  'app_version': instance.appVersion,
  'server_version': instance.serverVersion,
};
