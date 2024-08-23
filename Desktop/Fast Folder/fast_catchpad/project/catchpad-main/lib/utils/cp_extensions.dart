extension StringExtensions on String {
  String capitalizeSentence() {
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
