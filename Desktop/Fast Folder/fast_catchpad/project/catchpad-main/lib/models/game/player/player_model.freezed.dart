// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return _PlayerModel.fromJson(json);
}

/// @nodoc
mixin _$PlayerModel {
  String get id => throw _privateConstructorUsedError;

  /// this will be used for sorting the players,
  /// as our id is a string, we cant sort using it
  /// because when we want 2 to be before 10, '10'
  /// actually comes before '2' in the string.
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// this indicates the user id associated
  /// with the player.
  @JsonKey(toJson: _userToJson, fromJson: _userFromJson)
  RegisterUser? get user => throw _privateConstructorUsedError;
  @JsonKey(toJson: _colorsToJson, fromJson: _colorsFromJson)
  @protected
  List<Color> get colors => throw _privateConstructorUsedError;
  @JsonKey(toJson: _devicesToJson, fromJson: _devicesFromJson)
  @protected
  List<DiscoveredDevice> get devices => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerModelCopyWith<PlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerModelCopyWith<$Res> {
  factory $PlayerModelCopyWith(
          PlayerModel value, $Res Function(PlayerModel) then) =
      _$PlayerModelCopyWithImpl<$Res, PlayerModel>;
  @useResult
  $Res call(
      {String id,
      DateTime? createdAt,
      String? name,
      @JsonKey(toJson: _userToJson, fromJson: _userFromJson) RegisterUser? user,
      @JsonKey(toJson: _colorsToJson, fromJson: _colorsFromJson)
      @protected
      List<Color> colors,
      @JsonKey(toJson: _devicesToJson, fromJson: _devicesFromJson)
      @protected
      List<DiscoveredDevice> devices});
}

/// @nodoc
class _$PlayerModelCopyWithImpl<$Res, $Val extends PlayerModel>
    implements $PlayerModelCopyWith<$Res> {
  _$PlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? name = freezed,
    Object? user = freezed,
    Object? colors = null,
    Object? devices = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as RegisterUser?,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      devices: null == devices
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<DiscoveredDevice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerModelCopyWith<$Res>
    implements $PlayerModelCopyWith<$Res> {
  factory _$$_PlayerModelCopyWith(
          _$_PlayerModel value, $Res Function(_$_PlayerModel) then) =
      __$$_PlayerModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime? createdAt,
      String? name,
      @JsonKey(toJson: _userToJson, fromJson: _userFromJson) RegisterUser? user,
      @JsonKey(toJson: _colorsToJson, fromJson: _colorsFromJson)
      @protected
      List<Color> colors,
      @JsonKey(toJson: _devicesToJson, fromJson: _devicesFromJson)
      @protected
      List<DiscoveredDevice> devices});
}

/// @nodoc
class __$$_PlayerModelCopyWithImpl<$Res>
    extends _$PlayerModelCopyWithImpl<$Res, _$_PlayerModel>
    implements _$$_PlayerModelCopyWith<$Res> {
  __$$_PlayerModelCopyWithImpl(
      _$_PlayerModel _value, $Res Function(_$_PlayerModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? name = freezed,
    Object? user = freezed,
    Object? colors = null,
    Object? devices = null,
  }) {
    return _then(_$_PlayerModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as RegisterUser?,
      colors: null == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      devices: null == devices
          ? _value._devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<DiscoveredDevice>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerModel extends _PlayerModel {
  const _$_PlayerModel(
      {required this.id,
      required this.createdAt,
      this.name,
      @JsonKey(toJson: _userToJson, fromJson: _userFromJson) this.user,
      @JsonKey(toJson: _colorsToJson, fromJson: _colorsFromJson)
      @protected
      final List<Color> colors = const [],
      @JsonKey(toJson: _devicesToJson, fromJson: _devicesFromJson)
      @protected
      final List<DiscoveredDevice> devices = const []})
      : _colors = colors,
        _devices = devices,
        super._();

  factory _$_PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerModelFromJson(json);

  @override
  final String id;

  /// this will be used for sorting the players,
  /// as our id is a string, we cant sort using it
  /// because when we want 2 to be before 10, '10'
  /// actually comes before '2' in the string.
  @override
  final DateTime? createdAt;
  @override
  final String? name;

  /// this indicates the user id associated
  /// with the player.
  @override
  @JsonKey(toJson: _userToJson, fromJson: _userFromJson)
  final RegisterUser? user;
  final List<Color> _colors;
  @override
  @JsonKey(toJson: _colorsToJson, fromJson: _colorsFromJson)
  @protected
  List<Color> get colors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_colors);
  }

  final List<DiscoveredDevice> _devices;
  @override
  @JsonKey(toJson: _devicesToJson, fromJson: _devicesFromJson)
  @protected
  List<DiscoveredDevice> get devices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  String toString() {
    return 'PlayerModel(id: $id, createdAt: $createdAt, name: $name, user: $user, colors: $colors, devices: $devices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._colors, _colors) &&
            const DeepCollectionEquality().equals(other._devices, _devices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      name,
      user,
      const DeepCollectionEquality().hash(_colors),
      const DeepCollectionEquality().hash(_devices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerModelCopyWith<_$_PlayerModel> get copyWith =>
      __$$_PlayerModelCopyWithImpl<_$_PlayerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerModelToJson(
      this,
    );
  }
}

abstract class _PlayerModel extends PlayerModel {
  const factory _PlayerModel(
      {required final String id,
      required final DateTime? createdAt,
      final String? name,
      @JsonKey(toJson: _userToJson, fromJson: _userFromJson)
      final RegisterUser? user,
      @JsonKey(toJson: _colorsToJson, fromJson: _colorsFromJson)
      @protected
      final List<Color> colors,
      @JsonKey(toJson: _devicesToJson, fromJson: _devicesFromJson)
      @protected
      final List<DiscoveredDevice> devices}) = _$_PlayerModel;
  const _PlayerModel._() : super._();

  factory _PlayerModel.fromJson(Map<String, dynamic> json) =
      _$_PlayerModel.fromJson;

  @override
  String get id;
  @override

  /// this will be used for sorting the players,
  /// as our id is a string, we cant sort using it
  /// because when we want 2 to be before 10, '10'
  /// actually comes before '2' in the string.
  DateTime? get createdAt;
  @override
  String? get name;
  @override

  /// this indicates the user id associated
  /// with the player.
  @JsonKey(toJson: _userToJson, fromJson: _userFromJson)
  RegisterUser? get user;
  @override
  @JsonKey(toJson: _colorsToJson, fromJson: _colorsFromJson)
  @protected
  List<Color> get colors;
  @override
  @JsonKey(toJson: _devicesToJson, fromJson: _devicesFromJson)
  @protected
  List<DiscoveredDevice> get devices;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerModelCopyWith<_$_PlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
