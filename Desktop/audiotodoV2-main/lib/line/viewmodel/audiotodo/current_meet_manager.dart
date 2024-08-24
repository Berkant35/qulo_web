import 'dart:io';

import 'package:audiotodo/line/repository/api_repository/gpt_repository.dart';
import 'package:audiotodo/line/repository/fb_repository/db_meet_repository.dart';
import 'package:audiotodo/line/repository/fb_repository/storage_repository.dart';
import 'package:audiotodo/line/viewmodel/app/record/recorder_controller_manager.dart';
import 'package:audiotodo/line/viewmodel/audiotodo/current_meeting_states.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/constants/enums/meet/audio_steppers.dart';
import 'package:audiotodo/utilities/constants/enums/meet/record_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/speech_states.dart';
import 'package:audiotodo/utilities/constants/exceptions/firebase_exceptions.dart';
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../../models/meet/meet_model.dart';
import '../../../utilities/constants/exceptions/record_exceptions.dart';

typedef SpeechTextSessions = Map<int, String>;
typedef CursorRichTextParts = Map<int, String>;

class CurrentMeetManagerNotifier extends StateNotifier<Meet?> {
  CurrentMeetManagerNotifier(Meet? state) : super(null);

  StringBuffer newBuffer = StringBuffer();

  final StorageRepository _storageRepository = StorageRepository();
  final DbMeetRepository _dbMeetRepository = DbMeetRepository();
  final _gptRepository = GPTRepository.instance;

  //Handle sessions when pause and resume state at the meet this parameter must
  //update for which reference
  SpeechTextSessions speechTextSessions = {};

  //When you add new content to the meeting, this value should be triggered by the addContent function.
  //Then it should be added with the second using that key, and we should listen to this parameter in the UI.
  //Listening to the background color change of the rich text in the saved current meeting will help us, what do you say?
  CursorRichTextParts cursorRichTextParts = {};

  //Maybe will help in future.
  Meet? lastMeet;

  //This parameter control any added content for current session.If this true
  //you can pass to next session smoothly if set false you must set manually
  //to next session by dialog
  bool _anyAddedContentForCurrentSession = false;

  //This value help us for handle which session on meeting.
  //When you want pause meeting we must increment to this value
  int currentIndex = 0;

  //This attribute control any stop status on meeting.
  //So we can adding last meeting content with before content
  bool isPaused = false;

  String lastDetectText = "";

  changeCurrentMeetState(Meet? meet) => state = meet;

  void initialize(WidgetRef ref) {
    if (state != null) {
      state = null;
    }
    final uniqueId = ref.read(currentUUIDManager.notifier).getV1UUID(ref);

    speechTextSessions.addAll({currentIndex: ""});
    state = Meet(
      meetId: uniqueId,
      createdDateTime: DateTime.now().toLocal(),
      meetCategory: "Undefined",
      userId: ref.read(authManager)!.userId,
      createdPdfFile: false,
      createdWordFile: false,
    );
  }

  Future<bool> updateMeet(WidgetRef ref, Meet meet) async {
    state = meet;
    final updateToFirebaseStatus = await _dbMeetRepository
        .saveMeetToCloud(state!, ref, isRecreateAgain: true);

    //Result of update to firebase
    if (updateToFirebaseStatus) {
      logger.d("Update to firebase success");
    } else {
      logger.d("Update to firebase failed");
      throw Exception("Update to firebase failed");
    }
    return updateToFirebaseStatus;
  }

  void addContent(
      String content, bool willAddPart, WidgetRef ref, bool isFinalResult) {
    if (willAddPart) {
      if (content.length < lastDetectText.length) {
        lastDetectText = content;
        return;
      }

      final allTextPartsForMeetContent = StringBuffer();

      cursorRichTextParts.values.toList().forEach((perText) {
        allTextPartsForMeetContent.write(perText);
      });

      if (isFinalResult) {
        cursorRichTextParts.addAll({
          currentIndex: content,
        });
      } else {
        cursorRichTextParts[currentIndex] = content;
      }

      lastDetectText = content;

      state =
          state!.copyWith(meetContent: allTextPartsForMeetContent.toString());
    }

    final currentMeetText = content;

    speechTextSessions[currentIndex] = currentMeetText;

    if (!_anyAddedContentForCurrentSession) {
      _anyAddedContentForCurrentSession = true;
    }
  }

  bool get anyAddedContent => _anyAddedContentForCurrentSession;

  void incrementSession(WidgetRef ref) {
    if (state == null) return;
    newBuffer.clear();
    newBuffer.write(state!.meetContent);
    currentIndex++;
    speechTextSessions.addAll({currentIndex: ""});
    _anyAddedContentForCurrentSession = false;
  }

