// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pre_trace.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PreTrace _$PreTraceFromJson(Map<String, dynamic> json) {
  return _PreTrace.fromJson(json);
}

/// @nodoc
mixin _$PreTrace {
  /// Represents the number of clicks made to the screen during the game.
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  int? get clickToScreenCount => throw _privateConstructorUsedError;

  /// Represents the amount of time passed during the game, measured in some unit (e.g., seconds).
  @JsonKey(name: 'passedTime', defaultValue: 0)
  int? get passedTime => throw _privateConstructorUsedError;

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @JsonKey(name: 'endTime')
  String? get endTime => throw _privateConstructorUsedError;

  /// Represents the timestamp when the game trace was created.
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "createdMillisecondEpoch")
  String? get createdMillisecondEpoch => throw _privateConstructorUsedError;

  /// Represents the initial battery charge percentage of the phone.
  @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
  int? get phoneChargeStartPercent => throw _privateConstructorUsedError;

  /// Represents a list of products associated with the game trace.
  @JsonKey(name: 'padList', defaultValue: {})
  Map<String, dynamic> get padList => throw _privateConstructorUsedError;

  /// Represents the location data (latitude and longitude) associated with the game trace.
  @JsonKey(name: 'locationData')
  Map<String, double>? get locationData => throw _privateConstructorUsedError;

  /// Represents a mapping of pad IDs to their battery levels.
  @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
  Map<String, double>? get padBatteryMapStart =>
      throw _privateConstructorUsedError;

  /// Indicates whether the player has entered the game or not.
  @JsonKey(name: 'isEnterToGame', defaultValue: false)
  bool? get isEnterToGame => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreTraceCopyWith<PreTrace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreTraceCopyWith<$Res> {
  factory $PreTraceCopyWith(PreTrace value, $Res Function(PreTrace) then) =
      _$PreTraceCopyWithImpl<$Res, PreTrace>;
  @useResult
  $Res call(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      int? clickToScreenCount,
      @JsonKey(name: 'passedTime', defaultValue: 0) int? passedTime,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: "createdMillisecondEpoch") String? createdMillisecondEpoch,
      @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
      int? phoneChargeStartPercent,
      @JsonKey(name: 'padList', defaultValue: {}) Map<String, dynamic> padList,
      @JsonKey(name: 'locationData') Map<String, double>? locationData,
      @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
      Map<String, double>? padBatteryMapStart,
      @JsonKey(name: 'isEnterToGame', defaultValue: false)
      bool? isEnterToGame});
}

/// @nodoc
class _$PreTraceCopyWithImpl<$Res, $Val extends PreTrace>
    implements $PreTraceCopyWith<$Res> {
  _$PreTraceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickToScreenCount = freezed,
    Object? passedTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
    Object? createdMillisecondEpoch = freezed,
    Object? phoneChargeStartPercent = freezed,
    Object? padList = null,
    Object? locationData = freezed,
    Object? padBatteryMapStart = freezed,
    Object? isEnterToGame = freezed,
  }) {
    return _then(_value.copyWith(
      clickToScreenCount: freezed == clickToScreenCount
          ? _value.clickToScreenCount
          : clickToScreenCount // ignore: cast_nullable_to_non_nullable
              as int?,
      passedTime: freezed == passedTime
          ? _value.passedTime
          : passedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneChargeStartPercent: freezed == phoneChargeStartPercent
          ? _value.phoneChargeStartPercent
          : phoneChargeStartPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      padList: null == padList
          ? _value.padList
          : padList // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locationData: freezed == locationData
          ? _value.locationData
          : locationData // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      padBatteryMapStart: freezed == padBatteryMapStart
          ? _value.padBatteryMapStart
          : padBatteryMapStart // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      isEnterToGame: freezed == isEnterToGame
          ? _value.isEnterToGame
          : isEnterToGame // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PreTraceCopyWith<$Res> implements $PreTraceCopyWith<$Res> {
  factory _$$_PreTraceCopyWith(
          _$_PreTrace value, $Res Function(_$_PreTrace) then) =
      __$$_PreTraceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      int? clickToScreenCount,
      @JsonKey(name: 'passedTime', defaultValue: 0) int? passedTime,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: "createdMillisecondEpoch") String? createdMillisecondEpoch,
      @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
      int? phoneChargeStartPercent,
      @JsonKey(name: 'padList', defaultValue: {}) Map<String, dynamic> padList,
      @JsonKey(name: 'locationData') Map<String, double>? locationData,
      @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
      Map<String, double>? padBatteryMapStart,
      @JsonKey(name: 'isEnterToGame', defaultValue: false)
      bool? isEnterToGame});
}

