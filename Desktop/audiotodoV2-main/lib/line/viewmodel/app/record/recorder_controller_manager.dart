import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/components/dialogs/record_dialogs.dart';
import 'package:audiotodo/utilities/constants/enums/meet/record_states.dart';
import 'package:audiotodo/utilities/constants/exceptions/record_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

enum SoundFileTypes {
  m4a,
  aac,
  wav;

//From String
  static SoundFileTypes fromString(String value) {
    return SoundFileTypes.values.firstWhere((e) => e.name == value);
  }
}

///m4a: Bu, MPEG-4 Audio (M4A) dosya formatını temsil eder. M4A formatı,
///sıkıştırılmış ses verilerini depolamak için kullanılan bir formattır.
///Genellikle Apple tarafından kullanılan ve
///iTunes Store'da sıkça karşılaşılan bir formattır.

///aac: Bu, Advanced Audio Coding (AAC) dosya formatını temsil eder.
///AAC, yüksek kalitede ses sıkıştırması sağlayan bir formattır. Daha düşük
///veri hızlarında bile iyi ses kalitesi sunar ve genellikle müzik dosyaları
///için kullanılır.

///wav: Bu, Waveform Audio File Format (WAV) dosya formatını temsil eder.
///WAV, ses verilerini kaydetmek için kullanılan bir formattır. Genellikle
///yüksek kalitede ses depolamak veya ses düzenleme işlemleri için tercih
///edilen bir formattır.

class RecorderControllerNotifier extends StateNotifier<RecorderController?> {
  RecorderControllerNotifier(RecorderController? state) : super(null);



  StreamSubscription? _subscription;

  Duration? _currentDuration;

  Map<String, String> currentMeetRecords = {};

  late File? _currentFile;

  Duration get currentDuration => _currentDuration!;

  void resetCurrentDuration() => _currentDuration = null;


  bool _popUpTimeout = false;

  /// [sampleRate]: Ne kadar ayrıntılı ses kaydı alalım 44.1 hertz gibi bir defaul değeri var.
  /// [bitRate]: Saniyede kaç bit alabiliyoruz kaydedebiliyoruz data verişi oluyor gibi*

  Future<void> initializeRecorderController(WidgetRef ref) async {
    try {
      state = RecorderController();
    } catch (e) {
      logger.e("InitalizeRecordController $e");
      RecordExceptions.handleRecordException("Not initialized", ref);
    }
  }

  Future<int?> sizeOfCurrentFile() async {
    return await _currentFile?.length();
  }

  //TODO THIS FUNCTION START RECORDING
  Future<void> startRecord(WidgetRef ref) async {
    try {
      if (state == null) {
        await initializeRecorderController(ref);
      }
      ref.read(currentWaveAnimationControlState.notifier).changState(true);
      ref
          .read(currentRecordStateManager.notifier)
          .changeRecordState(RecordStates.recording);

      final hasPermission = await state!.checkPermission();

      if (!hasPermission) {
        await ref
            .read(currentPermissionControllerManager.notifier)
            .giveGrantedToAllPermissions();
      }

      final mainPath = await _localPath;
      final meetId = ref.read(currentMeetControllerManager)!.meetId;
      final path = "$mainPath/$meetId/meet_sound.${SoundFileTypes.aac.name}";
      _currentFile = await File(path).create(recursive: true, exclusive: true);

      if (_currentFile == null) {
        RecordExceptions.handleRecordException("File creating Error", ref);
        return;
      }
      assert(_currentFile != null);

      currentMeetRecords.addAll({
        ref.read(currentMeetControllerManager)!.meetId!: _currentFile!.path
      });

      await state!.record(path: _currentFile!.path);

      state!.onRecorderStateChanged.listen((event) {
        switch (event) {
          case RecorderState.recording:
            ref
                .read(currentWaveAnimationControlState.notifier)
                .changState(true);
            break;
          case RecorderState.paused:
          case RecorderState.stopped:
            ref
                .read(currentWaveAnimationControlState.notifier)
                .changState(false);
            break;
          default:
            ref
                .read(currentWaveAnimationControlState.notifier)
                .changState(false);
        }
      });

      _subscription = state!.onCurrentDuration.listen((event) async {
        _currentDuration ??= event;

        if (ref.watch(currentRecordStateManager) == RecordStates.recording) {
          _currentDuration =
              _currentDuration! + const Duration(milliseconds: 50);
          if (_currentDuration!.inSeconds >=
              (ref.read(authManager)!.totalRecordSeconds ?? 0)) {
            // Finished Record
            await ref
                .read(currentMeetControllerManager.notifier)
                .reviewCurrentMeetingState(ref);

            if (!_popUpTimeout && !state!.isRecording && ref.read(currentAudioStepManager) == AudioToDoSteps.reviewMeet) {
              _popUpTimeout = true;
              await RecordDialogs.noHaveRecordTime();
              Future.delayed(const Duration(milliseconds: 500), () {
                _popUpTimeout = false;
              });
            }
          }

          // check if current duration less than user has record time
        }
      }, cancelOnError: true);
    } catch (e) {
      logger.e(state != null);
      logger.e(e.toString() + StackTrace.current.toString());
    }
  }

  String get currentPath => currentMeetRecords.values.first;

  Duration? currentDurationLocal() => _currentDuration;

  Future<void> pause(WidgetRef ref) async {
    // logger.d("Pause Record");

    ref
        .read(currentRecordStateManager.notifier)
        .changeRecordState(RecordStates.pause);

    await state!.pause();
    assert(state!.recorderState == RecorderState.paused);
  }

  Future<void> stop(WidgetRef ref) async {
    // logger.d("Stop Record");

    ref
        .read(currentRecordStateManager.notifier)
        .changeRecordState(RecordStates.idle);

    _subscription?.cancel();

    final res = await state!.stop(false);

    // TODO ARADA MEET MODELIMIZI GUZEL BIR SEKİLDE GUNCELLEYELİM
  }

  Future<void> resume(WidgetRef ref) async {
    // logger.d("Resume Record");
    ref
        .read(currentRecordStateManager.notifier)
        .changeRecordState(RecordStates.recording);

    if (ref.read(currentMeetControllerManager) != null) {
      if (!state!.isRecording) {
        logger.i("Resume to current record");
        if (_currentFile != null) {
          final length = await _currentFile!.length();

          await state!.record(
            path: _currentFile!.path,
          );

          logger.w("Length of file: $length");
        } else {
          RecordExceptions.handleRecordException(
              "Resume Current File Null", ref);
          throw Exception(
              " [_currentFile] Null in Resume Function on recorder_controller_manager");
        }
      }
    } else {
      startRecord(ref);
    }
  }

  Future<void> disposeRecord(WidgetRef ref) async {
    // logger.d("Dispose Record");
    ref
        .read(currentRecordStateManager.notifier)
        .changeRecordState(RecordStates.idle);

    _subscription?.cancel();
    _subscription = null;
    _currentDuration = null;
    currentMeetRecords.clear();
    state = null;
    _currentFile = null;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/records";
  }

  String getPathOfFileByMeetId(WidgetRef ref, String meetId) =>
      currentMeetRecords[meetId]!;
}
