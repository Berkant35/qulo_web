import 'package:catchpad/models/enums/utility/dialog_parts_enum.dart';
import 'package:catchpad/prov/dialogs/game_start_condition_dialog_prov.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/sticker_match_provider.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../prov/exercise_provider.dart';
import '../../prov/game/selected_players_prov.dart';
import '../../utils/l10n/l10n.dart';
import '../enums/game/education_type.dart';
import '../enums/game/game_execution_device.dart';
import '../enums/game/math_operation.dart';
import '../enums/game/mentor_controls_state.dart';
import '../enums/game/sport_mentor_controls_state.dart';
import 'attachment/attachment.dart';
import 'player/player_model.dart';
import 'player/selected_player_model.dart';

export '../enums/game/game_execution_device.dart';
export '../enums/game/math_operation.dart';
export '../enums/game/mentor_controls_state.dart';
export 'game_should_select_property.dart';

part 'game_controls_setup.freezed.dart';

@freezed
class GameControlsSetup with _$GameControlsSetup {
  const GameControlsSetup._();

  const factory GameControlsSetup({
    @Default(MentorControlsState.deny) MentorControlsState mentorControlsState,
    GameEducationTypeSelectionSetup? gameEducationTypeSelectionSetup,
    GameExerciseOpeartionsSelectionSetup? gameExerciseOpeartionsSelectionSetup,
    GameStickerMatchSelectionSetup? gameStickerMatchSelectionSetup,
    GameMusicSelectionSetup? gameMusicSelectionSetup,
    GameOperationSelectionSetup? gameOperationSelectionSetup,
    GameExecutionDeviceSelectionSetup? gameExecutionDevicesSelectionSetup,
    GameQuizSelectionSetup? gameQuizSelectionSetup,
    GameAudioSelectionSetup? gameAudioControls,
    // TODO: add ui controls, a widget builder which will controls the game's ui (gameScreenWidgetProv)
  }) = _GameControlsSetup;

  bool satisfiesAllConditions(WidgetRef ref) {
    var dialogContentTextMap = {
      DialogParts.title: "",
      DialogParts.description: ""
    };
    final l10n = L10n.inst(ref.context);
    bool isExerciseSatisfies = (gameExerciseOpeartionsSelectionSetup == null)
        ? true
        : gameExerciseOpeartionsSelectionSetup!.satisfiesAllConditions(ref);

    /*logger.i(isExerciseSatisfies.toString()+(ref
        .read(currentGameProv)
        ?.setup
        .controlsSetup
        .gameExerciseOpeartionsSelectionSetup !=
        null).toString());*/

    if (!isExerciseSatisfies &&
        ref
                .read(currentGameProv)
                ?.setup
                .controlsSetup
                .gameExerciseOpeartionsSelectionSetup !=
            null) {
      dialogContentTextMap.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_exercise_empty_title);
      dialogContentTextMap.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_exercise_empty_content);
    }

    bool isStickersSatisfies = (gameStickerMatchSelectionSetup == null)
        ? true
        : gameStickerMatchSelectionSetup!.satisfiesAllConditions(ref);



    if (!isStickersSatisfies &&
        ref
                .read(currentGameProv)
                ?.setup
                .controlsSetup
                .gameStickerMatchSelectionSetup !=
            null) {
      dialogContentTextMap.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_sticker_empty_title);
      dialogContentTextMap.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_sticker_empty_content);
    }

    bool isMusicSatisfies = (gameMusicSelectionSetup == null)
        ? true
        : gameMusicSelectionSetup!.satisfiesAllConditions(ref);

    if (!isMusicSatisfies &&
        ref
                .read(currentGameProv)
                ?.setup
                .controlsSetup
                .gameMusicSelectionSetup !=
            null) {
      dialogContentTextMap.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_music_empty_title);
      dialogContentTextMap.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_music_empty_content);
    }

    bool isGameOperationSelectionSetup = (gameOperationSelectionSetup == null ||
        gameOperationSelectionSetup!.satisfiesAllConditions(ref));

    if (!isGameOperationSelectionSetup &&
        ref
                .read(currentGameProv)
                ?.setup
                .controlsSetup
                .gameOperationSelectionSetup !=
            null) {
      dialogContentTextMap.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_operation_empty_title);
      dialogContentTextMap.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_operation_empty_content);
    }

    bool isGameExecutionDevicesSelectionSetup =
        (gameExecutionDevicesSelectionSetup == null ||
            gameExecutionDevicesSelectionSetup!.satisfiesAllConditions(ref));
    if (!isGameExecutionDevicesSelectionSetup &&
        ref
                .read(currentGameProv)
                ?.setup
                .controlsSetup
                .gameExecutionDevicesSelectionSetup !=
            null) {
      dialogContentTextMap.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_execution_empty_title);
      dialogContentTextMap.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_execution_empty_content);
    }
    bool isMentorControlState = mentorControlsState.satisfiesAllConditions(ref);

    if (!isMentorControlState &&
        ref.read(currentGameProv)?.setup.controlsSetup.mentorControlsState !=
            null) {
      dialogContentTextMap.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_mentor_empty_title);
      dialogContentTextMap.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_mentor_empty_content);
    }

    Future(() {
      ref
          .read(currentDialogTitleAndDescription.notifier)
          .changState(dialogContentTextMap);
    });

    //logger.i(
    //      "isExerciseSatisfies $isExerciseSatisfies \n"
    //      "isStickersSatisfies $isStickersSatisfies \n"
    //      "isMusicSatisfies $isMusicSatisfies \n"
    //      "isGameOperationSelectionSetup $isGameOperationSelectionSetup \n"
    //      "isGameExecutionDevicesSelectionSetup $isGameExecutionDevicesSelectionSetup \n"
    //      "isMentorControlState $isMentorControlState \n"
    //);

    return
        //
        isMusicSatisfies
            //
            &&
            //
            isGameOperationSelectionSetup &&
            //
            isGameExecutionDevicesSelectionSetup
            //
            &&
            //
            isMentorControlState &&
            //
            isExerciseSatisfies &&
            isStickersSatisfies

        //

        ;
  }
}

