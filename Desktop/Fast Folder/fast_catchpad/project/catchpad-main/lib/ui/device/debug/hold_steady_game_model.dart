import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/consts.dart';
import '../../../utils/cp_colors.dart';
import 'dart:math';
part 'hold_steady_game_model.freezed.dart';

enum Direction {
  top,
  bottom,
  right,
  left,
  all,
}

@freezed
class HoldSteadyGameModel with _$HoldSteadyGameModel {
  const HoldSteadyGameModel._();
  const factory HoldSteadyGameModel(
      {required double x,
      required double y,
      @Default(false) bool newDev,
      @Default(5) double radius,
      @Default(1) double minRadius}) = _HoldSteadyGameModel;


  static double calculateInclination(double pitch, double roll) {
    double rollRadians = roll * (pi / 180); // Roll değerini dereceden radyana çevir
    double pitchRadians = pitch * (pi / 180); // Pitch değerini dereceden radyana çevir

    double inclination = atan(sqrt(pow(tan(rollRadians), 2) + pow(tan(pitchRadians), 2)));

    return inclination * (180 / pi); // Eğimi radyandan dereceye çevirerek döndür
  }


  factory HoldSteadyGameModel.fromAcceleremetorGravityModel(
      AcceleremetorGravityModel model,
      {double? radius,
      double? minRadius,
      bool newDev = false}) {

    final newModel = HoldSteadyGameModel(
      // x and y are between -180 and 180
      // we want it between 0 and 360
      newDev: newDev,
      x: (newDev)
          ? (model.roll.isNegative ? model.roll + 180 : model.roll - 180)
          : model.roll,
      y: model.pitch,
    );


    return newModel.copyWith(
      radius: radius ?? newModel.radius,
      minRadius: minRadius ?? newModel.minRadius,
    );
  }

  static const _maxValue = 180;
  static const _minValue = -180;

  static SidesColorsModel lastUsedColor = SidesColorsModel.all(gameErrorColor);

  double get _rx => x;
  double get _ry => y;

  bool get _rxIsValid => _rx >= _minValue && _rx <= _maxValue;
  bool get _ryIsValid => _ry >= _minValue && _ry <= _maxValue;

  /// how much is rx distant from the center
  double get _rxFromCenter => (_rx).abs();

  /// how much is ry distant from the center
  double get _ryFromCenter => (_ry).abs();

  /// is it neutral, a bit to the left or right,
  /// not more focused on any.
  bool get _rxIsNeutral => _rxFromCenter <= neutralityRadius;

  /// is it neutral, a bit to the top or bottom,
  /// not more focused on any.
  bool get _ryIsNeutral => _ryFromCenter <= neutralityRadius;

  /// is leaned to the top right
  bool get isLeanedTr =>
      directions.contains(Direction.top) &&
      directions.contains(Direction.right);
  bool get isLeanedTl =>
      directions.contains(Direction.top) && directions.contains(Direction.left);
  bool get isLeanedBr =>
      directions.contains(Direction.bottom) &&
      directions.contains(Direction.right);
  bool get isLeanedBl =>
      directions.contains(Direction.bottom) &&
      directions.contains(Direction.left);

  /// when we wanna calculate if it is neutrally leaning to an x or y dimension
  /// for example we wanna calculate it is leaning to the top or bottom but
  /// not really to left or right, so radius * 3 is a good value to stay neutral.
  double get neutralityRadius => radius * 3;
  // newDev is the boolean variable for detecting the last version of catchpad devices
  // if it is true, the device is the new one, otherwise it is the old one
  // when all devices are updated, we can remove this variable
  // change the structure completely like its always true basically remove elses

  ///Donanım değiştiği için  ? : arasındaki değerleri tam zıt bir şekilde
  ///ayarlanıldı!



  bool get isTop {
    return (newDev) ?  (_rxIsValid && _rx > radius) : (_ryIsValid && _ry < -radius);
  }
  bool get isBottom =>
      (newDev) ?  (_rxIsValid && _rx < -radius) : (_ryIsValid && _ry > radius);
  bool get isLeft =>
      (newDev) ?  (_ryIsValid && _ry < -radius) : (_rxIsValid && _rx < -radius);
  bool get isRight =>
      (newDev) ? (_ryIsValid && _ry > radius) : (_rxIsValid && _rx > radius);