/// @nodoc
class __$$_PreTraceCopyWithImpl<$Res>
    extends _$PreTraceCopyWithImpl<$Res, _$_PreTrace>
    implements _$$_PreTraceCopyWith<$Res> {
  __$$_PreTraceCopyWithImpl(
      _$_PreTrace _value, $Res Function(_$_PreTrace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickToScreenCount = freezed,
    Object? passedTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
    Object? createdMillisecondEpoch = freezed,
    Object? phoneChargeStartPercent = freezed,
    Object? padList = null,
    Object? locationData = freezed,
    Object? padBatteryMapStart = freezed,
    Object? isEnterToGame = freezed,
  }) {
    return _then(_$_PreTrace(
      clickToScreenCount: freezed == clickToScreenCount
          ? _value.clickToScreenCount
          : clickToScreenCount // ignore: cast_nullable_to_non_nullable
              as int?,
      passedTime: freezed == passedTime
          ? _value.passedTime
          : passedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneChargeStartPercent: freezed == phoneChargeStartPercent
          ? _value.phoneChargeStartPercent
          : phoneChargeStartPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      padList: null == padList
          ? _value._padList
          : padList // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      locationData: freezed == locationData
          ? _value._locationData
          : locationData // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      padBatteryMapStart: freezed == padBatteryMapStart
          ? _value._padBatteryMapStart
          : padBatteryMapStart // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      isEnterToGame: freezed == isEnterToGame
          ? _value.isEnterToGame
          : isEnterToGame // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreTrace with DiagnosticableTreeMixin implements _PreTrace {
  const _$_PreTrace(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      this.clickToScreenCount = 0,
      @JsonKey(name: 'passedTime', defaultValue: 0) this.passedTime = 0,
      @JsonKey(name: 'endTime') this.endTime,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: "createdMillisecondEpoch") this.createdMillisecondEpoch,
      @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
      this.phoneChargeStartPercent = 0,
      @JsonKey(name: 'padList', defaultValue: {})
      final Map<String, dynamic> padList = const {},
      @JsonKey(name: 'locationData') final Map<String, double>? locationData,
      @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
      final Map<String, double>? padBatteryMapStart = const {},
      @JsonKey(name: 'isEnterToGame', defaultValue: false)
      this.isEnterToGame = false})
      : _padList = padList,
        _locationData = locationData,
        _padBatteryMapStart = padBatteryMapStart;

  factory _$_PreTrace.fromJson(Map<String, dynamic> json) =>
      _$$_PreTraceFromJson(json);

  /// Represents the number of clicks made to the screen during the game.
  @override
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  final int? clickToScreenCount;

  /// Represents the amount of time passed during the game, measured in some unit (e.g., seconds).
  @override
  @JsonKey(name: 'passedTime', defaultValue: 0)
  final int? passedTime;

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;

  /// Represents the timestamp when the game trace was created.
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: "createdMillisecondEpoch")
  final String? createdMillisecondEpoch;

  /// Represents the initial battery charge percentage of the phone.
  @override
  @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
  final int? phoneChargeStartPercent;

  /// Represents a list of products associated with the game trace.
  final Map<String, dynamic> _padList;

  /// Represents a list of products associated with the game trace.
  @override
  @JsonKey(name: 'padList', defaultValue: {})
  Map<String, dynamic> get padList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_padList);
  }

  /// Represents the location data (latitude and longitude) associated with the game trace.
  final Map<String, double>? _locationData;

  /// Represents the location data (latitude and longitude) associated with the game trace.
  @override
  @JsonKey(name: 'locationData')
  Map<String, double>? get locationData {
    final value = _locationData;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Represents a mapping of pad IDs to their battery levels.
  final Map<String, double>? _padBatteryMapStart;

  /// Represents a mapping of pad IDs to their battery levels.
  @override
  @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
  Map<String, double>? get padBatteryMapStart {
    final value = _padBatteryMapStart;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Indicates whether the player has entered the game or not.
  @override
  @JsonKey(name: 'isEnterToGame', defaultValue: false)
  final bool? isEnterToGame;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreTrace(clickToScreenCount: $clickToScreenCount, passedTime: $passedTime, endTime: $endTime, createdAt: $createdAt, createdMillisecondEpoch: $createdMillisecondEpoch, phoneChargeStartPercent: $phoneChargeStartPercent, padList: $padList, locationData: $locationData, padBatteryMapStart: $padBatteryMapStart, isEnterToGame: $isEnterToGame)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PreTrace'))
      ..add(DiagnosticsProperty('clickToScreenCount', clickToScreenCount))
      ..add(DiagnosticsProperty('passedTime', passedTime))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty(
          'createdMillisecondEpoch', createdMillisecondEpoch))
      ..add(DiagnosticsProperty(
          'phoneChargeStartPercent', phoneChargeStartPercent))
      ..add(DiagnosticsProperty('padList', padList))
      ..add(DiagnosticsProperty('locationData', locationData))
      ..add(DiagnosticsProperty('padBatteryMapStart', padBatteryMapStart))
      ..add(DiagnosticsProperty('isEnterToGame', isEnterToGame));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PreTrace &&
            (identical(other.clickToScreenCount, clickToScreenCount) ||
                other.clickToScreenCount == clickToScreenCount) &&
            (identical(other.passedTime, passedTime) ||
                other.passedTime == passedTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(
                    other.createdMillisecondEpoch, createdMillisecondEpoch) ||
                other.createdMillisecondEpoch == createdMillisecondEpoch) &&
            (identical(
                    other.phoneChargeStartPercent, phoneChargeStartPercent) ||
                other.phoneChargeStartPercent == phoneChargeStartPercent) &&
            const DeepCollectionEquality().equals(other._padList, _padList) &&
            const DeepCollectionEquality()
                .equals(other._locationData, _locationData) &&
            const DeepCollectionEquality()
                .equals(other._padBatteryMapStart, _padBatteryMapStart) &&
            (identical(other.isEnterToGame, isEnterToGame) ||
                other.isEnterToGame == isEnterToGame));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clickToScreenCount,
      passedTime,
      endTime,
      createdAt,
      createdMillisecondEpoch,
      phoneChargeStartPercent,
      const DeepCollectionEquality().hash(_padList),
      const DeepCollectionEquality().hash(_locationData),
      const DeepCollectionEquality().hash(_padBatteryMapStart),
      isEnterToGame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PreTraceCopyWith<_$_PreTrace> get copyWith =>
      __$$_PreTraceCopyWithImpl<_$_PreTrace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PreTraceToJson(
      this,
    );
  }
}

