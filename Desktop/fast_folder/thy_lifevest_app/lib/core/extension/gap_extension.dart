import 'package:flutter/cupertino.dart';
import 'package:thy_lifevest_app/core/utils/screen_size.dart';

extension GapExtension on BuildContext {
  SizedBox get gap2 => const SizedBox(height: 2);

  SizedBox get gap2W => const SizedBox(width: 2);

  SizedBox get gap4 => const SizedBox(height: 4);

  SizedBox get gap4W => const SizedBox(width: 4);

  SizedBox get gap8 => const SizedBox(height: 8);

  SizedBox get gap8W => const SizedBox(width: 8);

  SizedBox get gap10 => const SizedBox(height: 10);

  SizedBox get gap10W => const SizedBox(width: 10);

  SizedBox get gap12 => const SizedBox(height: 12);

  SizedBox get gap12W => const SizedBox(width: 12);

  SizedBox get gap16 => const SizedBox(height: 16);

  SizedBox get gap16W => const SizedBox(width: 16);

  SizedBox get gap20 => const SizedBox(height: 20);

  SizedBox get gap20W => const SizedBox(width: 20);

  SizedBox get gap24 => const SizedBox(height: 24);

  SizedBox get gap24W => const SizedBox(width: 24);

  SizedBox get gap32 => const SizedBox(height: 32);

  SizedBox get gap32W => const SizedBox(width: 32);

  SizedBox get gap80 => const SizedBox(height: 80);
  SizedBox get bottomPaddingGap => SizedBox(height: ScreenSize().bottomPadding);

  SizedBox get topPaddingGap => SizedBox(height: ScreenSize().topPadding);

  SizedBox gap(double dimension) => SizedBox.square(dimension: dimension);
}
