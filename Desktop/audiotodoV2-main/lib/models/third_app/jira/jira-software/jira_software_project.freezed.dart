// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jira_software_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JiraSoftwareProject _$JiraSoftwareProjectFromJson(Map<String, dynamic> json) {
  return _JiraSoftwareProject.fromJson(json);
}

/// @nodoc
mixin _$JiraSoftwareProject {
  @JsonKey(name: 'expand')
  String? get expand => throw _privateConstructorUsedError;
  @JsonKey(name: 'self')
  String? get self => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'key')
  String? get key => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatarUrls')
  AvatarUrls? get avatarUrls => throw _privateConstructorUsedError;
  @JsonKey(name: 'projectTypeKey')
  String? get projectTypeKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'simplified')
  bool? get simplified => throw _privateConstructorUsedError;
  @JsonKey(name: 'style')
  String? get style => throw _privateConstructorUsedError;
  @JsonKey(name: 'isPrivate')
  bool? get isPrivate => throw _privateConstructorUsedError;
  @JsonKey(name: 'entityId')
  String? get entityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'uuid')
  String? get uuid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JiraSoftwareProjectCopyWith<JiraSoftwareProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JiraSoftwareProjectCopyWith<$Res> {
  factory $JiraSoftwareProjectCopyWith(
          JiraSoftwareProject value, $Res Function(JiraSoftwareProject) then) =
      _$JiraSoftwareProjectCopyWithImpl<$Res, JiraSoftwareProject>;
  @useResult
  $Res call(
      {@JsonKey(name: 'expand') String? expand,
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
      @JsonKey(name: 'uuid') String? uuid});

  $AvatarUrlsCopyWith<$Res>? get avatarUrls;
}

