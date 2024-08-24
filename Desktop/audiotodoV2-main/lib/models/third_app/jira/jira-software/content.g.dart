// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      type: json['type'] as String?,
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => TextContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'content': instance.content?.map((e) => e.toJson()).toList(),
    };
