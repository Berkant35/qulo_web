// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'num_range.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NumRange _$NumRangeFromJson(Map<String, dynamic> json) {
  return _Range.fromJson(json);
}

/// @nodoc
mixin _$NumRange {
  int get min => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;

  /// default value.
  /// e.g. this could be used for the game duration,
  /// and `def` would specify the default duration that
  /// will be selected in the duration picker.
  int? get def => throw _privateConstructorUsedError;

  /// the selection range, for example if this is 5,
  /// then the selections will go like [min, min+5, ..., def-5, def, def+5, ..., max-5, max]
  int get step => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NumRangeCopyWith<NumRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumRangeCopyWith<$Res> {
  factory $NumRangeCopyWith(NumRange value, $Res Function(NumRange) then) =
      _$NumRangeCopyWithImpl<$Res, NumRange>;
  @useResult
  $Res call({int min, int max, int? def, int step});
}

/// @nodoc
class _$NumRangeCopyWithImpl<$Res, $Val extends NumRange>
    implements $NumRangeCopyWith<$Res> {
  _$NumRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? def = freezed,
    Object? step = null,
  }) {
    return _then(_value.copyWith(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      def: freezed == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as int?,
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RangeCopyWith<$Res> implements $NumRangeCopyWith<$Res> {
  factory _$$_RangeCopyWith(_$_Range value, $Res Function(_$_Range) then) =
      __$$_RangeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int min, int max, int? def, int step});
}

/// @nodoc
class __$$_RangeCopyWithImpl<$Res>
    extends _$NumRangeCopyWithImpl<$Res, _$_Range>
    implements _$$_RangeCopyWith<$Res> {
  __$$_RangeCopyWithImpl(_$_Range _value, $Res Function(_$_Range) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? def = freezed,
    Object? step = null,
  }) {
    return _then(_$_Range(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      def: freezed == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as int?,
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Range extends _Range {
  const _$_Range(
      {required this.min,
      required this.max,
      this.def,
      this.step = NumRange._defStep})
      : assert(min <= max, 'min cannot be bigger than max'),
        assert(def == null || def >= min && def <= max,
            'def must be between min and max'),
        assert(def == null || def % step == 0, 'step must be a divisor of def'),
        assert(min % step == 0, 'step must be a divisor of min'),
        assert(max % step == 0, 'step must be a divisor of max'),
        super._();

  factory _$_Range.fromJson(Map<String, dynamic> json) =>
      _$$_RangeFromJson(json);

  @override
  final int min;
  @override
  final int max;

  /// default value.
  /// e.g. this could be used for the game duration,
  /// and `def` would specify the default duration that
  /// will be selected in the duration picker.
  @override
  final int? def;

  /// the selection range, for example if this is 5,
  /// then the selections will go like [min, min+5, ..., def-5, def, def+5, ..., max-5, max]
  @override
  @JsonKey()
  final int step;

  @override
  String toString() {
    return 'NumRange(min: $min, max: $max, def: $def, step: $step)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Range &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.def, def) || other.def == def) &&
            (identical(other.step, step) || other.step == step));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, min, max, def, step);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RangeCopyWith<_$_Range> get copyWith =>
      __$$_RangeCopyWithImpl<_$_Range>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RangeToJson(
      this,
    );
  }
}

abstract class _Range extends NumRange {
  const factory _Range(
      {required final int min,
      required final int max,
      final int? def,
      final int step}) = _$_Range;
  const _Range._() : super._();

  factory _Range.fromJson(Map<String, dynamic> json) = _$_Range.fromJson;

  @override
  int get min;
  @override
  int get max;
  @override

  /// default value.
  /// e.g. this could be used for the game duration,
  /// and `def` would specify the default duration that
  /// will be selected in the duration picker.
  int? get def;
  @override

  /// the selection range, for example if this is 5,
  /// then the selections will go like [min, min+5, ..., def-5, def, def+5, ..., max-5, max]
  int get step;
  @override
  @JsonKey(ignore: true)
  _$$_RangeCopyWith<_$_Range> get copyWith =>
      throw _privateConstructorUsedError;
}
