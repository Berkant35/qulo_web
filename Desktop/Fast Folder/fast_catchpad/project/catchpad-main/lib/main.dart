import 'dart:async';
import 'dart:io';
import 'package:autostarter/autostarter.dart';
import 'package:catchpad/emb_app.dart';
import 'package:catchpad/models/permission/permission_manager.dart';
import 'package:catchpad/my_app.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/emb/iga/flags_prov.dart';
import 'package:catchpad/prov/emb/iga/iga_background_ble.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as lg;
import 'package:logger/logger.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'firebase_options.dart';
import 'utils/route_table.dart';
import 'utils/settings/app_settings.dart';
import 'utils/utils.dart';

late AppSettings mainScreenInitSettings;

Future<void> initCpFlutterLib() async {
  final logger = lg.Logger(
    printer: PrettyPrinter(),
    //output: LogConsole.wrap(innerOutput: ConsoleOutput()),
    filter: DevelopmentFilter(),
  );

  lg.Logger.level = Level.debug;
  CatchPadFlutterLibInit.init(
    logger: logger,
    debugMode: false,
  );
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await FlutterDownloader.initialize(
      debug: true,
      // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true //
      );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = FirebaseAuth.instance;
  final curUser = auth.currentUser;

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    if (curUser != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(curUser.uid);
    }
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (curUser != null) {
    initialLocation = RouteTable.rHomeScreen;
  } else {
    initialLocation = RouteTable.rWelcomeScreen;
  }
  mainScreenInitSettings = await AppSettings.init();

  if (AppSettingsToggles.fbEmulator) {
    // firebase emulators:start
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  initCpFlutterLib();
  //SystemInfoControlNotifier.initalizeAndSet();

  runApp(const ProviderScope(child: AppWrapper()));
}

class AppWrapper extends ConsumerStatefulWidget {
  const AppWrapper({super.key});

  @override
  ConsumerState<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends ConsumerState<AppWrapper> {
  //We must wait to initialize.Because this phone may IGA tablet.
  //if is IGA tablet go to EmbApp

  ValueNotifier<bool> phoneInformationIsInitialized = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => initializeDeviceInformation());
  }

  @override
  Widget build(BuildContext context) {
    // Main
    Future(() {
      ref.read(currentNewVersionState.notifier).changeState(false);
      ref.read(currentEmbModeManager.notifier).changState(0);
    });

    // Emb
    // final isIgaTablet =
    //     ref.watch(currentDeviceInformationManager.notifier).isIgaTablet();
    //
    //
    // Future(() {
    //   // EVENT IGA
    //   ref.read(eventIgaController.notifier).changState(false);
    //   ref.read(currentEmbModeManager.notifier).changState(0);
    //   ref.watch(currentNewVersionState.notifier).changeState(true);
    //   ref.watch(currentDeviceInformationManager);
    // });

    return Consumer(
      builder: (context, provider, child) {
        return ValueListenableBuilder(
            valueListenable: phoneInformationIsInitialized,
            builder: (BuildContext context, bool initialized, Widget? child) {
              // --Emb--
              // if (isIgaTablet) {
              //
              //   ref.read(igaBackGroundManager.notifier).selectIgaTablets(
              //       ref.read(currentDeviceInformationManager)?.deviceId ??
              //           "default");
              //
              //   buildThen();
              //
              //   Future(() {
              //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              //         overlays: []);
              //
              //     ref.read(currentEmbModeManager.notifier).changState(1);
              //     ref
              //         .read(currentIgaResultManager.notifier)
              //         .igaSetCurrentLocation(ref);
              //   });
              // }
              //
              // Future(() {
              //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              //       overlays: []);
              //
              //   ref.read(currentEmbModeManager.notifier).changState(1);
              //   ref
              //       .read(currentIgaResultManager.notifier)
              //       .igaSetCurrentLocation(ref);
              // });
              // --Emb--

              return !initialized
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : true
                      ? const MyApp()
                      : const MyApp();
            });
      },
    );
  }

  Future<void> buildThen() async {
    WakelockPlus.enable();
    if (Platform.isAndroid) {
      Autostarter.isAutoStartPermissionAvailable().then((value) async {
        try {
          await Autostarter.getAutoStartPermission(open: true);
        } catch (e) {
          return;
        }
      });
    }
  }

  Future<void> initializeDeviceInformation() async {
    final isGrantedReadPhone = await Permission.phone.isGranted;

    if (!isGrantedReadPhone) await Permission.phone.request();

    await ref.read(currentDeviceInformationManager.notifier).initialize(ref);

    if (ref.read(currentEmbModeManager) == 1) {
      ref
          .read(currentIgaLeaderboardManager.notifier)
          .initalizePeriodicReportLoop(ref);
      ref
          .read(currentIgaLeaderboardManager.notifier)
          .initalizePeriodicallyOkeyLoop(ref);
      ref
          .read(currentIgaLeaderboardManager.notifier)
          .initalizePeriodicallyRestartApp(ref);
    }

    phoneInformationIsInitialized.value = true;
    phoneInformationIsInitialized.notifyListeners();
  }
}
