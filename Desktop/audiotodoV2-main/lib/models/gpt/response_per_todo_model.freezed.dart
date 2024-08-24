// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_per_todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResponsePerTodoModel _$ResponsePerTodoModelFromJson(Map<String, dynamic> json) {
  return _ResponsePerTodoModel.fromJson(json);
}

/// @nodoc
mixin _$ResponsePerTodoModel {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'meetId')
  String? get meetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'todo_title')
  String? get todoTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'todo_content')
  String? get todoContent => throw _privateConstructorUsedError;
  @JsonKey(name: 'deadline')
  String? get deadline => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String>? get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_persons')
  List<String>? get assignedPersons => throw _privateConstructorUsedError;
  @JsonKey(name: 'deadline_time')
  String? get deadlineTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_time')
  String? get createdTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponsePerTodoModelCopyWith<ResponsePerTodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponsePerTodoModelCopyWith<$Res> {
  factory $ResponsePerTodoModelCopyWith(ResponsePerTodoModel value,
          $Res Function(ResponsePerTodoModel) then) =
      _$ResponsePerTodoModelCopyWithImpl<$Res, ResponsePerTodoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'meetId') String? meetId,
      @JsonKey(name: 'todo_title') String? todoTitle,
      @JsonKey(name: 'todo_content') String? todoContent,
      @JsonKey(name: 'deadline') String? deadline,
      @JsonKey(name: 'tags') List<String>? tags,
      @JsonKey(name: 'assigned_persons') List<String>? assignedPersons,
      @JsonKey(name: 'deadline_time') String? deadlineTime,
      @JsonKey(name: 'created_time') String? createdTime});
}

/// @nodoc
class _$ResponsePerTodoModelCopyWithImpl<$Res,
        $Val extends ResponsePerTodoModel>
    implements $ResponsePerTodoModelCopyWith<$Res> {
  _$ResponsePerTodoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? meetId = freezed,
    Object? todoTitle = freezed,
    Object? todoContent = freezed,
    Object? deadline = freezed,
    Object? tags = freezed,
    Object? assignedPersons = freezed,
    Object? deadlineTime = freezed,
    Object? createdTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      meetId: freezed == meetId
          ? _value.meetId
          : meetId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoTitle: freezed == todoTitle
          ? _value.todoTitle
          : todoTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      todoContent: freezed == todoContent
          ? _value.todoContent
          : todoContent // ignore: cast_nullable_to_non_nullable
              as String?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      assignedPersons: freezed == assignedPersons
          ? _value.assignedPersons
          : assignedPersons // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      deadlineTime: freezed == deadlineTime
          ? _value.deadlineTime
          : deadlineTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponsePerTodoModelImplCopyWith<$Res>
    implements $ResponsePerTodoModelCopyWith<$Res> {
  factory _$$ResponsePerTodoModelImplCopyWith(_$ResponsePerTodoModelImpl value,
          $Res Function(_$ResponsePerTodoModelImpl) then) =
      __$$ResponsePerTodoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'meetId') String? meetId,
      @JsonKey(name: 'todo_title') String? todoTitle,
      @JsonKey(name: 'todo_content') String? todoContent,
      @JsonKey(name: 'deadline') String? deadline,
      @JsonKey(name: 'tags') List<String>? tags,
      @JsonKey(name: 'assigned_persons') List<String>? assignedPersons,
      @JsonKey(name: 'deadline_time') String? deadlineTime,
      @JsonKey(name: 'created_time') String? createdTime});
}