  Future<void> controlMeetingManageButton(WidgetRef pRef) async {
    if (pRef.read(currentSpeechToTextManager) == null ||
        pRef.read(currentRecorderControllerManager) == null) {
      await initializeAudioToDo(pRef);
    }

    final currentRecordState = pRef.read(currentRecordStateManager);
    final currentSpeechState = pRef.read(currentSpeechStateManager);

    if (currentRecordState == RecordStates.idle &&
        currentSpeechState == SpeechStates.idle) {
      pRef.read(currentMeetControllerManager.notifier).initialize(pRef);
      pRef.read(currentMeetControllerManager.notifier).startMeeting(pRef);
      pRef.read(currentPeriodicPromptManagerState.notifier).create(pRef);
      pRef
          .read(currentMeetingManagerState.notifier)
          .changState(CurrentMeetStates.contiune);

      //We have already started a meeting
    } else if (currentRecordState == RecordStates.recording &&
        currentSpeechState == SpeechStates.listening) {
      incrementSession(pRef);

      pRef.read(currentRecorderControllerManager.notifier).pause(pRef);
      pRef.read(currentSpeechToTextManager.notifier).stopListening(pRef);
      pRef
          .read(currentMeetingManagerState.notifier)
          .changState(CurrentMeetStates.stop);
      //We have a meeting but stop case
    } else if ((currentRecordState == RecordStates.pause ||
            currentRecordState == RecordStates.stopped) &&
        currentSpeechState == SpeechStates.stopping) {
      pRef.read(currentRecorderControllerManager.notifier).resume(pRef);
      pRef.read(currentSpeechToTextManager.notifier).startListening(pRef);
      pRef
          .read(currentMeetingManagerState.notifier)
          .changState(CurrentMeetStates.contiune);
    } else {
      //Shit!
      RecordExceptions.handleRecordException(
          "Unsupported case i guess we have a big logic mistake!", pRef);
    }
  }

  Future<void> initializeAudioToDo(WidgetRef pref) async {
    pref.read(currentMeetControllerManager.notifier).initialize(pref);
    final ftr = <Future>[
      pref
          .read(currentRecorderControllerManager.notifier)
          .initializeRecorderController(pref),
      pref.read(currentSpeechToTextManager.notifier).initSpeechToText(pref)
    ];
    await Future.wait(ftr);
  }

  Future<void> pauseSpeechAndRecord(WidgetRef pRef) async {
    final currentRecordState = pRef.read(currentRecordStateManager);
    final currentSpeechState = pRef.read(currentSpeechStateManager);
    if (currentRecordState == RecordStates.recording &&
        currentSpeechState == SpeechStates.listening) {
      incrementSession(pRef);

      pRef.read(currentRecorderControllerManager.notifier).pause(pRef);
      pRef.read(currentSpeechToTextManager.notifier).stopListening(pRef);
      pRef
          .read(currentMeetingManagerState.notifier)
          .changState(CurrentMeetStates.stop);
      //We have a meeting but stop case
    }
  }

  ///Speech to text and record controller must be initialized before this method
  Future<void> startMeeting(WidgetRef ref) async {
    final tempTitle = DateTime.now().toString().substring(0, 16);
    ref
        .read(currentAudioStepManager.notifier)
        .changeState(AudioToDoSteps.record);
    state = state!.copyWith(meetTitle: tempTitle, meetContent: "");
    List<Future> list = [
      ref.read(currentSpeechToTextManager.notifier).startListening(ref),
      ref.read(currentRecorderControllerManager.notifier).startRecord(ref)
    ];

    await Future.wait(list);
  }

  Future<void> reviewCurrentMeetingState(WidgetRef ref) async {
    try {
      final currentMeetSoundFile = ref
          .read(currentRecorderControllerManager.notifier)
          .getPathOfFileByMeetId(ref, state!.meetId!);

      File file = File(currentMeetSoundFile);

      final isSaved =
          await _storageRepository.saveFileToLocal(file, state!.meetId!, ref);

      //logger.i("Saved: $isSaved");

      ref.read(currentMeetControllerManager.notifier).stopMeeting(ref);

      final isInitialized = await ref
          .read(currentPlayerManagerState.notifier)
          .initializePlayerController(ref);

      if (isInitialized) {
        ref
            .read(currentAudioStepManager.notifier)
            .changeState(AudioToDoSteps.reviewMeet);

        if (!isSaved) {
          RecordExceptions.handleRecordException("Save Local Fail!", ref);
        }
      } else {
        RecordExceptions.handleRecordException("Initialize Player Error", ref);
      }
    } catch (e) {
      RecordExceptions.handleRecordException(e.toString(), ref);
    }
  }

  Future<void> stopMeeting(WidgetRef ref) async {
    final futureList = <Future>[];
    futureList
        .add(ref.read(currentSpeechToTextManager.notifier).stopListening(ref));
    futureList
        .add(ref.read(currentRecorderControllerManager.notifier).stop(ref));

    await Future.wait(futureList);
  }

