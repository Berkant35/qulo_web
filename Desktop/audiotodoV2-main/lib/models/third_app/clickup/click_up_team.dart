import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'click_up_team.freezed.dart';
part 'click_up_team.g.dart';

@freezed
class ClickUpTeam with _$ClickUpTeam {
  const factory ClickUpTeam({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'members') List<Members>? members,
  }) = _ClickUpTeam;

  factory ClickUpTeam.fromJson(Map<String, Object?> json) =>
      _$ClickUpTeamFromJson(json);
}

@freezed
class Members with _$Members {
  const factory Members({
    @JsonKey(name: 'user') User? user,
    @JsonKey(name: 'invited_by') InvitedBy? invitedBy,
    @JsonKey(name: 'can_see_time_spent') bool? canSeeTimeSpent,
    @JsonKey(name: 'can_see_time_estimated') bool? canSeeTimeEstimated,
    @JsonKey(name: 'can_see_points_estimated') bool? canSeePointsEstimated,
    @JsonKey(name: 'can_edit_tags') bool? canEditTags,
    @JsonKey(name: 'can_create_views') bool? canCreateViews,
  }) = _Members;

  factory Members.fromJson(Map<String, Object?> json) =>
      _$MembersFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'profilePicture') String? profilePicture,
    @JsonKey(name: 'initials') String? initials,
    @JsonKey(name: 'role') int? role,
    @JsonKey(name: 'last_active') String? lastActive,
    @JsonKey(name: 'date_joined') String? dateJoined,
    @JsonKey(name: 'date_invited') String? dateInvited,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@freezed
class InvitedBy with _$InvitedBy {
  const factory InvitedBy({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'initials') String? initials,
    @JsonKey(name: 'profilePicture') String? profilePicture,
  }) = _InvitedBy;

  factory InvitedBy.fromJson(Map<String, Object?> json) =>
      _$InvitedByFromJson(json);
}
