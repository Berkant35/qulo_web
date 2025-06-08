import 'dart:ui';

class AppColors {
  static const Color thyPrimary = Color(0xFFEF0101);
  static const Color surface = Color(0xFFFFECE5);
  static const Color surfaceSecondary = Color(0xFF76808A);

  static const Color textPrimary = Color(0xFF292F39);
  static const Color black = Color(0xFF000000);
  static const Color textPrimary50 = Color(0xFF191B1E);

  static const Color gray = Color(0xFFC3C3C3);
  static const Color gray25 = Color(0xFFF3F3F3);
  static const Color gray50 = Color(0xFFF5F5F5);
  static const Color gray100 = Color(0xFFEBEBEB);
  static const Color gray150 = Color(0xFFB5B5B5);
  static const Color gray200 = Color(0xFF9397A0);
  static const Color gray250 = Color(0xFFE7E7E7);
  static const Color gray300 = Color(0xFFA9ACAF);
  static const Color gray400 = Color(0xFFF8F8F8);
  static const Color gray450 = Color(0xFFFCFCFC);
  static const Color gray500 = Color(0xFF76808A);
  static const Color gray600 = Color(0xFFBABFC5);
  static const Color gray700 = Color(0xFFE1E1E1);
  static const Color gray500With15Alpha = Color(0x2676808A);
  static const Color gray500With50Alpha = Color(0x8076808A);
  static const Color shadowGray = Color(0x14D1D1D1);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white100 = Color(0xFFF2F2F2);
  static const Color white200 = Color(0xFFE5E9ED);
  static const Color white300 = Color(0xFFE6E6E6);

  static const Color primary = Color(0xFF5A009F);
  static const Color softPurple = Color(0xFF817886);
  static const Color purple800 = Color(0xFFCA22C8);

  static const Color secondary = Color(0xFFA1A1A1);

  static const Color pink100 = Color(0xFFFFD6DB);

  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFF3030);
  static const Color red200 = Color(0xFFB70000);
  static const Color red500 = Color(0xFFCE011B);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red800 = Color(0xFFB3051B);

  static const Color lightGreen = Color(0xFF58D78F);
  static const Color green = Color(0xFF178750);
  static const Color green50 = Color(0xFF21D77B);

  static const Color blue = Color(0xFF005EF5);
  static const Color warning = Color(0xFFB5BD1F);
  //orange
  static const Color orange = Color(0xFFFFA500);

  // Success and Error colors
  static const Color success = Color(0xFF178750);
  static const Color error = Color(0xFFB70000);
  static const Color gray800 = Color(0xFF1F2937);

  static const Color transparent = Color(0x00000000);

  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}

extension ColorOpacityExtension on Color {
  Color get withValues075 => withValues(alpha: .075);

  Color get withValues10 => withValues(alpha: .1);

  Color get withValues15 => withValues(alpha: .15);

  Color get withValues16 => withValues(alpha: .16);

  Color get withValues20 => withValues(alpha: .20);

  Color get withValues30 => withValues(alpha: .3);

  Color get withValues50 => withValues(alpha: .5);

  Color get withValues75 => withValues(alpha: .75);
}