@freezed
class GameMusicSelectionSetup with _$GameMusicSelectionSetup {
  const GameMusicSelectionSetup._();

  const factory GameMusicSelectionSetup({
    required Set<Attachment> selectableMusics,
    required Set<Attachment> selectedMusics,
  }) = _GameMusicSelectionSetup;

  factory GameMusicSelectionSetup.init({
    required Set<Attachment> selectableMusics,
  }) =>
      GameMusicSelectionSetup(
        selectableMusics: selectableMusics,
        selectedMusics: const {},
      );

  bool satisfiesAllConditions(WidgetRef ref) {
    return selectedMusics.isNotEmpty;
  }
}

@freezed
class GameOperationSelectionSetup with _$GameOperationSelectionSetup {
  const GameOperationSelectionSetup._();

  const factory GameOperationSelectionSetup({
    required Set<MathOperation> selectedOperations,
  }) = _GameOperationSelectionSetup;

  factory GameOperationSelectionSetup.init() => GameOperationSelectionSetup(
        selectedOperations: MathOperation.values.toSet(),
      );

  bool satisfiesAllConditions(WidgetRef ref) {
    return selectedOperations.isNotEmpty;
  }
}

@freezed
class GameEducationTypeSelectionSetup with _$GameEducationTypeSelectionSetup {
  const GameEducationTypeSelectionSetup._();

  const factory GameEducationTypeSelectionSetup({
    required Set<EducationType> selectedOperations,
  }) = _GameEducationTypeSelectionSetup;

  factory GameEducationTypeSelectionSetup.init() =>
      GameEducationTypeSelectionSetup(
        selectedOperations: {EducationType.values.toSet().first},
      );

  bool satisfiesAllConditions(WidgetRef ref) {
    return selectedOperations.isNotEmpty;
  }
}

@freezed
class GameExerciseOpeartionsSelectionSetup
    with _$GameExerciseOpeartionsSelectionSetup {
  const GameExerciseOpeartionsSelectionSetup._();

  const factory GameExerciseOpeartionsSelectionSetup({
    required Set<ExerciseOperation> selectedOperations,
  }) = _GameExerciseOpeartionsSelectionSetup;

  factory GameExerciseOpeartionsSelectionSetup.init() =>
      GameExerciseOpeartionsSelectionSetup(
        selectedOperations: ExerciseOperation.values.toSet(),
      );

  bool satisfiesAllConditions(WidgetRef ref) {
    final SelectedPlayerModel? selectedPlayer =
        ref.watch(selectedGeneralPlayerProv);
    final Set<SelectedPlayerModel>? selectedPlayers =
        ref.watch(selectedPlayersProv);
    final moves = ref.watch(exerciseProvider);
    PlayerModel? player = selectedPlayer?.player;
    List<String> playerClrs = [];

    if (player != null) {
      for (var color in player.clrs) {
        if(!playerClrs.contains(color.value.toRadixString(16))){
          playerClrs.add(color.value.toRadixString(16));
        }

      }
    }
    if (selectedPlayers != null) {
      for (var player in selectedPlayers) {
        for (var color in player.player.clrs) {
          if(!playerClrs.contains(color.value.toRadixString(16))){
            playerClrs.add(color.value.toRadixString(16));
          }
        }
      }
    }

    return moves.exercises.values
            .toSet()
            .intersection(playerClrs.toSet())
            .length ==
        playerClrs.length;
  }
}

