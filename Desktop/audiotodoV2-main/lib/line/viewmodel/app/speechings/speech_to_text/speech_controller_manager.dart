import 'dart:async';

import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/components/dialogs/record_dialogs.dart';
import 'package:audiotodo/utilities/constants/exceptions/record_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../utilities/constants/enums/meet/speech_states.dart';
import '../../../audiotodo/current_meeting_states.dart';

// A StateNotifier class that wraps the SpeechToText class provided by the speech_to_text package
// It allows you to handle the state of the SpeechToText class with a StateNotifier
// In this case, it also has some extra functionality that is specific to the app
class SpeechToTextNotifier extends StateNotifier<SpeechToText?> {
  // Constructor for the SpeechToTextNotifier class
  // Initializes the state to null since the SpeechToText class hasn't been created yet
  SpeechToTextNotifier(SpeechToText? state) : super(null);

  // A constant duration for the final timeout of the speech recognition process
  final finalTimeOut = const Duration(hours: 1);
  bool think = false;
  int i = 0;

  // 1-5
  int _lastSoundLevel = 0;
  static const _maxSoundLevel = 50;
  static const _minSoundLevel = 0;

  int get lastSoundLevel => _lastSoundLevel;

  //Stream Subscription for last [lastSoundLevel] value
  // StreamSubscription<int>? _soundLevelSubscription;



  // A method to initialize the SpeechToText class
  // It checks if the state is null and then creates a new SpeechToText object
  // It also initializes the speech recognition options and error listeners
  Future<void> initSpeechToText(WidgetRef ref) async {
    if (state == null) {
      state = SpeechToText();

      await state!
          .initialize(
        onError: (sR) => initializeErrorListener(sR, ref),
        options: [],
        debugLogging: true,
        finalTimeout: finalTimeOut,
        onStatus: (sListener) => speechStatusListener(sListener, ref),
      )
          .then((value) async {
        await getLocales(ref);
      });
    }
  }

  // A method to stop listening for speech input
  // It uses the stop() method provided by the SpeechToText class
  // It also handles any exceptions that may occur during the process
  Future<void> stopListening(WidgetRef ref) async {
    try {
      ref
          .read(currentSpeechStateManager.notifier)
          .changeStateOfSpeechState(SpeechStates.stopping, ref);

      await state!.stop();
      await state!.cancel();
    } catch (e) {
      RecordExceptions.handleRecordException(e.toString(), ref,
          title: "Stop Listening For Speech To Text Notifier");
    }
  }

  // A method to cancel the speech recognition process
  // It uses the cancel() method provided by the SpeechToText class
  // It also handles any exceptions that may occur during the process
  Future<void> cancelFromSpeechToText(WidgetRef ref) async {
    try {
      await state!.cancel();
    } catch (e) {
      RecordExceptions.handleRecordException(e.toString(), ref,
          title: "Cancel From Speech To Text For Speech To Text Notifier");
    }
  }

  // A method to get a list of available locales for speech recognition
  // It uses the locales() method provided by the SpeechToText class
  // It also handles any exceptions that may occur during the process
  Future<List<LocaleName>> getLocales(WidgetRef ref) async {
    try {
      if (state == null) {
        return await initSpeechToText(ref).then((value) {
          return state!.locales();
        });
      } else {
        return await state!.locales();
      }
    } catch (e) {
      RecordExceptions.handleRecordException(e.toString(), ref);
      return [];
    }
  }

  // A method to get the system's current locale for speech recognition
  // It uses the systemLocale() method provided by the SpeechToText class
  // It also handles any exceptions that may occur during the process
  Future<LocaleName?> getSystemLocaleName(WidgetRef ref) async {
    try {
      return await state!.systemLocale();
    } on SpeechToTextNotInitializedException catch (e) {
      RecordExceptions.handleRecordException(e.toString(), ref);
      return null;
    }
  }

  // A method to start listening for speech input
  // It checks if the user has the necessary permission and if the SpeechToText
  // class is available If so, it starts the speech recognition process and
  // registers  callbacks for sound level change, device availability, and speech
  // recognition result If not, it displays appropriate dialogs or requests permission
  Future<void> startListening(WidgetRef ref) async {
    try {
      final hasPermission = await state!.hasPermission;

      if (hasPermission) {
        ref
            .read(currentSpeechStateManager.notifier)
            .changeStateOfSpeechState(SpeechStates.listening, ref);

        state!.listen(
            onSoundLevelChange: (val) => onSoundLevelChange(ref, val),
            onResult: (val) => onResult(val, ref),
            localeId: ref.watch(currentLanguageManager)?.localeId,
            listenFor: const Duration(seconds: 120),
            pauseFor: const Duration(seconds: 120),
            listenOptions: SpeechListenOptions(
              listenMode: ListenMode.dictation,
              autoPunctuation: true,
              partialResults: true,
            ));

        // ref.read(currentRecorderControllerManager.notifier).resume(ref);
      } else {
        ref
            .read(currentPermissionControllerManager.notifier)
            .giveGrantedToAllPermissions();
      }
    } on Exception catch (e) {
      RecordExceptions.handleRecordException(e.toString(), ref,
          title: "Start Listening For Speech To Text Notifier");
    }
  }

