
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'click_up_task.freezed.dart';
part 'click_up_task.g.dart';

@freezed
class ClickUpTask with _$ClickUpTask {
  const factory ClickUpTask({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'assignees') List<int>? assignees,
    @JsonKey(name: 'tags') List<String>? tags,
    @JsonKey(name: 'priority') int? priority,
    @JsonKey(name: 'due_date') int? dueDate,
    @JsonKey(name: 'due_date_time') bool? dueDateTime,
    @JsonKey(name: 'time_estimate') int? timeEstimate,
    @JsonKey(name: 'start_date') int? startDate,
    @JsonKey(name: 'start_date_time') bool? startDateTime,
  }) = _ClickUpTask;

  factory ClickUpTask.fromJson(Map<String, Object?> json) =>
      _$ClickUpTaskFromJson(json);
}
