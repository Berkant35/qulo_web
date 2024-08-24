import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'jira_software_project.freezed.dart';
part 'jira_software_project.g.dart';

@freezed
class JiraSoftwareProject with _$JiraSoftwareProject {
  const factory JiraSoftwareProject({
    @JsonKey(name: 'expand') String? expand,
    @JsonKey(name: 'self') String? self,
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'key') String? key,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatarUrls') AvatarUrls? avatarUrls,
    @JsonKey(name: 'projectTypeKey') String? projectTypeKey,
    @JsonKey(name: 'simplified') bool? simplified,
    @JsonKey(name: 'style') String? style,
    @JsonKey(name: 'isPrivate') bool? isPrivate,
    @JsonKey(name: 'entityId') String? entityId,
    @JsonKey(name: 'uuid') String? uuid,
  }) = _JiraSoftwareProject;

  factory JiraSoftwareProject.fromJson(Map<String, Object?> json) =>
      _$JiraSoftwareProjectFromJson(json);
}

@freezed
class AvatarUrls with _$AvatarUrls {
  const factory AvatarUrls({
    @JsonKey(name: '48x48') String? s48x48,
    @JsonKey(name: '24x24') String? s24x24,
    @JsonKey(name: '16x16') String? s16x16,
    @JsonKey(name: '32x32') String? s32x32,
  }) = _AvatarUrls;

  factory AvatarUrls.fromJson(Map<String, Object?> json) =>
      _$AvatarUrlsFromJson(json);
}
