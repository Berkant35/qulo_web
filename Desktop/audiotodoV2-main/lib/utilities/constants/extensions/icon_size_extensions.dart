


import 'package:responsive_sizer/responsive_sizer.dart';

enum IconSizeExtension{small,normal,medium,high,huge,mega}


extension IconSizeValue on IconSizeExtension{

  double get sizeValue  {
    switch(this){
      case IconSizeExtension.small:
        return 4.w;
      case IconSizeExtension.normal:
        return 6.w;
      case IconSizeExtension.medium:
        return 8.w;
      case IconSizeExtension.high:
        return 12.w;
      case IconSizeExtension.huge:
        return 18.w;
      case IconSizeExtension.mega:
        return 24.w;
      default:
        throw Exception('NOT VALİD FONT SİZE');
    }
  }

}