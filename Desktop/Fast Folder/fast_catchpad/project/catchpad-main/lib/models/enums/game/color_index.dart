/// as we're setting up everything to be json serializable,
/// we cant just use player.colors[x], so we would use this instead
///
/// player.colors = [FFF, 000, ddd];
/// ColorIndex.first => player.colors[0] => FFF
/// ColorIndex.second => player.colors[1] => 000
/// ColorIndex.third => player.colors[2] => ddd
enum ColorIndex {
  first,
  second,
  third,
  fourth,
  fifth,
  sixth,
  seventh,
  eighth,
  ninth,
  tenth,

  /// generates a random color
  random,

  /// when the [InstructionModel] parent of this [ActionModel]
  /// has multi devices, and we wanna use the same random color for all of them
  constRandom,
}