  bool get isTopRight => (newDev)
      ? (_rxIsValid && _ryIsValid && _rx > radius && _ry > radius)
      : (_rxIsValid && _ryIsValid && _rx > radius && _ry < -radius);
  bool get isTopLeft => (newDev)
      ? (_rxIsValid && _ryIsValid && _rx > radius && _ry < -radius)
      : (_rxIsValid && _ryIsValid && _rx < -radius && _ry < -radius);
  bool get isBottomRight => (newDev)
      ? (_rxIsValid && _ryIsValid && _rx < -radius && _ry > radius)
      : (_rxIsValid && _ryIsValid && _rx > radius && _ry > radius);
  bool get isBottomLeft => (newDev)
      ? (_rxIsValid && _ryIsValid && _rx < -radius && _ry < -radius)
      : (_rxIsValid && _ryIsValid && _rx < -radius && _ry > radius);
  bool get isCentralized =>
      _rxIsValid && _rxIsValid && _rx.abs() < radius && _ry.abs() < radius;

  bool get isLeanedTop {
    if (!isTop) {
      return false;
    }

    return _rxIsNeutral;
  }

  bool get isLeanedBottom {
    if (!isBottom) {
      return false;
    }

    return _rxIsNeutral;
  }

  bool get isLeanedLeft {
    if (!isLeft) {
      return false;
    }

    return _ryIsNeutral;
  }

  bool get isLeanedRight {
    if (!isRight) {
      return false;
    }

    return _ryIsNeutral;
  }

  bool get isLeaned =>
      isTopRight ||
      isTopLeft ||
      isBottomRight ||
      isBottomLeft ||
      isRight ||
      isLeft ||
      isTop ||
      isBottom;
  bool get isSteady => !isLeaned;

  Set<Direction> get directions {
    final Set<Direction> dir = {};

    if (isRight) {
      dir.add(Direction.right);
    }
    // do not skip this check because it is
    // the exact opposite to the one above,
    // because it actually not, there is a
    // small windows where the pad is inside
    // the radius.
    if (isLeft) {
      dir.add(Direction.left);
    }

    if (isTop) {
      dir.add(Direction.top);
    }
    // do not skip this check because it is
    // the exact opposite to the one above,
    // because it actually not, there is a
    // small windows where the pad is inside
    // the radius.
    if (isBottom) {
      dir.add(Direction.bottom);
    }

    if (dir.isEmpty /*  || dir.length == 4 */) {
      // we can't check for isSteady at the top
      // because it uses other stuff that use
      // directions to calculate themselves which
      // will use isSteady which will use other stuff
      // that use directions to calculate themselves
      // which will use isSteady which will use other
      // stuff
      // STOP!;
      dir.add(Direction.all);
    }

    return dir;
  }

  SidesColorsModel _composeColor({
    required SidesColorsModel allSteady,
    required SidesColorsModel anyLeaned,
  }) {
    if (isCentralized) {
      return allSteady;
    }

    if (isTopRight) {
      lastUsedColor = SidesColorsModel.off().copyWith(tl: anyLeaned.tl);
      return lastUsedColor;
    }

    if (isBottomRight) {
      lastUsedColor = SidesColorsModel.off().copyWith(bl: anyLeaned.bl);
      return lastUsedColor;
    }
    if (isTopLeft) {
      lastUsedColor = SidesColorsModel.off().copyWith(tr: anyLeaned.tr);
      return lastUsedColor;
    }
    if (isBottomLeft) {
      lastUsedColor = SidesColorsModel.off().copyWith(br: anyLeaned.br);
      return lastUsedColor;
    }

    if (isRight) {
      lastUsedColor = SidesColorsModel.off().copyWith(
        tl: anyLeaned.tl,
        bl: anyLeaned.bl,
      );
      return lastUsedColor;
    }

    if (isLeft) {
      lastUsedColor = SidesColorsModel.off().copyWith(
        tr: anyLeaned.tr,
        br: anyLeaned.br,
      );
      return lastUsedColor;
    }

    if (isTop) {
      lastUsedColor = SidesColorsModel.off().copyWith(
        tr: anyLeaned.tr,
        tl: anyLeaned.tl,
      );
      return lastUsedColor;
    }

    if (isBottom) {
      lastUsedColor = SidesColorsModel.off().copyWith(
        br: anyLeaned.br,
        bl: anyLeaned.bl,
      );
      return lastUsedColor;
    }

    return lastUsedColor;
  }

  SidesColorsModel get getColorSuccessError {
    return _composeColor(
      allSteady: SidesColorsModel.all(gameSuccessColor),
      anyLeaned: SidesColorsModel.all(gameErrorColor),
    );
  }

  SidesColorsModel get colorForQuiz {
    return _composeColor(
      allSteady: SidesColorsModel.all(const Color.fromARGB(255, 255, 102, 0)),
      anyLeaned: SidesColorsModel.all(const Color.fromARGB(255, 255, 102, 0)),
    );
  }

  SidesColorsModel get getColor {
    var mdl = CpColors.cpSidesColorsModel;
    return _composeColor(
      allSteady: mdl,
      anyLeaned: mdl,
    );
  }
}
