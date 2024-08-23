// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'meta_trace.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MetaTrace _$MetaTraceFromJson(Map<String, dynamic> json) {
  return _MetaTrace.fromJson(json);
}

/// @nodoc
mixin _$MetaTrace {
  /// Represents the unique identifier for the game trace.
  @JsonKey(name: 'traceID')
  String? get traceID => throw _privateConstructorUsedError;

  /// Represents the unique identifier for the user associated with the game trace.
  @JsonKey(name: 'userID')
  String? get userID => throw _privateConstructorUsedError;

  /// Represents the unique identifier for the game associated with the trace.
  @JsonKey(name: 'gameID')
  String? get gameID => throw _privateConstructorUsedError;

  /// Represents the operating system (OS) on which the game was played.
  @JsonKey(name: 'os')
  String? get os => throw _privateConstructorUsedError;

  /// Represents the model of the phone used to play the game.
  @JsonKey(name: 'phoneModel')
  String? get phoneModel => throw _privateConstructorUsedError;

  /// Represents the MAC address of the phone used to play the game.
  @JsonKey(name: 'phoneMacID')
  String? get phoneMacID => throw _privateConstructorUsedError;
  @JsonKey(name: 'manufacturer')
  String? get manufacturer => throw _privateConstructorUsedError;
  @JsonKey(name: 'cpuType')
  String? get cpuType => throw _privateConstructorUsedError;
  @JsonKey(name: 'platformVersion')
  String? get platformVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'imeiNo')
  String? get imeiNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'apiLevel')
  String? get apiLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'deviceName')
  String? get deviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'productName')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'hardware')
  String? get hardware => throw _privateConstructorUsedError;

  /// Represents the timestamp when the game trace was created.
  @JsonKey(name: 'createdTime')
  String? get createdTime => throw _privateConstructorUsedError;
  @JsonKey(name: "millisecondEpoch")
  String? get createdMillisecondEpoch => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetaTraceCopyWith<MetaTrace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaTraceCopyWith<$Res> {
  factory $MetaTraceCopyWith(MetaTrace value, $Res Function(MetaTrace) then) =
      _$MetaTraceCopyWithImpl<$Res, MetaTrace>;
  @useResult
  $Res call(
      {@JsonKey(name: 'traceID') String? traceID,
      @JsonKey(name: 'userID') String? userID,
      @JsonKey(name: 'gameID') String? gameID,
      @JsonKey(name: 'os') String? os,
      @JsonKey(name: 'phoneModel') String? phoneModel,
      @JsonKey(name: 'phoneMacID') String? phoneMacID,
      @JsonKey(name: 'manufacturer') String? manufacturer,
      @JsonKey(name: 'cpuType') String? cpuType,
      @JsonKey(name: 'platformVersion') String? platformVersion,
      @JsonKey(name: 'imeiNo') String? imeiNo,
      @JsonKey(name: 'apiLevel') String? apiLevel,
      @JsonKey(name: 'deviceName') String? deviceName,
      @JsonKey(name: 'productName') String? productName,
      @JsonKey(name: 'hardware') String? hardware,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: "millisecondEpoch") String? createdMillisecondEpoch,
      String? createdAt});
}

