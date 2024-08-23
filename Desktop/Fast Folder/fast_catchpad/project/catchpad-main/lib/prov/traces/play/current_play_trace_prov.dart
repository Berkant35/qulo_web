import 'dart:async';

import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/models/feedback/traces/play/game_trace.dart';
import 'package:catchpad/models/feedback/traces/play/play_trace.dart';
import 'package:catchpad/models/feedback/traces/play/pre_trace.dart';
import 'package:catchpad/models/feedback/traces/play/result_trace.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: slash_for_doc_comments
/**
    [CurrentMetaTraceNotifier]    [CurrentPreTraceNotifier]   [CurrentGameTraceNotifier]   [CurrentResultTraceNotifier]
    |                             |                            |                           |
    \|/                           \|/                          \|/                         \|/
    ----------------------------------------------------------------------------------------------------------------
    [CurrentPlayTraceNotifier]
 */

class CurrentPlayTraceNotifier extends StateNotifier<PlayTrace?> {
  CurrentPlayTraceNotifier(PlayTrace? state) : super(null);
  @deprecated
  static const countDownMs = 0;




  Future<PlayTrace?> initializePlayTrace(WidgetRef ref) async {
    StackTrace stackTrace = StackTrace.current;
    if (state != null) await saveToFirebaseNewTrace(ref);

    if (!ref.context.mounted) return null;

    ref
        .read(currentPlayTraceStateManager.notifier)
        .changState(PlayTraceStates.pre);

    final ftr = <Future>[
      ref.read(currentMetaTraceManager.notifier).createMetaTrace(ref),
      ref.read(currentPreTraceManager.notifier).create(ref)
    ];

    await Future.wait(ftr).then((value) {
      if (!ref.context.mounted) return null;
      ref.read(currentBleTrackerStateManager.notifier).initialize(ref);
    });

    if (!ref.context.mounted) return state;

    await updateCurrentPlayTrace(ref);

    return state;
  }

  Future<void> updateCurrentPlayTrace(WidgetRef ref) async {
    final playTrace = PlayTrace(
        gameControlSetup: ref.read(currentGameProv)!.setup.toJson(),
        resultTrace: ref.read(currentResultTraceManager),
        metaTrace: ref.read(currentMetaTraceManager),
        preTrace: ref.read(currentPreTraceManager),
        gameTrace: ref.read(currentGameTraceManager));

    state = playTrace;

    if (state?.createdMillisecondEpoch == null) {
      final dateTime = DateTime.now().millisecondsSinceEpoch.toString();
      state = state?.copyWith(createdMillisecondEpoch: dateTime);
    }
  }

  Future<void> changePlayTraceState(
      PlayTraceStates changeToState, WidgetRef ref) async {
    //set switch case for changeToState
    /*var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {

      return;
    }*/

    ref.read(currentPlayTraceStateManager.notifier).changState(changeToState);

    switch (changeToState) {
      case PlayTraceStates.pre:
        ref.read(currentPreTraceManager.notifier).create(ref);
        break;
      case PlayTraceStates.game:
        ref
            .read(currentPreTraceManager.notifier)
            .finishToPreState(enterGameValue: true, ref: ref);
        ref.read(currentGameTraceManager.notifier).create(ref);
        break;
      case PlayTraceStates.result:
        ref
            .read(currentGameTraceManager.notifier)
            .finishToGameState(enterToResult: true, ref: ref);
        ref.read(currentResultTraceManager.notifier).create(ref);
        break;
      case PlayTraceStates.idle:
        idleToEndStates(ref);
    }
  }

  Future<void> idleToEndStates(WidgetRef ref) async {
    switch (ref.read(currentPlayTraceStateManager)) {
      case PlayTraceStates.pre:
        await ref
            .read(currentPreTraceManager.notifier)
            .finishToPreState(enterGameValue: false, ref: ref);
        break;
      case PlayTraceStates.game:
        await ref
            .read(currentGameTraceManager.notifier)
            .finishToGameState(enterToResult: false, ref: ref);
        break;
      case PlayTraceStates.result:
        await ref
            .read(currentResultTraceManager.notifier)
            .finishToResultState(ref: ref);
        await saveToFirebaseNewTrace(ref);
        break;
      case PlayTraceStates.idle:
        await ref
            .read(currentPreTraceManager.notifier)
            .finishToPreState(enterGameValue: false, ref: ref);
        await saveToFirebaseNewTrace(ref);
        break;
    }
  }

  // Save to Firebase Current PlayTrace Model

