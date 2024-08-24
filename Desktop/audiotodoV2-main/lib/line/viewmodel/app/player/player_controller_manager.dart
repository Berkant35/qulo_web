import 'dart:io';
import 'dart:typed_data';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/line/db/api/network_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/meet/player_states.dart';
import 'package:audiotodo/utilities/constants/exceptions/record_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../utilities/constants/app/config.dart';
import '../record/recorder_controller_manager.dart';

final class PlayerControlManagerNotifier extends StateNotifier<PlayerController?>  {
  PlayerControlManagerNotifier(PlayerController? state) : super(null);

  int? _durationMillisecond;

  int? get durationMillisecond => _durationMillisecond;

  void setDuration(int? value) {
    _durationMillisecond = value;
  }

  Future<int?> sizeOfCurrentFile(File file) async {
    return await file.length();
  }
  /// Get current meet sound file link and then download set to current PlayerController state
  Future<bool> initializePlayerFromStorageController(WidgetRef ref) async {
    //download sound file
    state = PlayerController();

    final networkManager = NetworkManager();
    final currentMeet = ref.read(currentMeetControllerManager);

    //Call NetworkBase downloadFile method
    final downloadPath = await networkManager.downloadFile(
        currentMeet!.soundFileLink ?? "",
        currentMeet.meetId ?? "",
        SoundFileTypes.fromString(currentMeet.soundFileType!));

    File currentFile = await File(downloadPath!).create(recursive: true);

    return await state!
        .preparePlayer(
      path: currentFile.path,
      shouldExtractWaveform: true,
      noOfSamples: Configs.noOfSamples,
      volume: Configs.startVolumeSound,
    ).then((value) => true);
  }

  Future<bool> initializePlayerController(WidgetRef ref) async {
    try {
      final filePath =
          ref.read(currentRecorderControllerManager.notifier).currentPath;

      state = PlayerController();

      final currentFile = File(filePath);

      final length = await sizeOfCurrentFile(currentFile);

      return await state!
          .preparePlayer(
            path: filePath,
            shouldExtractWaveform: true,
            noOfSamples: Configs.noOfSamples,
            volume: Configs.startVolumeSound,
          )
          .then((value) => true);
    } catch (e) {
      RecordExceptions.handleRecordException(e.toString(), ref);
      return false;
    }
  }

  Future<void> startPlayer(WidgetRef ref,
      {FinishMode finishMode = FinishMode.pause}) async {
    ref
        .read(currentPlayerControlState.notifier)
        .changState(CustomPlayerStates.listen);

    state!.startPlayer(finishMode: finishMode);
  }

  Future<void> pausePlayer(WidgetRef ref) async {
    state!.pausePlayer();
    ref
        .read(currentPlayerControlState.notifier)
        .changState(CustomPlayerStates.stop);
  }

  Future<void> setVolume(WidgetRef ref, double volumeVal) async =>
      state!.setVolume(volumeVal);

  Future<int> getDuration(WidgetRef ref,
          {DurationType durationType = DurationType.current}) async =>
      state!.getDuration(durationType);

  void destroy() => state = null;
}
