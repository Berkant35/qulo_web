// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'click_up_space.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClickUpSpace _$ClickUpSpaceFromJson(Map<String, dynamic> json) {
  return _ClickUpSpace.fromJson(json);
}

/// @nodoc
mixin _$ClickUpSpace {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'private')
  bool? get private => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar')
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_can_manage')
  bool? get adminCanManage => throw _privateConstructorUsedError;
  @JsonKey(name: 'statuses')
  List<Statuses>? get statuses => throw _privateConstructorUsedError;
  @JsonKey(name: 'multiple_assignees')
  bool? get multipleAssignees => throw _privateConstructorUsedError;
  @JsonKey(name: 'features')
  Features? get features => throw _privateConstructorUsedError;
  @JsonKey(name: 'archived')
  bool? get archived => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClickUpSpaceCopyWith<ClickUpSpace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpSpaceCopyWith<$Res> {
  factory $ClickUpSpaceCopyWith(
          ClickUpSpace value, $Res Function(ClickUpSpace) then) =
      _$ClickUpSpaceCopyWithImpl<$Res, ClickUpSpace>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'private') bool? private,
      @JsonKey(name: 'avatar') String? avatar,
      @JsonKey(name: 'admin_can_manage') bool? adminCanManage,
      @JsonKey(name: 'statuses') List<Statuses>? statuses,
      @JsonKey(name: 'multiple_assignees') bool? multipleAssignees,
      @JsonKey(name: 'features') Features? features,
      @JsonKey(name: 'archived') bool? archived});

  $FeaturesCopyWith<$Res>? get features;
}

/// @nodoc
class _$ClickUpSpaceCopyWithImpl<$Res, $Val extends ClickUpSpace>
    implements $ClickUpSpaceCopyWith<$Res> {
  _$ClickUpSpaceCopyWithImpl(this._value, this._then);

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
    Object? private = freezed,
    Object? avatar = freezed,
    Object? adminCanManage = freezed,
    Object? statuses = freezed,
    Object? multipleAssignees = freezed,
    Object? features = freezed,
    Object? archived = freezed,
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
      private: freezed == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      adminCanManage: freezed == adminCanManage
          ? _value.adminCanManage
          : adminCanManage // ignore: cast_nullable_to_non_nullable
              as bool?,
      statuses: freezed == statuses
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<Statuses>?,
      multipleAssignees: freezed == multipleAssignees
          ? _value.multipleAssignees
          : multipleAssignees // ignore: cast_nullable_to_non_nullable
              as bool?,
      features: freezed == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as Features?,
      archived: freezed == archived
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FeaturesCopyWith<$Res>? get features {
    if (_value.features == null) {
      return null;
    }

    return $FeaturesCopyWith<$Res>(_value.features!, (value) {
      return _then(_value.copyWith(features: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClickUpSpaceImplCopyWith<$Res>
    implements $ClickUpSpaceCopyWith<$Res> {
  factory _$$ClickUpSpaceImplCopyWith(
          _$ClickUpSpaceImpl value, $Res Function(_$ClickUpSpaceImpl) then) =
      __$$ClickUpSpaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'color') String? color,
      @JsonKey(name: 'private') bool? private,
      @JsonKey(name: 'avatar') String? avatar,
      @JsonKey(name: 'admin_can_manage') bool? adminCanManage,
      @JsonKey(name: 'statuses') List<Statuses>? statuses,
      @JsonKey(name: 'multiple_assignees') bool? multipleAssignees,
      @JsonKey(name: 'features') Features? features,
      @JsonKey(name: 'archived') bool? archived});

  @override
  $FeaturesCopyWith<$Res>? get features;
}

/// @nodoc
class __$$ClickUpSpaceImplCopyWithImpl<$Res>
    extends _$ClickUpSpaceCopyWithImpl<$Res, _$ClickUpSpaceImpl>
    implements _$$ClickUpSpaceImplCopyWith<$Res> {
  __$$ClickUpSpaceImplCopyWithImpl(
      _$ClickUpSpaceImpl _value, $Res Function(_$ClickUpSpaceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? color = freezed,
    Object? private = freezed,
    Object? avatar = freezed,
    Object? adminCanManage = freezed,
    Object? statuses = freezed,
    Object? multipleAssignees = freezed,
    Object? features = freezed,
    Object? archived = freezed,
  }) {
    return _then(_$ClickUpSpaceImpl(
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
      private: freezed == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      adminCanManage: freezed == adminCanManage
          ? _value.adminCanManage
          : adminCanManage // ignore: cast_nullable_to_non_nullable
              as bool?,
      statuses: freezed == statuses
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<Statuses>?,
      multipleAssignees: freezed == multipleAssignees
          ? _value.multipleAssignees
          : multipleAssignees // ignore: cast_nullable_to_non_nullable
              as bool?,
      features: freezed == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as Features?,
      archived: freezed == archived
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpSpaceImpl with DiagnosticableTreeMixin implements _ClickUpSpace {
  const _$ClickUpSpaceImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'color') this.color,
      @JsonKey(name: 'private') this.private,
      @JsonKey(name: 'avatar') this.avatar,
      @JsonKey(name: 'admin_can_manage') this.adminCanManage,
      @JsonKey(name: 'statuses') final List<Statuses>? statuses,
      @JsonKey(name: 'multiple_assignees') this.multipleAssignees,
      @JsonKey(name: 'features') this.features,
      @JsonKey(name: 'archived') this.archived})
      : _statuses = statuses;

  factory _$ClickUpSpaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClickUpSpaceImplFromJson(json);

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
  @JsonKey(name: 'private')
  final bool? private;
  @override
  @JsonKey(name: 'avatar')
  final String? avatar;
  @override
  @JsonKey(name: 'admin_can_manage')
  final bool? adminCanManage;
  final List<Statuses>? _statuses;
  @override
  @JsonKey(name: 'statuses')
  List<Statuses>? get statuses {
    final value = _statuses;
    if (value == null) return null;
    if (_statuses is EqualUnmodifiableListView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'multiple_assignees')
  final bool? multipleAssignees;
  @override
  @JsonKey(name: 'features')
  final Features? features;
  @override
  @JsonKey(name: 'archived')
  final bool? archived;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClickUpSpace(id: $id, name: $name, color: $color, private: $private, avatar: $avatar, adminCanManage: $adminCanManage, statuses: $statuses, multipleAssignees: $multipleAssignees, features: $features, archived: $archived)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClickUpSpace'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('private', private))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('adminCanManage', adminCanManage))
      ..add(DiagnosticsProperty('statuses', statuses))
      ..add(DiagnosticsProperty('multipleAssignees', multipleAssignees))
      ..add(DiagnosticsProperty('features', features))
      ..add(DiagnosticsProperty('archived', archived));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpSpaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.private, private) || other.private == private) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.adminCanManage, adminCanManage) ||
                other.adminCanManage == adminCanManage) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses) &&
            (identical(other.multipleAssignees, multipleAssignees) ||
                other.multipleAssignees == multipleAssignees) &&
            (identical(other.features, features) ||
                other.features == features) &&
            (identical(other.archived, archived) ||
                other.archived == archived));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      color,
      private,
      avatar,
      adminCanManage,
      const DeepCollectionEquality().hash(_statuses),
      multipleAssignees,
      features,
      archived);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpSpaceImplCopyWith<_$ClickUpSpaceImpl> get copyWith =>
      __$$ClickUpSpaceImplCopyWithImpl<_$ClickUpSpaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpSpaceImplToJson(
      this,
    );
  }
}

abstract class _ClickUpSpace implements ClickUpSpace {
  const factory _ClickUpSpace(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'color') final String? color,
      @JsonKey(name: 'private') final bool? private,
      @JsonKey(name: 'avatar') final String? avatar,
      @JsonKey(name: 'admin_can_manage') final bool? adminCanManage,
      @JsonKey(name: 'statuses') final List<Statuses>? statuses,
      @JsonKey(name: 'multiple_assignees') final bool? multipleAssignees,
      @JsonKey(name: 'features') final Features? features,
      @JsonKey(name: 'archived') final bool? archived}) = _$ClickUpSpaceImpl;

  factory _ClickUpSpace.fromJson(Map<String, dynamic> json) =
      _$ClickUpSpaceImpl.fromJson;

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
  @JsonKey(name: 'private')
  bool? get private;
  @override
  @JsonKey(name: 'avatar')
  String? get avatar;
  @override
  @JsonKey(name: 'admin_can_manage')
  bool? get adminCanManage;
  @override
  @JsonKey(name: 'statuses')
  List<Statuses>? get statuses;
  @override
  @JsonKey(name: 'multiple_assignees')
  bool? get multipleAssignees;
  @override
  @JsonKey(name: 'features')
  Features? get features;
  @override
  @JsonKey(name: 'archived')
  bool? get archived;
  @override
  @JsonKey(ignore: true)
  _$$ClickUpSpaceImplCopyWith<_$ClickUpSpaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Statuses _$StatusesFromJson(Map<String, dynamic> json) {
  return _Statuses.fromJson(json);
}

