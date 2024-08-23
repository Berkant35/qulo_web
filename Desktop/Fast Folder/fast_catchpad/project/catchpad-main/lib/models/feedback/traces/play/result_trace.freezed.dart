// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'result_trace.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResultTrace _$ResultTraceFromJson(Map<String, dynamic> json) {
  return _ResultTrace.fromJson(json);
}

/// @nodoc
mixin _$ResultTrace {
  /// Represents the number of clicks made to the screen during the game.
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  int? get clickToScreenCount => throw _privateConstructorUsedError;

  /// Represents the amount of time passed during the game, measured
  /// in some unit (e.g., seconds).
  @JsonKey(name: 'passedTime', defaultValue: 0)
  int? get passedTime => throw _privateConstructorUsedError;

  /// Indicates whether the "Again" button was triggered or not.
  @JsonKey(name: 'againButtonTrigger', defaultValue: false)
  bool? get againButtonTrigger => throw _privateConstructorUsedError;

  /// Represents the initial battery charge percentage of the phone.
  @JsonKey(name: 'phoneChargeStartPercent')
  int? get phoneChargeStartPercent => throw _privateConstructorUsedError;

  /// Represents the final battery charge percentage of the phone.
  @JsonKey(name: 'phoneChargeEndPercent')
  int? get phoneChargeEndPercent => throw _privateConstructorUsedError;

  /// Represents a mapping of pad IDs to their battery levels.
  @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
  Map<String, double>? get padBatteryMapStop =>
      throw _privateConstructorUsedError;

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @JsonKey(name: 'endTime')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdTime')
  String? get createdTime => throw _privateConstructorUsedError;
  @JsonKey(name: "createdMillisecondEpoch")
  String? get createdMillisecondEpoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultTraceCopyWith<ResultTrace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultTraceCopyWith<$Res> {
  factory $ResultTraceCopyWith(
          ResultTrace value, $Res Function(ResultTrace) then) =
      _$ResultTraceCopyWithImpl<$Res, ResultTrace>;
  @useResult
  $Res call(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      int? clickToScreenCount,
      @JsonKey(name: 'passedTime', defaultValue: 0) int? passedTime,
      @JsonKey(name: 'againButtonTrigger', defaultValue: false)
      bool? againButtonTrigger,
      @JsonKey(name: 'phoneChargeStartPercent') int? phoneChargeStartPercent,
      @JsonKey(name: 'phoneChargeEndPercent') int? phoneChargeEndPercent,
      @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
      Map<String, double>? padBatteryMapStop,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: "createdMillisecondEpoch")
      String? createdMillisecondEpoch});
}

/// @nodoc
class _$ResultTraceCopyWithImpl<$Res, $Val extends ResultTrace>
    implements $ResultTraceCopyWith<$Res> {
  _$ResultTraceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickToScreenCount = freezed,
    Object? passedTime = freezed,
    Object? againButtonTrigger = freezed,
    Object? phoneChargeStartPercent = freezed,
    Object? phoneChargeEndPercent = freezed,
    Object? padBatteryMapStop = freezed,
    Object? endTime = freezed,
    Object? createdTime = freezed,
    Object? createdMillisecondEpoch = freezed,
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
      againButtonTrigger: freezed == againButtonTrigger
          ? _value.againButtonTrigger
          : againButtonTrigger // ignore: cast_nullable_to_non_nullable
              as bool?,
      phoneChargeStartPercent: freezed == phoneChargeStartPercent
          ? _value.phoneChargeStartPercent
          : phoneChargeStartPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      phoneChargeEndPercent: freezed == phoneChargeEndPercent
          ? _value.phoneChargeEndPercent
          : phoneChargeEndPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      padBatteryMapStop: freezed == padBatteryMapStop
          ? _value.padBatteryMapStop
          : padBatteryMapStop // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResultTraceCopyWith<$Res>
    implements $ResultTraceCopyWith<$Res> {
  factory _$$_ResultTraceCopyWith(
          _$_ResultTrace value, $Res Function(_$_ResultTrace) then) =
      __$$_ResultTraceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      int? clickToScreenCount,
      @JsonKey(name: 'passedTime', defaultValue: 0) int? passedTime,
      @JsonKey(name: 'againButtonTrigger', defaultValue: false)
      bool? againButtonTrigger,
      @JsonKey(name: 'phoneChargeStartPercent') int? phoneChargeStartPercent,
      @JsonKey(name: 'phoneChargeEndPercent') int? phoneChargeEndPercent,
      @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
      Map<String, double>? padBatteryMapStop,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: "createdMillisecondEpoch")
      String? createdMillisecondEpoch});
}

