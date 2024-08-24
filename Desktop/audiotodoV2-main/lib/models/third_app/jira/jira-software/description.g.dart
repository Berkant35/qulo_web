// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DescriptionImpl _$$DescriptionImplFromJson(Map<String, dynamic> json) =>
    _$DescriptionImpl(
      type: json['type'] as String?,
      version: (json['version'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DescriptionImplToJson(_$DescriptionImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'version': instance.version,
      'content': instance.content?.map((e) => e.toJson()).toList(),
    };
