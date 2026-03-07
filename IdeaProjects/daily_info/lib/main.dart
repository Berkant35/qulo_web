import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';
import 'services/analytics_service.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize storage service
  await StorageService.init();

  // Initialize notification service
  await NotificationService.init();

  // Log app open
  await AnalyticsService.logAppOpen();

  runApp(const DailyInfoApp());
}

class DailyInfoApp extends StatelessWidget {
  const DailyInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      navigatorObservers: [AnalyticsService.observer],
      home: const HomeScreen(),
    );
  }
}
