import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef CurrentAudioFilesOnPad = Map<String, String>;

class AudioDevsNotifier extends StateNotifier<CurrentAudioFilesOnPad> {
  AudioDevsNotifier(CurrentAudioFilesOnPad state) : super({});

  Future<void> setPathOfAudioOnPad(String deviceId, String path) async
  {
    if(!state.keys.contains(deviceId))
    {
      state.addAll({deviceId: path});
    }
      else
    {
      state.update(deviceId, (value) => path);
    }
  }

}
