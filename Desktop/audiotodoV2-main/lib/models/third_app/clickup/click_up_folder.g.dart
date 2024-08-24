// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'click_up_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClickUpFolderImpl _$$ClickUpFolderImplFromJson(Map<String, dynamic> json) =>
    _$ClickUpFolderImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      orderindex: (json['orderindex'] as num?)?.toInt(),
      overrideStatuses: json['override_statuses'] as bool?,
      hidden: json['hidden'] as bool?,
      taskCount: json['task_count'] as String?,
    );

Map<String, dynamic> _$$ClickUpFolderImplToJson(_$ClickUpFolderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'orderindex': instance.orderindex,
      'override_statuses': instance.overrideStatuses,
      'hidden': instance.hidden,
      'task_count': instance.taskCount,
    };
