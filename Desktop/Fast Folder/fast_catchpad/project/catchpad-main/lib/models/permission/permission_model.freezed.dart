// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'permission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PermissionModel {
  Map<Permission, PermissionStatus> get permissions =>
      throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  PermissionType get type => throw _privateConstructorUsedError;
  IconData? get icon => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionModelCopyWith<PermissionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionModelCopyWith<$Res> {
  factory $PermissionModelCopyWith(
          PermissionModel value, $Res Function(PermissionModel) then) =
      _$PermissionModelCopyWithImpl<$Res, PermissionModel>;
  @useResult
  $Res call(
      {Map<Permission, PermissionStatus> permissions,
      bool isRequired,
      PermissionType type,
      IconData? icon});
}

/// @nodoc
class _$PermissionModelCopyWithImpl<$Res, $Val extends PermissionModel>
    implements $PermissionModelCopyWith<$Res> {
  _$PermissionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permissions = null,
    Object? isRequired = null,
    Object? type = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as Map<Permission, PermissionStatus>,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PermissionType,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PermissionModelCopyWith<$Res>
    implements $PermissionModelCopyWith<$Res> {
  factory _$$_PermissionModelCopyWith(
          _$_PermissionModel value, $Res Function(_$_PermissionModel) then) =
      __$$_PermissionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<Permission, PermissionStatus> permissions,
      bool isRequired,
      PermissionType type,
      IconData? icon});
}

/// @nodoc
class __$$_PermissionModelCopyWithImpl<$Res>
    extends _$PermissionModelCopyWithImpl<$Res, _$_PermissionModel>
    implements _$$_PermissionModelCopyWith<$Res> {
  __$$_PermissionModelCopyWithImpl(
      _$_PermissionModel _value, $Res Function(_$_PermissionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permissions = null,
    Object? isRequired = null,
    Object? type = null,
    Object? icon = freezed,
  }) {
    return _then(_$_PermissionModel(
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as Map<Permission, PermissionStatus>,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PermissionType,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
    ));
  }
}

/// @nodoc

class _$_PermissionModel extends _PermissionModel {
  const _$_PermissionModel(
      {required final Map<Permission, PermissionStatus> permissions,
      required this.isRequired,
      required this.type,
      this.icon})
      : _permissions = permissions,
        super._();

  final Map<Permission, PermissionStatus> _permissions;
  @override
  Map<Permission, PermissionStatus> get permissions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_permissions);
  }

  @override
  final bool isRequired;
  @override
  final PermissionType type;
  @override
  final IconData? icon;

  @override
  String toString() {
    return 'PermissionModel(permissions: $permissions, isRequired: $isRequired, type: $type, icon: $icon)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PermissionModelCopyWith<_$_PermissionModel> get copyWith =>
      __$$_PermissionModelCopyWithImpl<_$_PermissionModel>(this, _$identity);
}

abstract class _PermissionModel extends PermissionModel {
  const factory _PermissionModel(
      {required final Map<Permission, PermissionStatus> permissions,
      required final bool isRequired,
      required final PermissionType type,
      final IconData? icon}) = _$_PermissionModel;
  const _PermissionModel._() : super._();

  @override
  Map<Permission, PermissionStatus> get permissions;
  @override
  bool get isRequired;
  @override
  PermissionType get type;
  @override
  IconData? get icon;
  @override
  @JsonKey(ignore: true)
  _$$_PermissionModelCopyWith<_$_PermissionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
