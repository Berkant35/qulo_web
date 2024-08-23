import 'dart:ui';

import 'package:catchpad/data/api/telegram/telegram_manager.dart';
import 'package:catchpad/prov/auth/auth_prov.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restart_app/restart_app.dart';

import 'data/api/user_api.dart';
import 'models/lang_model.dart';
import 'utils/cp_theme.dart';
import 'utils/l10n/json_l10n.dart';
import 'utils/route_table.dart';
import 'utils/utils.dart';

class EmbApp extends ConsumerStatefulWidget {
  const EmbApp({super.key});

  @override
  ConsumerState<EmbApp> createState() => _EmbAppState();
}

class _EmbAppState extends ConsumerState<EmbApp> with WidgetsBindingObserver {
  Future<bool> initialization() async {

    DartPluginRegistrant.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();

    await TelegramManager.instance?.init(
        dotenv.env['TELEGRAM_SERVER_BASE_URL']!, {
      'headers': {
        'content-type': 'application/json'
      },
    });

    FlutterNativeSplash.remove();
    const email  = "software.catchpad@gmail.com";

    UserCredential credential = await ref.read(authProvider.notifier).login(
      email,
      "Cp2023*!",
    );

    final user = await UsersApi.instance
        .getUserFromEmailAddress(email);
    ref
        .read(currentUserProv.notifier)
        .update(user);

    logger.i("Credential: ${credential.user?.displayName}");
    return true;
  }

  late final Future<bool> x;

  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(AppLifecycleState.paused == state){
      Restart.restartApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      RouteTable.refreshListenableProvider,
      (_, __) => ref.read(RouteTable.routerEmbProvider).refresh(),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    final router = ref.watch(RouteTable.routerEmbProvider);

    final currentLang = ref.watch(appLangProv);

    return Listener(
      onPointerUp: (pointer) {
        ref
            .read(currentIgaIsThereAnyCustomerManager.notifier)
            .changState(true, ref);
      },
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: CpTheme.themeV2,
          routerConfig: router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            CountryLocalizations.delegate,
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
  }
}