@freezed
class GameStickerMatchSelectionSetup with _$GameStickerMatchSelectionSetup {
  const GameStickerMatchSelectionSetup._();

  const factory GameStickerMatchSelectionSetup() =
      _GameStickerMatchSelectionSetup;

  factory GameStickerMatchSelectionSetup.init() =>
      const GameStickerMatchSelectionSetup();

  bool satisfiesAllConditions(WidgetRef ref) {
    final stickers = ref.watch(stickerProvider);
    final SelectedPlayerModel? selectedPlayer =
        ref.watch(selectedGeneralPlayerProv);
    final Set<SelectedPlayerModel>? selectedPlayers =
        ref.watch(selectedPlayersProv);
    PlayerModel? player = selectedPlayer?.player;
    List<DiscoveredDevice> devs = [];
    if (player != null) {
      for (var dev in player.devs) {
        devs.add(dev);
      }
    }
    if (selectedPlayers != null) {
      for (var player in selectedPlayers) {
        for (var dev in player.player.devs) {
          devs.add(dev);
        }
      }
    }

    bool returnvalue =
        stickers.stickers.entries.every((sticker) => sticker.value != null) &&
            devs.length == stickers.stickers.length;
    return returnvalue;
  }
}

@freezed
class GameAudioSelectionSetup with _$GameAudioSelectionSetup {
  const GameAudioSelectionSetup._();

  const factory GameAudioSelectionSetup({
    GameAudioSelectionSetupItem? gameAudioSetup,
    GameAudioSelectionSetupItem? musicSetup,
    GameAudioSelectionSetupItem? soundEffectsSetup,
  }) = _GameAudioSelectionSetup;

  bool satisfiesAllConditions(WidgetRef ref) {
    return true;
  }
}

@freezed
class GameAudioSelectionSetupItem with _$GameAudioSelectionSetupItem {
  const GameAudioSelectionSetupItem._();

  const factory GameAudioSelectionSetupItem(
      {required bool isEnabled,
      required bool isChangable,
      bool? chooseMusic}) = _GameOperationSelectionSetupItem;
}

@freezed
class GameExecutionDeviceSelectionSetup
    with _$GameExecutionDeviceSelectionSetup {
  const GameExecutionDeviceSelectionSetup._();

  const factory GameExecutionDeviceSelectionSetup({
    required Set<GameExecutionDevice> selectedDevices,
  }) = _GameExecutionDeviceSelectionSetup;

  factory GameExecutionDeviceSelectionSetup.init() =>
      GameExecutionDeviceSelectionSetup(
        selectedDevices: GameExecutionDevice.values.toSet(),
      );

  bool get isPlayableOnPads =>
      selectedDevices.contains(GameExecutionDevice.pads);

  bool get isPlayableOnApp => selectedDevices.contains(GameExecutionDevice.app);

  bool satisfiesAllConditions(WidgetRef ref) {
    return selectedDevices.isNotEmpty;
  }
}

@freezed
class GameQuizSelectionSetup with _$GameQuizSelectionSetup {
  const GameQuizSelectionSetup._();

  const factory GameQuizSelectionSetup({
    required Set<GameExecutionDevice> selectedDevices,
  }) = _GameQuizSelectionSetup;

  factory GameQuizSelectionSetup.init() => GameQuizSelectionSetup(
        selectedDevices: GameExecutionDevice.values.toSet(),
      );

  bool get isPlayableOnPads =>
      selectedDevices.contains(GameExecutionDevice.pads);

  bool get isPlayableOnApp => selectedDevices.contains(GameExecutionDevice.app);

  bool satisfiesAllConditions(WidgetRef ref) {
    return selectedDevices.isNotEmpty;
  }
}
