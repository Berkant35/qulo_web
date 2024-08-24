// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'click_up_folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClickUpFolder _$ClickUpFolderFromJson(Map<String, dynamic> json) {
  return _ClickUpFolder.fromJson(json);
}

/// @nodoc
mixin _$ClickUpFolder {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderindex')
  int? get orderindex => throw _privateConstructorUsedError;
  @JsonKey(name: 'override_statuses')
  bool? get overrideStatuses => throw _privateConstructorUsedError;
  @JsonKey(name: 'hidden')
  bool? get hidden => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_count')
  String? get taskCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClickUpFolderCopyWith<ClickUpFolder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpFolderCopyWith<$Res> {
  factory $ClickUpFolderCopyWith(
          ClickUpFolder value, $Res Function(ClickUpFolder) then) =
      _$ClickUpFolderCopyWithImpl<$Res, ClickUpFolder>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'orderindex') int? orderindex,
      @JsonKey(name: 'override_statuses') bool? overrideStatuses,
      @JsonKey(name: 'hidden') bool? hidden,
      @JsonKey(name: 'task_count') String? taskCount});
}

/// @nodoc
class _$ClickUpFolderCopyWithImpl<$Res, $Val extends ClickUpFolder>
    implements $ClickUpFolderCopyWith<$Res> {
  _$ClickUpFolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? orderindex = freezed,
    Object? overrideStatuses = freezed,
    Object? hidden = freezed,
    Object? taskCount = freezed,
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
      orderindex: freezed == orderindex
          ? _value.orderindex
          : orderindex // ignore: cast_nullable_to_non_nullable
              as int?,
      overrideStatuses: freezed == overrideStatuses
          ? _value.overrideStatuses
          : overrideStatuses // ignore: cast_nullable_to_non_nullable
              as bool?,
      hidden: freezed == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      taskCount: freezed == taskCount
          ? _value.taskCount
          : taskCount // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClickUpFolderImplCopyWith<$Res>
    implements $ClickUpFolderCopyWith<$Res> {
  factory _$$ClickUpFolderImplCopyWith(
          _$ClickUpFolderImpl value, $Res Function(_$ClickUpFolderImpl) then) =
      __$$ClickUpFolderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'orderindex') int? orderindex,
      @JsonKey(name: 'override_statuses') bool? overrideStatuses,
      @JsonKey(name: 'hidden') bool? hidden,
      @JsonKey(name: 'task_count') String? taskCount});
}

/// @nodoc
class __$$ClickUpFolderImplCopyWithImpl<$Res>
    extends _$ClickUpFolderCopyWithImpl<$Res, _$ClickUpFolderImpl>
    implements _$$ClickUpFolderImplCopyWith<$Res> {
  __$$ClickUpFolderImplCopyWithImpl(
      _$ClickUpFolderImpl _value, $Res Function(_$ClickUpFolderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? orderindex = freezed,
    Object? overrideStatuses = freezed,
    Object? hidden = freezed,
    Object? taskCount = freezed,
  }) {
    return _then(_$ClickUpFolderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      orderindex: freezed == orderindex
          ? _value.orderindex
          : orderindex // ignore: cast_nullable_to_non_nullable
              as int?,
      overrideStatuses: freezed == overrideStatuses
          ? _value.overrideStatuses
          : overrideStatuses // ignore: cast_nullable_to_non_nullable
              as bool?,
      hidden: freezed == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      taskCount: freezed == taskCount
          ? _value.taskCount
          : taskCount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpFolderImpl
    with DiagnosticableTreeMixin
    implements _ClickUpFolder {
  const _$ClickUpFolderImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'orderindex') this.orderindex,
      @JsonKey(name: 'override_statuses') this.overrideStatuses,
      @JsonKey(name: 'hidden') this.hidden,
      @JsonKey(name: 'task_count') this.taskCount});

  factory _$ClickUpFolderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClickUpFolderImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'orderindex')
  final int? orderindex;
  @override
  @JsonKey(name: 'override_statuses')
  final bool? overrideStatuses;
  @override
  @JsonKey(name: 'hidden')
  final bool? hidden;
  @override
  @JsonKey(name: 'task_count')
  final String? taskCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClickUpFolder(id: $id, name: $name, orderindex: $orderindex, overrideStatuses: $overrideStatuses, hidden: $hidden, taskCount: $taskCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClickUpFolder'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('orderindex', orderindex))
      ..add(DiagnosticsProperty('overrideStatuses', overrideStatuses))
      ..add(DiagnosticsProperty('hidden', hidden))
      ..add(DiagnosticsProperty('taskCount', taskCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpFolderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderindex, orderindex) ||
                other.orderindex == orderindex) &&
            (identical(other.overrideStatuses, overrideStatuses) ||
                other.overrideStatuses == overrideStatuses) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.taskCount, taskCount) ||
                other.taskCount == taskCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, orderindex, overrideStatuses, hidden, taskCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpFolderImplCopyWith<_$ClickUpFolderImpl> get copyWith =>
      __$$ClickUpFolderImplCopyWithImpl<_$ClickUpFolderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpFolderImplToJson(
      this,
    );
  }
}

abstract class _ClickUpFolder implements ClickUpFolder {
  const factory _ClickUpFolder(
          {@JsonKey(name: 'id') final String? id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'orderindex') final int? orderindex,
          @JsonKey(name: 'override_statuses') final bool? overrideStatuses,
          @JsonKey(name: 'hidden') final bool? hidden,
          @JsonKey(name: 'task_count') final String? taskCount}) =
      _$ClickUpFolderImpl;

  factory _ClickUpFolder.fromJson(Map<String, dynamic> json) =
      _$ClickUpFolderImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'orderindex')
  int? get orderindex;
  @override
  @JsonKey(name: 'override_statuses')
  bool? get overrideStatuses;
  @override
  @JsonKey(name: 'hidden')
  bool? get hidden;
  @override
  @JsonKey(name: 'task_count')
  String? get taskCount;
  @override
  @JsonKey(ignore: true)
  _$$ClickUpFolderImplCopyWith<_$ClickUpFolderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
