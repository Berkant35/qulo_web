import 'dart:io';
import 'dart:ui';
import 'package:audiotodo/line/db/api/heroku_server/heroku_server_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/core/theme/theme.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/ui/landing/landing_page.dart';
import 'package:audiotodo/utilities/constants/app/application_constants.dart';
import 'package:audiotodo/utilities/constants/app/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialog_shower/flutter_dialog_shower.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/navigation/navigation_route.dart';
import 'core/navigation/navigation_service.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'line/db/api/gpt/gpt_manager.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

bool isFatalError(FlutterErrorDetails errorDetails) {
  // Hata mesajında belirli anahtar kelimeleri kontrol et
  const fatalErrorKeywords = [
    'OutOfMemoryError',
    'StackOverflowError',
    'fatal',
    'NSInternalInconsistencyException',
    'NSRangeException',
    'NSInvalidArgumentException',
    'NSGenericException',
    'SIGABRT', // Signal Abort
    'SIGSEGV', // Segmentation Fault
    'SIGBUS', // Bus Error
    'SIGILL', // Illegal Instruction
    'SIGFPE', // Floating Point Exception
    'EXC_BAD_ACCESS', // Bad Memory Access
    'EXC_BAD_INSTRUCTION', // Illegal Instruction
    'EXC_ARITHMETIC', // Arithmetic Exception
    'EXC_CRASH', // Crash Exception
    'mach_exception' // Mach Exception (low-level system exceptions)
    // Diğer iOS spesifik ölümcül hata türlerini ekleyin
  ];


  for (var keyword in fatalErrorKeywords) {
    if (errorDetails.exceptionAsString().contains(keyword)) {
      return true;
    }
  }
  return false;
}
Future<void> main() async {

  DartPluginRegistrant.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await dotenv.load(fileName: ".env");
  final revConfiguration =
      PurchasesConfiguration(dotenv.env['REVENUECAT_API_KEY']!);

  await Purchases.configure(revConfiguration);

  await GPTManager.instance?.init(
      dotenv.env['AUDIOTODO_SERVER_BASE_URL']!, RequestConfigs.customHeaders);

  await HerokuServerManager.instance?.init(
  dotenv.env['AUDIOTODO_SERVER_BASE_URL']!, RequestConfigs.customHeaders);


  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  try{
    Hive.init(appDocDirectory.absolute.path);

  }catch(e){
    logger.e("hİVE ERROR: $e");
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: AudioToDo()));

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: CustomColors.primaryColor, // Durum çubuğunu şeffaf yap

  ));
  bool fatalError = true;

  FlutterError.onError = (errorDetails) {
    fatalError = isFatalError(errorDetails);
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
     fatalError = error.toString().contains('fatal');

    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

}

class AudioToDo extends ConsumerStatefulWidget {
  const AudioToDo({
    super.key,
  });

  @override
  ConsumerState createState() => _AudioToDoState();
}

class _AudioToDoState extends ConsumerState<AudioToDo> {
  @override
  void initState() {
    super.initState();
    ref
        .read(currentLanguageManager.notifier)
        .getChoosedApplicationLanguage(ref)
        .then((value) => ref
            .read(currentLanguageManager.notifier)
            .initializeCurrentRecognitionLanguage(ref)
            .then((value) => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveSizer(builder: (context, orientation, screenType) {

      DialogShower.init(context);
      return MaterialApp(
        title: ApplicationConstants.appTitle,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: CustomTheme.themeData,
        onGenerateRoute:NavigationRoute.instance.generateRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const LandingPage(),
      );
    });
  }
}


