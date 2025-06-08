extension IntExtension on int? {
  int get getValueOrDefault => this ?? 0;

  String get formattedRemainingTime {
    int minutes = getValueOrDefault ~/ 60;
    int seconds = getValueOrDefault % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
