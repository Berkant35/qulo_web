import 'package:freezed_annotation/freezed_annotation.dart';
part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    @JsonKey(name: 'key') String? key,
  }) = _Project;

  factory Project.fromJson(Map<String, Object?> json) =>
      _$ProjectFromJson(json);
}
