class AssetPaths {
  String _toSVG(String name) => 'assets/images/svg/$name.svg';

  String _toGif(String name) => 'assets/images/anim/$name.gif';

  String _toVideo(String name) => 'assets/video/$name.mp4';

  String _toPNG(String name) => 'assets/images/png/$name.png';

  static const loading = 'assets/images/svg/loading.svg';

  static const buttonLoading = 'assets/images/svg/button_loading.svg';
}
