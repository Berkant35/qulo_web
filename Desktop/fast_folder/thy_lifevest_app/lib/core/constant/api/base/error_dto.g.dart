// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDto _$ErrorDtoFromJson(Map<String, dynamic> json) => ErrorDto(
  path: json['path'] as String?,
  message: json['message'] as String?,
  errorCode: json['errorCode'] as String?,
);

Map<String, dynamic> _$ErrorDtoToJson(ErrorDto instance) => <String, dynamic>{
  'path': instance.path,
  'message': instance.message,
  'errorCode': instance.errorCode,
};