  Future<void> createTodoListFromGpt(WidgetRef ref,
      {bool isOnce = true}) async {
    try {



      final currentUser = ref.read(authManager);



      if (!isOnce && (currentUser?.totalRecreateCount ?? 0) <= 0) {
        RecordDialogs.noHaveRecreate();
        return;
      }

      ref
          .read(currentAudioStepManager.notifier)
          .changeState(AudioToDoSteps.waitingResponse);

      //----Uploading To Cloud----//
      //I want to save file to local before send to gpt

      final file =
          await _storageRepository.getFileFromLocal(state!.meetId!, ref);
      final dateTimeStartMs = DateTime.now().millisecondsSinceEpoch;
      //I want to save file to firebase storage
      final soundLinkCreate =
          await _storageRepository.getFileLink(file, file!.path, ref);
      final dateTimeEndMs = DateTime.now().millisecondsSinceEpoch;

      state = state!.copyWith(soundFileLink: soundLinkCreate);
      //----Uploading To Cloud End----//

      final responseTodoByRepo = await _gptRepository!.getResponseTodoModel(
          ref.read(currentMeetControllerManager)!.meetContent!,
          ref,
          soundLinkCreate ?? "");

      if (responseTodoByRepo != null) {
        //Pure text set!
        state = state!.copyWith(
            meetContent: responseTodoByRepo.meetPureText,
            meetSubtitle: responseTodoByRepo.meetContentSummarize ?? "-");



        for (var perTodo in responseTodoByRepo.todos!) {
          if (perTodo.todoTitle == null &&
              (perTodo.todoTitle!.isEmpty || perTodo.todoContent!.isEmpty)) {
            responseTodoByRepo.todos!.remove(perTodo);
          }
        }
      }

      final date = ref
          .read(currentRecorderControllerManager.notifier)
          .currentDurationLocal();

      final meet = ref.read(currentMeetControllerManager);

      state = state!.copyWith(
          responseTodo: responseTodoByRepo,
          recordTimeSecond: date?.inSeconds,
          recordTimeMs: date?.inMilliseconds,
          soundFileType: SoundFileTypes.aac.name,
          lang: ref.read(currentLanguageManager)!.name,
          createdAt: DateTime.now().queryDayAndHHmm,
          contentWordCount: meet!.meetContent?.split(" ").length,
          contentLetterCount: meet.meetContent?.length ?? 0,
          meetLocaleFilePath: ref
              .read(currentRecorderControllerManager.notifier)
              .getPathOfFileByMeetId(ref, meet.meetId!),
          meetTitle: responseTodoByRepo?.meetSuggestedTitle,
          meetSubtitle: responseTodoByRepo?.meetContentSummarize,
          meetContent: responseTodoByRepo?.meetPureText);

      //Temp To-do List Setting by this method
      ref.read(tempTodoListState.notifier).initialize(ref);

      final updateToFirebaseStatus = await _dbMeetRepository
          .saveMeetToCloud(state!, ref, isRecreateAgain: isOnce == false);

      //Result of update to firebase
      if (updateToFirebaseStatus) {
        // if [updateToFirebaseStatus] true you did decrease totalRecordMinutes
        // on server so you must update user [totalRecordMinutes] current
        // session on app
        final currentAuth = ref.read(authManager);

        ref.read(authManager.notifier).changeUser(currentAuth!.copyWith(
              totalRecordSeconds: isOnce
                  ? currentAuth.totalRecordSeconds! - state!.recordTimeSecond!
                  : currentAuth.totalRecordSeconds!,
            ));

        //If is this recreated we have to update recreate count
        if (!isOnce) {
          await decreaseRecreateCountFromFirebase(ref);
        }
      }



    } finally {



      /**/
      if (state?.responseTodo != null) {
        ref
            .read(currentAudioStepManager.notifier)
            .changeState(AudioToDoSteps.responseTodoList);
      } else {
        ref
            .read(currentAudioStepManager.notifier)
            .changeState(AudioToDoSteps.reviewMeet);
      }
    }
  }

  Future<void> decreaseRecreateCountFromFirebase(WidgetRef ref) async {
    final res = await _dbMeetRepository.updateCurrentRecreateCount(ref);

    logger.i("Decrease Recreate Count");
    if (res) {
      final currentUser = ref.read(authManager);
      final currentRecreateCount = currentUser!.totalRecreateCount! - 1;
      ref.read(authManager.notifier).changeUser(
          currentUser.copyWith(totalRecreateCount: currentRecreateCount));
    }
  }

  Future<void> destroyMeetingAndRefresh(WidgetRef ref) async {
    if (state != null) {
      //TODO YOU MUST CHANGE

      return await stopMeeting(ref).then((value) async {
        //record last meet to this state
        lastMeet = state;
        state = null;

        //Session control has changing default values...
        currentIndex = 0;
        cursorRichTextParts.clear();
        speechTextSessions.clear();
        newBuffer.clear();
      });
    } else {
      ref
          .read(currentAudioStepManager.notifier)
          .changeState(AudioToDoSteps.idle);
    }
  }

  Future<void> giveRateToMeet(WidgetRef ref, double rate) async {
    final res =
        await _dbMeetRepository.giveRateToMeet(state!.meetId!, rate, ref);

    if (res) {
      state = state!.copyWith(likeRate: rate);
      logger.i("Rate given to meet");
    } else {
      logger.i("Rate given to meet failed");
    }
  }

  void deleteAllFiles(WidgetRef ref) {
    _storageRepository.deleteAllFiles(ref);
  }
}
