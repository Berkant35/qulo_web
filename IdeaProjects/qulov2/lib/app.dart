import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/app_localizations.dart';
import 'package:qulo_v2/core/theme/app_theme.dart';
import 'package:qulo_v2/core/widgets/in_app_banner.dart';
import 'package:qulo_v2/providers/locale_provider.dart';
import 'package:qulo_v2/providers/notification_provider.dart';
import 'package:qulo_v2/providers/theme_provider.dart';
import 'package:qulo_v2/routing/app_router.dart';

class QuloApp extends ConsumerStatefulWidget {
  const QuloApp({super.key});

  @override
  ConsumerState<QuloApp> createState() => _QuloAppState();
}

class _QuloAppState extends ConsumerState<QuloApp> {
  bool _callbacksSet = false;

  void _setupNotificationCallbacks() {
    if (_callbacksSet) return;
    _callbacksSet = true;

    ref.read(notificationProvider.notifier).setUICallbacks(
      onForegroundNotification: (message) {
        final title = message.notification?.title ?? 'Qulo';
        final body = message.notification?.body ?? '';
        final actionUrl = message.data['action_url'] as String?;

        final context = rootNavigatorKey.currentContext;
        if (context == null) return;

        final overlay = Overlay.of(context);
        late OverlayEntry entry;
        entry = OverlayEntry(
          builder: (_) => Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: InAppBanner(
                title: title,
                body: body,
                onTap: () {
                  entry.remove();
                  if (actionUrl != null && actionUrl.isNotEmpty) {
                    ref.read(routerProvider).go(actionUrl);
                  }
                },
                onDismiss: () => entry.remove(),
              ),
            ),
          ),
        );
        overlay.insert(entry);
      },
      onNavigate: (actionUrl) {
        ref.read(routerProvider).go(actionUrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    final appThemeMode = ref.watch(themeProvider);
    final themeMode = switch (appThemeMode) {
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
      AppThemeMode.system => ThemeMode.system,
    };

    // Set up notification callbacks after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupNotificationCallbacks();
    });

    return MaterialApp.router(
      title: 'Qulo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [Locale('tr'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
