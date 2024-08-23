/// as we're setting up everything to be json serializable,
/// we cant just use player.pads[x], so we would use this instead
///
/// player.pads = [1,4,7];
/// PlayerDevice.first => player.pads[0] => 1
/// PlayerDevice.second => player.pads[1] => 4
/// PlayerDevice.third => player.pads[2] => 7
enum PlayerDevice {
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
  eleventh,
  twelfth,

  /// selects a random pad
  random,

  /// selects all pads other than the random pad
  allExceptRandom,
}