  Future<void> saveToFirebaseNewTrace(WidgetRef ref) async {

      if(ref.read(currentEmbModeManager) == 1) return;

      if (state == null) return;


      updateCurrentPlayTrace(ref);

      final lastDate = DateTime.now();

      setPassedTimesOnAllTraces(ref, lastDate);

      Map<String, dynamic> map = {
        "gameControlSetup": state!.gameControlSetup,
        "resultTrace": ref.read(currentResultTraceManager)?.toJson(),
        "metaTrace": ref.read(currentMetaTraceManager)?.toJson(),
        "preTrace": ref.read(currentPreTraceManager)?.toJson(),
        "gameTrace": ref.read(currentGameTraceManager)?.toJson(),
        "createdAt": lastDate.toIso8601String()
      };



      if(map["gameTrace"] != null && (map["gameTrace"]["createdTime"] == null || map["gameTrace"]["endTime"] == null)){
        logger.e("Not end! ${map["gameTrace"]}");
        ref.read(currentGameTraceManager.notifier).disposeCurrentTrace();
        FirebaseFirestore.instance
            .collection(FirebaseCollectionEnums.main_traces.name)
            .doc(FirebaseCollectionEnumsWithDocuments.error_traces.name)
            .collection(FirebaseCollectionEnums.traces.name)
            .doc(state!.metaTrace?.traceID)
            .set(state!.toJson());
      }else{

        FirebaseFirestore.instance
            .collection(FirebaseCollectionEnums.main_traces.name)
            .doc(kDebugMode || adminIdList.contains(state!.metaTrace!.userID)
            ? FirebaseCollectionEnumsWithDocuments.admin_traces.name
            : FirebaseCollectionEnumsWithDocuments.play_traces.name)
            .collection(FirebaseCollectionEnums.traces.name)
            .doc(state!.metaTrace?.traceID)
            .set(map);
      }

      disposeCurrentTrace(ref);
  }



  //TODO CHECK WEIRD CASES

  void disposeCurrentTrace(WidgetRef ref) {

    ref.read(currentMetaTraceManager.notifier).disposeCurrentTrace();
    ref.read(currentGameTraceManager.notifier).disposeCurrentTrace();
    ref.read(currentPreTraceManager.notifier).disposeCurrentTrace();
    ref.read(currentResultTraceManager.notifier).disposeCurrentTrace();
    disposeOnlyCurrentPlayTrace(ref);
  }

  void disposeOnlyCurrentPlayTrace(WidgetRef ref) => state = null;

  void setPassedTimesOnAllTraces(WidgetRef ref, DateTime lastDate) {


    PreTrace? preTrace = ref.read(currentPreTraceManager);

    if(preTrace == null) return;

    int preTraceCreatedMs = int.parse(preTrace.createdMillisecondEpoch!);

    GameTrace? gameTrace = ref.read(currentGameTraceManager);

    int gameTraceCreatedMs =
        gameTrace != null ? int.parse(gameTrace.createdMillisecondEpoch!) : 0;

    ResultTrace? resultTrace = ref.read(currentResultTraceManager);

    int resultTraceCreatedMs = resultTrace != null
        ? int.parse(resultTrace.createdMillisecondEpoch!)
        : 0;

    final updatedPreTrace = preTrace.copyWith(
        passedTime: ((gameTrace != null
                    ? gameTraceCreatedMs
                    : lastDate.millisecondsSinceEpoch) -
                preTraceCreatedMs)
            .msToSec
            .toInt().abs(),
        endTime: gameTrace == null
            ? lastDate.toString().substring(0,20)
            : gameTrace.createdTime);

    final updatedGameTrace = gameTrace?.copyWith(
        passedTime: (((resultTrace == null
                        ? lastDate.millisecondsSinceEpoch
                        : resultTraceCreatedMs) -
                    countDownMs) -
                gameTraceCreatedMs)
            .msToSec
            .toInt().abs(),
        endTime: resultTrace == null
            ? lastDate.toString().substring(0,20)
            : resultTrace.createdTime);


    final updatedResultTrace = resultTrace?.copyWith(
        passedTime: (lastDate.millisecondsSinceEpoch - resultTraceCreatedMs)
            .msToSec
            .toInt().abs(),
        endTime: lastDate.toString().substring(0,20));

    ref.read(currentPreTraceManager.notifier).updateState(updatedPreTrace);
    if (updatedGameTrace == null) return;
    ref.read(currentGameTraceManager.notifier).updateState(updatedGameTrace);
    if (updatedResultTrace == null) return;
    ref
        .read(currentResultTraceManager.notifier)
        .updateState(updatedResultTrace);
  }


// TODO SAVE TO LOCAL DB!

// TODO CHECK ANY SAVED TO LOCAL DB ANY TRACE IF TRUE SEND TO FİREBASE ELSE GO AHEAD!
}
