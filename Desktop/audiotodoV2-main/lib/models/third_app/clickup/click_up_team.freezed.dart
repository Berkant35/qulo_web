// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'click_up_team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClickUpTeam _$ClickUpTeamFromJson(Map<String, dynamic> json) {
  return _ClickUpTeam.fromJson(json);
}

/// @nodoc
mixin _$ClickUpTeam {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar')
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'members')
  List<Members>? get members => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClickUpTeamCopyWith<ClickUpTeam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpTeamCopyWith<$Res> {
  factory $ClickUpTeamCopyWith(
          ClickUpTeam value, $Res Function(ClickUpTeam) then) =
      _$ClickUpTeamCopyWithImpl<$Res, ClickUpTeam>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'avatar') String? avatar,
      @JsonKey(name: 'members') List<Members>? members});
}

/// @nodoc
class _$ClickUpTeamCopyWithImpl<$Res, $Val extends ClickUpTeam>
    implements $ClickUpTeamCopyWith<$Res> {
  _$ClickUpTeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? color = freezed,
    Object? avatar = freezed,
    Object? members = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Members>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClickUpTeamImplCopyWith<$Res>
    implements $ClickUpTeamCopyWith<$Res> {
  factory _$$ClickUpTeamImplCopyWith(
          _$ClickUpTeamImpl value, $Res Function(_$ClickUpTeamImpl) then) =
      __$$ClickUpTeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'avatar') String? avatar,
      @JsonKey(name: 'members') List<Members>? members});
}

/// @nodoc
class __$$ClickUpTeamImplCopyWithImpl<$Res>
    extends _$ClickUpTeamCopyWithImpl<$Res, _$ClickUpTeamImpl>
    implements _$$ClickUpTeamImplCopyWith<$Res> {
  __$$ClickUpTeamImplCopyWithImpl(
      _$ClickUpTeamImpl _value, $Res Function(_$ClickUpTeamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? color = freezed,
    Object? avatar = freezed,
    Object? members = freezed,
  }) {
    return _then(_$ClickUpTeamImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      members: freezed == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Members>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpTeamImpl with DiagnosticableTreeMixin implements _ClickUpTeam {
  const _$ClickUpTeamImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'color') this.color,
      @JsonKey(name: 'avatar') this.avatar,
      @JsonKey(name: 'members') final List<Members>? members})
      : _members = members;

  factory _$ClickUpTeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClickUpTeamImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'color')
  final String? color;
  @override
  @JsonKey(name: 'avatar')
  final String? avatar;
  final List<Members>? _members;
  @override
  @JsonKey(name: 'members')
  List<Members>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClickUpTeam(id: $id, name: $name, color: $color, avatar: $avatar, members: $members)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClickUpTeam'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('members', members));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpTeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color, avatar,
      const DeepCollectionEquality().hash(_members));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpTeamImplCopyWith<_$ClickUpTeamImpl> get copyWith =>
      __$$ClickUpTeamImplCopyWithImpl<_$ClickUpTeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpTeamImplToJson(
      this,
    );
  }
}

abstract class _ClickUpTeam implements ClickUpTeam {
  const factory _ClickUpTeam(
          {@JsonKey(name: 'id') final String? id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'color') final String? color,
          @JsonKey(name: 'avatar') final String? avatar,
          @JsonKey(name: 'members') final List<Members>? members}) =
      _$ClickUpTeamImpl;

  factory _ClickUpTeam.fromJson(Map<String, dynamic> json) =
      _$ClickUpTeamImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(name: 'avatar')
  String? get avatar;
  @override
  @JsonKey(name: 'members')
  List<Members>? get members;
  @override
  @JsonKey(ignore: true)
  _$$ClickUpTeamImplCopyWith<_$ClickUpTeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Members _$MembersFromJson(Map<String, dynamic> json) {
  return _Members.fromJson(json);
}