/// @nodoc
class __$$_ResultTraceCopyWithImpl<$Res>
    extends _$ResultTraceCopyWithImpl<$Res, _$_ResultTrace>
    implements _$$_ResultTraceCopyWith<$Res> {
  __$$_ResultTraceCopyWithImpl(
      _$_ResultTrace _value, $Res Function(_$_ResultTrace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickToScreenCount = freezed,
    Object? passedTime = freezed,
    Object? againButtonTrigger = freezed,
    Object? phoneChargeStartPercent = freezed,
    Object? phoneChargeEndPercent = freezed,
    Object? padBatteryMapStop = freezed,
    Object? endTime = freezed,
    Object? createdTime = freezed,
    Object? createdMillisecondEpoch = freezed,
  }) {
    return _then(_$_ResultTrace(
      clickToScreenCount: freezed == clickToScreenCount
          ? _value.clickToScreenCount
          : clickToScreenCount // ignore: cast_nullable_to_non_nullable
              as int?,
      passedTime: freezed == passedTime
          ? _value.passedTime
          : passedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      againButtonTrigger: freezed == againButtonTrigger
          ? _value.againButtonTrigger
          : againButtonTrigger // ignore: cast_nullable_to_non_nullable
              as bool?,
      phoneChargeStartPercent: freezed == phoneChargeStartPercent
          ? _value.phoneChargeStartPercent
          : phoneChargeStartPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      phoneChargeEndPercent: freezed == phoneChargeEndPercent
          ? _value.phoneChargeEndPercent
          : phoneChargeEndPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      padBatteryMapStop: freezed == padBatteryMapStop
          ? _value._padBatteryMapStop
          : padBatteryMapStop // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ResultTrace with DiagnosticableTreeMixin implements _ResultTrace {
  const _$_ResultTrace(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      this.clickToScreenCount = 0,
      @JsonKey(name: 'passedTime', defaultValue: 0) this.passedTime = 0,
      @JsonKey(name: 'againButtonTrigger', defaultValue: false)
      this.againButtonTrigger = false,
      @JsonKey(name: 'phoneChargeStartPercent')
      this.phoneChargeStartPercent = 0,
      @JsonKey(name: 'phoneChargeEndPercent') this.phoneChargeEndPercent = 0,
      @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
      final Map<String, double>? padBatteryMapStop = const {},
      @JsonKey(name: 'endTime') this.endTime,
      @JsonKey(name: 'createdTime') this.createdTime,
      @JsonKey(name: "createdMillisecondEpoch") this.createdMillisecondEpoch})
      : _padBatteryMapStop = padBatteryMapStop;

  factory _$_ResultTrace.fromJson(Map<String, dynamic> json) =>
      _$$_ResultTraceFromJson(json);

  /// Represents the number of clicks made to the screen during the game.
  @override
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  final int? clickToScreenCount;

  /// Represents the amount of time passed during the game, measured
  /// in some unit (e.g., seconds).
  @override
  @JsonKey(name: 'passedTime', defaultValue: 0)
  final int? passedTime;

  /// Indicates whether the "Again" button was triggered or not.
  @override
  @JsonKey(name: 'againButtonTrigger', defaultValue: false)
  final bool? againButtonTrigger;

  /// Represents the initial battery charge percentage of the phone.
  @override
  @JsonKey(name: 'phoneChargeStartPercent')
  final int? phoneChargeStartPercent;

  /// Represents the final battery charge percentage of the phone.
  @override
  @JsonKey(name: 'phoneChargeEndPercent')
  final int? phoneChargeEndPercent;

  /// Represents a mapping of pad IDs to their battery levels.
  final Map<String, double>? _padBatteryMapStop;

  /// Represents a mapping of pad IDs to their battery levels.
  @override
  @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
  Map<String, double>? get padBatteryMapStop {
    final value = _padBatteryMapStop;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;
  @override
  @JsonKey(name: 'createdTime')
  final String? createdTime;
  @override
  @JsonKey(name: "createdMillisecondEpoch")
  final String? createdMillisecondEpoch;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ResultTrace(clickToScreenCount: $clickToScreenCount, passedTime: $passedTime, againButtonTrigger: $againButtonTrigger, phoneChargeStartPercent: $phoneChargeStartPercent, phoneChargeEndPercent: $phoneChargeEndPercent, padBatteryMapStop: $padBatteryMapStop, endTime: $endTime, createdTime: $createdTime, createdMillisecondEpoch: $createdMillisecondEpoch)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ResultTrace'))
      ..add(DiagnosticsProperty('clickToScreenCount', clickToScreenCount))
      ..add(DiagnosticsProperty('passedTime', passedTime))
      ..add(DiagnosticsProperty('againButtonTrigger', againButtonTrigger))
      ..add(DiagnosticsProperty(
          'phoneChargeStartPercent', phoneChargeStartPercent))
      ..add(DiagnosticsProperty('phoneChargeEndPercent', phoneChargeEndPercent))
      ..add(DiagnosticsProperty('padBatteryMapStop', padBatteryMapStop))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty(
          'createdMillisecondEpoch', createdMillisecondEpoch));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResultTrace &&
            (identical(other.clickToScreenCount, clickToScreenCount) ||
                other.clickToScreenCount == clickToScreenCount) &&
            (identical(other.passedTime, passedTime) ||
                other.passedTime == passedTime) &&
            (identical(other.againButtonTrigger, againButtonTrigger) ||
                other.againButtonTrigger == againButtonTrigger) &&
            (identical(
                    other.phoneChargeStartPercent, phoneChargeStartPercent) ||
                other.phoneChargeStartPercent == phoneChargeStartPercent) &&
            (identical(other.phoneChargeEndPercent, phoneChargeEndPercent) ||
                other.phoneChargeEndPercent == phoneChargeEndPercent) &&
            const DeepCollectionEquality()
                .equals(other._padBatteryMapStop, _padBatteryMapStop) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(
                    other.createdMillisecondEpoch, createdMillisecondEpoch) ||
                other.createdMillisecondEpoch == createdMillisecondEpoch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clickToScreenCount,
      passedTime,
      againButtonTrigger,
      phoneChargeStartPercent,
      phoneChargeEndPercent,
      const DeepCollectionEquality().hash(_padBatteryMapStop),
      endTime,
      createdTime,
      createdMillisecondEpoch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultTraceCopyWith<_$_ResultTrace> get copyWith =>
      __$$_ResultTraceCopyWithImpl<_$_ResultTrace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResultTraceToJson(
      this,
    );
  }
}

abstract class _ResultTrace implements ResultTrace {
  const factory _ResultTrace(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      final int? clickToScreenCount,
      @JsonKey(name: 'passedTime', defaultValue: 0) final int? passedTime,
      @JsonKey(name: 'againButtonTrigger', defaultValue: false)
      final bool? againButtonTrigger,
      @JsonKey(name: 'phoneChargeStartPercent')
      final int? phoneChargeStartPercent,
      @JsonKey(name: 'phoneChargeEndPercent') final int? phoneChargeEndPercent,
      @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
      final Map<String, double>? padBatteryMapStop,
      @JsonKey(name: 'endTime') final String? endTime,
      @JsonKey(name: 'createdTime') final String? createdTime,
      @JsonKey(name: "createdMillisecondEpoch")
      final String? createdMillisecondEpoch}) = _$_ResultTrace;

  factory _ResultTrace.fromJson(Map<String, dynamic> json) =
      _$_ResultTrace.fromJson;

  @override

  /// Represents the number of clicks made to the screen during the game.
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  int? get clickToScreenCount;
  @override

  /// Represents the amount of time passed during the game, measured
  /// in some unit (e.g., seconds).
  @JsonKey(name: 'passedTime', defaultValue: 0)
  int? get passedTime;
  @override

  /// Indicates whether the "Again" button was triggered or not.
  @JsonKey(name: 'againButtonTrigger', defaultValue: false)
  bool? get againButtonTrigger;
  @override

  /// Represents the initial battery charge percentage of the phone.
  @JsonKey(name: 'phoneChargeStartPercent')
  int? get phoneChargeStartPercent;
  @override

  /// Represents the final battery charge percentage of the phone.
  @JsonKey(name: 'phoneChargeEndPercent')
  int? get phoneChargeEndPercent;
  @override

  /// Represents a mapping of pad IDs to their battery levels.
  @JsonKey(name: 'padBatteryMapStop', defaultValue: {})
  Map<String, double>? get padBatteryMapStop;
  @override

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override
  @JsonKey(name: 'createdTime')
  String? get createdTime;
  @override
  @JsonKey(name: "createdMillisecondEpoch")
  String? get createdMillisecondEpoch;
  @override
  @JsonKey(ignore: true)
  _$$_ResultTraceCopyWith<_$_ResultTrace> get copyWith =>
      throw _privateConstructorUsedError;
}
