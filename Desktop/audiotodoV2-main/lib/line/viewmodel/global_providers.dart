import 'package:audiotodo/line/viewmodel/admin/admin_prov.dart';
import 'package:audiotodo/line/viewmodel/heroku/heroku_manager.dart';

import 'admob/admob_manager.dart';
import 'global_export.dart';
import 'preferences/prefrences_manager.dart';

typedef LoadingStateKeyStatusMap = Map<String, LoadingState>;


//You can handle all authentication bussiniess logics
final authManager =
    StateNotifierProvider<AuthManagerProvider, UserModel?>((ref) {
  return AuthManagerProvider(null);
});

final currentLoadingStateManager =
    StateNotifierProvider<AllLoadingManagers, LoadingStateKeyStatusMap>((ref) {
  return AllLoadingManagers({});
});
final aLoadingStateManager =
    StateNotifierProvider<ALoadingManager, LoadingState>((ref) {
  return ALoadingManager(LoadingState.idle);
});

final currentNavigationIndex =
    StateNotifierProvider<CurrentNavigationIndex, int>((ref) {
  return CurrentNavigationIndex(0);
});

final currentLanguageManager =
    StateNotifierProvider<CurrentLanguageManagerNotifier, LocaleName?>((ref) {
  return CurrentLanguageManagerNotifier(null);
});

final currentRecordStateManager =
    StateNotifierProvider<RecordStateManagerNotifier, RecordStates>((ref) {
  return RecordStateManagerNotifier(RecordStates.idle);
});

final currentRecorderControllerManager =
    StateNotifierProvider<RecorderControllerNotifier, RecorderController?>(
        (ref) {
  return RecorderControllerNotifier(null);
});

final currentSpeechToTextManager =
    StateNotifierProvider<SpeechToTextNotifier, SpeechToText?>((ref) {
  return SpeechToTextNotifier(null);
});

final currentSpeechStateManager =
    StateNotifierProvider<SpeechStateNotifier, SpeechStates>((ref) {
  return SpeechStateNotifier(SpeechStates.idle);
});

final currentPermissionControllerManager = StateNotifierProvider.autoDispose<
    PermissionHandlerNotifier, CustomPermissionHandler>((ref) {
  return PermissionHandlerNotifier({});
});

final currentMeetControllerManager =
    StateNotifierProvider<CurrentMeetManagerNotifier, Meet?>((ref) {
  return CurrentMeetManagerNotifier(null);
});

final currentWordMatchTimeMapManager = StateNotifierProvider<
    CurrentWordMatchTimeMapNotifier, CurrentWordMatchTimeMap>((ref) {
  return CurrentWordMatchTimeMapNotifier({});
});

final currentUUIDManager =
    StateNotifierProvider<UUIDManagerNotifier, Uuid?>((ref) {
  return UUIDManagerNotifier(null);
});

final currentAudioStepManager =
    StateNotifierProvider<CurrentAudioStepManagerNotifier, AudioToDoSteps>(
        (ref) => CurrentAudioStepManagerNotifier(AudioToDoSteps.idle));

final currentMeetingManagerState =
    StateNotifierProvider<CurrentMeetManagerControlNotifier, CurrentMeetStates>(
        (ref) => CurrentMeetManagerControlNotifier(CurrentMeetStates.idle));

final currentPlayerManagerState =
    StateNotifierProvider<PlayerControlManagerNotifier, PlayerController?>(
        (ref) {
  return PlayerControlManagerNotifier(null);
});

final currentResultViewControlState =
    StateNotifierProvider<ResultViewStateControlNotifier, ResultViewStates>(
        (ref) => ResultViewStateControlNotifier(ResultViewStates.summary));

final currentPeriodicPromptManagerState =
    StateNotifierProvider<PeriodicPromptManagerNotifier, StringBuffer?>((ref) {
  return PeriodicPromptManagerNotifier(null);
});

final currentPlayerControlState =
    StateNotifierProvider<PlayerStateControlNotifier, CustomPlayerStates>(
        (ref) => PlayerStateControlNotifier(CustomPlayerStates.idle));

final currentWaveAnimationControlState =
    StateNotifierProvider<WaveAnimationControlNotifier, bool>(
        (ref) => WaveAnimationControlNotifier(false));

final currentAdminControlState = StateNotifierProvider<AdminControlNotifier, bool>(
    (ref) => AdminControlNotifier(false));

final currentPerTodoEditControlState =
    StateNotifierProvider<EditTodoManager, ResponsePerTodoModel?>((ref) {
  return EditTodoManager(null);
});

final currentSelectsClickUpState =
    StateNotifierProvider<CurrentSelectTaskManagerNotifier, ClickUpSelect>(
        (ref) {
  return CurrentSelectTaskManagerNotifier({});
});

final tempTodoListState =
    StateNotifierProvider<TempConfirmTodoNotifier, TempConfirmTodoList>((ref) {
  return TempConfirmTodoNotifier([]);
});

final officeFileManagerState =
    StateNotifierProvider<PdfOfficeManager, OfficeFileAttributeMap>((ref) {
  return PdfOfficeManager(OfficeFilesAttributeMap.defaultPdfAttribute);
});

final currentIntegrationHelpState =
    StateNotifierProvider<HelpIntegrationControlNotifier, TodoPlatforms>(
        (
            ref)
        => HelpIntegrationControlNotifier(TodoPlatforms.none));

final currentJiraSoftwareProjectState = StateNotifierProvider<
    JiraSoftwareSelectTaskManagerNotifier, JiraSoftwareProject?>(
        (
        ref) {
  return JiraSoftwareSelectTaskManagerNotifier(null);
});

final currentSelectMeetState =
    StateNotifierProvider<CurrentSelectMeetControlNotifier, Meet?>((ref) {
  return CurrentSelectMeetControlNotifier(null, null);
});

final currentMicrosoftFileState =
    StateNotifierProvider<CurrentMcFileControlNotifier, MicrosoftFiles>((ref) {
  return CurrentMcFileControlNotifier(MicrosoftFiles.unknown);
});

final currentPhotoManagerState =
    StateNotifierProvider<PhotoManagerNotifier, XFile?>((ref) {
  return PhotoManagerNotifier(null);
});


final currentTextToSpeechControlNotifier =
    StateNotifierProvider<TextToSpeechControlNotifier, ContentTextToSpeechMap>((ref) {
  return TextToSpeechControlNotifier({});
});

final currentPlanControlNotifier =
    StateNotifierProvider<CurrentPlanControlNotifier, PlanType>((ref) {
  return CurrentPlanControlNotifier(PlanType.none);
});


final currentVerisonManagerNotifier =
    StateNotifierProvider<VersionManagerNotifier, String?>((ref) {
  return VersionManagerNotifier( null);
});


final currentPreferencesControlNotifier =
    StateNotifierProvider<PreferencesControlNotifier, CheckedMapPreferences>((ref) {
  return PreferencesControlNotifier({});
});

final currentHerokuManager = StateNotifierProvider<HerokuManagerControlNotifier, bool>((ref) {
  return HerokuManagerControlNotifier(false);
});
final currentAdmobManager = StateNotifierProvider<AdmobManager, bool>((ref) {
  return AdmobManager();
});
