import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qulo_v2/firebase_options.dart';
import 'package:qulo_v2/core/config/supabase_config.dart';
import 'package:qulo_v2/core/error/error_manager.dart';
import 'package:qulo_v2/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ErrorManager.init();
  await initSupabase();

  runApp(const ProviderScope(child: QuloApp()));
}