/// @nodoc
class _$JiraSoftwareProjectCopyWithImpl<$Res, $Val extends JiraSoftwareProject>
    implements $JiraSoftwareProjectCopyWith<$Res> {
  _$JiraSoftwareProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expand = freezed,
    Object? self = freezed,
    Object? id = freezed,
    Object? key = freezed,
    Object? name = freezed,
    Object? avatarUrls = freezed,
    Object? projectTypeKey = freezed,
    Object? simplified = freezed,
    Object? style = freezed,
    Object? isPrivate = freezed,
    Object? entityId = freezed,
    Object? uuid = freezed,
  }) {
    return _then(_value.copyWith(
      expand: freezed == expand
          ? _value.expand
          : expand // ignore: cast_nullable_to_non_nullable
              as String?,
      self: freezed == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrls: freezed == avatarUrls
          ? _value.avatarUrls
          : avatarUrls // ignore: cast_nullable_to_non_nullable
              as AvatarUrls?,
      projectTypeKey: freezed == projectTypeKey
          ? _value.projectTypeKey
          : projectTypeKey // ignore: cast_nullable_to_non_nullable
              as String?,
      simplified: freezed == simplified
          ? _value.simplified
          : simplified // ignore: cast_nullable_to_non_nullable
              as bool?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AvatarUrlsCopyWith<$Res>? get avatarUrls {
    if (_value.avatarUrls == null) {
      return null;
    }

    return $AvatarUrlsCopyWith<$Res>(_value.avatarUrls!, (value) {
      return _then(_value.copyWith(avatarUrls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JiraSoftwareProjectImplCopyWith<$Res>
    implements $JiraSoftwareProjectCopyWith<$Res> {
  factory _$$JiraSoftwareProjectImplCopyWith(_$JiraSoftwareProjectImpl value,
          $Res Function(_$JiraSoftwareProjectImpl) then) =
      __$$JiraSoftwareProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'expand') String? expand,
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
      @JsonKey(name: 'uuid') String? uuid});

  @override
  $AvatarUrlsCopyWith<$Res>? get avatarUrls;
}

/// @nodoc
class __$$JiraSoftwareProjectImplCopyWithImpl<$Res>
    extends _$JiraSoftwareProjectCopyWithImpl<$Res, _$JiraSoftwareProjectImpl>
    implements _$$JiraSoftwareProjectImplCopyWith<$Res> {
  __$$JiraSoftwareProjectImplCopyWithImpl(_$JiraSoftwareProjectImpl _value,
      $Res Function(_$JiraSoftwareProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expand = freezed,
    Object? self = freezed,
    Object? id = freezed,
    Object? key = freezed,
    Object? name = freezed,
    Object? avatarUrls = freezed,
    Object? projectTypeKey = freezed,
    Object? simplified = freezed,
    Object? style = freezed,
    Object? isPrivate = freezed,
    Object? entityId = freezed,
    Object? uuid = freezed,
  }) {
    return _then(_$JiraSoftwareProjectImpl(
      expand: freezed == expand
          ? _value.expand
          : expand // ignore: cast_nullable_to_non_nullable
              as String?,
      self: freezed == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrls: freezed == avatarUrls
          ? _value.avatarUrls
          : avatarUrls // ignore: cast_nullable_to_non_nullable
              as AvatarUrls?,
      projectTypeKey: freezed == projectTypeKey
          ? _value.projectTypeKey
          : projectTypeKey // ignore: cast_nullable_to_non_nullable
              as String?,
      simplified: freezed == simplified
          ? _value.simplified
          : simplified // ignore: cast_nullable_to_non_nullable
              as bool?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JiraSoftwareProjectImpl
    with DiagnosticableTreeMixin
    implements _JiraSoftwareProject {
  const _$JiraSoftwareProjectImpl(
      {@JsonKey(name: 'expand') this.expand,
      @JsonKey(name: 'self') this.self,
      @JsonKey(name: 'id') this.id,
      @JsonKey(name: 'key') this.key,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'avatarUrls') this.avatarUrls,
      @JsonKey(name: 'projectTypeKey') this.projectTypeKey,
      @JsonKey(name: 'simplified') this.simplified,
      @JsonKey(name: 'style') this.style,
      @JsonKey(name: 'isPrivate') this.isPrivate,
      @JsonKey(name: 'entityId') this.entityId,
      @JsonKey(name: 'uuid') this.uuid});

  factory _$JiraSoftwareProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$JiraSoftwareProjectImplFromJson(json);

  @override
  @JsonKey(name: 'expand')
  final String? expand;
  @override
  @JsonKey(name: 'self')
  final String? self;
  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'key')
  final String? key;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'avatarUrls')
  final AvatarUrls? avatarUrls;
  @override
  @JsonKey(name: 'projectTypeKey')
  final String? projectTypeKey;
  @override
  @JsonKey(name: 'simplified')
  final bool? simplified;
  @override
  @JsonKey(name: 'style')
  final String? style;
  @override
  @JsonKey(name: 'isPrivate')
  final bool? isPrivate;
  @override
  @JsonKey(name: 'entityId')
  final String? entityId;
  @override
  @JsonKey(name: 'uuid')
  final String? uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'JiraSoftwareProject(expand: $expand, self: $self, id: $id, key: $key, name: $name, avatarUrls: $avatarUrls, projectTypeKey: $projectTypeKey, simplified: $simplified, style: $style, isPrivate: $isPrivate, entityId: $entityId, uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'JiraSoftwareProject'))
      ..add(DiagnosticsProperty('expand', expand))
      ..add(DiagnosticsProperty('self', self))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('avatarUrls', avatarUrls))
      ..add(DiagnosticsProperty('projectTypeKey', projectTypeKey))
      ..add(DiagnosticsProperty('simplified', simplified))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('isPrivate', isPrivate))
      ..add(DiagnosticsProperty('entityId', entityId))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JiraSoftwareProjectImpl &&
            (identical(other.expand, expand) || other.expand == expand) &&
            (identical(other.self, self) || other.self == self) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrls, avatarUrls) ||
                other.avatarUrls == avatarUrls) &&
            (identical(other.projectTypeKey, projectTypeKey) ||
                other.projectTypeKey == projectTypeKey) &&
            (identical(other.simplified, simplified) ||
                other.simplified == simplified) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, expand, self, id, key, name,
      avatarUrls, projectTypeKey, simplified, style, isPrivate, entityId, uuid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JiraSoftwareProjectImplCopyWith<_$JiraSoftwareProjectImpl> get copyWith =>
      __$$JiraSoftwareProjectImplCopyWithImpl<_$JiraSoftwareProjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JiraSoftwareProjectImplToJson(
      this,
    );
  }
}

abstract class _JiraSoftwareProject implements JiraSoftwareProject {
  const factory _JiraSoftwareProject(
      {@JsonKey(name: 'expand') final String? expand,
      @JsonKey(name: 'self') final String? self,
      @JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'key') final String? key,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'avatarUrls') final AvatarUrls? avatarUrls,
      @JsonKey(name: 'projectTypeKey') final String? projectTypeKey,
      @JsonKey(name: 'simplified') final bool? simplified,
      @JsonKey(name: 'style') final String? style,
      @JsonKey(name: 'isPrivate') final bool? isPrivate,
      @JsonKey(name: 'entityId') final String? entityId,
      @JsonKey(name: 'uuid') final String? uuid}) = _$JiraSoftwareProjectImpl;

  factory _JiraSoftwareProject.fromJson(Map<String, dynamic> json) =
      _$JiraSoftwareProjectImpl.fromJson;

  @override
  @JsonKey(name: 'expand')
  String? get expand;
  @override
  @JsonKey(name: 'self')
  String? get self;
  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'key')
  String? get key;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'avatarUrls')
  AvatarUrls? get avatarUrls;
  @override
  @JsonKey(name: 'projectTypeKey')
  String? get projectTypeKey;
  @override
  @JsonKey(name: 'simplified')
  bool? get simplified;
  @override
  @JsonKey(name: 'style')
  String? get style;
  @override
  @JsonKey(name: 'isPrivate')
  bool? get isPrivate;
  @override
  @JsonKey(name: 'entityId')
  String? get entityId;
  @override
  @JsonKey(name: 'uuid')
  String? get uuid;
  @override
  @JsonKey(ignore: true)
  _$$JiraSoftwareProjectImplCopyWith<_$JiraSoftwareProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AvatarUrls _$AvatarUrlsFromJson(Map<String, dynamic> json) {
  return _AvatarUrls.fromJson(json);
}

