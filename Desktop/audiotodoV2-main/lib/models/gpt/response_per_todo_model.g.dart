// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_per_todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponsePerTodoModelImpl _$$ResponsePerTodoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ResponsePerTodoModelImpl(
      id: json['id'] as String?,
      meetId: json['meetId'] as String?,
      todoTitle: json['todo_title'] as String?,
      todoContent: json['todo_content'] as String?,
      deadline: json['deadline'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      assignedPersons: (json['assigned_persons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deadlineTime: json['deadline_time'] as String?,
      createdTime: json['created_time'] as String?,
    );

Map<String, dynamic> _$$ResponsePerTodoModelImplToJson(
        _$ResponsePerTodoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meetId': instance.meetId,
      'todo_title': instance.todoTitle,
      'todo_content': instance.todoContent,
      'deadline': instance.deadline,
      'tags': instance.tags,
      'assigned_persons': instance.assignedPersons,
      'deadline_time': instance.deadlineTime,
      'created_time': instance.createdTime,
    };
