import 'dart:developer';
import 'dart:ui';

import 'package:catchpad/generated/l10n.dart';
import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/lang_model.dart';
import 'package:catchpad/prov/app_settings_prov.dart';
import 'package:catchpad/sandbox.dart';
import 'package:catchpad/ui/emb/iga/iga_base_view.dart';
import 'package:catchpad/ui/emb/iga/iga_game_start_counter.dart';
import 'package:catchpad/ui/emb/iga/iga_parameters.dart';
import 'package:catchpad/ui/emb/iga/iga_res/iga_leaderboard.dart';
import 'package:catchpad/ui/emb/iga/iga_sandbox.dart';
import 'package:catchpad/ui/home_screen.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/locales.dart';
import 'package:catchpad/utils/widgets/custom_rate_widget.dart';
import 'package:catchpad/v2/screens/authentication/login/login_screen.dart';
import 'package:catchpad/v2/screens/explore/explore_screen.dart';
import 'package:catchpad/v2/screens/filter/filter_screen.dart';
import 'package:catchpad/v2/screens/filter/filter_show_all_screen.dart';
import 'package:catchpad/v2/screens/home/home_screen.dart';
import 'package:catchpad/v2/screens/onboarding/onboarding_screen.dart';
import 'package:catchpad/v2/screens/authentication/register/register_screen.dart';
import 'package:catchpad/v2/screens/self_identify/self_identify_screen.dart';
import 'package:catchpad/v2/screens/tests/tests_screen.dart';
import 'package:catchpad/v2/utils/constants/scheme/app_theme.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as lg;
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'firebase_options.dart';
import 'my_app.dart';
import 'utils/route_table.dart';
import 'utils/settings/app_settings.dart';
import 'utils/utils.dart';
import 'v2/screens/game/game_setup/game_setup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));

  // runApp(DevicePreview(
  //     enabled: true,
  //     builder: (context) {
  //       return const MyApp();
  //     }));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const HomeScreenV2(),
          '/explore': (context) => const ExploreScreen()
        },
        theme: AppTheme.lightTheme,
        home: const IgaParameters(),
      );
    });
  }
}
