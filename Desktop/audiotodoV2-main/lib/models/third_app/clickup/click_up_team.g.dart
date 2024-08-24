// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'click_up_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClickUpTeamImpl _$$ClickUpTeamImplFromJson(Map<String, dynamic> json) =>
    _$ClickUpTeamImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      avatar: json['avatar'] as String?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Members.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClickUpTeamImplToJson(_$ClickUpTeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'avatar': instance.avatar,
      'members': instance.members?.map((e) => e.toJson()).toList(),
    };

_$MembersImpl _$$MembersImplFromJson(Map<String, dynamic> json) =>
    _$MembersImpl(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      invitedBy: json['invited_by'] == null
          ? null
          : InvitedBy.fromJson(json['invited_by'] as Map<String, dynamic>),
      canSeeTimeSpent: json['can_see_time_spent'] as bool?,
      canSeeTimeEstimated: json['can_see_time_estimated'] as bool?,
      canSeePointsEstimated: json['can_see_points_estimated'] as bool?,
      canEditTags: json['can_edit_tags'] as bool?,
      canCreateViews: json['can_create_views'] as bool?,
    );

Map<String, dynamic> _$$MembersImplToJson(_$MembersImpl instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'invited_by': instance.invitedBy?.toJson(),
      'can_see_time_spent': instance.canSeeTimeSpent,
      'can_see_time_estimated': instance.canSeeTimeEstimated,
      'can_see_points_estimated': instance.canSeePointsEstimated,
      'can_edit_tags': instance.canEditTags,
      'can_create_views': instance.canCreateViews,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      color: json['color'] as String?,
      profilePicture: json['profilePicture'] as String?,
      initials: json['initials'] as String?,
      role: (json['role'] as num?)?.toInt(),
      lastActive: json['last_active'] as String?,
      dateJoined: json['date_joined'] as String?,
      dateInvited: json['date_invited'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'color': instance.color,
      'profilePicture': instance.profilePicture,
      'initials': instance.initials,
      'role': instance.role,
      'last_active': instance.lastActive,
      'date_joined': instance.dateJoined,
      'date_invited': instance.dateInvited,
    };

_$InvitedByImpl _$$InvitedByImplFromJson(Map<String, dynamic> json) =>
    _$InvitedByImpl(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      color: json['color'] as String?,
      email: json['email'] as String?,
      initials: json['initials'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$InvitedByImplToJson(_$InvitedByImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'color': instance.color,
      'email': instance.email,
      'initials': instance.initials,
      'profilePicture': instance.profilePicture,
    };