/// @nodoc
mixin _$Members {
  @JsonKey(name: 'user')
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'invited_by')
  InvitedBy? get invitedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_see_time_spent')
  bool? get canSeeTimeSpent => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_see_time_estimated')
  bool? get canSeeTimeEstimated => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_see_points_estimated')
  bool? get canSeePointsEstimated => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_edit_tags')
  bool? get canEditTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_create_views')
  bool? get canCreateViews => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MembersCopyWith<Members> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembersCopyWith<$Res> {
  factory $MembersCopyWith(Members value, $Res Function(Members) then) =
      _$MembersCopyWithImpl<$Res, Members>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user') User? user,
      @JsonKey(name: 'invited_by') InvitedBy? invitedBy,
      @JsonKey(name: 'can_see_time_spent') bool? canSeeTimeSpent,
      @JsonKey(name: 'can_see_time_estimated') bool? canSeeTimeEstimated,
      @JsonKey(name: 'can_see_points_estimated') bool? canSeePointsEstimated,
      @JsonKey(name: 'can_edit_tags') bool? canEditTags,
      @JsonKey(name: 'can_create_views') bool? canCreateViews});

  $UserCopyWith<$Res>? get user;
  $InvitedByCopyWith<$Res>? get invitedBy;
}

/// @nodoc
class _$MembersCopyWithImpl<$Res, $Val extends Members>
    implements $MembersCopyWith<$Res> {
  _$MembersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? invitedBy = freezed,
    Object? canSeeTimeSpent = freezed,
    Object? canSeeTimeEstimated = freezed,
    Object? canSeePointsEstimated = freezed,
    Object? canEditTags = freezed,
    Object? canCreateViews = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      invitedBy: freezed == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as InvitedBy?,
      canSeeTimeSpent: freezed == canSeeTimeSpent
          ? _value.canSeeTimeSpent
          : canSeeTimeSpent // ignore: cast_nullable_to_non_nullable
              as bool?,
      canSeeTimeEstimated: freezed == canSeeTimeEstimated
          ? _value.canSeeTimeEstimated
          : canSeeTimeEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      canSeePointsEstimated: freezed == canSeePointsEstimated
          ? _value.canSeePointsEstimated
          : canSeePointsEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      canEditTags: freezed == canEditTags
          ? _value.canEditTags
          : canEditTags // ignore: cast_nullable_to_non_nullable
              as bool?,
      canCreateViews: freezed == canCreateViews
          ? _value.canCreateViews
          : canCreateViews // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InvitedByCopyWith<$Res>? get invitedBy {
    if (_value.invitedBy == null) {
      return null;
    }

    return $InvitedByCopyWith<$Res>(_value.invitedBy!, (value) {
      return _then(_value.copyWith(invitedBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MembersImplCopyWith<$Res> implements $MembersCopyWith<$Res> {
  factory _$$MembersImplCopyWith(
          _$MembersImpl value, $Res Function(_$MembersImpl) then) =
      __$$MembersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user') User? user,
      @JsonKey(name: 'invited_by') InvitedBy? invitedBy,
      @JsonKey(name: 'can_see_time_spent') bool? canSeeTimeSpent,
      @JsonKey(name: 'can_see_time_estimated') bool? canSeeTimeEstimated,
      @JsonKey(name: 'can_see_points_estimated') bool? canSeePointsEstimated,
      @JsonKey(name: 'can_edit_tags') bool? canEditTags,
      @JsonKey(name: 'can_create_views') bool? canCreateViews});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $InvitedByCopyWith<$Res>? get invitedBy;
}

/// @nodoc
class __$$MembersImplCopyWithImpl<$Res>
    extends _$MembersCopyWithImpl<$Res, _$MembersImpl>
    implements _$$MembersImplCopyWith<$Res> {
  __$$MembersImplCopyWithImpl(
      _$MembersImpl _value, $Res Function(_$MembersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? invitedBy = freezed,
    Object? canSeeTimeSpent = freezed,
    Object? canSeeTimeEstimated = freezed,
    Object? canSeePointsEstimated = freezed,
    Object? canEditTags = freezed,
    Object? canCreateViews = freezed,
  }) {
    return _then(_$MembersImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      invitedBy: freezed == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as InvitedBy?,
      canSeeTimeSpent: freezed == canSeeTimeSpent
          ? _value.canSeeTimeSpent
          : canSeeTimeSpent // ignore: cast_nullable_to_non_nullable
              as bool?,
      canSeeTimeEstimated: freezed == canSeeTimeEstimated
          ? _value.canSeeTimeEstimated
          : canSeeTimeEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      canSeePointsEstimated: freezed == canSeePointsEstimated
          ? _value.canSeePointsEstimated
          : canSeePointsEstimated // ignore: cast_nullable_to_non_nullable
              as bool?,
      canEditTags: freezed == canEditTags
          ? _value.canEditTags
          : canEditTags // ignore: cast_nullable_to_non_nullable
              as bool?,
      canCreateViews: freezed == canCreateViews
          ? _value.canCreateViews
          : canCreateViews // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MembersImpl with DiagnosticableTreeMixin implements _Members {
  const _$MembersImpl(
      {@JsonKey(name: 'user') this.user,
      @JsonKey(name: 'invited_by') this.invitedBy,
      @JsonKey(name: 'can_see_time_spent') this.canSeeTimeSpent,
      @JsonKey(name: 'can_see_time_estimated') this.canSeeTimeEstimated,
      @JsonKey(name: 'can_see_points_estimated') this.canSeePointsEstimated,
      @JsonKey(name: 'can_edit_tags') this.canEditTags,
      @JsonKey(name: 'can_create_views') this.canCreateViews});

  factory _$MembersImpl.fromJson(Map<String, dynamic> json) =>
      _$$MembersImplFromJson(json);

  @override
  @JsonKey(name: 'user')
  final User? user;
  @override
  @JsonKey(name: 'invited_by')
  final InvitedBy? invitedBy;
  @override
  @JsonKey(name: 'can_see_time_spent')
  final bool? canSeeTimeSpent;
  @override
  @JsonKey(name: 'can_see_time_estimated')
  final bool? canSeeTimeEstimated;
  @override
  @JsonKey(name: 'can_see_points_estimated')
  final bool? canSeePointsEstimated;
  @override
  @JsonKey(name: 'can_edit_tags')
  final bool? canEditTags;
  @override
  @JsonKey(name: 'can_create_views')
  final bool? canCreateViews;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Members(user: $user, invitedBy: $invitedBy, canSeeTimeSpent: $canSeeTimeSpent, canSeeTimeEstimated: $canSeeTimeEstimated, canSeePointsEstimated: $canSeePointsEstimated, canEditTags: $canEditTags, canCreateViews: $canCreateViews)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Members'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('invitedBy', invitedBy))
      ..add(DiagnosticsProperty('canSeeTimeSpent', canSeeTimeSpent))
      ..add(DiagnosticsProperty('canSeeTimeEstimated', canSeeTimeEstimated))
      ..add(DiagnosticsProperty('canSeePointsEstimated', canSeePointsEstimated))
      ..add(DiagnosticsProperty('canEditTags', canEditTags))
      ..add(DiagnosticsProperty('canCreateViews', canCreateViews));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembersImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.canSeeTimeSpent, canSeeTimeSpent) ||
                other.canSeeTimeSpent == canSeeTimeSpent) &&
            (identical(other.canSeeTimeEstimated, canSeeTimeEstimated) ||
                other.canSeeTimeEstimated == canSeeTimeEstimated) &&
            (identical(other.canSeePointsEstimated, canSeePointsEstimated) ||
                other.canSeePointsEstimated == canSeePointsEstimated) &&
            (identical(other.canEditTags, canEditTags) ||
                other.canEditTags == canEditTags) &&
            (identical(other.canCreateViews, canCreateViews) ||
                other.canCreateViews == canCreateViews));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, invitedBy, canSeeTimeSpent,
      canSeeTimeEstimated, canSeePointsEstimated, canEditTags, canCreateViews);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MembersImplCopyWith<_$MembersImpl> get copyWith =>
      __$$MembersImplCopyWithImpl<_$MembersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MembersImplToJson(
      this,
    );
  }
}

