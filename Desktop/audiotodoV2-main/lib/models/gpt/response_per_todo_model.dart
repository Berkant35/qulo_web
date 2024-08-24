import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_per_todo_model.freezed.dart';
part 'response_per_todo_model.g.dart';

@freezed
class ResponsePerTodoModel with _$ResponsePerTodoModel {
  const factory ResponsePerTodoModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'meetId') String? meetId,
    @JsonKey(name: 'todo_title') String? todoTitle,
    @JsonKey(name: 'todo_content') String? todoContent,
    @JsonKey(name: 'deadline') String? deadline,
    @JsonKey(name: 'tags') List<String>? tags,
    @JsonKey(name: 'assigned_persons')
    List<String>? assignedPersons,
    @JsonKey(name: 'deadline_time') String? deadlineTime,
    @JsonKey(name: 'created_time') String? createdTime,
  }) = _ResponsePerTodoModel;

  factory ResponsePerTodoModel.fromJson(Map<String, Object?> json) =>
      _$ResponsePerTodoModelFromJson(json);
}
