// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'selected_player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectedPlayerModel {
  PlayerModel get player => throw _privateConstructorUsedError;
  StagedPlayerModel get staged => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectedPlayerModelCopyWith<SelectedPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedPlayerModelCopyWith<$Res> {
  factory $SelectedPlayerModelCopyWith(
          SelectedPlayerModel value, $Res Function(SelectedPlayerModel) then) =
      _$SelectedPlayerModelCopyWithImpl<$Res, SelectedPlayerModel>;
  @useResult
  $Res call({PlayerModel player, StagedPlayerModel staged});

  $PlayerModelCopyWith<$Res> get player;
  $StagedPlayerModelCopyWith<$Res> get staged;
}

/// @nodoc
class _$SelectedPlayerModelCopyWithImpl<$Res, $Val extends SelectedPlayerModel>
    implements $SelectedPlayerModelCopyWith<$Res> {
  _$SelectedPlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? staged = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerModel,
      staged: null == staged
          ? _value.staged
          : staged // ignore: cast_nullable_to_non_nullable
              as StagedPlayerModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerModelCopyWith<$Res> get player {
    return $PlayerModelCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StagedPlayerModelCopyWith<$Res> get staged {
    return $StagedPlayerModelCopyWith<$Res>(_value.staged, (value) {
      return _then(_value.copyWith(staged: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SelectedPlayerModelCopyWith<$Res>
    implements $SelectedPlayerModelCopyWith<$Res> {
  factory _$$_SelectedPlayerModelCopyWith(_$_SelectedPlayerModel value,
          $Res Function(_$_SelectedPlayerModel) then) =
      __$$_SelectedPlayerModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlayerModel player, StagedPlayerModel staged});

  @override
  $PlayerModelCopyWith<$Res> get player;
  @override
  $StagedPlayerModelCopyWith<$Res> get staged;
}

/// @nodoc
class __$$_SelectedPlayerModelCopyWithImpl<$Res>
    extends _$SelectedPlayerModelCopyWithImpl<$Res, _$_SelectedPlayerModel>
    implements _$$_SelectedPlayerModelCopyWith<$Res> {
  __$$_SelectedPlayerModelCopyWithImpl(_$_SelectedPlayerModel _value,
      $Res Function(_$_SelectedPlayerModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? staged = null,
  }) {
    return _then(_$_SelectedPlayerModel(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerModel,
      staged: null == staged
          ? _value.staged
          : staged // ignore: cast_nullable_to_non_nullable
              as StagedPlayerModel,
    ));
  }
}

/// @nodoc

class _$_SelectedPlayerModel extends _SelectedPlayerModel {
  const _$_SelectedPlayerModel({required this.player, required this.staged})
      : super._();

  @override
  final PlayerModel player;
  @override
  final StagedPlayerModel staged;

  @override
  String toString() {
    return 'SelectedPlayerModel(player: $player, staged: $staged)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectedPlayerModelCopyWith<_$_SelectedPlayerModel> get copyWith =>
      __$$_SelectedPlayerModelCopyWithImpl<_$_SelectedPlayerModel>(
          this, _$identity);
}

abstract class _SelectedPlayerModel extends SelectedPlayerModel {
  const factory _SelectedPlayerModel(
      {required final PlayerModel player,
      required final StagedPlayerModel staged}) = _$_SelectedPlayerModel;
  const _SelectedPlayerModel._() : super._();

  @override
  PlayerModel get player;
  @override
  StagedPlayerModel get staged;
  @override
  @JsonKey(ignore: true)
  _$$_SelectedPlayerModelCopyWith<_$_SelectedPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