abstract class _PreTrace implements PreTrace {
  const factory _PreTrace(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      final int? clickToScreenCount,
      @JsonKey(name: 'passedTime', defaultValue: 0) final int? passedTime,
      @JsonKey(name: 'endTime') final String? endTime,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: "createdMillisecondEpoch")
      final String? createdMillisecondEpoch,
      @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
      final int? phoneChargeStartPercent,
      @JsonKey(name: 'padList', defaultValue: {})
      final Map<String, dynamic> padList,
      @JsonKey(name: 'locationData') final Map<String, double>? locationData,
      @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
      final Map<String, double>? padBatteryMapStart,
      @JsonKey(name: 'isEnterToGame', defaultValue: false)
      final bool? isEnterToGame}) = _$_PreTrace;

  factory _PreTrace.fromJson(Map<String, dynamic> json) = _$_PreTrace.fromJson;

  @override

  /// Represents the number of clicks made to the screen during the game.
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  int? get clickToScreenCount;
  @override

  /// Represents the amount of time passed during the game, measured in some unit (e.g., seconds).
  @JsonKey(name: 'passedTime', defaultValue: 0)
  int? get passedTime;
  @override

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override

  /// Represents the timestamp when the game trace was created.
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: "createdMillisecondEpoch")
  String? get createdMillisecondEpoch;
  @override

  /// Represents the initial battery charge percentage of the phone.
  @JsonKey(name: 'phoneChargeStartPercent', defaultValue: 0)
  int? get phoneChargeStartPercent;
  @override

  /// Represents a list of products associated with the game trace.
  @JsonKey(name: 'padList', defaultValue: {})
  Map<String, dynamic> get padList;
  @override

  /// Represents the location data (latitude and longitude) associated with the game trace.
  @JsonKey(name: 'locationData')
  Map<String, double>? get locationData;
  @override

  /// Represents a mapping of pad IDs to their battery levels.
  @JsonKey(name: 'padBatteryMapStart', defaultValue: {})
  Map<String, double>? get padBatteryMapStart;
  @override

  /// Indicates whether the player has entered the game or not.
  @JsonKey(name: 'isEnterToGame', defaultValue: false)
  bool? get isEnterToGame;
  @override
  @JsonKey(ignore: true)
  _$$_PreTraceCopyWith<_$_PreTrace> get copyWith =>
      throw _privateConstructorUsedError;
}
