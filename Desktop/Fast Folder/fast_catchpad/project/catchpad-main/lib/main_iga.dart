import 'dart:ui';

import 'package:catchpad/sandbox.dart';
import 'package:catchpad/ui/emb/iga/iga_base_view.dart';
import 'package:catchpad/ui/emb/iga/iga_game_start_counter.dart';
import 'package:catchpad/ui/emb/iga/iga_res/leaderboard/iga_leaderboard.dart';
import 'package:catchpad/ui/emb/iga/iga_sandbox.dart';
import 'package:catchpad/utils/locales.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
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

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        supportedLocales: SupportedLocales.supportedLocales,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        title: 'iga',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const ProviderScope(child: Sandbox()),
      );
    });
  }
}
