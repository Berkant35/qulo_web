

import 'dart:io';

import 'package:catchpad/utils/consts.dart';

enum PlatformEnum {
  android,
  ios;

  static String get versionName {
    if(Platform.isIOS){
      return PlatformEnum.ios.name;
    }

    if(Platform.isAndroid){
      return PlatformEnum.android.name;
    }

    throw Exception('Platform unused please check!');
  }

  static String get storeLink {
    if(Platform.isIOS){
      return appStoreLink;
    }

    if(Platform.isAndroid){
      return googlePlayLink;
    }

    throw Exception('Platform unused please check!');
  }

}