/// @nodoc
class _$MetaTraceCopyWithImpl<$Res, $Val extends MetaTrace>
    implements $MetaTraceCopyWith<$Res> {
  _$MetaTraceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceID = freezed,
    Object? userID = freezed,
    Object? gameID = freezed,
    Object? os = freezed,
    Object? phoneModel = freezed,
    Object? phoneMacID = freezed,
    Object? manufacturer = freezed,
    Object? cpuType = freezed,
    Object? platformVersion = freezed,
    Object? imeiNo = freezed,
    Object? apiLevel = freezed,
    Object? deviceName = freezed,
    Object? productName = freezed,
    Object? hardware = freezed,
    Object? createdTime = freezed,
    Object? createdMillisecondEpoch = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      traceID: freezed == traceID
          ? _value.traceID
          : traceID // ignore: cast_nullable_to_non_nullable
              as String?,
      userID: freezed == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
      gameID: freezed == gameID
          ? _value.gameID
          : gameID // ignore: cast_nullable_to_non_nullable
              as String?,
      os: freezed == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneModel: freezed == phoneModel
          ? _value.phoneModel
          : phoneModel // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneMacID: freezed == phoneMacID
          ? _value.phoneMacID
          : phoneMacID // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      cpuType: freezed == cpuType
          ? _value.cpuType
          : cpuType // ignore: cast_nullable_to_non_nullable
              as String?,
      platformVersion: freezed == platformVersion
          ? _value.platformVersion
          : platformVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      imeiNo: freezed == imeiNo
          ? _value.imeiNo
          : imeiNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apiLevel: freezed == apiLevel
          ? _value.apiLevel
          : apiLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      hardware: freezed == hardware
          ? _value.hardware
          : hardware // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MetaTraceCopyWith<$Res> implements $MetaTraceCopyWith<$Res> {
  factory _$$_MetaTraceCopyWith(
          _$_MetaTrace value, $Res Function(_$_MetaTrace) then) =
      __$$_MetaTraceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'traceID') String? traceID,
      @JsonKey(name: 'userID') String? userID,
      @JsonKey(name: 'gameID') String? gameID,
      @JsonKey(name: 'os') String? os,
      @JsonKey(name: 'phoneModel') String? phoneModel,
      @JsonKey(name: 'phoneMacID') String? phoneMacID,
      @JsonKey(name: 'manufacturer') String? manufacturer,
      @JsonKey(name: 'cpuType') String? cpuType,
      @JsonKey(name: 'platformVersion') String? platformVersion,
      @JsonKey(name: 'imeiNo') String? imeiNo,
      @JsonKey(name: 'apiLevel') String? apiLevel,
      @JsonKey(name: 'deviceName') String? deviceName,
      @JsonKey(name: 'productName') String? productName,
      @JsonKey(name: 'hardware') String? hardware,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: "millisecondEpoch") String? createdMillisecondEpoch,
      String? createdAt});
}

