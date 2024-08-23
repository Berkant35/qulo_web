// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_prov_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthProvState {
  AsyncValue<User?> get firebaseUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthProvStateCopyWith<AuthProvState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthProvStateCopyWith<$Res> {
  factory $AuthProvStateCopyWith(
          AuthProvState value, $Res Function(AuthProvState) then) =
      _$AuthProvStateCopyWithImpl<$Res, AuthProvState>;
  @useResult
  $Res call({AsyncValue<User?> firebaseUser});
}

/// @nodoc
class _$AuthProvStateCopyWithImpl<$Res, $Val extends AuthProvState>
    implements $AuthProvStateCopyWith<$Res> {
  _$AuthProvStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firebaseUser = null,
  }) {
    return _then(_value.copyWith(
      firebaseUser: null == firebaseUser
          ? _value.firebaseUser
          : firebaseUser // ignore: cast_nullable_to_non_nullable
              as AsyncValue<User?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthProvStateCopyWith<$Res>
    implements $AuthProvStateCopyWith<$Res> {
  factory _$$_AuthProvStateCopyWith(
          _$_AuthProvState value, $Res Function(_$_AuthProvState) then) =
      __$$_AuthProvStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<User?> firebaseUser});
}

/// @nodoc
class __$$_AuthProvStateCopyWithImpl<$Res>
    extends _$AuthProvStateCopyWithImpl<$Res, _$_AuthProvState>
    implements _$$_AuthProvStateCopyWith<$Res> {
  __$$_AuthProvStateCopyWithImpl(
      _$_AuthProvState _value, $Res Function(_$_AuthProvState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firebaseUser = null,
  }) {
    return _then(_$_AuthProvState(
      firebaseUser: null == firebaseUser
          ? _value.firebaseUser
          : firebaseUser // ignore: cast_nullable_to_non_nullable
              as AsyncValue<User?>,
    ));
  }
}

/// @nodoc

class _$_AuthProvState extends _AuthProvState {
  _$_AuthProvState({this.firebaseUser = const AsyncValue<User?>.loading()})
      : super._();

  @override
  @JsonKey()
  final AsyncValue<User?> firebaseUser;

  @override
  String toString() {
    return 'AuthProvState(firebaseUser: $firebaseUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthProvState &&
            (identical(other.firebaseUser, firebaseUser) ||
                other.firebaseUser == firebaseUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, firebaseUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthProvStateCopyWith<_$_AuthProvState> get copyWith =>
      __$$_AuthProvStateCopyWithImpl<_$_AuthProvState>(this, _$identity);
}

abstract class _AuthProvState extends AuthProvState {
  factory _AuthProvState({final AsyncValue<User?> firebaseUser}) =
      _$_AuthProvState;
  _AuthProvState._() : super._();

  @override
  AsyncValue<User?> get firebaseUser;
  @override
  @JsonKey(ignore: true)
  _$$_AuthProvStateCopyWith<_$_AuthProvState> get copyWith =>
      throw _privateConstructorUsedError;
}
