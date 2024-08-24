// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issuetype.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Issuetype _$IssuetypeFromJson(Map<String, dynamic> json) {
  return _Issuetype.fromJson(json);
}

/// @nodoc
mixin _$Issuetype {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IssuetypeCopyWith<Issuetype> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssuetypeCopyWith<$Res> {
  factory $IssuetypeCopyWith(Issuetype value, $Res Function(Issuetype) then) =
      _$IssuetypeCopyWithImpl<$Res, Issuetype>;
  @useResult
  $Res call({@JsonKey(name: 'name') String? name});
}

/// @nodoc
class _$IssuetypeCopyWithImpl<$Res, $Val extends Issuetype>
    implements $IssuetypeCopyWith<$Res> {
  _$IssuetypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IssuetypeImplCopyWith<$Res>
    implements $IssuetypeCopyWith<$Res> {
  factory _$$IssuetypeImplCopyWith(
          _$IssuetypeImpl value, $Res Function(_$IssuetypeImpl) then) =
      __$$IssuetypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'name') String? name});
}

/// @nodoc
class __$$IssuetypeImplCopyWithImpl<$Res>
    extends _$IssuetypeCopyWithImpl<$Res, _$IssuetypeImpl>
    implements _$$IssuetypeImplCopyWith<$Res> {
  __$$IssuetypeImplCopyWithImpl(
      _$IssuetypeImpl _value, $Res Function(_$IssuetypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$IssuetypeImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IssuetypeImpl implements _Issuetype {
  const _$IssuetypeImpl({@JsonKey(name: 'name') this.name});

  factory _$IssuetypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$IssuetypeImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;

  @override
  String toString() {
    return 'Issuetype(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssuetypeImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IssuetypeImplCopyWith<_$IssuetypeImpl> get copyWith =>
      __$$IssuetypeImplCopyWithImpl<_$IssuetypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IssuetypeImplToJson(
      this,
    );
  }
}

abstract class _Issuetype implements Issuetype {
  const factory _Issuetype({@JsonKey(name: 'name') final String? name}) =
      _$IssuetypeImpl;

  factory _Issuetype.fromJson(Map<String, dynamic> json) =
      _$IssuetypeImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$IssuetypeImplCopyWith<_$IssuetypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
