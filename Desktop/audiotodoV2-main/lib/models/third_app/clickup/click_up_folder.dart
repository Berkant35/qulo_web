import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'click_up_folder.freezed.dart';
part 'click_up_folder.g.dart';

@freezed
class ClickUpFolder with _$ClickUpFolder {
  const factory ClickUpFolder({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'orderindex') int? orderindex,
    @JsonKey(name: 'override_statuses') bool? overrideStatuses,
    @JsonKey(name: 'hidden') bool? hidden,
    @JsonKey(name: 'task_count') String? taskCount,
  }) = _ClickUpFolder;

  factory ClickUpFolder.fromJson(Map<String, Object?> json) =>
      _$ClickUpFolderFromJson(json);
}
