// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'click_up_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClickUpTask _$ClickUpTaskFromJson(Map<String, dynamic> json) {
  return _ClickUpTask.fromJson(json);
}

/// @nodoc
mixin _$ClickUpTask {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'assignees')
  List<int>? get assignees => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String>? get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'priority')
  int? get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date')
  int? get dueDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date_time')
  bool? get dueDateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_estimate')
  int? get timeEstimate => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  int? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date_time')
  bool? get startDateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClickUpTaskCopyWith<ClickUpTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpTaskCopyWith<$Res> {
  factory $ClickUpTaskCopyWith(
          ClickUpTask value, $Res Function(ClickUpTask) then) =
      _$ClickUpTaskCopyWithImpl<$Res, ClickUpTask>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'assignees') List<int>? assignees,
      @JsonKey(name: 'tags') List<String>? tags,
      @JsonKey(name: 'priority') int? priority,
      @JsonKey(name: 'due_date') int? dueDate,
      @JsonKey(name: 'due_date_time') bool? dueDateTime,
      @JsonKey(name: 'time_estimate') int? timeEstimate,
      @JsonKey(name: 'start_date') int? startDate,
      @JsonKey(name: 'start_date_time') bool? startDateTime});
}

/// @nodoc
class _$ClickUpTaskCopyWithImpl<$Res, $Val extends ClickUpTask>
    implements $ClickUpTaskCopyWith<$Res> {
  _$ClickUpTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? assignees = freezed,
    Object? tags = freezed,
    Object? priority = freezed,
    Object? dueDate = freezed,
    Object? dueDateTime = freezed,
    Object? timeEstimate = freezed,
    Object? startDate = freezed,
    Object? startDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      assignees: freezed == assignees
          ? _value.assignees
          : assignees // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as int?,
      dueDateTime: freezed == dueDateTime
          ? _value.dueDateTime
          : dueDateTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      timeEstimate: freezed == timeEstimate
          ? _value.timeEstimate
          : timeEstimate // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int?,
      startDateTime: freezed == startDateTime
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClickUpTaskImplCopyWith<$Res>
    implements $ClickUpTaskCopyWith<$Res> {
  factory _$$ClickUpTaskImplCopyWith(
          _$ClickUpTaskImpl value, $Res Function(_$ClickUpTaskImpl) then) =
      __$$ClickUpTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'assignees') List<int>? assignees,
      @JsonKey(name: 'tags') List<String>? tags,
      @JsonKey(name: 'priority') int? priority,
      @JsonKey(name: 'due_date') int? dueDate,
      @JsonKey(name: 'due_date_time') bool? dueDateTime,
      @JsonKey(name: 'time_estimate') int? timeEstimate,
      @JsonKey(name: 'start_date') int? startDate,
      @JsonKey(name: 'start_date_time') bool? startDateTime});
}

