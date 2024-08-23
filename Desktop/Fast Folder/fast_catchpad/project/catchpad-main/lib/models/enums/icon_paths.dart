enum IconPaths {
  distance,
  tap,
  motion,
  force,
  none;

  // final String name;
  // const IconPaths([this.name]);
  String get path => 'assets/icons/$name.png';
}
