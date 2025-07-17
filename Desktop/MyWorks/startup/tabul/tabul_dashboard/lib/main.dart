import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/theme/theme.dart';
import 'core/routing/app_router.dart';
import 'core/constants/constants.dart';

/// Ana uygulama giriş noktası
/// Sadece light theme ile basit yapı
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TabulDashboardApp());
}

/// Ana uygulama widget'ı
/// Sadece light theme ile
class TabulDashboardApp extends StatelessWidget {
  const TabulDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // App configuration
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme configuration - only light theme
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,

      // Router configuration
      routerConfig: AppRouter.router,

      // Responsive configuration
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(
              start: 0,
              end: 600,
              name: MOBILE,
            ),
            const Breakpoint(
              start: 601,
              end: 1024,
              name: TABLET,
            ),
            const Breakpoint(
              start: 1025,
              end: double.infinity,
              name: DESKTOP,
            ),
          ],
        );
      },
    );
  }
}