/// @nodoc
mixin _$Statuses {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderindex')
  int? get orderindex => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusesCopyWith<Statuses> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusesCopyWith<$Res> {
  factory $StatusesCopyWith(Statuses value, $Res Function(Statuses) then) =
      _$StatusesCopyWithImpl<$Res, Statuses>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'orderindex') int? orderindex,
      @JsonKey(name: 'color') String? color});
}

/// @nodoc
class _$StatusesCopyWithImpl<$Res, $Val extends Statuses>
    implements $StatusesCopyWith<$Res> {
  _$StatusesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? orderindex = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      orderindex: freezed == orderindex
          ? _value.orderindex
          : orderindex // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusesImplCopyWith<$Res>
    implements $StatusesCopyWith<$Res> {
  factory _$$StatusesImplCopyWith(
          _$StatusesImpl value, $Res Function(_$StatusesImpl) then) =
      __$$StatusesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'orderindex') int? orderindex,
      @JsonKey(name: 'color') String? color});
}

/// @nodoc
class __$$StatusesImplCopyWithImpl<$Res>
    extends _$StatusesCopyWithImpl<$Res, _$StatusesImpl>
    implements _$$StatusesImplCopyWith<$Res> {
  __$$StatusesImplCopyWithImpl(
      _$StatusesImpl _value, $Res Function(_$StatusesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? orderindex = freezed,
    Object? color = freezed,
  }) {
    return _then(_$StatusesImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      orderindex: freezed == orderindex
          ? _value.orderindex
          : orderindex // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusesImpl with DiagnosticableTreeMixin implements _Statuses {
  const _$StatusesImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'orderindex') this.orderindex,
      @JsonKey(name: 'color') this.color});

  factory _$StatusesImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusesImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'status')
  final String? status;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'orderindex')
  final int? orderindex;
  @override
  @JsonKey(name: 'color')
  final String? color;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Statuses(id: $id, status: $status, type: $type, orderindex: $orderindex, color: $color)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Statuses'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('orderindex', orderindex))
      ..add(DiagnosticsProperty('color', color));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.orderindex, orderindex) ||
                other.orderindex == orderindex) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, type, orderindex, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusesImplCopyWith<_$StatusesImpl> get copyWith =>
      __$$StatusesImplCopyWithImpl<_$StatusesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusesImplToJson(
      this,
    );
  }
}

abstract class _Statuses implements Statuses {
  const factory _Statuses(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'status') final String? status,
      @JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'orderindex') final int? orderindex,
      @JsonKey(name: 'color') final String? color}) = _$StatusesImpl;

  factory _Statuses.fromJson(Map<String, dynamic> json) =
      _$StatusesImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'status')
  String? get status;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'orderindex')
  int? get orderindex;
  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$StatusesImplCopyWith<_$StatusesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Features _$FeaturesFromJson(Map<String, dynamic> json) {
  return _Features.fromJson(json);
}

/// @nodoc
mixin _$Features {
  @JsonKey(name: 'due_dates')
  DueDates? get dueDates => throw _privateConstructorUsedError;
  @JsonKey(name: 'sprints')
  Sprints? get sprints => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_tracking')
  TimeTracking? get timeTracking => throw _privateConstructorUsedError;
  @JsonKey(name: 'points')
  Points? get points => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_items')
  CustomItems? get customItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'priorities')
  Priorities? get priorities => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  Tags? get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'check_unresolved')
  CheckUnresolved? get checkUnresolved => throw _privateConstructorUsedError;
  @JsonKey(name: 'zoom')
  Zoom? get zoom => throw _privateConstructorUsedError;
  @JsonKey(name: 'milestones')
  Milestones? get milestones => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_fields')
  CustomFields? get customFields => throw _privateConstructorUsedError;
  @JsonKey(name: 'dependency_warning')
  DependencyWarning? get dependencyWarning =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'status_pies')
  StatusPies? get statusPies => throw _privateConstructorUsedError;
  @JsonKey(name: 'multiple_assignees')
  MultipleAssignees? get multipleAssignees =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'emails')
  Emails? get emails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeaturesCopyWith<Features> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturesCopyWith<$Res> {
  factory $FeaturesCopyWith(Features value, $Res Function(Features) then) =
      _$FeaturesCopyWithImpl<$Res, Features>;
  @useResult
  $Res call(
      {@JsonKey(name: 'due_dates') DueDates? dueDates,
      @JsonKey(name: 'sprints') Sprints? sprints,
      @JsonKey(name: 'time_tracking') TimeTracking? timeTracking,
      @JsonKey(name: 'points') Points? points,
      @JsonKey(name: 'custom_items') CustomItems? customItems,
      @JsonKey(name: 'priorities') Priorities? priorities,
      @JsonKey(name: 'tags') Tags? tags,
      @JsonKey(name: 'check_unresolved') CheckUnresolved? checkUnresolved,
      @JsonKey(name: 'zoom') Zoom? zoom,
      @JsonKey(name: 'milestones') Milestones? milestones,
      @JsonKey(name: 'custom_fields') CustomFields? customFields,
      @JsonKey(name: 'dependency_warning') DependencyWarning? dependencyWarning,
      @JsonKey(name: 'status_pies') StatusPies? statusPies,
      @JsonKey(name: 'multiple_assignees') MultipleAssignees? multipleAssignees,
      @JsonKey(name: 'emails') Emails? emails});

  $DueDatesCopyWith<$Res>? get dueDates;
  $SprintsCopyWith<$Res>? get sprints;
  $TimeTrackingCopyWith<$Res>? get timeTracking;
  $PointsCopyWith<$Res>? get points;
  $CustomItemsCopyWith<$Res>? get customItems;
  $PrioritiesCopyWith<$Res>? get priorities;
  $TagsCopyWith<$Res>? get tags;
  $CheckUnresolvedCopyWith<$Res>? get checkUnresolved;
  $ZoomCopyWith<$Res>? get zoom;
  $MilestonesCopyWith<$Res>? get milestones;
  $CustomFieldsCopyWith<$Res>? get customFields;
  $DependencyWarningCopyWith<$Res>? get dependencyWarning;
  $StatusPiesCopyWith<$Res>? get statusPies;
  $MultipleAssigneesCopyWith<$Res>? get multipleAssignees;
  $EmailsCopyWith<$Res>? get emails;
}

