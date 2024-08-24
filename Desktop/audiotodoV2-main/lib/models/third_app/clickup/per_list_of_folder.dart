import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'per_list_of_folder.freezed.dart';
part 'per_list_of_folder.g.dart';

@freezed
class PerListOfFolder with _$PerListOfFolder {
  const factory PerListOfFolder({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'orderindex') int? orderindex,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'task_count') int? taskCount,
  }) = _PerListOfFolder;

  factory PerListOfFolder.fromJson(Map<String, Object?> json) =>
      _$PerListOfFolderFromJson(json);
}
