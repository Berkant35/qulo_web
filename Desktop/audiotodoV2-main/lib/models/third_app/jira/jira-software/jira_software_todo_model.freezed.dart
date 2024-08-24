// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jira_software_todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JiraSoftwareToDoModel _$JiraSoftwareToDoModelFromJson(
    Map<String, dynamic> json) {
  return _JiraSoftwareToDoModel.fromJson(json);
}

/// @nodoc
mixin _$JiraSoftwareToDoModel {
  @JsonKey(name: 'fields')
  Fields? get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JiraSoftwareToDoModelCopyWith<JiraSoftwareToDoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JiraSoftwareToDoModelCopyWith<$Res> {
  factory $JiraSoftwareToDoModelCopyWith(JiraSoftwareToDoModel value,
          $Res Function(JiraSoftwareToDoModel) then) =
      _$JiraSoftwareToDoModelCopyWithImpl<$Res, JiraSoftwareToDoModel>;
  @useResult
  $Res call({@JsonKey(name: 'fields') Fields? fields});

  $FieldsCopyWith<$Res>? get fields;
}

/// @nodoc
class _$JiraSoftwareToDoModelCopyWithImpl<$Res,
        $Val extends JiraSoftwareToDoModel>
    implements $JiraSoftwareToDoModelCopyWith<$Res> {
  _$JiraSoftwareToDoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fields = freezed,
  }) {
    return _then(_value.copyWith(
      fields: freezed == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Fields?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldsCopyWith<$Res>? get fields {
    if (_value.fields == null) {
      return null;
    }

    return $FieldsCopyWith<$Res>(_value.fields!, (value) {
      return _then(_value.copyWith(fields: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JiraSoftwareToDoModelImplCopyWith<$Res>
    implements $JiraSoftwareToDoModelCopyWith<$Res> {
  factory _$$JiraSoftwareToDoModelImplCopyWith(
          _$JiraSoftwareToDoModelImpl value,
          $Res Function(_$JiraSoftwareToDoModelImpl) then) =
      __$$JiraSoftwareToDoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'fields') Fields? fields});

  @override
  $FieldsCopyWith<$Res>? get fields;
}

/// @nodoc
class __$$JiraSoftwareToDoModelImplCopyWithImpl<$Res>
    extends _$JiraSoftwareToDoModelCopyWithImpl<$Res,
        _$JiraSoftwareToDoModelImpl>
    implements _$$JiraSoftwareToDoModelImplCopyWith<$Res> {
  __$$JiraSoftwareToDoModelImplCopyWithImpl(_$JiraSoftwareToDoModelImpl _value,
      $Res Function(_$JiraSoftwareToDoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fields = freezed,
  }) {
    return _then(_$JiraSoftwareToDoModelImpl(
      fields: freezed == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Fields?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JiraSoftwareToDoModelImpl implements _JiraSoftwareToDoModel {
  const _$JiraSoftwareToDoModelImpl({@JsonKey(name: 'fields') this.fields});

  factory _$JiraSoftwareToDoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JiraSoftwareToDoModelImplFromJson(json);

  @override
  @JsonKey(name: 'fields')
  final Fields? fields;

  @override
  String toString() {
    return 'JiraSoftwareToDoModel(fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JiraSoftwareToDoModelImpl &&
            (identical(other.fields, fields) || other.fields == fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fields);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JiraSoftwareToDoModelImplCopyWith<_$JiraSoftwareToDoModelImpl>
      get copyWith => __$$JiraSoftwareToDoModelImplCopyWithImpl<
          _$JiraSoftwareToDoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JiraSoftwareToDoModelImplToJson(
      this,
    );
  }
}

abstract class _JiraSoftwareToDoModel implements JiraSoftwareToDoModel {
  const factory _JiraSoftwareToDoModel(
          {@JsonKey(name: 'fields') final Fields? fields}) =
      _$JiraSoftwareToDoModelImpl;

  factory _JiraSoftwareToDoModel.fromJson(Map<String, dynamic> json) =
      _$JiraSoftwareToDoModelImpl.fromJson;

  @override
  @JsonKey(name: 'fields')
  Fields? get fields;
  @override
  @JsonKey(ignore: true)
  _$$JiraSoftwareToDoModelImplCopyWith<_$JiraSoftwareToDoModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