/// @nodoc
class __$$_MetaTraceCopyWithImpl<$Res>
    extends _$MetaTraceCopyWithImpl<$Res, _$_MetaTrace>
    implements _$$_MetaTraceCopyWith<$Res> {
  __$$_MetaTraceCopyWithImpl(
      _$_MetaTrace _value, $Res Function(_$_MetaTrace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceID = freezed,
    Object? userID = freezed,
    Object? gameID = freezed,
    Object? os = freezed,
    Object? phoneModel = freezed,
    Object? phoneMacID = freezed,
    Object? manufacturer = freezed,
    Object? cpuType = freezed,
    Object? platformVersion = freezed,
    Object? imeiNo = freezed,
    Object? apiLevel = freezed,
    Object? deviceName = freezed,
    Object? productName = freezed,
    Object? hardware = freezed,
    Object? createdTime = freezed,
    Object? createdMillisecondEpoch = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_MetaTrace(
      traceID: freezed == traceID
          ? _value.traceID
          : traceID // ignore: cast_nullable_to_non_nullable
              as String?,
      userID: freezed == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
      gameID: freezed == gameID
          ? _value.gameID
          : gameID // ignore: cast_nullable_to_non_nullable
              as String?,
      os: freezed == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneModel: freezed == phoneModel
          ? _value.phoneModel
          : phoneModel // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneMacID: freezed == phoneMacID
          ? _value.phoneMacID
          : phoneMacID // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      cpuType: freezed == cpuType
          ? _value.cpuType
          : cpuType // ignore: cast_nullable_to_non_nullable
              as String?,
      platformVersion: freezed == platformVersion
          ? _value.platformVersion
          : platformVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      imeiNo: freezed == imeiNo
          ? _value.imeiNo
          : imeiNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apiLevel: freezed == apiLevel
          ? _value.apiLevel
          : apiLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      hardware: freezed == hardware
          ? _value.hardware
          : hardware // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MetaTrace with DiagnosticableTreeMixin implements _MetaTrace {
  const _$_MetaTrace(
      {@JsonKey(name: 'traceID') this.traceID,
      @JsonKey(name: 'userID') this.userID,
      @JsonKey(name: 'gameID') this.gameID,
      @JsonKey(name: 'os') this.os,
      @JsonKey(name: 'phoneModel') this.phoneModel,
      @JsonKey(name: 'phoneMacID') this.phoneMacID,
      @JsonKey(name: 'manufacturer') this.manufacturer,
      @JsonKey(name: 'cpuType') this.cpuType,
      @JsonKey(name: 'platformVersion') this.platformVersion,
      @JsonKey(name: 'imeiNo') this.imeiNo,
      @JsonKey(name: 'apiLevel') this.apiLevel,
      @JsonKey(name: 'deviceName') this.deviceName,
      @JsonKey(name: 'productName') this.productName,
      @JsonKey(name: 'hardware') this.hardware,
      @JsonKey(name: 'createdTime') this.createdTime,
      @JsonKey(name: "millisecondEpoch") this.createdMillisecondEpoch,
      this.createdAt});

  factory _$_MetaTrace.fromJson(Map<String, dynamic> json) =>
      _$$_MetaTraceFromJson(json);

  /// Represents the unique identifier for the game trace.
  @override
  @JsonKey(name: 'traceID')
  final String? traceID;

  /// Represents the unique identifier for the user associated with the game trace.
  @override
  @JsonKey(name: 'userID')
  final String? userID;

  /// Represents the unique identifier for the game associated with the trace.
  @override
  @JsonKey(name: 'gameID')
  final String? gameID;

  /// Represents the operating system (OS) on which the game was played.
  @override
  @JsonKey(name: 'os')
  final String? os;

  /// Represents the model of the phone used to play the game.
  @override
  @JsonKey(name: 'phoneModel')
  final String? phoneModel;

  /// Represents the MAC address of the phone used to play the game.
  @override
  @JsonKey(name: 'phoneMacID')
  final String? phoneMacID;
  @override
  @JsonKey(name: 'manufacturer')
  final String? manufacturer;
  @override
  @JsonKey(name: 'cpuType')
  final String? cpuType;
  @override
  @JsonKey(name: 'platformVersion')
  final String? platformVersion;
  @override
  @JsonKey(name: 'imeiNo')
  final String? imeiNo;
  @override
  @JsonKey(name: 'apiLevel')
  final String? apiLevel;
  @override
  @JsonKey(name: 'deviceName')
  final String? deviceName;
  @override
  @JsonKey(name: 'productName')
  final String? productName;
  @override
  @JsonKey(name: 'hardware')
  final String? hardware;

  /// Represents the timestamp when the game trace was created.
  @override
  @JsonKey(name: 'createdTime')
  final String? createdTime;
  @override
  @JsonKey(name: "millisecondEpoch")
  final String? createdMillisecondEpoch;
  @override
  final String? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MetaTrace(traceID: $traceID, userID: $userID, gameID: $gameID, os: $os, phoneModel: $phoneModel, phoneMacID: $phoneMacID, manufacturer: $manufacturer, cpuType: $cpuType, platformVersion: $platformVersion, imeiNo: $imeiNo, apiLevel: $apiLevel, deviceName: $deviceName, productName: $productName, hardware: $hardware, createdTime: $createdTime, createdMillisecondEpoch: $createdMillisecondEpoch, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MetaTrace'))
      ..add(DiagnosticsProperty('traceID', traceID))
      ..add(DiagnosticsProperty('userID', userID))
      ..add(DiagnosticsProperty('gameID', gameID))
      ..add(DiagnosticsProperty('os', os))
      ..add(DiagnosticsProperty('phoneModel', phoneModel))
      ..add(DiagnosticsProperty('phoneMacID', phoneMacID))
      ..add(DiagnosticsProperty('manufacturer', manufacturer))
      ..add(DiagnosticsProperty('cpuType', cpuType))
      ..add(DiagnosticsProperty('platformVersion', platformVersion))
      ..add(DiagnosticsProperty('imeiNo', imeiNo))
      ..add(DiagnosticsProperty('apiLevel', apiLevel))
      ..add(DiagnosticsProperty('deviceName', deviceName))
      ..add(DiagnosticsProperty('productName', productName))
      ..add(DiagnosticsProperty('hardware', hardware))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty(
          'createdMillisecondEpoch', createdMillisecondEpoch))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MetaTrace &&
            (identical(other.traceID, traceID) || other.traceID == traceID) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.gameID, gameID) || other.gameID == gameID) &&
            (identical(other.os, os) || other.os == os) &&
            (identical(other.phoneModel, phoneModel) ||
                other.phoneModel == phoneModel) &&
            (identical(other.phoneMacID, phoneMacID) ||
                other.phoneMacID == phoneMacID) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.cpuType, cpuType) || other.cpuType == cpuType) &&
            (identical(other.platformVersion, platformVersion) ||
                other.platformVersion == platformVersion) &&
            (identical(other.imeiNo, imeiNo) || other.imeiNo == imeiNo) &&
            (identical(other.apiLevel, apiLevel) ||
                other.apiLevel == apiLevel) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.hardware, hardware) ||
                other.hardware == hardware) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(
                    other.createdMillisecondEpoch, createdMillisecondEpoch) ||
                other.createdMillisecondEpoch == createdMillisecondEpoch) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      traceID,
      userID,
      gameID,
      os,
      phoneModel,
      phoneMacID,
      manufacturer,
      cpuType,
      platformVersion,
      imeiNo,
      apiLevel,
      deviceName,
      productName,
      hardware,
      createdTime,
      createdMillisecondEpoch,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MetaTraceCopyWith<_$_MetaTrace> get copyWith =>
      __$$_MetaTraceCopyWithImpl<_$_MetaTrace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MetaTraceToJson(
      this,
    );
  }
}