/// @nodoc
class _$FeaturesCopyWithImpl<$Res, $Val extends Features>
    implements $FeaturesCopyWith<$Res> {
  _$FeaturesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dueDates = freezed,
    Object? sprints = freezed,
    Object? timeTracking = freezed,
    Object? points = freezed,
    Object? customItems = freezed,
    Object? priorities = freezed,
    Object? tags = freezed,
    Object? checkUnresolved = freezed,
    Object? zoom = freezed,
    Object? milestones = freezed,
    Object? customFields = freezed,
    Object? dependencyWarning = freezed,
    Object? statusPies = freezed,
    Object? multipleAssignees = freezed,
    Object? emails = freezed,
  }) {
    return _then(_value.copyWith(
      dueDates: freezed == dueDates
          ? _value.dueDates
          : dueDates // ignore: cast_nullable_to_non_nullable
              as DueDates?,
      sprints: freezed == sprints
          ? _value.sprints
          : sprints // ignore: cast_nullable_to_non_nullable
              as Sprints?,
      timeTracking: freezed == timeTracking
          ? _value.timeTracking
          : timeTracking // ignore: cast_nullable_to_non_nullable
              as TimeTracking?,
      points: freezed == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as Points?,
      customItems: freezed == customItems
          ? _value.customItems
          : customItems // ignore: cast_nullable_to_non_nullable
              as CustomItems?,
      priorities: freezed == priorities
          ? _value.priorities
          : priorities // ignore: cast_nullable_to_non_nullable
              as Priorities?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Tags?,
      checkUnresolved: freezed == checkUnresolved
          ? _value.checkUnresolved
          : checkUnresolved // ignore: cast_nullable_to_non_nullable
              as CheckUnresolved?,
      zoom: freezed == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as Zoom?,
      milestones: freezed == milestones
          ? _value.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as Milestones?,
      customFields: freezed == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as CustomFields?,
      dependencyWarning: freezed == dependencyWarning
          ? _value.dependencyWarning
          : dependencyWarning // ignore: cast_nullable_to_non_nullable
              as DependencyWarning?,
      statusPies: freezed == statusPies
          ? _value.statusPies
          : statusPies // ignore: cast_nullable_to_non_nullable
              as StatusPies?,
      multipleAssignees: freezed == multipleAssignees
          ? _value.multipleAssignees
          : multipleAssignees // ignore: cast_nullable_to_non_nullable
              as MultipleAssignees?,
      emails: freezed == emails
          ? _value.emails
          : emails // ignore: cast_nullable_to_non_nullable
              as Emails?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DueDatesCopyWith<$Res>? get dueDates {
    if (_value.dueDates == null) {
      return null;
    }

    return $DueDatesCopyWith<$Res>(_value.dueDates!, (value) {
      return _then(_value.copyWith(dueDates: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SprintsCopyWith<$Res>? get sprints {
    if (_value.sprints == null) {
      return null;
    }

    return $SprintsCopyWith<$Res>(_value.sprints!, (value) {
      return _then(_value.copyWith(sprints: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TimeTrackingCopyWith<$Res>? get timeTracking {
    if (_value.timeTracking == null) {
      return null;
    }

    return $TimeTrackingCopyWith<$Res>(_value.timeTracking!, (value) {
      return _then(_value.copyWith(timeTracking: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PointsCopyWith<$Res>? get points {
    if (_value.points == null) {
      return null;
    }

    return $PointsCopyWith<$Res>(_value.points!, (value) {
      return _then(_value.copyWith(points: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomItemsCopyWith<$Res>? get customItems {
    if (_value.customItems == null) {
      return null;
    }

    return $CustomItemsCopyWith<$Res>(_value.customItems!, (value) {
      return _then(_value.copyWith(customItems: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PrioritiesCopyWith<$Res>? get priorities {
    if (_value.priorities == null) {
      return null;
    }

    return $PrioritiesCopyWith<$Res>(_value.priorities!, (value) {
      return _then(_value.copyWith(priorities: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TagsCopyWith<$Res>? get tags {
    if (_value.tags == null) {
      return null;
    }

    return $TagsCopyWith<$Res>(_value.tags!, (value) {
      return _then(_value.copyWith(tags: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CheckUnresolvedCopyWith<$Res>? get checkUnresolved {
    if (_value.checkUnresolved == null) {
      return null;
    }

    return $CheckUnresolvedCopyWith<$Res>(_value.checkUnresolved!, (value) {
      return _then(_value.copyWith(checkUnresolved: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ZoomCopyWith<$Res>? get zoom {
    if (_value.zoom == null) {
      return null;
    }

    return $ZoomCopyWith<$Res>(_value.zoom!, (value) {
      return _then(_value.copyWith(zoom: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MilestonesCopyWith<$Res>? get milestones {
    if (_value.milestones == null) {
      return null;
    }

    return $MilestonesCopyWith<$Res>(_value.milestones!, (value) {
      return _then(_value.copyWith(milestones: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomFieldsCopyWith<$Res>? get customFields {
    if (_value.customFields == null) {
      return null;
    }

    return $CustomFieldsCopyWith<$Res>(_value.customFields!, (value) {
      return _then(_value.copyWith(customFields: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DependencyWarningCopyWith<$Res>? get dependencyWarning {
    if (_value.dependencyWarning == null) {
      return null;
    }

    return $DependencyWarningCopyWith<$Res>(_value.dependencyWarning!, (value) {
      return _then(_value.copyWith(dependencyWarning: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusPiesCopyWith<$Res>? get statusPies {
    if (_value.statusPies == null) {
      return null;
    }

    return $StatusPiesCopyWith<$Res>(_value.statusPies!, (value) {
      return _then(_value.copyWith(statusPies: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MultipleAssigneesCopyWith<$Res>? get multipleAssignees {
    if (_value.multipleAssignees == null) {
      return null;
    }

    return $MultipleAssigneesCopyWith<$Res>(_value.multipleAssignees!, (value) {
      return _then(_value.copyWith(multipleAssignees: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EmailsCopyWith<$Res>? get emails {
    if (_value.emails == null) {
      return null;
    }

    return $EmailsCopyWith<$Res>(_value.emails!, (value) {
      return _then(_value.copyWith(emails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeaturesImplCopyWith<$Res>
    implements $FeaturesCopyWith<$Res> {
  factory _$$FeaturesImplCopyWith(
          _$FeaturesImpl value, $Res Function(_$FeaturesImpl) then) =
      __$$FeaturesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'due_dates') DueDates? dueDates,
      @JsonKey(name: 'sprints') Sprints? sprints,
      @JsonKey(name: 'time_tracking') TimeTracking? timeTracking,
      @JsonKey(name: 'points') Points? points,
      @JsonKey(name: 'custom_items') CustomItems? customItems,
      @JsonKey(name: 'priorities') Priorities? priorities,
      @JsonKey(name: 'tags') Tags? tags,
      @JsonKey(name: 'check_unresolved') CheckUnresolved? checkUnresolved,
      @JsonKey(name: 'zoom') Zoom? zoom,
      @JsonKey(name: 'milestones') Milestones? milestones,
      @JsonKey(name: 'custom_fields') CustomFields? customFields,
      @JsonKey(name: 'dependency_warning') DependencyWarning? dependencyWarning,
      @JsonKey(name: 'status_pies') StatusPies? statusPies,
      @JsonKey(name: 'multiple_assignees') MultipleAssignees? multipleAssignees,
      @JsonKey(name: 'emails') Emails? emails});

  @override
  $DueDatesCopyWith<$Res>? get dueDates;
  @override
  $SprintsCopyWith<$Res>? get sprints;
  @override
  $TimeTrackingCopyWith<$Res>? get timeTracking;
  @override
  $PointsCopyWith<$Res>? get points;
  @override
  $CustomItemsCopyWith<$Res>? get customItems;
  @override
  $PrioritiesCopyWith<$Res>? get priorities;
  @override
  $TagsCopyWith<$Res>? get tags;
  @override
  $CheckUnresolvedCopyWith<$Res>? get checkUnresolved;
  @override
  $ZoomCopyWith<$Res>? get zoom;
  @override
  $MilestonesCopyWith<$Res>? get milestones;
  @override
  $CustomFieldsCopyWith<$Res>? get customFields;
  @override
  $DependencyWarningCopyWith<$Res>? get dependencyWarning;
  @override
  $StatusPiesCopyWith<$Res>? get statusPies;
  @override
  $MultipleAssigneesCopyWith<$Res>? get multipleAssignees;
  @override
  $EmailsCopyWith<$Res>? get emails;
}

/// @nodoc
class __$$FeaturesImplCopyWithImpl<$Res>
    extends _$FeaturesCopyWithImpl<$Res, _$FeaturesImpl>
    implements _$$FeaturesImplCopyWith<$Res> {
  __$$FeaturesImplCopyWithImpl(
      _$FeaturesImpl _value, $Res Function(_$FeaturesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dueDates = freezed,
    Object? sprints = freezed,
    Object? timeTracking = freezed,
    Object? points = freezed,
    Object? customItems = freezed,
    Object? priorities = freezed,
    Object? tags = freezed,
    Object? checkUnresolved = freezed,
    Object? zoom = freezed,
    Object? milestones = freezed,
    Object? customFields = freezed,
    Object? dependencyWarning = freezed,
    Object? statusPies = freezed,
    Object? multipleAssignees = freezed,
    Object? emails = freezed,
  }) {
    return _then(_$FeaturesImpl(
      dueDates: freezed == dueDates
          ? _value.dueDates
          : dueDates // ignore: cast_nullable_to_non_nullable
              as DueDates?,
      sprints: freezed == sprints
          ? _value.sprints
          : sprints // ignore: cast_nullable_to_non_nullable
              as Sprints?,
      timeTracking: freezed == timeTracking
          ? _value.timeTracking
          : timeTracking // ignore: cast_nullable_to_non_nullable
              as TimeTracking?,
      points: freezed == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as Points?,
      customItems: freezed == customItems
          ? _value.customItems
          : customItems // ignore: cast_nullable_to_non_nullable
              as CustomItems?,
      priorities: freezed == priorities
          ? _value.priorities
          : priorities // ignore: cast_nullable_to_non_nullable
              as Priorities?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Tags?,
      checkUnresolved: freezed == checkUnresolved
          ? _value.checkUnresolved
          : checkUnresolved // ignore: cast_nullable_to_non_nullable
              as CheckUnresolved?,
      zoom: freezed == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as Zoom?,
      milestones: freezed == milestones
          ? _value.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as Milestones?,
      customFields: freezed == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as CustomFields?,
      dependencyWarning: freezed == dependencyWarning
          ? _value.dependencyWarning
          : dependencyWarning // ignore: cast_nullable_to_non_nullable
              as DependencyWarning?,
      statusPies: freezed == statusPies
          ? _value.statusPies
          : statusPies // ignore: cast_nullable_to_non_nullable
              as StatusPies?,
      multipleAssignees: freezed == multipleAssignees
          ? _value.multipleAssignees
          : multipleAssignees // ignore: cast_nullable_to_non_nullable
              as MultipleAssignees?,
      emails: freezed == emails
          ? _value.emails
          : emails // ignore: cast_nullable_to_non_nullable
              as Emails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturesImpl with DiagnosticableTreeMixin implements _Features {
  const _$FeaturesImpl(
      {@JsonKey(name: 'due_dates') this.dueDates,
      @JsonKey(name: 'sprints') this.sprints,
      @JsonKey(name: 'time_tracking') this.timeTracking,
      @JsonKey(name: 'points') this.points,
      @JsonKey(name: 'custom_items') this.customItems,
      @JsonKey(name: 'priorities') this.priorities,
      @JsonKey(name: 'tags') this.tags,
      @JsonKey(name: 'check_unresolved') this.checkUnresolved,
      @JsonKey(name: 'zoom') this.zoom,
      @JsonKey(name: 'milestones') this.milestones,
      @JsonKey(name: 'custom_fields') this.customFields,
      @JsonKey(name: 'dependency_warning') this.dependencyWarning,
      @JsonKey(name: 'status_pies') this.statusPies,
      @JsonKey(name: 'multiple_assignees') this.multipleAssignees,
      @JsonKey(name: 'emails') this.emails});

  factory _$FeaturesImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturesImplFromJson(json);

  @override
  @JsonKey(name: 'due_dates')
  final DueDates? dueDates;
  @override
  @JsonKey(name: 'sprints')
  final Sprints? sprints;
  @override
  @JsonKey(name: 'time_tracking')
  final TimeTracking? timeTracking;
  @override
  @JsonKey(name: 'points')
  final Points? points;
  @override
  @JsonKey(name: 'custom_items')
  final CustomItems? customItems;
  @override
  @JsonKey(name: 'priorities')
  final Priorities? priorities;
  @override
  @JsonKey(name: 'tags')
  final Tags? tags;
  @override
  @JsonKey(name: 'check_unresolved')
  final CheckUnresolved? checkUnresolved;
  @override
  @JsonKey(name: 'zoom')
  final Zoom? zoom;
  @override
  @JsonKey(name: 'milestones')
  final Milestones? milestones;
  @override
  @JsonKey(name: 'custom_fields')
  final CustomFields? customFields;
  @override
  @JsonKey(name: 'dependency_warning')
  final DependencyWarning? dependencyWarning;
  @override
  @JsonKey(name: 'status_pies')
  final StatusPies? statusPies;
  @override
  @JsonKey(name: 'multiple_assignees')
  final MultipleAssignees? multipleAssignees;
  @override
  @JsonKey(name: 'emails')
  final Emails? emails;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Features(dueDates: $dueDates, sprints: $sprints, timeTracking: $timeTracking, points: $points, customItems: $customItems, priorities: $priorities, tags: $tags, checkUnresolved: $checkUnresolved, zoom: $zoom, milestones: $milestones, customFields: $customFields, dependencyWarning: $dependencyWarning, statusPies: $statusPies, multipleAssignees: $multipleAssignees, emails: $emails)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Features'))
      ..add(DiagnosticsProperty('dueDates', dueDates))
      ..add(DiagnosticsProperty('sprints', sprints))
      ..add(DiagnosticsProperty('timeTracking', timeTracking))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('customItems', customItems))
      ..add(DiagnosticsProperty('priorities', priorities))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('checkUnresolved', checkUnresolved))
      ..add(DiagnosticsProperty('zoom', zoom))
      ..add(DiagnosticsProperty('milestones', milestones))
      ..add(DiagnosticsProperty('customFields', customFields))
      ..add(DiagnosticsProperty('dependencyWarning', dependencyWarning))
      ..add(DiagnosticsProperty('statusPies', statusPies))
      ..add(DiagnosticsProperty('multipleAssignees', multipleAssignees))
      ..add(DiagnosticsProperty('emails', emails));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturesImpl &&
            (identical(other.dueDates, dueDates) ||
                other.dueDates == dueDates) &&
            (identical(other.sprints, sprints) || other.sprints == sprints) &&
            (identical(other.timeTracking, timeTracking) ||
                other.timeTracking == timeTracking) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.customItems, customItems) ||
                other.customItems == customItems) &&
            (identical(other.priorities, priorities) ||
                other.priorities == priorities) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.checkUnresolved, checkUnresolved) ||
                other.checkUnresolved == checkUnresolved) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.milestones, milestones) ||
                other.milestones == milestones) &&
            (identical(other.customFields, customFields) ||
                other.customFields == customFields) &&
            (identical(other.dependencyWarning, dependencyWarning) ||
                other.dependencyWarning == dependencyWarning) &&
            (identical(other.statusPies, statusPies) ||
                other.statusPies == statusPies) &&
            (identical(other.multipleAssignees, multipleAssignees) ||
                other.multipleAssignees == multipleAssignees) &&
            (identical(other.emails, emails) || other.emails == emails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dueDates,
      sprints,
      timeTracking,
      points,
      customItems,
      priorities,
      tags,
      checkUnresolved,
      zoom,
      milestones,
      customFields,
      dependencyWarning,
      statusPies,
      multipleAssignees,
      emails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturesImplCopyWith<_$FeaturesImpl> get copyWith =>
      __$$FeaturesImplCopyWithImpl<_$FeaturesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturesImplToJson(
      this,
    );
  }
}

abstract class _Features implements Features {
  const factory _Features(
      {@JsonKey(name: 'due_dates') final DueDates? dueDates,
      @JsonKey(name: 'sprints') final Sprints? sprints,
      @JsonKey(name: 'time_tracking') final TimeTracking? timeTracking,
      @JsonKey(name: 'points') final Points? points,
      @JsonKey(name: 'custom_items') final CustomItems? customItems,
      @JsonKey(name: 'priorities') final Priorities? priorities,
      @JsonKey(name: 'tags') final Tags? tags,
      @JsonKey(name: 'check_unresolved') final CheckUnresolved? checkUnresolved,
      @JsonKey(name: 'zoom') final Zoom? zoom,
      @JsonKey(name: 'milestones') final Milestones? milestones,
      @JsonKey(name: 'custom_fields') final CustomFields? customFields,
      @JsonKey(name: 'dependency_warning')
      final DependencyWarning? dependencyWarning,
      @JsonKey(name: 'status_pies') final StatusPies? statusPies,
      @JsonKey(name: 'multiple_assignees')
      final MultipleAssignees? multipleAssignees,
      @JsonKey(name: 'emails') final Emails? emails}) = _$FeaturesImpl;

  factory _Features.fromJson(Map<String, dynamic> json) =
      _$FeaturesImpl.fromJson;

  @override
  @JsonKey(name: 'due_dates')
  DueDates? get dueDates;
  @override
  @JsonKey(name: 'sprints')
  Sprints? get sprints;
  @override
  @JsonKey(name: 'time_tracking')
  TimeTracking? get timeTracking;
  @override
  @JsonKey(name: 'points')
  Points? get points;
  @override
  @JsonKey(name: 'custom_items')
  CustomItems? get customItems;
  @override
  @JsonKey(name: 'priorities')
  Priorities? get priorities;
  @override
  @JsonKey(name: 'tags')
  Tags? get tags;
  @override
  @JsonKey(name: 'check_unresolved')
  CheckUnresolved? get checkUnresolved;
  @override
  @JsonKey(name: 'zoom')
  Zoom? get zoom;
  @override
  @JsonKey(name: 'milestones')
  Milestones? get milestones;
  @override
  @JsonKey(name: 'custom_fields')
  CustomFields? get customFields;
  @override
  @JsonKey(name: 'dependency_warning')
  DependencyWarning? get dependencyWarning;
  @override
  @JsonKey(name: 'status_pies')
  StatusPies? get statusPies;
  @override
  @JsonKey(name: 'multiple_assignees')
  MultipleAssignees? get multipleAssignees;
  @override
  @JsonKey(name: 'emails')
  Emails? get emails;
  @override
  @JsonKey(ignore: true)
  _$$FeaturesImplCopyWith<_$FeaturesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DueDates _$DueDatesFromJson(Map<String, dynamic> json) {
  return _DueDates.fromJson(json);
}

/// @nodoc
mixin _$DueDates {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  bool? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'remap_due_dates')
  bool? get remapDueDates => throw _privateConstructorUsedError;
  @JsonKey(name: 'remap_closed_due_date')
  bool? get remapClosedDueDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DueDatesCopyWith<DueDates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DueDatesCopyWith<$Res> {
  factory $DueDatesCopyWith(DueDates value, $Res Function(DueDates) then) =
      _$DueDatesCopyWithImpl<$Res, DueDates>;
  @useResult
  $Res call(
      {@JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(name: 'start_date') bool? startDate,
      @JsonKey(name: 'remap_due_dates') bool? remapDueDates,
      @JsonKey(name: 'remap_closed_due_date') bool? remapClosedDueDate});
}

/// @nodoc
class _$DueDatesCopyWithImpl<$Res, $Val extends DueDates>
    implements $DueDatesCopyWith<$Res> {
  _$DueDatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? startDate = freezed,
    Object? remapDueDates = freezed,
    Object? remapClosedDueDate = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as bool?,
      remapDueDates: freezed == remapDueDates
          ? _value.remapDueDates
          : remapDueDates // ignore: cast_nullable_to_non_nullable
              as bool?,
      remapClosedDueDate: freezed == remapClosedDueDate
          ? _value.remapClosedDueDate
          : remapClosedDueDate // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DueDatesImplCopyWith<$Res>
    implements $DueDatesCopyWith<$Res> {
  factory _$$DueDatesImplCopyWith(
          _$DueDatesImpl value, $Res Function(_$DueDatesImpl) then) =
      __$$DueDatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(name: 'start_date') bool? startDate,
      @JsonKey(name: 'remap_due_dates') bool? remapDueDates,
      @JsonKey(name: 'remap_closed_due_date') bool? remapClosedDueDate});
}

/// @nodoc
class __$$DueDatesImplCopyWithImpl<$Res>
    extends _$DueDatesCopyWithImpl<$Res, _$DueDatesImpl>
    implements _$$DueDatesImplCopyWith<$Res> {
  __$$DueDatesImplCopyWithImpl(
      _$DueDatesImpl _value, $Res Function(_$DueDatesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? startDate = freezed,
    Object? remapDueDates = freezed,
    Object? remapClosedDueDate = freezed,
  }) {
    return _then(_$DueDatesImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as bool?,
      remapDueDates: freezed == remapDueDates
          ? _value.remapDueDates
          : remapDueDates // ignore: cast_nullable_to_non_nullable
              as bool?,
      remapClosedDueDate: freezed == remapClosedDueDate
          ? _value.remapClosedDueDate
          : remapClosedDueDate // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DueDatesImpl with DiagnosticableTreeMixin implements _DueDates {
  const _$DueDatesImpl(
      {@JsonKey(name: 'enabled') this.enabled,
      @JsonKey(name: 'start_date') this.startDate,
      @JsonKey(name: 'remap_due_dates') this.remapDueDates,
      @JsonKey(name: 'remap_closed_due_date') this.remapClosedDueDate});

  factory _$DueDatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$DueDatesImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @override
  @JsonKey(name: 'start_date')
  final bool? startDate;
  @override
  @JsonKey(name: 'remap_due_dates')
  final bool? remapDueDates;
  @override
  @JsonKey(name: 'remap_closed_due_date')
  final bool? remapClosedDueDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DueDates(enabled: $enabled, startDate: $startDate, remapDueDates: $remapDueDates, remapClosedDueDate: $remapClosedDueDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DueDates'))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('remapDueDates', remapDueDates))
      ..add(DiagnosticsProperty('remapClosedDueDate', remapClosedDueDate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DueDatesImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.remapDueDates, remapDueDates) ||
                other.remapDueDates == remapDueDates) &&
            (identical(other.remapClosedDueDate, remapClosedDueDate) ||
                other.remapClosedDueDate == remapClosedDueDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, enabled, startDate, remapDueDates, remapClosedDueDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DueDatesImplCopyWith<_$DueDatesImpl> get copyWith =>
      __$$DueDatesImplCopyWithImpl<_$DueDatesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DueDatesImplToJson(
      this,
    );
  }
}

abstract class _DueDates implements DueDates {
  const factory _DueDates(
      {@JsonKey(name: 'enabled') final bool? enabled,
      @JsonKey(name: 'start_date') final bool? startDate,
      @JsonKey(name: 'remap_due_dates') final bool? remapDueDates,
      @JsonKey(name: 'remap_closed_due_date')
      final bool? remapClosedDueDate}) = _$DueDatesImpl;

  factory _DueDates.fromJson(Map<String, dynamic> json) =
      _$DueDatesImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(name: 'start_date')
  bool? get startDate;
  @override
  @JsonKey(name: 'remap_due_dates')
  bool? get remapDueDates;
  @override
  @JsonKey(name: 'remap_closed_due_date')
  bool? get remapClosedDueDate;
  @override
  @JsonKey(ignore: true)
  _$$DueDatesImplCopyWith<_$DueDatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Sprints _$SprintsFromJson(Map<String, dynamic> json) {
  return _Sprints.fromJson(json);
}

/// @nodoc
mixin _$Sprints {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SprintsCopyWith<Sprints> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SprintsCopyWith<$Res> {
  factory $SprintsCopyWith(Sprints value, $Res Function(Sprints) then) =
      _$SprintsCopyWithImpl<$Res, Sprints>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$SprintsCopyWithImpl<$Res, $Val extends Sprints>
    implements $SprintsCopyWith<$Res> {
  _$SprintsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SprintsImplCopyWith<$Res> implements $SprintsCopyWith<$Res> {
  factory _$$SprintsImplCopyWith(
          _$SprintsImpl value, $Res Function(_$SprintsImpl) then) =
      __$$SprintsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$SprintsImplCopyWithImpl<$Res>
    extends _$SprintsCopyWithImpl<$Res, _$SprintsImpl>
    implements _$$SprintsImplCopyWith<$Res> {
  __$$SprintsImplCopyWithImpl(
      _$SprintsImpl _value, $Res Function(_$SprintsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$SprintsImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SprintsImpl with DiagnosticableTreeMixin implements _Sprints {
  const _$SprintsImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$SprintsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SprintsImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Sprints(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Sprints'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SprintsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SprintsImplCopyWith<_$SprintsImpl> get copyWith =>
      __$$SprintsImplCopyWithImpl<_$SprintsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SprintsImplToJson(
      this,
    );
  }
}

abstract class _Sprints implements Sprints {
  const factory _Sprints({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$SprintsImpl;

  factory _Sprints.fromJson(Map<String, dynamic> json) = _$SprintsImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$SprintsImplCopyWith<_$SprintsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeTracking _$TimeTrackingFromJson(Map<String, dynamic> json) {
  return _TimeTracking.fromJson(json);
}

/// @nodoc
mixin _$TimeTracking {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'harvest')
  bool? get harvest => throw _privateConstructorUsedError;
  @JsonKey(name: 'rollup')
  bool? get rollup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeTrackingCopyWith<TimeTracking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeTrackingCopyWith<$Res> {
  factory $TimeTrackingCopyWith(
          TimeTracking value, $Res Function(TimeTracking) then) =
      _$TimeTrackingCopyWithImpl<$Res, TimeTracking>;
  @useResult
  $Res call(
      {@JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(name: 'harvest') bool? harvest,
      @JsonKey(name: 'rollup') bool? rollup});
}

/// @nodoc
class _$TimeTrackingCopyWithImpl<$Res, $Val extends TimeTracking>
    implements $TimeTrackingCopyWith<$Res> {
  _$TimeTrackingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? harvest = freezed,
    Object? rollup = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      harvest: freezed == harvest
          ? _value.harvest
          : harvest // ignore: cast_nullable_to_non_nullable
              as bool?,
      rollup: freezed == rollup
          ? _value.rollup
          : rollup // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeTrackingImplCopyWith<$Res>
    implements $TimeTrackingCopyWith<$Res> {
  factory _$$TimeTrackingImplCopyWith(
          _$TimeTrackingImpl value, $Res Function(_$TimeTrackingImpl) then) =
      __$$TimeTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(name: 'harvest') bool? harvest,
      @JsonKey(name: 'rollup') bool? rollup});
}

/// @nodoc
class __$$TimeTrackingImplCopyWithImpl<$Res>
    extends _$TimeTrackingCopyWithImpl<$Res, _$TimeTrackingImpl>
    implements _$$TimeTrackingImplCopyWith<$Res> {
  __$$TimeTrackingImplCopyWithImpl(
      _$TimeTrackingImpl _value, $Res Function(_$TimeTrackingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? harvest = freezed,
    Object? rollup = freezed,
  }) {
    return _then(_$TimeTrackingImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      harvest: freezed == harvest
          ? _value.harvest
          : harvest // ignore: cast_nullable_to_non_nullable
              as bool?,
      rollup: freezed == rollup
          ? _value.rollup
          : rollup // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeTrackingImpl with DiagnosticableTreeMixin implements _TimeTracking {
  const _$TimeTrackingImpl(
      {@JsonKey(name: 'enabled') this.enabled,
      @JsonKey(name: 'harvest') this.harvest,
      @JsonKey(name: 'rollup') this.rollup});

  factory _$TimeTrackingImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeTrackingImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @override
  @JsonKey(name: 'harvest')
  final bool? harvest;
  @override
  @JsonKey(name: 'rollup')
  final bool? rollup;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimeTracking(enabled: $enabled, harvest: $harvest, rollup: $rollup)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimeTracking'))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('harvest', harvest))
      ..add(DiagnosticsProperty('rollup', rollup));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeTrackingImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.harvest, harvest) || other.harvest == harvest) &&
            (identical(other.rollup, rollup) || other.rollup == rollup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, harvest, rollup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeTrackingImplCopyWith<_$TimeTrackingImpl> get copyWith =>
      __$$TimeTrackingImplCopyWithImpl<_$TimeTrackingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeTrackingImplToJson(
      this,
    );
  }
}

abstract class _TimeTracking implements TimeTracking {
  const factory _TimeTracking(
      {@JsonKey(name: 'enabled') final bool? enabled,
      @JsonKey(name: 'harvest') final bool? harvest,
      @JsonKey(name: 'rollup') final bool? rollup}) = _$TimeTrackingImpl;

  factory _TimeTracking.fromJson(Map<String, dynamic> json) =
      _$TimeTrackingImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(name: 'harvest')
  bool? get harvest;
  @override
  @JsonKey(name: 'rollup')
  bool? get rollup;
  @override
  @JsonKey(ignore: true)
  _$$TimeTrackingImplCopyWith<_$TimeTrackingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Points _$PointsFromJson(Map<String, dynamic> json) {
  return _Points.fromJson(json);
}

/// @nodoc
mixin _$Points {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointsCopyWith<Points> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsCopyWith<$Res> {
  factory $PointsCopyWith(Points value, $Res Function(Points) then) =
      _$PointsCopyWithImpl<$Res, Points>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$PointsCopyWithImpl<$Res, $Val extends Points>
    implements $PointsCopyWith<$Res> {
  _$PointsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointsImplCopyWith<$Res> implements $PointsCopyWith<$Res> {
  factory _$$PointsImplCopyWith(
          _$PointsImpl value, $Res Function(_$PointsImpl) then) =
      __$$PointsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$PointsImplCopyWithImpl<$Res>
    extends _$PointsCopyWithImpl<$Res, _$PointsImpl>
    implements _$$PointsImplCopyWith<$Res> {
  __$$PointsImplCopyWithImpl(
      _$PointsImpl _value, $Res Function(_$PointsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$PointsImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsImpl with DiagnosticableTreeMixin implements _Points {
  const _$PointsImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$PointsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Points(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Points'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsImplCopyWith<_$PointsImpl> get copyWith =>
      __$$PointsImplCopyWithImpl<_$PointsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsImplToJson(
      this,
    );
  }
}

abstract class _Points implements Points {
  const factory _Points({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$PointsImpl;

  factory _Points.fromJson(Map<String, dynamic> json) = _$PointsImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$PointsImplCopyWith<_$PointsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomItems _$CustomItemsFromJson(Map<String, dynamic> json) {
  return _CustomItems.fromJson(json);
}

/// @nodoc
mixin _$CustomItems {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomItemsCopyWith<CustomItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomItemsCopyWith<$Res> {
  factory $CustomItemsCopyWith(
          CustomItems value, $Res Function(CustomItems) then) =
      _$CustomItemsCopyWithImpl<$Res, CustomItems>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$CustomItemsCopyWithImpl<$Res, $Val extends CustomItems>
    implements $CustomItemsCopyWith<$Res> {
  _$CustomItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomItemsImplCopyWith<$Res>
    implements $CustomItemsCopyWith<$Res> {
  factory _$$CustomItemsImplCopyWith(
          _$CustomItemsImpl value, $Res Function(_$CustomItemsImpl) then) =
      __$$CustomItemsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$CustomItemsImplCopyWithImpl<$Res>
    extends _$CustomItemsCopyWithImpl<$Res, _$CustomItemsImpl>
    implements _$$CustomItemsImplCopyWith<$Res> {
  __$$CustomItemsImplCopyWithImpl(
      _$CustomItemsImpl _value, $Res Function(_$CustomItemsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$CustomItemsImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomItemsImpl with DiagnosticableTreeMixin implements _CustomItems {
  const _$CustomItemsImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$CustomItemsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomItemsImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomItems(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomItems'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomItemsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomItemsImplCopyWith<_$CustomItemsImpl> get copyWith =>
      __$$CustomItemsImplCopyWithImpl<_$CustomItemsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomItemsImplToJson(
      this,
    );
  }
}

abstract class _CustomItems implements CustomItems {
  const factory _CustomItems({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$CustomItemsImpl;

  factory _CustomItems.fromJson(Map<String, dynamic> json) =
      _$CustomItemsImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$CustomItemsImplCopyWith<_$CustomItemsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Priorities _$PrioritiesFromJson(Map<String, dynamic> json) {
  return _Priorities.fromJson(json);
}

/// @nodoc
mixin _$Priorities {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'priorities')
  List<Priorities>? get priorities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrioritiesCopyWith<Priorities> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrioritiesCopyWith<$Res> {
  factory $PrioritiesCopyWith(
          Priorities value, $Res Function(Priorities) then) =
      _$PrioritiesCopyWithImpl<$Res, Priorities>;
  @useResult
  $Res call(
      {@JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(name: 'priorities') List<Priorities>? priorities});
}

/// @nodoc
class _$PrioritiesCopyWithImpl<$Res, $Val extends Priorities>
    implements $PrioritiesCopyWith<$Res> {
  _$PrioritiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? priorities = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      priorities: freezed == priorities
          ? _value.priorities
          : priorities // ignore: cast_nullable_to_non_nullable
              as List<Priorities>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrioritiesImplCopyWith<$Res>
    implements $PrioritiesCopyWith<$Res> {
  factory _$$PrioritiesImplCopyWith(
          _$PrioritiesImpl value, $Res Function(_$PrioritiesImpl) then) =
      __$$PrioritiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(name: 'priorities') List<Priorities>? priorities});
}

/// @nodoc
class __$$PrioritiesImplCopyWithImpl<$Res>
    extends _$PrioritiesCopyWithImpl<$Res, _$PrioritiesImpl>
    implements _$$PrioritiesImplCopyWith<$Res> {
  __$$PrioritiesImplCopyWithImpl(
      _$PrioritiesImpl _value, $Res Function(_$PrioritiesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
    Object? priorities = freezed,
  }) {
    return _then(_$PrioritiesImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      priorities: freezed == priorities
          ? _value._priorities
          : priorities // ignore: cast_nullable_to_non_nullable
              as List<Priorities>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrioritiesImpl with DiagnosticableTreeMixin implements _Priorities {
  const _$PrioritiesImpl(
      {@JsonKey(name: 'enabled') this.enabled,
      @JsonKey(name: 'priorities') final List<Priorities>? priorities})
      : _priorities = priorities;

  factory _$PrioritiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrioritiesImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;
  final List<Priorities>? _priorities;
  @override
  @JsonKey(name: 'priorities')
  List<Priorities>? get priorities {
    final value = _priorities;
    if (value == null) return null;
    if (_priorities is EqualUnmodifiableListView) return _priorities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Priorities(enabled: $enabled, priorities: $priorities)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Priorities'))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('priorities', priorities));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrioritiesImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            const DeepCollectionEquality()
                .equals(other._priorities, _priorities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, enabled, const DeepCollectionEquality().hash(_priorities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrioritiesImplCopyWith<_$PrioritiesImpl> get copyWith =>
      __$$PrioritiesImplCopyWithImpl<_$PrioritiesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrioritiesImplToJson(
      this,
    );
  }
}

abstract class _Priorities implements Priorities {
  const factory _Priorities(
          {@JsonKey(name: 'enabled') final bool? enabled,
          @JsonKey(name: 'priorities') final List<Priorities>? priorities}) =
      _$PrioritiesImpl;

  factory _Priorities.fromJson(Map<String, dynamic> json) =
      _$PrioritiesImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(name: 'priorities')
  List<Priorities>? get priorities;
  @override
  @JsonKey(ignore: true)
  _$$PrioritiesImplCopyWith<_$PrioritiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubPriorities _$SubPrioritiesFromJson(Map<String, dynamic> json) {
  return _SubPriorities.fromJson(json);
}

/// @nodoc
mixin _$SubPriorities {
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderindex')
  String? get orderindex => throw _privateConstructorUsedError;
  @JsonKey(name: 'priority')
  String? get priority => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubPrioritiesCopyWith<SubPriorities> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubPrioritiesCopyWith<$Res> {
  factory $SubPrioritiesCopyWith(
          SubPriorities value, $Res Function(SubPriorities) then) =
      _$SubPrioritiesCopyWithImpl<$Res, SubPriorities>;
  @useResult
  $Res call(
      {@JsonKey(name: 'color') String? color,
      @JsonKey(name: 'id') String? id,
      @JsonKey(name: 'orderindex') String? orderindex,
      @JsonKey(name: 'priority') String? priority});
}

/// @nodoc
class _$SubPrioritiesCopyWithImpl<$Res, $Val extends SubPriorities>
    implements $SubPrioritiesCopyWith<$Res> {
  _$SubPrioritiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? id = freezed,
    Object? orderindex = freezed,
    Object? priority = freezed,
  }) {
    return _then(_value.copyWith(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      orderindex: freezed == orderindex
          ? _value.orderindex
          : orderindex // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubPrioritiesImplCopyWith<$Res>
    implements $SubPrioritiesCopyWith<$Res> {
  factory _$$SubPrioritiesImplCopyWith(
          _$SubPrioritiesImpl value, $Res Function(_$SubPrioritiesImpl) then) =
      __$$SubPrioritiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'color') String? color,
      @JsonKey(name: 'id') String? id,
      @JsonKey(name: 'orderindex') String? orderindex,
      @JsonKey(name: 'priority') String? priority});
}

/// @nodoc
class __$$SubPrioritiesImplCopyWithImpl<$Res>
    extends _$SubPrioritiesCopyWithImpl<$Res, _$SubPrioritiesImpl>
    implements _$$SubPrioritiesImplCopyWith<$Res> {
  __$$SubPrioritiesImplCopyWithImpl(
      _$SubPrioritiesImpl _value, $Res Function(_$SubPrioritiesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? id = freezed,
    Object? orderindex = freezed,
    Object? priority = freezed,
  }) {
    return _then(_$SubPrioritiesImpl(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      orderindex: freezed == orderindex
          ? _value.orderindex
          : orderindex // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubPrioritiesImpl
    with DiagnosticableTreeMixin
    implements _SubPriorities {
  const _$SubPrioritiesImpl(
      {@JsonKey(name: 'color') this.color,
      @JsonKey(name: 'id') this.id,
      @JsonKey(name: 'orderindex') this.orderindex,
      @JsonKey(name: 'priority') this.priority});

  factory _$SubPrioritiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubPrioritiesImplFromJson(json);

  @override
  @JsonKey(name: 'color')
  final String? color;
  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'orderindex')
  final String? orderindex;
  @override
  @JsonKey(name: 'priority')
  final String? priority;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubPriorities(color: $color, id: $id, orderindex: $orderindex, priority: $priority)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubPriorities'))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('orderindex', orderindex))
      ..add(DiagnosticsProperty('priority', priority));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubPrioritiesImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderindex, orderindex) ||
                other.orderindex == orderindex) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, color, id, orderindex, priority);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubPrioritiesImplCopyWith<_$SubPrioritiesImpl> get copyWith =>
      __$$SubPrioritiesImplCopyWithImpl<_$SubPrioritiesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubPrioritiesImplToJson(
      this,
    );
  }
}

abstract class _SubPriorities implements SubPriorities {
  const factory _SubPriorities(
      {@JsonKey(name: 'color') final String? color,
      @JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'orderindex') final String? orderindex,
      @JsonKey(name: 'priority') final String? priority}) = _$SubPrioritiesImpl;

  factory _SubPriorities.fromJson(Map<String, dynamic> json) =
      _$SubPrioritiesImpl.fromJson;

  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'orderindex')
  String? get orderindex;
  @override
  @JsonKey(name: 'priority')
  String? get priority;
  @override
  @JsonKey(ignore: true)
  _$$SubPrioritiesImplCopyWith<_$SubPrioritiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return _Tags.fromJson(json);
}

/// @nodoc
mixin _$Tags {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagsCopyWith<Tags> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagsCopyWith<$Res> {
  factory $TagsCopyWith(Tags value, $Res Function(Tags) then) =
      _$TagsCopyWithImpl<$Res, Tags>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$TagsCopyWithImpl<$Res, $Val extends Tags>
    implements $TagsCopyWith<$Res> {
  _$TagsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagsImplCopyWith<$Res> implements $TagsCopyWith<$Res> {
  factory _$$TagsImplCopyWith(
          _$TagsImpl value, $Res Function(_$TagsImpl) then) =
      __$$TagsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$TagsImplCopyWithImpl<$Res>
    extends _$TagsCopyWithImpl<$Res, _$TagsImpl>
    implements _$$TagsImplCopyWith<$Res> {
  __$$TagsImplCopyWithImpl(_$TagsImpl _value, $Res Function(_$TagsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$TagsImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TagsImpl with DiagnosticableTreeMixin implements _Tags {
  const _$TagsImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$TagsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagsImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Tags(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Tags'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagsImplCopyWith<_$TagsImpl> get copyWith =>
      __$$TagsImplCopyWithImpl<_$TagsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagsImplToJson(
      this,
    );
  }
}

abstract class _Tags implements Tags {
  const factory _Tags({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$TagsImpl;

  factory _Tags.fromJson(Map<String, dynamic> json) = _$TagsImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$TagsImplCopyWith<_$TagsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckUnresolved _$CheckUnresolvedFromJson(Map<String, dynamic> json) {
  return _CheckUnresolved.fromJson(json);
}

/// @nodoc
mixin _$CheckUnresolved {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckUnresolvedCopyWith<CheckUnresolved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckUnresolvedCopyWith<$Res> {
  factory $CheckUnresolvedCopyWith(
          CheckUnresolved value, $Res Function(CheckUnresolved) then) =
      _$CheckUnresolvedCopyWithImpl<$Res, CheckUnresolved>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$CheckUnresolvedCopyWithImpl<$Res, $Val extends CheckUnresolved>
    implements $CheckUnresolvedCopyWith<$Res> {
  _$CheckUnresolvedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckUnresolvedImplCopyWith<$Res>
    implements $CheckUnresolvedCopyWith<$Res> {
  factory _$$CheckUnresolvedImplCopyWith(_$CheckUnresolvedImpl value,
          $Res Function(_$CheckUnresolvedImpl) then) =
      __$$CheckUnresolvedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$CheckUnresolvedImplCopyWithImpl<$Res>
    extends _$CheckUnresolvedCopyWithImpl<$Res, _$CheckUnresolvedImpl>
    implements _$$CheckUnresolvedImplCopyWith<$Res> {
  __$$CheckUnresolvedImplCopyWithImpl(
      _$CheckUnresolvedImpl _value, $Res Function(_$CheckUnresolvedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$CheckUnresolvedImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckUnresolvedImpl
    with DiagnosticableTreeMixin
    implements _CheckUnresolved {
  const _$CheckUnresolvedImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$CheckUnresolvedImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckUnresolvedImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckUnresolved(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CheckUnresolved'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckUnresolvedImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckUnresolvedImplCopyWith<_$CheckUnresolvedImpl> get copyWith =>
      __$$CheckUnresolvedImplCopyWithImpl<_$CheckUnresolvedImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckUnresolvedImplToJson(
      this,
    );
  }
}

abstract class _CheckUnresolved implements CheckUnresolved {
  const factory _CheckUnresolved(
      {@JsonKey(name: 'enabled') final bool? enabled}) = _$CheckUnresolvedImpl;

  factory _CheckUnresolved.fromJson(Map<String, dynamic> json) =
      _$CheckUnresolvedImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$CheckUnresolvedImplCopyWith<_$CheckUnresolvedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Zoom _$ZoomFromJson(Map<String, dynamic> json) {
  return _Zoom.fromJson(json);
}

/// @nodoc
mixin _$Zoom {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ZoomCopyWith<Zoom> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoomCopyWith<$Res> {
  factory $ZoomCopyWith(Zoom value, $Res Function(Zoom) then) =
      _$ZoomCopyWithImpl<$Res, Zoom>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$ZoomCopyWithImpl<$Res, $Val extends Zoom>
    implements $ZoomCopyWith<$Res> {
  _$ZoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ZoomImplCopyWith<$Res> implements $ZoomCopyWith<$Res> {
  factory _$$ZoomImplCopyWith(
          _$ZoomImpl value, $Res Function(_$ZoomImpl) then) =
      __$$ZoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$ZoomImplCopyWithImpl<$Res>
    extends _$ZoomCopyWithImpl<$Res, _$ZoomImpl>
    implements _$$ZoomImplCopyWith<$Res> {
  __$$ZoomImplCopyWithImpl(_$ZoomImpl _value, $Res Function(_$ZoomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$ZoomImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ZoomImpl with DiagnosticableTreeMixin implements _Zoom {
  const _$ZoomImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$ZoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ZoomImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Zoom(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Zoom'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZoomImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ZoomImplCopyWith<_$ZoomImpl> get copyWith =>
      __$$ZoomImplCopyWithImpl<_$ZoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ZoomImplToJson(
      this,
    );
  }
}

abstract class _Zoom implements Zoom {
  const factory _Zoom({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$ZoomImpl;

  factory _Zoom.fromJson(Map<String, dynamic> json) = _$ZoomImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$ZoomImplCopyWith<_$ZoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Milestones _$MilestonesFromJson(Map<String, dynamic> json) {
  return _Milestones.fromJson(json);
}

/// @nodoc
mixin _$Milestones {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MilestonesCopyWith<Milestones> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MilestonesCopyWith<$Res> {
  factory $MilestonesCopyWith(
          Milestones value, $Res Function(Milestones) then) =
      _$MilestonesCopyWithImpl<$Res, Milestones>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$MilestonesCopyWithImpl<$Res, $Val extends Milestones>
    implements $MilestonesCopyWith<$Res> {
  _$MilestonesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MilestonesImplCopyWith<$Res>
    implements $MilestonesCopyWith<$Res> {
  factory _$$MilestonesImplCopyWith(
          _$MilestonesImpl value, $Res Function(_$MilestonesImpl) then) =
      __$$MilestonesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$MilestonesImplCopyWithImpl<$Res>
    extends _$MilestonesCopyWithImpl<$Res, _$MilestonesImpl>
    implements _$$MilestonesImplCopyWith<$Res> {
  __$$MilestonesImplCopyWithImpl(
      _$MilestonesImpl _value, $Res Function(_$MilestonesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$MilestonesImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MilestonesImpl with DiagnosticableTreeMixin implements _Milestones {
  const _$MilestonesImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$MilestonesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MilestonesImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Milestones(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Milestones'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MilestonesImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MilestonesImplCopyWith<_$MilestonesImpl> get copyWith =>
      __$$MilestonesImplCopyWithImpl<_$MilestonesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MilestonesImplToJson(
      this,
    );
  }
}

abstract class _Milestones implements Milestones {
  const factory _Milestones({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$MilestonesImpl;

  factory _Milestones.fromJson(Map<String, dynamic> json) =
      _$MilestonesImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$MilestonesImplCopyWith<_$MilestonesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomFields _$CustomFieldsFromJson(Map<String, dynamic> json) {
  return _CustomFields.fromJson(json);
}

/// @nodoc
mixin _$CustomFields {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomFieldsCopyWith<CustomFields> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFieldsCopyWith<$Res> {
  factory $CustomFieldsCopyWith(
          CustomFields value, $Res Function(CustomFields) then) =
      _$CustomFieldsCopyWithImpl<$Res, CustomFields>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$CustomFieldsCopyWithImpl<$Res, $Val extends CustomFields>
    implements $CustomFieldsCopyWith<$Res> {
  _$CustomFieldsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFieldsImplCopyWith<$Res>
    implements $CustomFieldsCopyWith<$Res> {
  factory _$$CustomFieldsImplCopyWith(
          _$CustomFieldsImpl value, $Res Function(_$CustomFieldsImpl) then) =
      __$$CustomFieldsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$CustomFieldsImplCopyWithImpl<$Res>
    extends _$CustomFieldsCopyWithImpl<$Res, _$CustomFieldsImpl>
    implements _$$CustomFieldsImplCopyWith<$Res> {
  __$$CustomFieldsImplCopyWithImpl(
      _$CustomFieldsImpl _value, $Res Function(_$CustomFieldsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$CustomFieldsImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomFieldsImpl with DiagnosticableTreeMixin implements _CustomFields {
  const _$CustomFieldsImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$CustomFieldsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomFieldsImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomFields(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomFields'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFieldsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFieldsImplCopyWith<_$CustomFieldsImpl> get copyWith =>
      __$$CustomFieldsImplCopyWithImpl<_$CustomFieldsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomFieldsImplToJson(
      this,
    );
  }
}

abstract class _CustomFields implements CustomFields {
  const factory _CustomFields({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$CustomFieldsImpl;

  factory _CustomFields.fromJson(Map<String, dynamic> json) =
      _$CustomFieldsImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$CustomFieldsImplCopyWith<_$CustomFieldsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DependencyWarning _$DependencyWarningFromJson(Map<String, dynamic> json) {
  return _DependencyWarning.fromJson(json);
}

/// @nodoc
mixin _$DependencyWarning {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DependencyWarningCopyWith<DependencyWarning> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DependencyWarningCopyWith<$Res> {
  factory $DependencyWarningCopyWith(
          DependencyWarning value, $Res Function(DependencyWarning) then) =
      _$DependencyWarningCopyWithImpl<$Res, DependencyWarning>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$DependencyWarningCopyWithImpl<$Res, $Val extends DependencyWarning>
    implements $DependencyWarningCopyWith<$Res> {
  _$DependencyWarningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DependencyWarningImplCopyWith<$Res>
    implements $DependencyWarningCopyWith<$Res> {
  factory _$$DependencyWarningImplCopyWith(_$DependencyWarningImpl value,
          $Res Function(_$DependencyWarningImpl) then) =
      __$$DependencyWarningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$DependencyWarningImplCopyWithImpl<$Res>
    extends _$DependencyWarningCopyWithImpl<$Res, _$DependencyWarningImpl>
    implements _$$DependencyWarningImplCopyWith<$Res> {
  __$$DependencyWarningImplCopyWithImpl(_$DependencyWarningImpl _value,
      $Res Function(_$DependencyWarningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$DependencyWarningImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DependencyWarningImpl
    with DiagnosticableTreeMixin
    implements _DependencyWarning {
  const _$DependencyWarningImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$DependencyWarningImpl.fromJson(Map<String, dynamic> json) =>
      _$$DependencyWarningImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DependencyWarning(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DependencyWarning'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DependencyWarningImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DependencyWarningImplCopyWith<_$DependencyWarningImpl> get copyWith =>
      __$$DependencyWarningImplCopyWithImpl<_$DependencyWarningImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DependencyWarningImplToJson(
      this,
    );
  }
}

abstract class _DependencyWarning implements DependencyWarning {
  const factory _DependencyWarning(
          {@JsonKey(name: 'enabled') final bool? enabled}) =
      _$DependencyWarningImpl;

  factory _DependencyWarning.fromJson(Map<String, dynamic> json) =
      _$DependencyWarningImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$DependencyWarningImplCopyWith<_$DependencyWarningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusPies _$StatusPiesFromJson(Map<String, dynamic> json) {
  return _StatusPies.fromJson(json);
}

/// @nodoc
mixin _$StatusPies {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusPiesCopyWith<StatusPies> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusPiesCopyWith<$Res> {
  factory $StatusPiesCopyWith(
          StatusPies value, $Res Function(StatusPies) then) =
      _$StatusPiesCopyWithImpl<$Res, StatusPies>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$StatusPiesCopyWithImpl<$Res, $Val extends StatusPies>
    implements $StatusPiesCopyWith<$Res> {
  _$StatusPiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusPiesImplCopyWith<$Res>
    implements $StatusPiesCopyWith<$Res> {
  factory _$$StatusPiesImplCopyWith(
          _$StatusPiesImpl value, $Res Function(_$StatusPiesImpl) then) =
      __$$StatusPiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$StatusPiesImplCopyWithImpl<$Res>
    extends _$StatusPiesCopyWithImpl<$Res, _$StatusPiesImpl>
    implements _$$StatusPiesImplCopyWith<$Res> {
  __$$StatusPiesImplCopyWithImpl(
      _$StatusPiesImpl _value, $Res Function(_$StatusPiesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$StatusPiesImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusPiesImpl with DiagnosticableTreeMixin implements _StatusPies {
  const _$StatusPiesImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$StatusPiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusPiesImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StatusPies(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StatusPies'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusPiesImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusPiesImplCopyWith<_$StatusPiesImpl> get copyWith =>
      __$$StatusPiesImplCopyWithImpl<_$StatusPiesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusPiesImplToJson(
      this,
    );
  }
}

abstract class _StatusPies implements StatusPies {
  const factory _StatusPies({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$StatusPiesImpl;

  factory _StatusPies.fromJson(Map<String, dynamic> json) =
      _$StatusPiesImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$StatusPiesImplCopyWith<_$StatusPiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MultipleAssignees _$MultipleAssigneesFromJson(Map<String, dynamic> json) {
  return _MultipleAssignees.fromJson(json);
}

/// @nodoc
mixin _$MultipleAssignees {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MultipleAssigneesCopyWith<MultipleAssignees> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultipleAssigneesCopyWith<$Res> {
  factory $MultipleAssigneesCopyWith(
          MultipleAssignees value, $Res Function(MultipleAssignees) then) =
      _$MultipleAssigneesCopyWithImpl<$Res, MultipleAssignees>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$MultipleAssigneesCopyWithImpl<$Res, $Val extends MultipleAssignees>
    implements $MultipleAssigneesCopyWith<$Res> {
  _$MultipleAssigneesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MultipleAssigneesImplCopyWith<$Res>
    implements $MultipleAssigneesCopyWith<$Res> {
  factory _$$MultipleAssigneesImplCopyWith(_$MultipleAssigneesImpl value,
          $Res Function(_$MultipleAssigneesImpl) then) =
      __$$MultipleAssigneesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$MultipleAssigneesImplCopyWithImpl<$Res>
    extends _$MultipleAssigneesCopyWithImpl<$Res, _$MultipleAssigneesImpl>
    implements _$$MultipleAssigneesImplCopyWith<$Res> {
  __$$MultipleAssigneesImplCopyWithImpl(_$MultipleAssigneesImpl _value,
      $Res Function(_$MultipleAssigneesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$MultipleAssigneesImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MultipleAssigneesImpl
    with DiagnosticableTreeMixin
    implements _MultipleAssignees {
  const _$MultipleAssigneesImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$MultipleAssigneesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MultipleAssigneesImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MultipleAssignees(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MultipleAssignees'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultipleAssigneesImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MultipleAssigneesImplCopyWith<_$MultipleAssigneesImpl> get copyWith =>
      __$$MultipleAssigneesImplCopyWithImpl<_$MultipleAssigneesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MultipleAssigneesImplToJson(
      this,
    );
  }
}

abstract class _MultipleAssignees implements MultipleAssignees {
  const factory _MultipleAssignees(
          {@JsonKey(name: 'enabled') final bool? enabled}) =
      _$MultipleAssigneesImpl;

  factory _MultipleAssignees.fromJson(Map<String, dynamic> json) =
      _$MultipleAssigneesImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$MultipleAssigneesImplCopyWith<_$MultipleAssigneesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Emails _$EmailsFromJson(Map<String, dynamic> json) {
  return _Emails.fromJson(json);
}

/// @nodoc
mixin _$Emails {
  @JsonKey(name: 'enabled')
  bool? get enabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmailsCopyWith<Emails> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailsCopyWith<$Res> {
  factory $EmailsCopyWith(Emails value, $Res Function(Emails) then) =
      _$EmailsCopyWithImpl<$Res, Emails>;
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class _$EmailsCopyWithImpl<$Res, $Val extends Emails>
    implements $EmailsCopyWith<$Res> {
  _$EmailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailsImplCopyWith<$Res> implements $EmailsCopyWith<$Res> {
  factory _$$EmailsImplCopyWith(
          _$EmailsImpl value, $Res Function(_$EmailsImpl) then) =
      __$$EmailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'enabled') bool? enabled});
}

/// @nodoc
class __$$EmailsImplCopyWithImpl<$Res>
    extends _$EmailsCopyWithImpl<$Res, _$EmailsImpl>
    implements _$$EmailsImplCopyWith<$Res> {
  __$$EmailsImplCopyWithImpl(
      _$EmailsImpl _value, $Res Function(_$EmailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = freezed,
  }) {
    return _then(_$EmailsImpl(
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailsImpl with DiagnosticableTreeMixin implements _Emails {
  const _$EmailsImpl({@JsonKey(name: 'enabled') this.enabled});

  factory _$EmailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailsImplFromJson(json);

  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Emails(enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Emails'))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailsImplCopyWith<_$EmailsImpl> get copyWith =>
      __$$EmailsImplCopyWithImpl<_$EmailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailsImplToJson(
      this,
    );
  }
}

abstract class _Emails implements Emails {
  const factory _Emails({@JsonKey(name: 'enabled') final bool? enabled}) =
      _$EmailsImpl;

  factory _Emails.fromJson(Map<String, dynamic> json) = _$EmailsImpl.fromJson;

  @override
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @override
  @JsonKey(ignore: true)
  _$$EmailsImplCopyWith<_$EmailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
