import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/utils.dart';

part 'num_range.freezed.dart';
part 'num_range.g.dart';

@freezed
class NumRange with _$NumRange {
  const NumRange._();

  static const _defStep = 5;

  @Assert("min <= max, 'min cannot be bigger than max'")
  @Assert(
      "def == null || def >= min && def <= max, 'def must be between min and max'")
  @Assert("def==null || def % step == 0, 'step must be a divisor of def'")
  @Assert("min % step == 0, 'step must be a divisor of min'")
  @Assert("max % step == 0, 'step must be a divisor of max'")
  const factory NumRange({
    required int min,
    required int max,

    /// default value.
    /// e.g. this could be used for the game duration,
    /// and `def` would specify the default duration that
    /// will be selected in the duration picker.
    int? def,

    /// the selection range, for example if this is 5,
    /// then the selections will go like [min, min+5, ..., def-5, def, def+5, ..., max-5, max]
    @Default(NumRange._defStep) int step,
  }) = _Range;

  factory NumRange.all(int m) {
    return NumRange(
      def: m,
      min: m,
      max: m,
    );
  }

  factory NumRange.def(int def) {
    return NumRange(
      min: def ~/ 2,
      max: def ~/ 2,
      def: def,
    );
  }

  factory NumRange.duration({
    required int def,
    required int min,
    required int max,
    int? step,
  }) {
    return NumRange(
      def: def,
      min: min,
      max: max,
      step: step ?? _defStep,
    );
  }

  factory NumRange.radius({
    required int def,
    required int min,
    required int max,
    int? step,
  }) {
    return NumRange(
      def: def,
      min: min,
      max: max,
      step: step ?? 1,
    );
  }

  factory NumRange.delay({
    required int def,
    required int min,
    required int max,
    int? step,
  }) {
    return NumRange(
      def: def,
      min: min,
      max: max,
      step: step ?? 1,
    );
  }

  factory NumRange.distance({
    required int def,
    required int min,
    required int max,
    int? step,
  }) {
    return NumRange(
      def: def,
      min: min,
      max: max,
      step: step ?? _defStep,
    );
  }

  factory NumRange.distanceCm({
    required int def,
    required int min,
    required int max,
    int? step,
  }) {
    return NumRange.distance(
      def: def.cmToMm.toInt(),
      min: min.cmToMm.toInt(),
      max: max.cmToMm.toInt(),
      step: step?.cmToMm.toInt() ?? _defStep.cmToMm.toInt(),
    );
  }

  /// this model is used for 2 purposes:
  /// 1. durations and distances, which can have a multiple of different
  /// steppers.
  /// 2. player and pad counts which can only have a stepper of 1 as
  /// the player will select the number of players or pads and wants
  /// to have a 1 stepper, rarely the step may be more than 1, in team
  /// games for example, this may be 2, may be 3, may be anything, so
  /// that's why we'll have a nullable step parameter also
  factory NumRange.count({
    required int min,
    required int max,
    int step = 1,
  }) {
    return NumRange(
      min: min,
      max: max,
      step: step,
    );
  }


  factory NumRange.padCount({
    required int min,
    required int max,
    int step = 1,
  }) {

    return NumRange.count(
      min: min,
      max: max,
      step: step,
    );
  }

  factory NumRange.playerCount({
    required int min,
    required int max,
    int step = 1,
  }) {
    return NumRange.count(
      min: min,
      max: max,
      step: step,
    );
  }

  String get rangeStr {
    if (min == max) {
      return '$min';
    }

    return '$min - $max';
  }

  Duration get duration {
    return Duration(seconds: def!);
  }

  factory NumRange.fromJson(Map<String, dynamic> json) =>
      _$NumRangeFromJson(json);
}