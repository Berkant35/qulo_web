import 'package:catchpad/models/emb/iga/traces/iga_trace_game_model.dart';
import 'package:catchpad/models/emb/iga/traces/iga_trace_meta_model.dart';
import 'package:catchpad/models/emb/iga/traces/iga_trace_model.dart';
import 'package:catchpad/models/emb/iga/traces/iga_trace_pre_model.dart';
import 'package:catchpad/models/emb/iga/traces/iga_trace_result_model.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';

import '../../../../models/emb/iga/traces/iga_register_trace_model.dart';
import '../../../game/selected_players_prov.dart';

/// All actions taken by the user from the start of
/// any game in the IGA until the end of the game
/// [IgaTraceModel].
class IgaTraceManagerNotifier extends StateNotifier<IgaTraceModel?> {
  IgaTraceManagerNotifier(IgaTraceModel? state) : super(null);

  DateTime? traceCurrentStateDateTime;
  bool isEnterRegisterValue = false;

  String? traceUserId;

  //Refresh current state for new trace
  Future<void> refresh({required WidgetRef ref}) async {
    await sendCurrentTraceToFirebase(ref: ref);
    traceCurrentStateDateTime = null;
    state = null;
    traceUserId = null;
  }

  /// Assigns the existing trace to the registered user
  void setIgaTraceUserId({required WidgetRef ref, required String igaUserId}) {
    traceUserId = igaUserId;
  }

  /// Allows us to check the flag if the user goes to the registration page at the end of the exercise
  Future<void> isEnterRegister({bool isEnter = false}) async {
    isEnterRegisterValue = isEnter;
  }

  /*
    @JsonKey(name: 'igaMetaTrace') @Default(IgaMetaTraceModel()) IgaMetaTraceModel? igaMetaTraceModel,
    @JsonKey(name: 'igaPreTrace') @Default(IgaPreTraceModel()) IgaPreTraceModel? igaPreTraceModel,
    @JsonKey(name: 'igaGameTrace') @Default(IgaGameTraceModel()) IgaGameTraceModel? igaGameTraceModel,
    @JsonKey(name: 'igaResultTrace') @Default(IgaResultTraceModel()) IgaResultTraceModel? igaResultTraceModel
  */

  /// TODO Initialize IgaTraceModel When any tap to tablet
  /// Creates an empty trace and fills its base data
  Future<void> createIgaTraceModel({required WidgetRef ref}) async {
    if (state != null) await refresh(ref: ref);
    var currentIgaTraceId = nanoid(24);
    traceCurrentStateDateTime = DateTime.now();
    var currentTime = traceCurrentStateDateTime.toString().substring(0, 19);
    state = IgaTraceModel(traceId: currentIgaTraceId, createdAt: currentTime);
  }

  /// Sends the generated Trace to Firebase
  Future<void> sendCurrentTraceToFirebase({required WidgetRef ref}) async {
    logger.i("Send Current Trace To Firebase ${state?.toJson()}");

    if (state?.igaPreTraceModel != null) {
      await FirebaseIgaCollectionEnumsWithField.iga_traces.reference
          .doc(state?.traceId)
          .set(state?.toJson());
    }
  }

  /// TODO Create PreTraceModel when any tapping
  ///  After creating a new trace, [IgaPlayTraceStates.pre] is created. In this case
  /// the user's actions until the user starts the game are collected under this trace structure.
  Future<void> createPreTraceModel({required WidgetRef ref}) async {
    // logger.i(
    //     "Trace Current State Date Time Is Null:${traceCurrentStateDateTime == null} ${state == null}");

    if (traceCurrentStateDateTime == null) return;
    //Calculate Current states
    final currentTimeForPreTrace = DateTime.now();
    final diffTimeFromTraceStart =
        currentTimeForPreTrace.difference(traceCurrentStateDateTime!);

    if (state == null) return;

    //Create current pre trace of current iga trace
    IgaPreTraceModel igaPreTraceModel = IgaPreTraceModel(
      traceId: state!.traceId,
      selectLanguage: L10n.inst(ref.context).language ?? "EN",
      selectMode: ref.read(currentIgaChooseLevelManager).name,
      selectPlayer: ref.read(currentIgaPlayerModeManager).name,
      createdAt: traceCurrentStateDateTime.toString().substring(0, 19),
      endTime: currentTimeForPreTrace.toString().substring(0, 19),
      passedTime: diffTimeFromTraceStart.inSeconds,
      isEnterGame: ref.read(currentSafeInGameToggleState),
    );

    createMetaTraceModel(ref: ref);

    // logger.w("Current Pre Trace: ${igaPreTraceModel.toJson()}");

    //Update current pre trace for current iga trace
    state = state!.copyWith(igaPreTraceModel: igaPreTraceModel);
  }

