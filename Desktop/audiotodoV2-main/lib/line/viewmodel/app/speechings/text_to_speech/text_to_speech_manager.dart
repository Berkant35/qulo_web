import 'dart:io';

import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// We have texts for text to speech. we need to keep track of the state of
/// each text. This provider keep these states.
enum TtsState { playing, stopped }

typedef ContentTextToSpeechMap = Map<String, TtsState>;
typedef KeyTexts = Map<String, String>;

class TextToSpeechControlNotifier
    extends StateNotifier<ContentTextToSpeechMap> {
  TextToSpeechControlNotifier(ContentTextToSpeechMap state) : super({});

  KeyTexts keyTexts = {};

  FlutterTts? _tts;

  FlutterTts? get tts => _tts;

  void changState(ContentTextToSpeechMap val) => state = val;

  void addNewTextState(WidgetRef ref, String key, TtsState val, String text) {
    state[key] = val;
    keyTexts[key] = text;
  }

  void updateTtsState(WidgetRef ref, String key, TtsState val) {
    ContentTextToSpeechMap map = state;
    map[key] = val;
    state = map;
    logger.i(state.toString());
  }

  void removeTextState(WidgetRef ref, String key) {
    state.remove(key);
    keyTexts.remove(key);
  }

  Future<void> initializeFlutterTts(WidgetRef ref) async {
    _tts = FlutterTts();
    if (_tts == null) throw Exception("Text to speech is not initialized");
    if (Platform.isIOS) {
      await _tts?.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
      await _tts?.awaitSpeakCompletion(true);
      await _tts?.awaitSynthCompletion(true);
      await _tts?.setVolume(1.0);
      await _tts?.setSpeechRate(0.5);
      await _tts?.setPitch(1.0);
    }
  }

  Future<void> playTts(WidgetRef ref, String key) async {


    final text = keyTexts[key];

    final localId = ref.read(currentLanguageManager)!.localeId;

    final available = await _tts!.isLanguageAvailable(localId);

    //TODO BURDA EĞER AVAILABLE FALSE GELİRSE BİR TOAST GİBİ MESAJ GÖSTERMEK LAZIM

    await _tts!.setLanguage(available ? localId : "en-US");

    updateTtsState(ref, key, TtsState.stopped);

    await _tts!.speak(text ?? "").then((value) => updateTtsState(ref, key, TtsState.playing));

  }

  void stopTts(WidgetRef ref, String key) async {
    _tts!.pause();
    _tts!.clearVoice();

    final res = await _tts!.stop();

    if (res == 1) {
      updateTtsState(ref, key, TtsState.playing);
    }
  }
}
