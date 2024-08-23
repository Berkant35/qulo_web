import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/ota/need_ota_pads.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'models/enums/traces/play_traces_enum.dart';
import 'models/lang_model.dart';
import 'prov/admins_prov.dart';
import 'prov/auth/current_user_prov.dart';
import 'prov/class_provider.dart';
import 'utils/cp_theme.dart';
import 'utils/l10n/json_l10n.dart';
import 'utils/route_table.dart';
import 'utils/utils.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  Future<bool> initialization() async {

    WidgetsFlutterBinding.ensureInitialized();

    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print

    /* final _auth = FirebaseAuth.instance;
    final curUser = _auth.currentUser;
    if (curUser != null) {
      await ref.read(currentUserAssetsProv.notifier).loadAssets(ref);
      ref
          .read(selectedClassProvider.notifier)
          .loadClass(ref); // needs to be loaded after loadclasses function
    }
    await ref.read(appSettingsToggleProvider.notifier).loadValues();

    await ref.read(userPermissionProvider.notifier).setAdminEmails();

    await ref.read(userPermissionProvider.notifier).addingFireStoreFix(ref); */

    final futureList = <Future>[
      ref.read(currentPadOtaConfigManager.notifier).getCurrentPadVersions(),
      ref.read(currentNeedOtaManager.notifier).initialize(ref),
      ref.read(currentVersionManager.notifier).checkAndGoToStoreOrApp(ref),
    ];

    Future.wait(futureList);

    print('go!');
    FlutterNativeSplash.remove();

    return true;
  }

  late final Future<bool> x;

  @override
  void initState() {

    initialization();

    //x = initialization();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App State: $state');

  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      RouteTable.refreshListenableProvider,
      (_, __) => ref.read(RouteTable.routerProvider).refresh(),
    );
    // ref.read(exerciseProvider.notifier).loadMoves(ref);

    // ref.read(quizProvider.notifier).loadQuizes(ref);

    // ref.read(classProvider.notifier).loadClasses(ref);

    final _auth = FirebaseAuth.instance;
    final curUser = _auth.currentUser;

    if (curUser != null) {
      ref.read(currentUserAssetsProv.notifier).loadAssets(ref);
      ref
          .read(selectedClassProvider.notifier)
          .loadClass(ref); // needs to be loaded after loadclasses function
    }

    ref.read(appSettingsToggleProvider.notifier).loadValues();

    ref.read(userPermissionProvider.notifier).setAdminEmails();

    ref.read(userPermissionProvider.notifier).addingFireStoreFix(ref);

    final router = ref.watch(RouteTable.routerProvider);

    final currentLang = ref.watch(appLangProv);
    /* final Widget materialappwidget =  */
    return Listener(
      onPointerUp: (_) {
        ref.read(currentDevicesManagerProvider).keys.forEach((deviceId) {
          ref
              .read(currentAutoDisposeTimerManager.notifier)
              .restartTimer(deviceId, ref);
        });
        incrementClickCountForTrace(ref);
      },
      child: ResponsiveSizer(builder: (context, orientation, screenType) {

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: CpTheme.theme,
          routerConfig: router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            JsonAppLocalizationssDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          builder: EasyLoading.init(),
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLang?.locale,
          localeListResolutionCallback: (locales, supportedLocales) {
            Locale? ret;

            final mainSupportedLocale = supportedLocales
                .last; // TODO It was first back then take a better look afterwards
            // here we're recieving [locales], which are the user's device's
            // selected locales, for example, they may choose [tr], and below it
            // [en], we'll recieve them but not always in order.

            if (locales == null || locales.isEmpty) {
              ret = mainSupportedLocale;
            } else {
              try {
                if (locales.any((lcl) => supportedLocales.contains(lcl))) {
                  final locale = locales.firstWhere(
                    (l) => supportedLocales.contains(l),
                  );

                  ret = locale;
                }
              } on StateError {
                ret = mainSupportedLocale;
              } catch (e) {
                assert(false);
                logger.e(e);

                ret = mainSupportedLocale;
              }
            }

            // we've left the language property of app settings
            // nullable and null by default, so first opening
            // of the app we'd get the device's language, and
            // set it to our preferences, and use that in the
            // next launch, no matter the device's language.
            // we may change this flow later to use the device's
            // language, but for now we'll use the user's selected
            // language.

            if (currentLang == null) {
              SchedulerBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  if (ret != null) {
                    ref.read(appLangProv.notifier).setLanguage(
                          LanguageModel.fromLocale(ret),
                        );
                  }
                },
              );
            }

            return ret;
          },
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            for (Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode ||
                  (supportedLocale.countryCode != null &&
                      // this can be true if both are null :))
                      supportedLocale.countryCode == locale.countryCode)) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      }),
    );
    //return materialappwidget;
    /*
    return FutureBuilder(
      future: x,
      builder: (context, snapshot) {
        /*
        if (snapshot.connectionState == ConnectionState.waiting) {
          return materialappwidget;
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return materialappwidget;
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return materialappwidget;
        } */
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.connectionState == ConnectionState.done) {
          //return materialappwidget;
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CpTheme.theme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            JsonAppLocalizationssDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: EasyLoading.init(),
          home: const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLang?.locale,
          localeListResolutionCallback: (locales, supportedLocales) {
            Locale? ret;
            final mainSupportedLocale = supportedLocales.last;
            if (locales == null || locales.isEmpty) {
              ret = mainSupportedLocale;
            } else {
              try {
                if (locales.any((lcl) => supportedLocales.contains(lcl))) {
                  final locale = locales.firstWhere(
                    (l) => supportedLocales.contains(l),
                  );
                  ret = locale;
                }
              } on StateError {
                ret = mainSupportedLocale;
              } catch (e) {
                assert(false);
                logger.e(e);
                ret = mainSupportedLocale;
              }
            }
            if (currentLang == null) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                ref
                    .read(appLangProv.notifier)
                    .setLanguage(LanguageModel.fromLocale(ret!));
              });
            }
            return ret;
          },
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            for (Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode ||
                  (supportedLocale.countryCode != null &&
                      supportedLocale.countryCode == locale.countryCode)) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    );*/
  }
}

void incrementClickCountForTrace(WidgetRef ref) {
  switch (ref.read(currentPlayTraceStateManager)) {
    case PlayTraceStates.idle:
      return;

    case PlayTraceStates.pre:
      ref.read(currentPreTraceManager.notifier).incrementClickCount();
      return;
    case PlayTraceStates.game:
      ref.read(currentGameTraceManager.notifier).incrementClickCount();
      break;
    case PlayTraceStates.result:
      ref.read(currentResultTraceManager.notifier).incrementClickCount();
      break;
  }
}