  /// TODO Create IgaMetaTraceModel when any start game
  /// /// After creating a new trace, [IgaPlayTraceStates.meta] is created. In this case
  /// fills in states with information such as which pier the user is on.
  Future<void> createMetaTraceModel({required WidgetRef ref}) async {
    logger.w("Create Meta Trace Model");
    final currentMap = <String>[];

    ref.read(bleConPr).keys.forEach((element) {
      currentMap.addAll({element.id});
    });
    if (state == null) return;

    IgaMetaTraceModel igaMetaTraceModel = IgaMetaTraceModel(
        traceId: state!.traceId,
        phoneInformation: ref.read(currentDeviceInformationManager)?.toJson() ??
            {"error": "Phone information not filled"},
        connectedDevices: currentMap,
        locationInformation: ref
                .read(currentIgaResultManager.notifier)
                .currentLocation
                ?.toJson() ??
            {});

    traceCurrentStateDateTime = DateTime.now();

    // logger.w("Current Meta Trace: ${igaMetaTraceModel.toJson()}");

    state = state!.copyWith(igaMetaTraceModel: igaMetaTraceModel);
  }

  /// i cannot remember why i create this func
  DateTime getDateTimeBefore20Seconds({required WidgetRef ref}) {
    DateTime currentTime = DateTime.now();
    Duration duration =
        Duration(seconds: ref.read(currentGameProv)!.setup.duration?.def ?? 20);
    DateTime before20Seconds = currentTime.subtract(duration);
    return before20Seconds;
  }

  /// TODO Create IgaGameTraceModel when any start game
  /// [IgaPlayTraceStates.game] is created after the game starts. In this case
  /// information about which game he/she played and when he/she played it is created.
  Future<void> createGameTraceModel({required WidgetRef ref}) async {
    if (state == null) return;

    IgaGameTraceModel igaGameTraceModel = IgaGameTraceModel(
        traceId: state!.traceId,
        createdAt:
            getDateTimeBefore20Seconds(ref: ref).toString().substring(0, 19),
        endTime: DateTime.now().toString().substring(0, 19),
        gameId: ref.read(currentGameProv)?.id,
        selectedColors: ref
            .read(selectedPlayersPlayersProv)
            .colors
            .map((e) => e.toString())
            .toList());

    logger.w("Game Trace: ${igaGameTraceModel.toJson()}");
    traceCurrentStateDateTime = DateTime.now();

    state = state!.copyWith(igaGameTraceModel: igaGameTraceModel);
  }

  /// TODO Create IgaResultTraceModel when finished game
  /// After the exercise is finished, [IgaPlayTraceStates.result] is generated. In this case
  /// This is the section that contains information such as whether the user has registered or not,
  ///  whether he/she has started the game again.
  /// It also contains information about how much time the user has spent here.
  Future<void> createResultTraceModel({required WidgetRef ref}) async {
    //Calculate Current states
    final currentTimeForPreTrace = DateTime.now();
    if (traceCurrentStateDateTime != null) return;
    final diffTimeFromTraceStart =
        currentTimeForPreTrace.difference(traceCurrentStateDateTime!);

    if (state == null) return;

    IgaResultTraceModel igaResultTraceModel = IgaResultTraceModel(
        traceId: state!.traceId,
        isEnterRegistered: isEnterRegisterValue,
        createdAt: state!.igaGameTraceModel!.endTime,
        endTime: currentTimeForPreTrace.toString().substring(0, 19),
        passedTime: diffTimeFromTraceStart.inSeconds);

    logger.w("Result Trace: ${igaResultTraceModel.toJson()}");

    traceCurrentStateDateTime = currentTimeForPreTrace;

    state = state!.copyWith(igaResultTraceModel: igaResultTraceModel);
  }

  /// This trace checks whether the registration has been successfully 
  /// completed after navigating to the registration screen.
  Future<void> createRegisterTraceModel({required WidgetRef ref}) async {
    //Calculate Current states
    final currentTimeForPreTrace = DateTime.now();

    final diffTimeFromTraceStart =
        currentTimeForPreTrace.difference(traceCurrentStateDateTime!);

    if (state == null) return;

    IgaRegisterTraceModel igaRegisterTraceModel = IgaRegisterTraceModel(
        traceId: state!.traceId,
        igaUserId: traceUserId,
        createdAt: state!.igaGameTraceModel!.endTime,
        endTime: currentTimeForPreTrace.toString().substring(0, 19),
        passedTime: diffTimeFromTraceStart.inSeconds,
        isRegistered: traceUserId != null);

    logger.w("Register Trace: ${igaRegisterTraceModel.toJson()}");

    traceCurrentStateDateTime = currentTimeForPreTrace;

    state = state!.copyWith(igaRegisterTraceModel: igaRegisterTraceModel);
  }
}
