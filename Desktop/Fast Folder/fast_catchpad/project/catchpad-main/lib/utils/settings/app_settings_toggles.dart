import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appSettingsToggleProvider =
    StateNotifierProvider<ToggleProvider, AppSettingsToggles>((ref) =>
        ToggleProvider(AppSettingsToggles(
            enableWelcome: true,
            enableFbEmulator: false,
            enableDeviceAdminOptions: kDebugMode || false,
            enableDeviceLogListen: false,
            enableEnvironmentSelection: false,
            enableShowGameLog: false,
            enableAddingUser: false,
            enableLeaderboardViewer: false,
            enableToForce: true,
            enableAuth: false,
            enableTriggerSound: false,
            enableAddingToFirestore: true,
            isDebuggingByDeveloper: false)));

class ToggleProvider extends StateNotifier<AppSettingsToggles> {
  ToggleProvider(AppSettingsToggles state) : super(state);

  Future<void> loadValues() async {
    final prefs = await SharedPreferences.getInstance();

    bool enableAddingUser = prefs.getBool('enableAddingUser') ?? false;

    bool enableDeviceAdminOptions =
        prefs.getBool('enableDeviceAdminOptions') ?? (kDebugMode || false);

    bool? enableAddingToFirestore = prefs.getBool('enableAddingToFirestore');

    bool enableLeaderboardViewer =
        prefs.getBool('enableLeaderboardViewer') ?? false;

    bool enableEnvironmentSelection =
        prefs.getBool('enableEnvironmentSelection') ?? false;

    bool isDebuggingByDeveloper =
        prefs.getBool('isDebuggingByDeveloper') ?? false;

    bool isEnableTriggerSound  = prefs.getBool('enableTriggerSoundEffect') ?? false;

    bool isForceSleep = prefs.getBool('enableForceToSleep') ?? false;

    bool enableDeviceLogListen = prefs.getBool('enableDeviceLogListen') ?? false;

    state = state.copyWith(
        enableAddingUser: enableAddingUser,
        enableDeviceAdminOptions: enableDeviceAdminOptions,
        enableAddingToFirestore: enableAddingToFirestore,
        enableEnvironmentSelection: enableEnvironmentSelection,
        enableLeaderboardViewer: enableLeaderboardViewer,
        enableDeviceLogListen: enableDeviceLogListen,
        isDebuggingByDeveloper: isDebuggingByDeveloper,
        enableTriggerSound: isEnableTriggerSound,
        enableToForce: isForceSleep);
  }

  void setNonAdminUsersValues() {
    state = state.copyWith(
        enableAddingUser: false,
        enableAuth: false,
        enableFbEmulator: false,
        enableShowGameLog: false,
        enableWelcome: false,
        enableDeviceAdminOptions: (kDebugMode || false),
        enableDeviceLogListen: false,

        enableLeaderboardViewer: false,
        enableAddingToFirestore: (kDebugMode) ? false : true,
        // true
        enableEnvironmentSelection: (kDebugMode) ? true : false,
        // false
        isDebuggingByDeveloper: false);
  }

  enableDeviceLogListenViewer(){
    state = state.copyWith(enableDeviceLogListen: true);
  }


  enableLeaderboardViewer() {
    state = state.copyWith(enableLeaderboardViewer: true);
  }

  disableLeaderboardViewer() {
    state = state.copyWith(enableLeaderboardViewer: false);
  }

  setLeaderboardViewer(bool value) {
    state = state.copyWith(enableLeaderboardViewer: value);
  }

  enableDevDebug() {
    state = state.copyWith(isDebuggingByDeveloper: true);
  }

  disableDevDebug() {
    state = state.copyWith(isDebuggingByDeveloper: false);
  }

  setDevDebug(bool newvalue) {
    state = state.copyWith(isDebuggingByDeveloper: newvalue);
  }

  enableWelcome() {
    state = state.copyWith(enableWelcome: true);
  }

  disableWelcome() {
    state = state.copyWith(enableWelcome: false);
  }

  setWelcome(bool value) {
    state = state.copyWith(enableWelcome: value);
  }

  enableFireStoreAdding() {
    state = state.copyWith(enableAddingToFirestore: true);
  }

  disableFireStoreAdding() {
    state = state.copyWith(enableAddingToFirestore: false);
  }

  setFireStoreAdding(bool value) {
    state = state.copyWith(enableAddingToFirestore: value);
  }

  enableAddingUser() {
    state = state.copyWith(enableAddingUser: true);
  }

  disableAddingUser() {
    state = state.copyWith(enableAddingUser: false);
  }

  setAddingUser(bool value) {
    state = state.copyWith(enableAddingUser: value);
  }

  enableEnvironmentSelection() {
    state = state.copyWith(enableEnvironmentSelection: true);
  }

  disableEnvironmentSelection() {
    state = state.copyWith(enableEnvironmentSelection: false);
  }

