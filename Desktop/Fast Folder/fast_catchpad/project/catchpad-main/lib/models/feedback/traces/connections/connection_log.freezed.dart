// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'connection_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConnectionLog _$ConnectionLogFromJson(Map<String, dynamic> json) {
  return _ConnectionLog.fromJson(json);
}

/// @nodoc
mixin _$ConnectionLog {
  @JsonKey(name: 'last_connection_time')
  String? get lastConnectionTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_id')
  String? get macId => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_model')
  String? get deviceModel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectionLogCopyWith<ConnectionLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionLogCopyWith<$Res> {
  factory $ConnectionLogCopyWith(
          ConnectionLog value, $Res Function(ConnectionLog) then) =
      _$ConnectionLogCopyWithImpl<$Res, ConnectionLog>;
  @useResult
  $Res call(
      {@JsonKey(name: 'last_connection_time') String? lastConnectionTime,
      @JsonKey(name: 'device_id') String? macId,
      @JsonKey(name: 'device_model') String? deviceModel});
}

/// @nodoc
class _$ConnectionLogCopyWithImpl<$Res, $Val extends ConnectionLog>
    implements $ConnectionLogCopyWith<$Res> {
  _$ConnectionLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastConnectionTime = freezed,
    Object? macId = freezed,
    Object? deviceModel = freezed,
  }) {
    return _then(_value.copyWith(
      lastConnectionTime: freezed == lastConnectionTime
          ? _value.lastConnectionTime
          : lastConnectionTime // ignore: cast_nullable_to_non_nullable
              as String?,
      macId: freezed == macId
          ? _value.macId
          : macId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConnectionLogCopyWith<$Res>
    implements $ConnectionLogCopyWith<$Res> {
  factory _$$_ConnectionLogCopyWith(
          _$_ConnectionLog value, $Res Function(_$_ConnectionLog) then) =
      __$$_ConnectionLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'last_connection_time') String? lastConnectionTime,
      @JsonKey(name: 'device_id') String? macId,
      @JsonKey(name: 'device_model') String? deviceModel});
}

/// @nodoc
class __$$_ConnectionLogCopyWithImpl<$Res>
    extends _$ConnectionLogCopyWithImpl<$Res, _$_ConnectionLog>
    implements _$$_ConnectionLogCopyWith<$Res> {
  __$$_ConnectionLogCopyWithImpl(
      _$_ConnectionLog _value, $Res Function(_$_ConnectionLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastConnectionTime = freezed,
    Object? macId = freezed,
    Object? deviceModel = freezed,
  }) {
    return _then(_$_ConnectionLog(
      lastConnectionTime: freezed == lastConnectionTime
          ? _value.lastConnectionTime
          : lastConnectionTime // ignore: cast_nullable_to_non_nullable
              as String?,
      macId: freezed == macId
          ? _value.macId
          : macId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConnectionLog with DiagnosticableTreeMixin implements _ConnectionLog {
  const _$_ConnectionLog(
      {@JsonKey(name: 'last_connection_time') this.lastConnectionTime,
      @JsonKey(name: 'device_id') this.macId,
      @JsonKey(name: 'device_model') this.deviceModel});

  factory _$_ConnectionLog.fromJson(Map<String, dynamic> json) =>
      _$$_ConnectionLogFromJson(json);

  @override
  @JsonKey(name: 'last_connection_time')
  final String? lastConnectionTime;
  @override
  @JsonKey(name: 'device_id')
  final String? macId;
  @override
  @JsonKey(name: 'device_model')
  final String? deviceModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConnectionLog(lastConnectionTime: $lastConnectionTime, macId: $macId, deviceModel: $deviceModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConnectionLog'))
      ..add(DiagnosticsProperty('lastConnectionTime', lastConnectionTime))
      ..add(DiagnosticsProperty('macId', macId))
      ..add(DiagnosticsProperty('deviceModel', deviceModel));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectionLog &&
            (identical(other.lastConnectionTime, lastConnectionTime) ||
                other.lastConnectionTime == lastConnectionTime) &&
            (identical(other.macId, macId) || other.macId == macId) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, lastConnectionTime, macId, deviceModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConnectionLogCopyWith<_$_ConnectionLog> get copyWith =>
      __$$_ConnectionLogCopyWithImpl<_$_ConnectionLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConnectionLogToJson(
      this,
    );
  }
}

abstract class _ConnectionLog implements ConnectionLog {
  const factory _ConnectionLog(
      {@JsonKey(name: 'last_connection_time') final String? lastConnectionTime,
      @JsonKey(name: 'device_id') final String? macId,
      @JsonKey(name: 'device_model')
      final String? deviceModel}) = _$_ConnectionLog;

  factory _ConnectionLog.fromJson(Map<String, dynamic> json) =
      _$_ConnectionLog.fromJson;

  @override
  @JsonKey(name: 'last_connection_time')
  String? get lastConnectionTime;
  @override
  @JsonKey(name: 'device_id')
  String? get macId;
  @override
  @JsonKey(name: 'device_model')
  String? get deviceModel;
  @override
  @JsonKey(ignore: true)
  _$$_ConnectionLogCopyWith<_$_ConnectionLog> get copyWith =>
      throw _privateConstructorUsedError;
}