/// @nodoc
mixin _$AvatarUrls {
  @JsonKey(name: '48x48')
  String? get s48x48 => throw _privateConstructorUsedError;
  @JsonKey(name: '24x24')
  String? get s24x24 => throw _privateConstructorUsedError;
  @JsonKey(name: '16x16')
  String? get s16x16 => throw _privateConstructorUsedError;
  @JsonKey(name: '32x32')
  String? get s32x32 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvatarUrlsCopyWith<AvatarUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarUrlsCopyWith<$Res> {
  factory $AvatarUrlsCopyWith(
          AvatarUrls value, $Res Function(AvatarUrls) then) =
      _$AvatarUrlsCopyWithImpl<$Res, AvatarUrls>;
  @useResult
  $Res call(
      {@JsonKey(name: '48x48') String? s48x48,
      @JsonKey(name: '24x24') String? s24x24,
      @JsonKey(name: '16x16') String? s16x16,
      @JsonKey(name: '32x32') String? s32x32});
}

/// @nodoc
class _$AvatarUrlsCopyWithImpl<$Res, $Val extends AvatarUrls>
    implements $AvatarUrlsCopyWith<$Res> {
  _$AvatarUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? s48x48 = freezed,
    Object? s24x24 = freezed,
    Object? s16x16 = freezed,
    Object? s32x32 = freezed,
  }) {
    return _then(_value.copyWith(
      s48x48: freezed == s48x48
          ? _value.s48x48
          : s48x48 // ignore: cast_nullable_to_non_nullable
              as String?,
      s24x24: freezed == s24x24
          ? _value.s24x24
          : s24x24 // ignore: cast_nullable_to_non_nullable
              as String?,
      s16x16: freezed == s16x16
          ? _value.s16x16
          : s16x16 // ignore: cast_nullable_to_non_nullable
              as String?,
      s32x32: freezed == s32x32
          ? _value.s32x32
          : s32x32 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AvatarUrlsImplCopyWith<$Res>
    implements $AvatarUrlsCopyWith<$Res> {
  factory _$$AvatarUrlsImplCopyWith(
          _$AvatarUrlsImpl value, $Res Function(_$AvatarUrlsImpl) then) =
      __$$AvatarUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '48x48') String? s48x48,
      @JsonKey(name: '24x24') String? s24x24,
      @JsonKey(name: '16x16') String? s16x16,
      @JsonKey(name: '32x32') String? s32x32});
}

