// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'per_list_of_folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PerListOfFolder _$PerListOfFolderFromJson(Map<String, dynamic> json) {
  return _PerListOfFolder.fromJson(json);
}

/// @nodoc
mixin _$PerListOfFolder {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderindex')
  int? get orderindex => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_count')
  int? get taskCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerListOfFolderCopyWith<PerListOfFolder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerListOfFolderCopyWith<$Res> {
  factory $PerListOfFolderCopyWith(
          PerListOfFolder value, $Res Function(PerListOfFolder) then) =
      _$PerListOfFolderCopyWithImpl<$Res, PerListOfFolder>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'orderindex') int? orderindex,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'task_count') int? taskCount});
}

/// @nodoc
class _$PerListOfFolderCopyWithImpl<$Res, $Val extends PerListOfFolder>
    implements $PerListOfFolderCopyWith<$Res> {
  _$PerListOfFolderCopyWithImpl(this._value, this._then);

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
    Object? content = freezed,
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
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      taskCount: freezed == taskCount
          ? _value.taskCount
          : taskCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerListOfFolderImplCopyWith<$Res>
    implements $PerListOfFolderCopyWith<$Res> {
  factory _$$PerListOfFolderImplCopyWith(_$PerListOfFolderImpl value,
          $Res Function(_$PerListOfFolderImpl) then) =
      __$$PerListOfFolderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'orderindex') int? orderindex,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'task_count') int? taskCount});
}

/// @nodoc
class __$$PerListOfFolderImplCopyWithImpl<$Res>
    extends _$PerListOfFolderCopyWithImpl<$Res, _$PerListOfFolderImpl>
    implements _$$PerListOfFolderImplCopyWith<$Res> {
  __$$PerListOfFolderImplCopyWithImpl(
      _$PerListOfFolderImpl _value, $Res Function(_$PerListOfFolderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? orderindex = freezed,
    Object? content = freezed,
    Object? taskCount = freezed,
  }) {
    return _then(_$PerListOfFolderImpl(
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
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      taskCount: freezed == taskCount
          ? _value.taskCount
          : taskCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerListOfFolderImpl
    with DiagnosticableTreeMixin
    implements _PerListOfFolder {
  const _$PerListOfFolderImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'orderindex') this.orderindex,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'task_count') this.taskCount});

  factory _$PerListOfFolderImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerListOfFolderImplFromJson(json);

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
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'task_count')
  final int? taskCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PerListOfFolder(id: $id, name: $name, orderindex: $orderindex, content: $content, taskCount: $taskCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PerListOfFolder'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('orderindex', orderindex))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('taskCount', taskCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerListOfFolderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderindex, orderindex) ||
                other.orderindex == orderindex) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.taskCount, taskCount) ||
                other.taskCount == taskCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, orderindex, content, taskCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PerListOfFolderImplCopyWith<_$PerListOfFolderImpl> get copyWith =>
      __$$PerListOfFolderImplCopyWithImpl<_$PerListOfFolderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerListOfFolderImplToJson(
      this,
    );
  }
}

abstract class _PerListOfFolder implements PerListOfFolder {
  const factory _PerListOfFolder(
          {@JsonKey(name: 'id') final String? id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'orderindex') final int? orderindex,
          @JsonKey(name: 'content') final String? content,
          @JsonKey(name: 'task_count') final int? taskCount}) =
      _$PerListOfFolderImpl;

  factory _PerListOfFolder.fromJson(Map<String, dynamic> json) =
      _$PerListOfFolderImpl.fromJson;

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
  @JsonKey(name: 'content')
  String? get content;
  @override
  @JsonKey(name: 'task_count')
  int? get taskCount;
  @override
  @JsonKey(ignore: true)
  _$$PerListOfFolderImplCopyWith<_$PerListOfFolderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
