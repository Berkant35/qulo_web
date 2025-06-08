import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/app_constant.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/keys/app_keys.dart';

class ScreenSize {
  static final ScreenSize _instance = ScreenSize._init();

  ScreenSize._init();

  factory ScreenSize() {
    return _instance;
  }

  factory ScreenSize.init() {
    final window = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single,
    );
    double screenWidth = window.size.width;
    double screenHeight = window.size.height;
    _instance.screenSize = Size(screenWidth, screenHeight);
    _instance.bottomPadding = window.padding.bottom;
    _instance.topPadding = window.padding.top;
    _instance.ratio =
        1 /
        min(
          screenWidth / AppConstants.designDeviceSize.width,
          screenHeight / AppConstants.designDeviceSize.height,
        );
    return _instance;
  }

  late Size screenSize;
  late double topPadding;
  late double bottomPadding;
  late double ratio;

  double getHeightPercent(double percent) {
    return screenSize.height * percent;
  }

  double getWidthPercent(double percent) {
    return screenSize.width * percent;
  }

  double getHeight(num heightNum) {
    double height =
        (screenSize.height * heightNum) / AppConstants.designDeviceSize.height;
    return height;
  }

  double getWidth(num widthNum) {
    double width =
        (screenSize.width * widthNum) / AppConstants.designDeviceSize.width;
    return width;
  }

  double getRadius(num radius) {
    double scaledRadius =
        (screenSize.width * radius) / AppConstants.designDeviceSize.width;
    return scaledRadius;
  }

  double getFontSize(num fontSize) {
    double scaledFontSize = fontSize * _scaleText;
    return scaledFontSize;
  }

  double get _scaleText => min(_scaleWidth, _scaleHeight);

  double get _scaleWidth =>
      screenSize.width / AppConstants.designDeviceSize.width;

  double get _scaleHeight =>
      screenSize.height / AppConstants.designDeviceSize.height;

  bool isKeyboardVisible() {
    final context = AppKeys.navigatorKey.currentState?.context;
    if (context.isNull) return false;
    final isKeyboardOpen = MediaQuery.of(context!).viewInsets.bottom > 0;
    return isKeyboardOpen;
  }
}
