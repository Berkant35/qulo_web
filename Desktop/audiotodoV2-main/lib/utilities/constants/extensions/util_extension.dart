import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

import '../enums/utilities/pdf_font_states.dart';

extension IterableExtension<T> on Iterable<T> {
  List<T> distinct<U>({required U Function(T t) by}) {
    final unique = <U, T>{};

    for (final item in this) {
      unique.putIfAbsent(by(item), () => item);
    }

    return unique.values.toList();
  }
}

extension CustomFontLoader on FontType {
  String get fontFileName {
    switch (this) {
      case FontType.regular:
        return 'Poppins-Regular.ttf';
      case FontType.black:
        return 'Poppins-Black.ttf';
      case FontType.blackItalic:
        return 'Poppins-BlackItalic.ttf';
      case FontType.bold:
        return 'Poppins-Bold.ttf';
      case FontType.boldItalic:
        return 'Poppins-BoldItalic.ttf';
      case FontType.extraBold:
        return 'Poppins-ExtraBold.ttf';
      case FontType.extraBoldItalic:
        return 'Poppins-ExtraBoldItalic.ttf';
      case FontType.extraLight:
        return 'Poppins-ExtraLight.ttf';
      case FontType.extraLightItalic:
        return 'Poppins-ExtraLightItalic.ttf';
      case FontType.italic:
        return 'Poppins-Italic.ttf';
      case FontType.light:
        return 'Poppins-Light.ttf';
      case FontType.lightItalic:
        return 'Poppins-LightItalic.ttf';
      case FontType.medium:
        return 'Poppins-Medium.ttf';
      case FontType.mediumItalic:
        return 'Poppins-MediumItalic.ttf';
      case FontType.semiBold:
        return 'Poppins-SemiBold.ttf';
      case FontType.semiBoldItalic:
        return 'Poppins-SemiBoldItalic.ttf';
      case FontType.thin:
        return 'Poppins-Thin.ttf';
      default:
        return 'Poppins-Regular.ttf';
    }
  }

  Future<Font> loadFont() async {
    var data = await rootBundle.load('assets/fonts/$fontFileName');
    var myFont = Font.ttf(data);
    return myFont;
  }
}