/// as we're setting up everything to be json serializable,
/// we cant just use players[x], so we would use this instead
///
/// players = ["a", "b", "c"];
/// PlayerIndex.first = players[0] => "a"
/// PlayerIndex.second = players[1] => "b"
/// PlayerIndex.third = players[2] => "c"
enum PlayerIndex {
  first,
  second,
  third,
  fourth,
  fifth,
  sixth,
}
