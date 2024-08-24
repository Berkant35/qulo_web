import 'package:freezed_annotation/freezed_annotation.dart';

import 'fields.dart';
part 'jira_software_todo_model.freezed.dart';
part 'jira_software_todo_model.g.dart';

@freezed
class JiraSoftwareToDoModel with _$JiraSoftwareToDoModel {
  const factory JiraSoftwareToDoModel({
    @JsonKey(name: 'fields') Fields? fields,
  }) = _JiraSoftwareToDoModel;

  factory JiraSoftwareToDoModel.fromJson(Map<String, Object?> json) =>
      _$JiraSoftwareToDoModelFromJson(json);
}
