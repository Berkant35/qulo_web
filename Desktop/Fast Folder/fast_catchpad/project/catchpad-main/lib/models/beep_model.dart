class BeepModel {
  static const String beep1 = 'BEEP/1/0';
  static const String beep2 = 'BEEP/1/1';
  static const String beep3 = 'AUDIO/bip2.mp3';//
}

class SandboxMusic {
  static const String sandboxBipPath = "assets/audio/sandbox/bip.mp3";
  static const String sandboxAacBipPath = "assets/audio/sandbox/bip.aac";
  static const String sandboxCowPath = "assets/audio/animals_game/animals_cow.mp3";
  static const String sandboxMotorcyclePath = "assets/audio/vehicles_game/motorcycle.mp3";
  static const String sandboxMotorcycleAacPath = "assets/audio/vehicles_game/motorcycle.aac";
}



enum BuzzerModes{
    lowPitch,
    mediumPitch,
    longHighPitch,
    customHighPitchFor,
    highPitch;
  String get modeString {
    switch (this) {
      case BuzzerModes.lowPitch:
        return 'BUZZER/1/4300/100/0';
      case BuzzerModes.mediumPitch:
        return 'BUZZER/1/3300/100/0';
      case BuzzerModes.highPitch:
        return 'BUZZER/1/1000/150/0';
      case BuzzerModes.longHighPitch:
        return 'BUZZER/1/1000/250/0';
      case BuzzerModes.customHighPitchFor:
        return 'BUZZER/1/2605/250/0';
      default:
        return '';
    }
  }
}

