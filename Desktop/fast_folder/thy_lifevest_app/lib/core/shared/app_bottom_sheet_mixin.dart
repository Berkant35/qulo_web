import 'package:flutter/cupertino.dart';
import 'package:thy_lifevest_app/core/constant/app_constant.dart';

mixin AppBottomSheetMixin {
  final Size designDeviceSize = AppConstants.designDeviceSize;

  double getScaleFactor(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double widthRatio = screenSize.width / designDeviceSize.width;
    final double heightRatio = screenSize.height / designDeviceSize.height;
    return widthRatio < heightRatio ? widthRatio : heightRatio;
  }

  double scaleSize(BuildContext context, double size) {
    return size * getScaleFactor(context);
  }
}