abstract class _Members implements Members {
  const factory _Members(
      {@JsonKey(name: 'user') final User? user,
      @JsonKey(name: 'invited_by') final InvitedBy? invitedBy,
      @JsonKey(name: 'can_see_time_spent') final bool? canSeeTimeSpent,
      @JsonKey(name: 'can_see_time_estimated') final bool? canSeeTimeEstimated,
      @JsonKey(name: 'can_see_points_estimated')
      final bool? canSeePointsEstimated,
      @JsonKey(name: 'can_edit_tags') final bool? canEditTags,
      @JsonKey(name: 'can_create_views')
      final bool? canCreateViews}) = _$MembersImpl;

  factory _Members.fromJson(Map<String, dynamic> json) = _$MembersImpl.fromJson;

  @override
  @JsonKey(name: 'user')
  User? get user;
  @override
  @JsonKey(name: 'invited_by')
  InvitedBy? get invitedBy;
  @override
  @JsonKey(name: 'can_see_time_spent')
  bool? get canSeeTimeSpent;
  @override
  @JsonKey(name: 'can_see_time_estimated')
  bool? get canSeeTimeEstimated;
  @override
  @JsonKey(name: 'can_see_points_estimated')
  bool? get canSeePointsEstimated;
  @override
  @JsonKey(name: 'can_edit_tags')
  bool? get canEditTags;
  @override
  @JsonKey(name: 'can_create_views')
  bool? get canCreateViews;
  @override
  @JsonKey(ignore: true)
  _$$MembersImplCopyWith<_$MembersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'profilePicture')
  String? get profilePicture => throw _privateConstructorUsedError;
  @JsonKey(name: 'initials')
  String? get initials => throw _privateConstructorUsedError;
  @JsonKey(name: 'role')
  int? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_active')
  String? get lastActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_joined')
  String? get dateJoined => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_invited')
  String? get dateInvited => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'profilePicture') String? profilePicture,
      @JsonKey(name: 'initials') String? initials,
      @JsonKey(name: 'role') int? role,
      @JsonKey(name: 'last_active') String? lastActive,
      @JsonKey(name: 'date_joined') String? dateJoined,
      @JsonKey(name: 'date_invited') String? dateInvited});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? color = freezed,
    Object? profilePicture = freezed,
    Object? initials = freezed,
    Object? role = freezed,
    Object? lastActive = freezed,
    Object? dateJoined = freezed,
    Object? dateInvited = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      initials: freezed == initials
          ? _value.initials
          : initials // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int?,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String?,
      dateJoined: freezed == dateJoined
          ? _value.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as String?,
      dateInvited: freezed == dateInvited
          ? _value.dateInvited
          : dateInvited // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'profilePicture') String? profilePicture,
      @JsonKey(name: 'initials') String? initials,
      @JsonKey(name: 'role') int? role,
      @JsonKey(name: 'last_active') String? lastActive,
      @JsonKey(name: 'date_joined') String? dateJoined,
      @JsonKey(name: 'date_invited') String? dateInvited});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? color = freezed,
    Object? profilePicture = freezed,
    Object? initials = freezed,
    Object? role = freezed,
    Object? lastActive = freezed,
    Object? dateJoined = freezed,
    Object? dateInvited = freezed,
  }) {
    return _then(_$UserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      initials: freezed == initials
          ? _value.initials
          : initials // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int?,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String?,
      dateJoined: freezed == dateJoined
          ? _value.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as String?,
      dateInvited: freezed == dateInvited
          ? _value.dateInvited
          : dateInvited // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl with DiagnosticableTreeMixin implements _User {
  const _$UserImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'username') this.username,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'color') this.color,
      @JsonKey(name: 'profilePicture') this.profilePicture,
      @JsonKey(name: 'initials') this.initials,
      @JsonKey(name: 'role') this.role,
      @JsonKey(name: 'last_active') this.lastActive,
      @JsonKey(name: 'date_joined') this.dateJoined,
      @JsonKey(name: 'date_invited') this.dateInvited});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'username')
  final String? username;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'color')
  final String? color;
  @override
  @JsonKey(name: 'profilePicture')
  final String? profilePicture;
  @override
  @JsonKey(name: 'initials')
  final String? initials;
  @override
  @JsonKey(name: 'role')
  final int? role;
  @override
  @JsonKey(name: 'last_active')
  final String? lastActive;
  @override
  @JsonKey(name: 'date_joined')
  final String? dateJoined;
  @override
  @JsonKey(name: 'date_invited')
  final String? dateInvited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(id: $id, username: $username, email: $email, color: $color, profilePicture: $profilePicture, initials: $initials, role: $role, lastActive: $lastActive, dateJoined: $dateJoined, dateInvited: $dateInvited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('profilePicture', profilePicture))
      ..add(DiagnosticsProperty('initials', initials))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('lastActive', lastActive))
      ..add(DiagnosticsProperty('dateJoined', dateJoined))
      ..add(DiagnosticsProperty('dateInvited', dateInvited));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.initials, initials) ||
                other.initials == initials) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.dateJoined, dateJoined) ||
                other.dateJoined == dateJoined) &&
            (identical(other.dateInvited, dateInvited) ||
                other.dateInvited == dateInvited));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, email, color,
      profilePicture, initials, role, lastActive, dateJoined, dateInvited);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: 'id') final int? id,
      @JsonKey(name: 'username') final String? username,
      @JsonKey(name: 'email') final String? email,
      @JsonKey(name: 'color') final String? color,
      @JsonKey(name: 'profilePicture') final String? profilePicture,
      @JsonKey(name: 'initials') final String? initials,
      @JsonKey(name: 'role') final int? role,
      @JsonKey(name: 'last_active') final String? lastActive,
      @JsonKey(name: 'date_joined') final String? dateJoined,
      @JsonKey(name: 'date_invited') final String? dateInvited}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'username')
  String? get username;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(name: 'profilePicture')
  String? get profilePicture;
  @override
  @JsonKey(name: 'initials')
  String? get initials;
  @override
  @JsonKey(name: 'role')
  int? get role;
  @override
  @JsonKey(name: 'last_active')
  String? get lastActive;
  @override
  @JsonKey(name: 'date_joined')
  String? get dateJoined;
  @override
  @JsonKey(name: 'date_invited')
  String? get dateInvited;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvitedBy _$InvitedByFromJson(Map<String, dynamic> json) {
  return _InvitedBy.fromJson(json);
}