  setEnvironmentSelection(bool value) {
    state = state.copyWith(enableEnvironmentSelection: value);
  }

  setEnableForceToSleep(bool value) {
    state = state.copyWith(enableToForce: value);
  }

  enableFbEmulator() {
    state = state.copyWith(enableFbEmulator: true);
  }

  disableFbEmulator() {
    state = state.copyWith(enableFbEmulator: false);
  }

  setFbEmulator(bool value) {
    state = state.copyWith(enableFbEmulator: value);
  }

  enableDeviceAdminOptions() {
    state = state.copyWith(enableDeviceAdminOptions: true);
  }

  disableDeviceAdminOptions() {
    state = state.copyWith(enableDeviceAdminOptions: false);
  }

  setDeviceAdminOptions(bool value) {
    state = state.copyWith(enableDeviceAdminOptions: value);
  }

  enableTriggerSound(bool value){
   state = state.copyWith(enableTriggerSound: value);
  }

  enableShowGameLog() {
    state = state.copyWith(enableShowGameLog: true);
  }

  disableShowGameLog() {
    state = state.copyWith(enableShowGameLog: false);
  }

  setShowGameLog(bool value) {
    state = state.copyWith(enableShowGameLog: value);
  }

  enableAuth() {
    state = state.copyWith(enableAuth: true);
  }

  disableAuth() {
    state = state.copyWith(enableAuth: false);
  }

  setAuth(bool value) {
    state = state.copyWith(enableAuth: value);
  }
}

class AppSettingsToggles {
  AppSettingsToggles(
      {required this.enableWelcome,
      required this.enableFbEmulator,
      required this.enableDeviceAdminOptions,
      required this.enableDeviceLogListen,
      required this.enableEnvironmentSelection,
      required this.enableShowGameLog,
      required this.enableAddingUser,
      required this.enableAuth,
      required this.enableToForce,
      required this.enableLeaderboardViewer,
      required this.enableTriggerSound,
      required this.enableAddingToFirestore,
      required this.isDebuggingByDeveloper});

  bool enableWelcome = isDebugging && true;
  bool enableFbEmulator = isDebugging && false;
  bool enableDeviceAdminOptions = isDebugging && true;
  bool enableDeviceLogListen = isDebugging && true;
  bool enableEnvironmentSelection = isDebugging && false;
  bool enableShowGameLog = isDebugging && false;
  bool enableAddingUser = isDebugging && false;
  bool enableTriggerSound = false;
  bool enableAuth = isDebugging && false;
  bool enableAddingToFirestore = isDebugging && true;
  bool enableToForce = true;
  bool enableLeaderboardViewer = isDebugging && false;

  static var isDebugging = true; //kDebugMode && true;
  static var isDebuggedByDev = false;

  static bool get fbEmulator => false;

  static bool get welcome => false;

  static bool get auth => false;

  /// this is not kDebugMode, this indicates wether
  /// a developer is using the app or not, because
  /// we already distribute the app in debug mode
  /// to the business team, so we cannot depend
  /// on kDebugMode.
  var isDebuggingByDeveloper = isDebugging && isDebuggedByDev;

  AppSettingsToggles copyWith(
          {bool? enableWelcome,
          bool? enableFbEmulator,
          bool? enableDeviceAdminOptions,
          bool? enableDeviceLogListen,
          bool? enableEnvironmentSelection,
          bool? enableShowGameLog,
          bool? enableAddingUser,
          bool? enableToForce,
          bool? enableAuth,
          bool? enableTriggerSound,
          bool? enableLeaderboardViewer,
          bool? enableAddingToFirestore,
          bool? isDebuggingByDeveloper}) =>
      AppSettingsToggles(
          enableWelcome: enableWelcome ?? this.enableWelcome,
          enableLeaderboardViewer:
              enableLeaderboardViewer ?? this.enableLeaderboardViewer,
          enableFbEmulator: enableFbEmulator ?? this.enableFbEmulator,
          enableDeviceAdminOptions:
              enableDeviceAdminOptions ?? this.enableDeviceAdminOptions,
          enableDeviceLogListen:enableDeviceLogListen ?? this.enableDeviceLogListen,
          enableToForce: enableToForce ?? this.enableToForce,
          enableEnvironmentSelection:
              enableEnvironmentSelection ?? this.enableEnvironmentSelection,
          enableShowGameLog: enableShowGameLog ?? this.enableShowGameLog,
          enableAddingUser: enableAddingUser ?? this.enableAddingUser,
          enableAuth: enableAuth ?? this.enableAuth,
          enableTriggerSound: enableTriggerSound ??  this.enableTriggerSound,
          enableAddingToFirestore:
              enableAddingToFirestore ?? this.enableAddingToFirestore,
          isDebuggingByDeveloper:
              isDebuggingByDeveloper ?? this.isDebuggingByDeveloper);
}
