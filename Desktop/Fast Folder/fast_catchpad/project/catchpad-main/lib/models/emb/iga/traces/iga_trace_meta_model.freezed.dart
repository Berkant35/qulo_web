// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'iga_trace_meta_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IgaMetaTraceModel _$IgaMetaTraceModelFromJson(Map<String, dynamic> json) {
  return _IgaMetaTraceModel.fromJson(json);
}

/// @nodoc
mixin _$IgaMetaTraceModel {
// we collect all devices infos about connected status, location and tablet info
  @JsonKey(name: 'traceId')
  String? get traceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'connectedDevices')
  List<String> get connectedDevices => throw _privateConstructorUsedError;
  @JsonKey(name: 'tabletInfo')
  Map<String, dynamic> get phoneInformation =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'locationInformation')
  Map<String, dynamic> get locationInformation =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IgaMetaTraceModelCopyWith<IgaMetaTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IgaMetaTraceModelCopyWith<$Res> {
  factory $IgaMetaTraceModelCopyWith(
          IgaMetaTraceModel value, $Res Function(IgaMetaTraceModel) then) =
      _$IgaMetaTraceModelCopyWithImpl<$Res, IgaMetaTraceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'connectedDevices') List<String> connectedDevices,
      @JsonKey(name: 'tabletInfo') Map<String, dynamic> phoneInformation,
      @JsonKey(name: 'locationInformation')
      Map<String, dynamic> locationInformation});
}

/// @nodoc
class _$IgaMetaTraceModelCopyWithImpl<$Res, $Val extends IgaMetaTraceModel>
    implements $IgaMetaTraceModelCopyWith<$Res> {
  _$IgaMetaTraceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? connectedDevices = null,
    Object? phoneInformation = null,
    Object? locationInformation = null,
  }) {
    return _then(_value.copyWith(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedDevices: null == connectedDevices
          ? _value.connectedDevices
          : connectedDevices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      phoneInformation: null == phoneInformation
          ? _value.phoneInformation
          : phoneInformation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locationInformation: null == locationInformation
          ? _value.locationInformation
          : locationInformation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IgaMetaTraceModelCopyWith<$Res>
    implements $IgaMetaTraceModelCopyWith<$Res> {
  factory _$$_IgaMetaTraceModelCopyWith(_$_IgaMetaTraceModel value,
          $Res Function(_$_IgaMetaTraceModel) then) =
      __$$_IgaMetaTraceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'connectedDevices') List<String> connectedDevices,
      @JsonKey(name: 'tabletInfo') Map<String, dynamic> phoneInformation,
      @JsonKey(name: 'locationInformation')
      Map<String, dynamic> locationInformation});
}

/// @nodoc
class __$$_IgaMetaTraceModelCopyWithImpl<$Res>
    extends _$IgaMetaTraceModelCopyWithImpl<$Res, _$_IgaMetaTraceModel>
    implements _$$_IgaMetaTraceModelCopyWith<$Res> {
  __$$_IgaMetaTraceModelCopyWithImpl(
      _$_IgaMetaTraceModel _value, $Res Function(_$_IgaMetaTraceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? connectedDevices = null,
    Object? phoneInformation = null,
    Object? locationInformation = null,
  }) {
    return _then(_$_IgaMetaTraceModel(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedDevices: null == connectedDevices
          ? _value._connectedDevices
          : connectedDevices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      phoneInformation: null == phoneInformation
          ? _value._phoneInformation
          : phoneInformation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locationInformation: null == locationInformation
          ? _value._locationInformation
          : locationInformation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IgaMetaTraceModel implements _IgaMetaTraceModel {
  const _$_IgaMetaTraceModel(
      {@JsonKey(name: 'traceId') this.traceId,
      @JsonKey(name: 'connectedDevices')
      final List<String> connectedDevices = const [],
      @JsonKey(name: 'tabletInfo')
      final Map<String, dynamic> phoneInformation = const {},
      @JsonKey(name: 'locationInformation')
      final Map<String, dynamic> locationInformation = const {}})
      : _connectedDevices = connectedDevices,
        _phoneInformation = phoneInformation,
        _locationInformation = locationInformation;

  factory _$_IgaMetaTraceModel.fromJson(Map<String, dynamic> json) =>
      _$$_IgaMetaTraceModelFromJson(json);

// we collect all devices infos about connected status, location and tablet info
  @override
  @JsonKey(name: 'traceId')
  final String? traceId;
  final List<String> _connectedDevices;
  @override
  @JsonKey(name: 'connectedDevices')
  List<String> get connectedDevices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connectedDevices);
  }

  final Map<String, dynamic> _phoneInformation;
  @override
  @JsonKey(name: 'tabletInfo')
  Map<String, dynamic> get phoneInformation {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_phoneInformation);
  }

  final Map<String, dynamic> _locationInformation;
  @override
  @JsonKey(name: 'locationInformation')
  Map<String, dynamic> get locationInformation {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_locationInformation);
  }

  @override
  String toString() {
    return 'IgaMetaTraceModel(traceId: $traceId, connectedDevices: $connectedDevices, phoneInformation: $phoneInformation, locationInformation: $locationInformation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IgaMetaTraceModel &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            const DeepCollectionEquality()
                .equals(other._connectedDevices, _connectedDevices) &&
            const DeepCollectionEquality()
                .equals(other._phoneInformation, _phoneInformation) &&
            const DeepCollectionEquality()
                .equals(other._locationInformation, _locationInformation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      traceId,
      const DeepCollectionEquality().hash(_connectedDevices),
      const DeepCollectionEquality().hash(_phoneInformation),
      const DeepCollectionEquality().hash(_locationInformation));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IgaMetaTraceModelCopyWith<_$_IgaMetaTraceModel> get copyWith =>
      __$$_IgaMetaTraceModelCopyWithImpl<_$_IgaMetaTraceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IgaMetaTraceModelToJson(
      this,
    );
  }
}

abstract class _IgaMetaTraceModel implements IgaMetaTraceModel {
  const factory _IgaMetaTraceModel(
      {@JsonKey(name: 'traceId') final String? traceId,
      @JsonKey(name: 'connectedDevices') final List<String> connectedDevices,
      @JsonKey(name: 'tabletInfo') final Map<String, dynamic> phoneInformation,
      @JsonKey(name: 'locationInformation')
      final Map<String, dynamic> locationInformation}) = _$_IgaMetaTraceModel;

  factory _IgaMetaTraceModel.fromJson(Map<String, dynamic> json) =
      _$_IgaMetaTraceModel.fromJson;

  @override // we collect all devices infos about connected status, location and tablet info
  @JsonKey(name: 'traceId')
  String? get traceId;
  @override
  @JsonKey(name: 'connectedDevices')
  List<String> get connectedDevices;
  @override
  @JsonKey(name: 'tabletInfo')
  Map<String, dynamic> get phoneInformation;
  @override
  @JsonKey(name: 'locationInformation')
  Map<String, dynamic> get locationInformation;
  @override
  @JsonKey(ignore: true)
  _$$_IgaMetaTraceModelCopyWith<_$_IgaMetaTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
