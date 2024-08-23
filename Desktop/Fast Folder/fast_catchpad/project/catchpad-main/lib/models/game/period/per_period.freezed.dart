// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'per_period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PerPeriod _$PerPeriodFromJson(Map<String, dynamic> json) {
  return _PerPeriod.fromJson(json);
}

/// @nodoc
mixin _$PerPeriod {
  @JsonKey(name: 'devices')
  List<BriefDeviceInfo>? get devices => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerPeriodCopyWith<PerPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerPeriodCopyWith<$Res> {
  factory $PerPeriodCopyWith(PerPeriod value, $Res Function(PerPeriod) then) =
      _$PerPeriodCopyWithImpl<$Res, PerPeriod>;
  @useResult
  $Res call(
      {@JsonKey(name: 'devices') List<BriefDeviceInfo>? devices,
      @JsonKey(name: 'name') String? name});
}

/// @nodoc
class _$PerPeriodCopyWithImpl<$Res, $Val extends PerPeriod>
    implements $PerPeriodCopyWith<$Res> {
  _$PerPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devices = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      devices: freezed == devices
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<BriefDeviceInfo>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PerPeriodCopyWith<$Res> implements $PerPeriodCopyWith<$Res> {
  factory _$$_PerPeriodCopyWith(
          _$_PerPeriod value, $Res Function(_$_PerPeriod) then) =
      __$$_PerPeriodCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'devices') List<BriefDeviceInfo>? devices,
      @JsonKey(name: 'name') String? name});
}

/// @nodoc
class __$$_PerPeriodCopyWithImpl<$Res>
    extends _$PerPeriodCopyWithImpl<$Res, _$_PerPeriod>
    implements _$$_PerPeriodCopyWith<$Res> {
  __$$_PerPeriodCopyWithImpl(
      _$_PerPeriod _value, $Res Function(_$_PerPeriod) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devices = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_PerPeriod(
      devices: freezed == devices
          ? _value._devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<BriefDeviceInfo>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PerPeriod implements _PerPeriod {
  const _$_PerPeriod(
      {@JsonKey(name: 'devices') final List<BriefDeviceInfo>? devices,
      @JsonKey(name: 'name') this.name})
      : _devices = devices;

  factory _$_PerPeriod.fromJson(Map<String, dynamic> json) =>
      _$$_PerPeriodFromJson(json);

  final List<BriefDeviceInfo>? _devices;
  @override
  @JsonKey(name: 'devices')
  List<BriefDeviceInfo>? get devices {
    final value = _devices;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'name')
  final String? name;

  @override
  String toString() {
    return 'PerPeriod(devices: $devices, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PerPeriod &&
            const DeepCollectionEquality().equals(other._devices, _devices) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_devices), name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PerPeriodCopyWith<_$_PerPeriod> get copyWith =>
      __$$_PerPeriodCopyWithImpl<_$_PerPeriod>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PerPeriodToJson(
      this,
    );
  }
}

abstract class _PerPeriod implements PerPeriod {
  const factory _PerPeriod(
      {@JsonKey(name: 'devices') final List<BriefDeviceInfo>? devices,
      @JsonKey(name: 'name') final String? name}) = _$_PerPeriod;

  factory _PerPeriod.fromJson(Map<String, dynamic> json) =
      _$_PerPeriod.fromJson;

  @override
  @JsonKey(name: 'devices')
  List<BriefDeviceInfo>? get devices;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_PerPeriodCopyWith<_$_PerPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}
