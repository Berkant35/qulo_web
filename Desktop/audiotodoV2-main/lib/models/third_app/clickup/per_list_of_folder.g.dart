// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'per_list_of_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerListOfFolderImpl _$$PerListOfFolderImplFromJson(
        Map<String, dynamic> json) =>
    _$PerListOfFolderImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      orderindex: (json['orderindex'] as num?)?.toInt(),
      content: json['content'] as String?,
      taskCount: (json['task_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PerListOfFolderImplToJson(
        _$PerListOfFolderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'orderindex': instance.orderindex,
      'content': instance.content,
      'task_count': instance.taskCount,
    };