/// @nodoc
class __$$ResponsePerTodoModelImplCopyWithImpl<$Res>
    extends _$ResponsePerTodoModelCopyWithImpl<$Res, _$ResponsePerTodoModelImpl>
    implements _$$ResponsePerTodoModelImplCopyWith<$Res> {
  __$$ResponsePerTodoModelImplCopyWithImpl(_$ResponsePerTodoModelImpl _value,
      $Res Function(_$ResponsePerTodoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? meetId = freezed,
    Object? todoTitle = freezed,
    Object? todoContent = freezed,
    Object? deadline = freezed,
    Object? tags = freezed,
    Object? assignedPersons = freezed,
    Object? deadlineTime = freezed,
    Object? createdTime = freezed,
  }) {
    return _then(_$ResponsePerTodoModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      meetId: freezed == meetId
          ? _value.meetId
          : meetId // ignore: cast_nullable_to_non_nullable
              as String?,
      todoTitle: freezed == todoTitle
          ? _value.todoTitle
          : todoTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      todoContent: freezed == todoContent
          ? _value.todoContent
          : todoContent // ignore: cast_nullable_to_non_nullable
              as String?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      assignedPersons: freezed == assignedPersons
          ? _value._assignedPersons
          : assignedPersons // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      deadlineTime: freezed == deadlineTime
          ? _value.deadlineTime
          : deadlineTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponsePerTodoModelImpl
    with DiagnosticableTreeMixin
    implements _ResponsePerTodoModel {
  const _$ResponsePerTodoModelImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'meetId') this.meetId,
      @JsonKey(name: 'todo_title') this.todoTitle,
      @JsonKey(name: 'todo_content') this.todoContent,
      @JsonKey(name: 'deadline') this.deadline,
      @JsonKey(name: 'tags') final List<String>? tags,
      @JsonKey(name: 'assigned_persons') final List<String>? assignedPersons,
      @JsonKey(name: 'deadline_time') this.deadlineTime,
      @JsonKey(name: 'created_time') this.createdTime})
      : _tags = tags,
        _assignedPersons = assignedPersons;

  factory _$ResponsePerTodoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResponsePerTodoModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'meetId')
  final String? meetId;
  @override
  @JsonKey(name: 'todo_title')
  final String? todoTitle;
  @override
  @JsonKey(name: 'todo_content')
  final String? todoContent;
  @override
  @JsonKey(name: 'deadline')
  final String? deadline;
  final List<String>? _tags;
  @override
  @JsonKey(name: 'tags')
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _assignedPersons;
  @override
  @JsonKey(name: 'assigned_persons')
  List<String>? get assignedPersons {
    final value = _assignedPersons;
    if (value == null) return null;
    if (_assignedPersons is EqualUnmodifiableListView) return _assignedPersons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'deadline_time')
  final String? deadlineTime;
  @override
  @JsonKey(name: 'created_time')
  final String? createdTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ResponsePerTodoModel(id: $id, meetId: $meetId, todoTitle: $todoTitle, todoContent: $todoContent, deadline: $deadline, tags: $tags, assignedPersons: $assignedPersons, deadlineTime: $deadlineTime, createdTime: $createdTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ResponsePerTodoModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('meetId', meetId))
      ..add(DiagnosticsProperty('todoTitle', todoTitle))
      ..add(DiagnosticsProperty('todoContent', todoContent))
      ..add(DiagnosticsProperty('deadline', deadline))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('assignedPersons', assignedPersons))
      ..add(DiagnosticsProperty('deadlineTime', deadlineTime))
      ..add(DiagnosticsProperty('createdTime', createdTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponsePerTodoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meetId, meetId) || other.meetId == meetId) &&
            (identical(other.todoTitle, todoTitle) ||
                other.todoTitle == todoTitle) &&
            (identical(other.todoContent, todoContent) ||
                other.todoContent == todoContent) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._assignedPersons, _assignedPersons) &&
            (identical(other.deadlineTime, deadlineTime) ||
                other.deadlineTime == deadlineTime) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      meetId,
      todoTitle,
      todoContent,
      deadline,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_assignedPersons),
      deadlineTime,
      createdTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponsePerTodoModelImplCopyWith<_$ResponsePerTodoModelImpl>
      get copyWith =>
          __$$ResponsePerTodoModelImplCopyWithImpl<_$ResponsePerTodoModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponsePerTodoModelImplToJson(
      this,
    );
  }
}

abstract class _ResponsePerTodoModel implements ResponsePerTodoModel {
  const factory _ResponsePerTodoModel(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'meetId') final String? meetId,
      @JsonKey(name: 'todo_title') final String? todoTitle,
      @JsonKey(name: 'todo_content') final String? todoContent,
      @JsonKey(name: 'deadline') final String? deadline,
      @JsonKey(name: 'tags') final List<String>? tags,
      @JsonKey(name: 'assigned_persons') final List<String>? assignedPersons,
      @JsonKey(name: 'deadline_time') final String? deadlineTime,
      @JsonKey(name: 'created_time')
      final String? createdTime}) = _$ResponsePerTodoModelImpl;

  factory _ResponsePerTodoModel.fromJson(Map<String, dynamic> json) =
      _$ResponsePerTodoModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'meetId')
  String? get meetId;
  @override
  @JsonKey(name: 'todo_title')
  String? get todoTitle;
  @override
  @JsonKey(name: 'todo_content')
  String? get todoContent;
  @override
  @JsonKey(name: 'deadline')
  String? get deadline;
  @override
  @JsonKey(name: 'tags')
  List<String>? get tags;
  @override
  @JsonKey(name: 'assigned_persons')
  List<String>? get assignedPersons;
  @override
  @JsonKey(name: 'deadline_time')
  String? get deadlineTime;
  @override
  @JsonKey(name: 'created_time')
  String? get createdTime;
  @override
  @JsonKey(ignore: true)
  _$$ResponsePerTodoModelImplCopyWith<_$ResponsePerTodoModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