  // A callback method for the speech recognition result
  // It is invoked when a speech recognition result is available
  // In this case, it logs the recognition result
  onResult(SpeechRecognitionResult recognitionResult, WidgetRef ref) async {
    //logger.i("Recognition Result:${recognitionResult.toJson()}");
    if (!ref.context.mounted) return;

    if (ref.read(currentSpeechStateManager) != SpeechStates.listening) return;

    if (recognitionResult.finalResult &&
        !ref.read(currentMeetControllerManager.notifier).anyAddedContent) {
      logger.d("B2");
      await dialogCaseForNextSession(ref);
    } else if (recognitionResult.finalResult &&
        ref.read(currentMeetingManagerState) == CurrentMeetStates.contiune) {
      ref.read(currentMeetControllerManager.notifier).incrementSession(ref);
      await ref.read(currentRecorderControllerManager.notifier).pause(ref);
      await ref.read(currentSpeechToTextManager.notifier).stopListening(ref);
      await ref
          .read(currentMeetControllerManager.notifier)
          .controlMeetingManageButton(ref);

      // ref.read(currentSpeechToTextManager.notifier).
      // ref.read(currentMeetControllerManager.notifier).addContent(
      //     "${recognitionResult.recognizedWords} ",
      //     recognitionResult.confidence == 1.0,
      //     ref);
      // ref.read(currentRecordStateManager.notifier).changeRecordState(RecordStates.pause);
      // ref.read(currentSpeechStateManager.notifier).changeStateOfSpeechState(SpeechStates.stopping, ref);
      // ref.read(currentMeetControllerManager.notifier).controlMeetingManageButton(ref);
      // ref.read(currentMeetControllerManager.notifier).controlMeetingManageButton(ref);
      // ref.read(currentRecorderControllerManager.notifier).resume(ref);
      // ref.read(currentRecordStateManager.notifier).changeRecordState(RecordStates.recording);
      // ref.read(currentMeetControllerManager.notifier).controlMeetingManageButton(ref);
      // ref.read(currentMeetControllerManager.notifier).controlMeetingManageButton(ref);
    }

    ref.read(currentMeetControllerManager.notifier).addContent(
        "${recognitionResult.recognizedWords} ",
        recognitionResult.confidence == 1.0,
        ref,
        recognitionResult.finalResult);
  }

  Future<void> dialogCaseForNextSession(WidgetRef ref) async {
    ref.read(currentMeetControllerManager.notifier).incrementSession(ref);

    await ref.read(currentRecorderControllerManager.notifier).pause(ref);
    await ref.read(currentSpeechToTextManager.notifier).stopListening(ref);
    await ref
        .read(currentMeetControllerManager.notifier)
        .controlMeetingManageButton(ref);

    await RecordDialogs.noRecognitionWordDialog(ref);
  }

  // A callback method for the device availability
  // It is invoked when the availability of the speech recognition device changes
  // In this case, it logs the device availability value
  onDevice(WidgetRef ref) {}

  // A callback method for the sound level change
  // It is invoked when the sound level changes during speech recognition
  // In this case, it logs the sound level value
  onSoundLevelChange(WidgetRef ref, double levelOfValue) {
    final calibration = levelOfValue.toInt().abs();

    _lastSoundLevel = calibration > _maxSoundLevel
        ? _maxSoundLevel
        : calibration < _minSoundLevel
            ? _minSoundLevel
            : calibration;
  }

  // A method to handle the speech recognition status reported by the library
  // It is invoked when the speech recognition status changes
  // In this case, it logs the speech status and performs specific actions based on the status
  speechStatusListener(String sListener, WidgetRef ref) {
    switch (sListener) {
      case 'listening':
        break;
      case 'notListening':
        break;
      case 'done':
        break;
      default:
    }
  }

  void initializeErrorListener(
      SpeechRecognitionError speechRecognitionError, WidgetRef ref) {
    dialogCaseForNextSession(ref);
    logger.e(speechRecognitionError.errorMsg);
    RecordExceptions.handleRecordException(
        speechRecognitionError.errorMsg, ref);
  }

  void destroy() {
    state = null;
  }
}
