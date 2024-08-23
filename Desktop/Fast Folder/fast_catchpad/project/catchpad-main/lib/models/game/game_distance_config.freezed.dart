// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_distance_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameDistanceConfig {
  /// unit is mm
  int get distance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameDistanceConfigCopyWith<GameDistanceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDistanceConfigCopyWith<$Res> {
  factory $GameDistanceConfigCopyWith(
          GameDistanceConfig value, $Res Function(GameDistanceConfig) then) =
      _$GameDistanceConfigCopyWithImpl<$Res, GameDistanceConfig>;
  @useResult
  $Res call({int distance});
}

/// @nodoc
class _$GameDistanceConfigCopyWithImpl<$Res, $Val extends GameDistanceConfig>
    implements $GameDistanceConfigCopyWith<$Res> {
  _$GameDistanceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = null,
  }) {
    return _then(_value.copyWith(
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameDistanceConfigCopyWith<$Res>
    implements $GameDistanceConfigCopyWith<$Res> {
  factory _$$_GameDistanceConfigCopyWith(_$_GameDistanceConfig value,
          $Res Function(_$_GameDistanceConfig) then) =
      __$$_GameDistanceConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int distance});
}

/// @nodoc
class __$$_GameDistanceConfigCopyWithImpl<$Res>
    extends _$GameDistanceConfigCopyWithImpl<$Res, _$_GameDistanceConfig>
    implements _$$_GameDistanceConfigCopyWith<$Res> {
  __$$_GameDistanceConfigCopyWithImpl(
      _$_GameDistanceConfig _value, $Res Function(_$_GameDistanceConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = null,
  }) {
    return _then(_$_GameDistanceConfig(
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GameDistanceConfig extends _GameDistanceConfig {
  const _$_GameDistanceConfig({required this.distance}) : super._();

  /// unit is mm
  @override
  final int distance;

  @override
  String toString() {
    return 'GameDistanceConfig(distance: $distance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameDistanceConfig &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameDistanceConfigCopyWith<_$_GameDistanceConfig> get copyWith =>
      __$$_GameDistanceConfigCopyWithImpl<_$_GameDistanceConfig>(
          this, _$identity);
}

abstract class _GameDistanceConfig extends GameDistanceConfig {
  const factory _GameDistanceConfig({required final int distance}) =
      _$_GameDistanceConfig;
  const _GameDistanceConfig._() : super._();

  @override

  /// unit is mm
  int get distance;
  @override
  @JsonKey(ignore: true)
  _$$_GameDistanceConfigCopyWith<_$_GameDistanceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
