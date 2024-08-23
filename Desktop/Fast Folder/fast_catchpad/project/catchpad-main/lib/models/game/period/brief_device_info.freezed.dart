// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'brief_device_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BriefDeviceInfo _$BriefDeviceInfoFromJson(Map<String, dynamic> json) {
  return _BriefDeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$BriefDeviceInfo {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get colorStr => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BriefDeviceInfoCopyWith<BriefDeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BriefDeviceInfoCopyWith<$Res> {
  factory $BriefDeviceInfoCopyWith(
          BriefDeviceInfo value, $Res Function(BriefDeviceInfo) then) =
      _$BriefDeviceInfoCopyWithImpl<$Res, BriefDeviceInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'color') String? colorStr});
}

/// @nodoc
class _$BriefDeviceInfoCopyWithImpl<$Res, $Val extends BriefDeviceInfo>
    implements $BriefDeviceInfoCopyWith<$Res> {
  _$BriefDeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? colorStr = freezed,
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
      colorStr: freezed == colorStr
          ? _value.colorStr
          : colorStr // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BriefDeviceInfoCopyWith<$Res>
    implements $BriefDeviceInfoCopyWith<$Res> {
  factory _$$_BriefDeviceInfoCopyWith(
          _$_BriefDeviceInfo value, $Res Function(_$_BriefDeviceInfo) then) =
      __$$_BriefDeviceInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'color') String? colorStr});
}

/// @nodoc
class __$$_BriefDeviceInfoCopyWithImpl<$Res>
    extends _$BriefDeviceInfoCopyWithImpl<$Res, _$_BriefDeviceInfo>
    implements _$$_BriefDeviceInfoCopyWith<$Res> {
  __$$_BriefDeviceInfoCopyWithImpl(
      _$_BriefDeviceInfo _value, $Res Function(_$_BriefDeviceInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? colorStr = freezed,
  }) {
    return _then(_$_BriefDeviceInfo(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      colorStr: freezed == colorStr
          ? _value.colorStr
          : colorStr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BriefDeviceInfo
    with DiagnosticableTreeMixin
    implements _BriefDeviceInfo {
  const _$_BriefDeviceInfo(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'color') this.colorStr});

  factory _$_BriefDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$$_BriefDeviceInfoFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'color')
  final String? colorStr;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BriefDeviceInfo(id: $id, name: $name, colorStr: $colorStr)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BriefDeviceInfo'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('colorStr', colorStr));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BriefDeviceInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.colorStr, colorStr) ||
                other.colorStr == colorStr));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, colorStr);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BriefDeviceInfoCopyWith<_$_BriefDeviceInfo> get copyWith =>
      __$$_BriefDeviceInfoCopyWithImpl<_$_BriefDeviceInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BriefDeviceInfoToJson(
      this,
    );
  }
}

abstract class _BriefDeviceInfo implements BriefDeviceInfo {
  const factory _BriefDeviceInfo(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'color') final String? colorStr}) = _$_BriefDeviceInfo;

  factory _BriefDeviceInfo.fromJson(Map<String, dynamic> json) =
      _$_BriefDeviceInfo.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'color')
  String? get colorStr;
  @override
  @JsonKey(ignore: true)
  _$$_BriefDeviceInfoCopyWith<_$_BriefDeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
