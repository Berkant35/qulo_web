abstract class AssetManager {
  //images
  static const String _cpLogoName = 'cp_logo.png',
      _cpLogoTextName = 'cp_logo_text.png';
  static const cplandingBackground = 'landing_background.png';
  static const _cpLogoNew = 'cp_logo_new.png';

  //svg
  static const String _goodPng = 'good.png';
  static const String _badPng = 'bad.png';

  //animations
  static const String _excellent = 'excellent.json';
  static const String _bad = 'notBad.json';
  static const String _good = 'good.json';
  static const String _perfect = 'perfect.json';
  static const String _notBad = 'bad.json';
  //static const String _good = 'excellent.json';
  //static const String _bad = 'bad.json';

  static String getImgPath(String imgName) {
    return 'assets/images/$imgName';
  }

  static String getIgaPath(String imgName) {
    return 'assets/iga/$imgName';
  }

  static String getSvgImgPath(String imgName) {
    return 'assets/images/svg/$imgName';
  }

  static String getLottieAnimationPath(String lottieAnimationName) {
    return 'assets/animation/lottie/$lottieAnimationName';
  }

  //images
  static String get cpLogo => getImgPath(_cpLogoName);
  static String get cpLogoText => getImgPath(_cpLogoTextName);
  static String get cpLogoNew => getImgPath(_cpLogoNew);

  static String get goodPng => getImgPath(_goodPng);
  static String get badPng => getImgPath(_badPng);

  //Animations
  static String get excellentAnimation => getLottieAnimationPath(_excellent);
  static String get goodAnimation => getLottieAnimationPath(_good);
  static String get badAnimation => getLottieAnimationPath(_bad);
  static String get notBadAnimation => getLottieAnimationPath(_notBad);
  static String get perfectAnimation => getLottieAnimationPath(_perfect);
  //static String get goodAnimation => getLottieAnimationPath(_good);
  //static String get badAnimation => getLottieAnimationPath(_bad);
}
