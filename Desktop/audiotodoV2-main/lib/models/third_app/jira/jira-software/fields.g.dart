// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FieldsImpl _$$FieldsImplFromJson(Map<String, dynamic> json) => _$FieldsImpl(
      project: json['project'] == null
          ? null
          : Project.fromJson(json['project'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
      description: json['description'] == null
          ? null
          : Description.fromJson(json['description'] as Map<String, dynamic>),
      labels:
          (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList(),
      issuetype: json['issuetype'] == null
          ? null
          : Issuetype.fromJson(json['issuetype'] as Map<String, dynamic>),
      customfield10016: (json['customfield_10016'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FieldsImplToJson(_$FieldsImpl instance) =>
    <String, dynamic>{
      'project': instance.project?.toJson(),
      'summary': instance.summary,
      'description': instance.description?.toJson(),
      'labels': instance.labels,
      'issuetype': instance.issuetype?.toJson(),
      'customfield_10016': instance.customfield10016,
    };