abstract class _MetaTrace implements MetaTrace {
  const factory _MetaTrace(
      {@JsonKey(name: 'traceID') final String? traceID,
      @JsonKey(name: 'userID') final String? userID,
      @JsonKey(name: 'gameID') final String? gameID,
      @JsonKey(name: 'os') final String? os,
      @JsonKey(name: 'phoneModel') final String? phoneModel,
      @JsonKey(name: 'phoneMacID') final String? phoneMacID,
      @JsonKey(name: 'manufacturer') final String? manufacturer,
      @JsonKey(name: 'cpuType') final String? cpuType,
      @JsonKey(name: 'platformVersion') final String? platformVersion,
      @JsonKey(name: 'imeiNo') final String? imeiNo,
      @JsonKey(name: 'apiLevel') final String? apiLevel,
      @JsonKey(name: 'deviceName') final String? deviceName,
      @JsonKey(name: 'productName') final String? productName,
      @JsonKey(name: 'hardware') final String? hardware,
      @JsonKey(name: 'createdTime') final String? createdTime,
      @JsonKey(name: "millisecondEpoch") final String? createdMillisecondEpoch,
      final String? createdAt}) = _$_MetaTrace;

  factory _MetaTrace.fromJson(Map<String, dynamic> json) =
      _$_MetaTrace.fromJson;

  @override

  /// Represents the unique identifier for the game trace.
  @JsonKey(name: 'traceID')
  String? get traceID;
  @override

  /// Represents the unique identifier for the user associated with the game trace.
  @JsonKey(name: 'userID')
  String? get userID;
  @override

  /// Represents the unique identifier for the game associated with the trace.
  @JsonKey(name: 'gameID')
  String? get gameID;
  @override

  /// Represents the operating system (OS) on which the game was played.
  @JsonKey(name: 'os')
  String? get os;
  @override

  /// Represents the model of the phone used to play the game.
  @JsonKey(name: 'phoneModel')
  String? get phoneModel;
  @override

  /// Represents the MAC address of the phone used to play the game.
  @JsonKey(name: 'phoneMacID')
  String? get phoneMacID;
  @override
  @JsonKey(name: 'manufacturer')
  String? get manufacturer;
  @override
  @JsonKey(name: 'cpuType')
  String? get cpuType;
  @override
  @JsonKey(name: 'platformVersion')
  String? get platformVersion;
  @override
  @JsonKey(name: 'imeiNo')
  String? get imeiNo;
  @override
  @JsonKey(name: 'apiLevel')
  String? get apiLevel;
  @override
  @JsonKey(name: 'deviceName')
  String? get deviceName;
  @override
  @JsonKey(name: 'productName')
  String? get productName;
  @override
  @JsonKey(name: 'hardware')
  String? get hardware;
  @override

  /// Represents the timestamp when the game trace was created.
  @JsonKey(name: 'createdTime')
  String? get createdTime;
  @override
  @JsonKey(name: "millisecondEpoch")
  String? get createdMillisecondEpoch;
  @override
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_MetaTraceCopyWith<_$_MetaTrace> get copyWith =>
      throw _privateConstructorUsedError;
}