/// @nodoc
class __$$AvatarUrlsImplCopyWithImpl<$Res>
    extends _$AvatarUrlsCopyWithImpl<$Res, _$AvatarUrlsImpl>
    implements _$$AvatarUrlsImplCopyWith<$Res> {
  __$$AvatarUrlsImplCopyWithImpl(
      _$AvatarUrlsImpl _value, $Res Function(_$AvatarUrlsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? s48x48 = freezed,
    Object? s24x24 = freezed,
    Object? s16x16 = freezed,
    Object? s32x32 = freezed,
  }) {
    return _then(_$AvatarUrlsImpl(
      s48x48: freezed == s48x48
          ? _value.s48x48
          : s48x48 // ignore: cast_nullable_to_non_nullable
              as String?,
      s24x24: freezed == s24x24
          ? _value.s24x24
          : s24x24 // ignore: cast_nullable_to_non_nullable
              as String?,
      s16x16: freezed == s16x16
          ? _value.s16x16
          : s16x16 // ignore: cast_nullable_to_non_nullable
              as String?,
      s32x32: freezed == s32x32
          ? _value.s32x32
          : s32x32 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AvatarUrlsImpl with DiagnosticableTreeMixin implements _AvatarUrls {
  const _$AvatarUrlsImpl(
      {@JsonKey(name: '48x48') this.s48x48,
      @JsonKey(name: '24x24') this.s24x24,
      @JsonKey(name: '16x16') this.s16x16,
      @JsonKey(name: '32x32') this.s32x32});

  factory _$AvatarUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvatarUrlsImplFromJson(json);

  @override
  @JsonKey(name: '48x48')
  final String? s48x48;
  @override
  @JsonKey(name: '24x24')
  final String? s24x24;
  @override
  @JsonKey(name: '16x16')
  final String? s16x16;
  @override
  @JsonKey(name: '32x32')
  final String? s32x32;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AvatarUrls(s48x48: $s48x48, s24x24: $s24x24, s16x16: $s16x16, s32x32: $s32x32)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AvatarUrls'))
      ..add(DiagnosticsProperty('s48x48', s48x48))
      ..add(DiagnosticsProperty('s24x24', s24x24))
      ..add(DiagnosticsProperty('s16x16', s16x16))
      ..add(DiagnosticsProperty('s32x32', s32x32));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvatarUrlsImpl &&
            (identical(other.s48x48, s48x48) || other.s48x48 == s48x48) &&
            (identical(other.s24x24, s24x24) || other.s24x24 == s24x24) &&
            (identical(other.s16x16, s16x16) || other.s16x16 == s16x16) &&
            (identical(other.s32x32, s32x32) || other.s32x32 == s32x32));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, s48x48, s24x24, s16x16, s32x32);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AvatarUrlsImplCopyWith<_$AvatarUrlsImpl> get copyWith =>
      __$$AvatarUrlsImplCopyWithImpl<_$AvatarUrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvatarUrlsImplToJson(
      this,
    );
  }
}

abstract class _AvatarUrls implements AvatarUrls {
  const factory _AvatarUrls(
      {@JsonKey(name: '48x48') final String? s48x48,
      @JsonKey(name: '24x24') final String? s24x24,
      @JsonKey(name: '16x16') final String? s16x16,
      @JsonKey(name: '32x32') final String? s32x32}) = _$AvatarUrlsImpl;

  factory _AvatarUrls.fromJson(Map<String, dynamic> json) =
      _$AvatarUrlsImpl.fromJson;

  @override
  @JsonKey(name: '48x48')
  String? get s48x48;
  @override
  @JsonKey(name: '24x24')
  String? get s24x24;
  @override
  @JsonKey(name: '16x16')
  String? get s16x16;
  @override
  @JsonKey(name: '32x32')
  String? get s32x32;
  @override
  @JsonKey(ignore: true)
  _$$AvatarUrlsImplCopyWith<_$AvatarUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
