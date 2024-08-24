// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_software_todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JiraSoftwareToDoModelImpl _$$JiraSoftwareToDoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JiraSoftwareToDoModelImpl(
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JiraSoftwareToDoModelImplToJson(
        _$JiraSoftwareToDoModelImpl instance) =>
    <String, dynamic>{
      'fields': instance.fields?.toJson(),
    };