/// @nodoc
mixin _$InvitedBy {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'initials')
  String? get initials => throw _privateConstructorUsedError;
  @JsonKey(name: 'profilePicture')
  String? get profilePicture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvitedByCopyWith<InvitedBy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitedByCopyWith<$Res> {
  factory $InvitedByCopyWith(InvitedBy value, $Res Function(InvitedBy) then) =
      _$InvitedByCopyWithImpl<$Res, InvitedBy>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'initials') String? initials,
      @JsonKey(name: 'profilePicture') String? profilePicture});
}

/// @nodoc
class _$InvitedByCopyWithImpl<$Res, $Val extends InvitedBy>
    implements $InvitedByCopyWith<$Res> {
  _$InvitedByCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? color = freezed,
    Object? email = freezed,
    Object? initials = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      initials: freezed == initials
          ? _value.initials
          : initials // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitedByImplCopyWith<$Res>
    implements $InvitedByCopyWith<$Res> {
  factory _$$InvitedByImplCopyWith(
          _$InvitedByImpl value, $Res Function(_$InvitedByImpl) then) =
      __$$InvitedByImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'initials') String? initials,
      @JsonKey(name: 'profilePicture') String? profilePicture});
}

/// @nodoc
class __$$InvitedByImplCopyWithImpl<$Res>
    extends _$InvitedByCopyWithImpl<$Res, _$InvitedByImpl>
    implements _$$InvitedByImplCopyWith<$Res> {
  __$$InvitedByImplCopyWithImpl(
      _$InvitedByImpl _value, $Res Function(_$InvitedByImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? color = freezed,
    Object? email = freezed,
    Object? initials = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(_$InvitedByImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      initials: freezed == initials
          ? _value.initials
          : initials // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitedByImpl with DiagnosticableTreeMixin implements _InvitedBy {
  const _$InvitedByImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'username') this.username,
      @JsonKey(name: 'color') this.color,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'initials') this.initials,
      @JsonKey(name: 'profilePicture') this.profilePicture});

  factory _$InvitedByImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitedByImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'username')
  final String? username;
  @override
  @JsonKey(name: 'color')
  final String? color;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'initials')
  final String? initials;
  @override
  @JsonKey(name: 'profilePicture')
  final String? profilePicture;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InvitedBy(id: $id, username: $username, color: $color, email: $email, initials: $initials, profilePicture: $profilePicture)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InvitedBy'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('initials', initials))
      ..add(DiagnosticsProperty('profilePicture', profilePicture));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitedByImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.initials, initials) ||
                other.initials == initials) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, username, color, email, initials, profilePicture);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitedByImplCopyWith<_$InvitedByImpl> get copyWith =>
      __$$InvitedByImplCopyWithImpl<_$InvitedByImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitedByImplToJson(
      this,
    );
  }
}

abstract class _InvitedBy implements InvitedBy {
  const factory _InvitedBy(
          {@JsonKey(name: 'id') final int? id,
          @JsonKey(name: 'username') final String? username,
          @JsonKey(name: 'color') final String? color,
          @JsonKey(name: 'email') final String? email,
          @JsonKey(name: 'initials') final String? initials,
          @JsonKey(name: 'profilePicture') final String? profilePicture}) =
      _$InvitedByImpl;

  factory _InvitedBy.fromJson(Map<String, dynamic> json) =
      _$InvitedByImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'username')
  String? get username;
  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'initials')
  String? get initials;
  @override
  @JsonKey(name: 'profilePicture')
  String? get profilePicture;
  @override
  @JsonKey(ignore: true)
  _$$InvitedByImplCopyWith<_$InvitedByImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
