/// previously this was names `GameShouldSelectMusic`, which
/// was only used to indicate wether the user should be able
/// to select a music or not. but now, we use this in more than
/// one place, so we renamed it to `GameShouldSelectProperty`.
enum GameShouldSelectProperty {
  allow,
  deny,
}
