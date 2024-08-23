// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ble_flow_tracker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BleFlowTracker _$BleFlowTrackerFromJson(Map<String, dynamic> json) {
  return _BleFlowTracker.fromJson(json);
}

/// @nodoc
mixin _$BleFlowTracker {
  @JsonKey(name: "bleFlowTrackerId")
  String? get bleFlowTrackerId => throw _privateConstructorUsedError;
  @JsonKey(name: "metaTrace")
  MetaTrace? get metaTrace => throw _privateConstructorUsedError;
  @JsonKey(name: "commandTimeTrackerList")
  List<CommandTimeTracker> get commandTimeTrackerList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BleFlowTrackerCopyWith<BleFlowTracker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BleFlowTrackerCopyWith<$Res> {
  factory $BleFlowTrackerCopyWith(
          BleFlowTracker value, $Res Function(BleFlowTracker) then) =
      _$BleFlowTrackerCopyWithImpl<$Res, BleFlowTracker>;
  @useResult
  $Res call(
      {@JsonKey(name: "bleFlowTrackerId") String? bleFlowTrackerId,
      @JsonKey(name: "metaTrace") MetaTrace? metaTrace,
      @JsonKey(name: "commandTimeTrackerList")
      List<CommandTimeTracker> commandTimeTrackerList});

  $MetaTraceCopyWith<$Res>? get metaTrace;
}

/// @nodoc
class _$BleFlowTrackerCopyWithImpl<$Res, $Val extends BleFlowTracker>
    implements $BleFlowTrackerCopyWith<$Res> {
  _$BleFlowTrackerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bleFlowTrackerId = freezed,
    Object? metaTrace = freezed,
    Object? commandTimeTrackerList = null,
  }) {
    return _then(_value.copyWith(
      bleFlowTrackerId: freezed == bleFlowTrackerId
          ? _value.bleFlowTrackerId
          : bleFlowTrackerId // ignore: cast_nullable_to_non_nullable
              as String?,
      metaTrace: freezed == metaTrace
          ? _value.metaTrace
          : metaTrace // ignore: cast_nullable_to_non_nullable
              as MetaTrace?,
      commandTimeTrackerList: null == commandTimeTrackerList
          ? _value.commandTimeTrackerList
          : commandTimeTrackerList // ignore: cast_nullable_to_non_nullable
              as List<CommandTimeTracker>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MetaTraceCopyWith<$Res>? get metaTrace {
    if (_value.metaTrace == null) {
      return null;
    }

    return $MetaTraceCopyWith<$Res>(_value.metaTrace!, (value) {
      return _then(_value.copyWith(metaTrace: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BleFlowTrackerCopyWith<$Res>
    implements $BleFlowTrackerCopyWith<$Res> {
  factory _$$_BleFlowTrackerCopyWith(
          _$_BleFlowTracker value, $Res Function(_$_BleFlowTracker) then) =
      __$$_BleFlowTrackerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "bleFlowTrackerId") String? bleFlowTrackerId,
      @JsonKey(name: "metaTrace") MetaTrace? metaTrace,
      @JsonKey(name: "commandTimeTrackerList")
      List<CommandTimeTracker> commandTimeTrackerList});

  @override
  $MetaTraceCopyWith<$Res>? get metaTrace;
}

/// @nodoc
class __$$_BleFlowTrackerCopyWithImpl<$Res>
    extends _$BleFlowTrackerCopyWithImpl<$Res, _$_BleFlowTracker>
    implements _$$_BleFlowTrackerCopyWith<$Res> {
  __$$_BleFlowTrackerCopyWithImpl(
      _$_BleFlowTracker _value, $Res Function(_$_BleFlowTracker) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bleFlowTrackerId = freezed,
    Object? metaTrace = freezed,
    Object? commandTimeTrackerList = null,
  }) {
    return _then(_$_BleFlowTracker(
      bleFlowTrackerId: freezed == bleFlowTrackerId
          ? _value.bleFlowTrackerId
          : bleFlowTrackerId // ignore: cast_nullable_to_non_nullable
              as String?,
      metaTrace: freezed == metaTrace
          ? _value.metaTrace
          : metaTrace // ignore: cast_nullable_to_non_nullable
              as MetaTrace?,
      commandTimeTrackerList: null == commandTimeTrackerList
          ? _value._commandTimeTrackerList
          : commandTimeTrackerList // ignore: cast_nullable_to_non_nullable
              as List<CommandTimeTracker>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BleFlowTracker implements _BleFlowTracker {
  const _$_BleFlowTracker(
      {@JsonKey(name: "bleFlowTrackerId") this.bleFlowTrackerId,
      @JsonKey(name: "metaTrace") this.metaTrace,
      @JsonKey(name: "commandTimeTrackerList")
      final List<CommandTimeTracker> commandTimeTrackerList =
          const <CommandTimeTracker>[]})
      : _commandTimeTrackerList = commandTimeTrackerList;

  factory _$_BleFlowTracker.fromJson(Map<String, dynamic> json) =>
      _$$_BleFlowTrackerFromJson(json);

  @override
  @JsonKey(name: "bleFlowTrackerId")
  final String? bleFlowTrackerId;
  @override
  @JsonKey(name: "metaTrace")
  final MetaTrace? metaTrace;
  final List<CommandTimeTracker> _commandTimeTrackerList;
  @override
  @JsonKey(name: "commandTimeTrackerList")
  List<CommandTimeTracker> get commandTimeTrackerList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commandTimeTrackerList);
  }

  @override
  String toString() {
    return 'BleFlowTracker(bleFlowTrackerId: $bleFlowTrackerId, metaTrace: $metaTrace, commandTimeTrackerList: $commandTimeTrackerList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BleFlowTracker &&
            (identical(other.bleFlowTrackerId, bleFlowTrackerId) ||
                other.bleFlowTrackerId == bleFlowTrackerId) &&
            (identical(other.metaTrace, metaTrace) ||
                other.metaTrace == metaTrace) &&
            const DeepCollectionEquality().equals(
                other._commandTimeTrackerList, _commandTimeTrackerList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bleFlowTrackerId, metaTrace,
      const DeepCollectionEquality().hash(_commandTimeTrackerList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BleFlowTrackerCopyWith<_$_BleFlowTracker> get copyWith =>
      __$$_BleFlowTrackerCopyWithImpl<_$_BleFlowTracker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BleFlowTrackerToJson(
      this,
    );
  }
}

abstract class _BleFlowTracker implements BleFlowTracker {
  const factory _BleFlowTracker(
          {@JsonKey(name: "bleFlowTrackerId") final String? bleFlowTrackerId,
          @JsonKey(name: "metaTrace") final MetaTrace? metaTrace,
          @JsonKey(name: "commandTimeTrackerList")
          final List<CommandTimeTracker> commandTimeTrackerList}) =
      _$_BleFlowTracker;

  factory _BleFlowTracker.fromJson(Map<String, dynamic> json) =
      _$_BleFlowTracker.fromJson;

  @override
  @JsonKey(name: "bleFlowTrackerId")
  String? get bleFlowTrackerId;
  @override
  @JsonKey(name: "metaTrace")
  MetaTrace? get metaTrace;
  @override
  @JsonKey(name: "commandTimeTrackerList")
  List<CommandTimeTracker> get commandTimeTrackerList;
  @override
  @JsonKey(ignore: true)
  _$$_BleFlowTrackerCopyWith<_$_BleFlowTracker> get copyWith =>
      throw _privateConstructorUsedError;
}