/// @nodoc
class __$$ClickUpTaskImplCopyWithImpl<$Res>
    extends _$ClickUpTaskCopyWithImpl<$Res, _$ClickUpTaskImpl>
    implements _$$ClickUpTaskImplCopyWith<$Res> {
  __$$ClickUpTaskImplCopyWithImpl(
      _$ClickUpTaskImpl _value, $Res Function(_$ClickUpTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? assignees = freezed,
    Object? tags = freezed,
    Object? priority = freezed,
    Object? dueDate = freezed,
    Object? dueDateTime = freezed,
    Object? timeEstimate = freezed,
    Object? startDate = freezed,
    Object? startDateTime = freezed,
  }) {
    return _then(_$ClickUpTaskImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      assignees: freezed == assignees
          ? _value._assignees
          : assignees // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as int?,
      dueDateTime: freezed == dueDateTime
          ? _value.dueDateTime
          : dueDateTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      timeEstimate: freezed == timeEstimate
          ? _value.timeEstimate
          : timeEstimate // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as int?,
      startDateTime: freezed == startDateTime
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpTaskImpl with DiagnosticableTreeMixin implements _ClickUpTask {
  const _$ClickUpTaskImpl(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'assignees') final List<int>? assignees,
      @JsonKey(name: 'tags') final List<String>? tags,
      @JsonKey(name: 'priority') this.priority,
      @JsonKey(name: 'due_date') this.dueDate,
      @JsonKey(name: 'due_date_time') this.dueDateTime,
      @JsonKey(name: 'time_estimate') this.timeEstimate,
      @JsonKey(name: 'start_date') this.startDate,
      @JsonKey(name: 'start_date_time') this.startDateTime})
      : _assignees = assignees,
        _tags = tags;

  factory _$ClickUpTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClickUpTaskImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  final List<int>? _assignees;
  @override
  @JsonKey(name: 'assignees')
  List<int>? get assignees {
    final value = _assignees;
    if (value == null) return null;
    if (_assignees is EqualUnmodifiableListView) return _assignees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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

  @override
  @JsonKey(name: 'priority')
  final int? priority;
  @override
  @JsonKey(name: 'due_date')
  final int? dueDate;
  @override
  @JsonKey(name: 'due_date_time')
  final bool? dueDateTime;
  @override
  @JsonKey(name: 'time_estimate')
  final int? timeEstimate;
  @override
  @JsonKey(name: 'start_date')
  final int? startDate;
  @override
  @JsonKey(name: 'start_date_time')
  final bool? startDateTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClickUpTask(name: $name, description: $description, assignees: $assignees, tags: $tags, priority: $priority, dueDate: $dueDate, dueDateTime: $dueDateTime, timeEstimate: $timeEstimate, startDate: $startDate, startDateTime: $startDateTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClickUpTask'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('assignees', assignees))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('priority', priority))
      ..add(DiagnosticsProperty('dueDate', dueDate))
      ..add(DiagnosticsProperty('dueDateTime', dueDateTime))
      ..add(DiagnosticsProperty('timeEstimate', timeEstimate))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('startDateTime', startDateTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpTaskImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._assignees, _assignees) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.dueDateTime, dueDateTime) ||
                other.dueDateTime == dueDateTime) &&
            (identical(other.timeEstimate, timeEstimate) ||
                other.timeEstimate == timeEstimate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.startDateTime, startDateTime) ||
                other.startDateTime == startDateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_assignees),
      const DeepCollectionEquality().hash(_tags),
      priority,
      dueDate,
      dueDateTime,
      timeEstimate,
      startDate,
      startDateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpTaskImplCopyWith<_$ClickUpTaskImpl> get copyWith =>
      __$$ClickUpTaskImplCopyWithImpl<_$ClickUpTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpTaskImplToJson(
      this,
    );
  }
}

abstract class _ClickUpTask implements ClickUpTask {
  const factory _ClickUpTask(
          {@JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'description') final String? description,
          @JsonKey(name: 'assignees') final List<int>? assignees,
          @JsonKey(name: 'tags') final List<String>? tags,
          @JsonKey(name: 'priority') final int? priority,
          @JsonKey(name: 'due_date') final int? dueDate,
          @JsonKey(name: 'due_date_time') final bool? dueDateTime,
          @JsonKey(name: 'time_estimate') final int? timeEstimate,
          @JsonKey(name: 'start_date') final int? startDate,
          @JsonKey(name: 'start_date_time') final bool? startDateTime}) =
      _$ClickUpTaskImpl;

  factory _ClickUpTask.fromJson(Map<String, dynamic> json) =
      _$ClickUpTaskImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'assignees')
  List<int>? get assignees;
  @override
  @JsonKey(name: 'tags')
  List<String>? get tags;
  @override
  @JsonKey(name: 'priority')
  int? get priority;
  @override
  @JsonKey(name: 'due_date')
  int? get dueDate;
  @override
  @JsonKey(name: 'due_date_time')
  bool? get dueDateTime;
  @override
  @JsonKey(name: 'time_estimate')
  int? get timeEstimate;
  @override
  @JsonKey(name: 'start_date')
  int? get startDate;
  @override
  @JsonKey(name: 'start_date_time')
  bool? get startDateTime;
  @override
  @JsonKey(ignore: true)
  _$$ClickUpTaskImplCopyWith<_$ClickUpTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
