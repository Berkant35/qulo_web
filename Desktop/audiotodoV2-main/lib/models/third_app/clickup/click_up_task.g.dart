// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'click_up_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClickUpTaskImpl _$$ClickUpTaskImplFromJson(Map<String, dynamic> json) =>
    _$ClickUpTaskImpl(
      name: json['name'] as String?,
      description: json['description'] as String?,
      assignees: (json['assignees'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      priority: (json['priority'] as num?)?.toInt(),
      dueDate: (json['due_date'] as num?)?.toInt(),
      dueDateTime: json['due_date_time'] as bool?,
      timeEstimate: (json['time_estimate'] as num?)?.toInt(),
      startDate: (json['start_date'] as num?)?.toInt(),
      startDateTime: json['start_date_time'] as bool?,
    );

Map<String, dynamic> _$$ClickUpTaskImplToJson(_$ClickUpTaskImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'assignees': instance.assignees,
      'tags': instance.tags,
      'priority': instance.priority,
      'due_date': instance.dueDate,
      'due_date_time': instance.dueDateTime,
      'time_estimate': instance.timeEstimate,
      'start_date': instance.startDate,
      'start_date_time': instance.startDateTime,
    };
