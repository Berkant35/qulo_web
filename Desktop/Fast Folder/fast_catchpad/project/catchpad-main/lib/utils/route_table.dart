import 'dart:io';

import 'package:catchpad/data/api/user_api.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/sandbox.dart';
import 'package:catchpad/ui/auth/login_form_body.dart';
import 'package:catchpad/ui/auth/register_form_body.dart';
import 'package:catchpad/ui/auth/subprofile/preferences.dart';
import 'package:catchpad/ui/emb/iga/iga_base.dart';
import 'package:catchpad/ui/event/create_new_event.dart';
import 'package:catchpad/ui/home_screen.dart';
import 'package:catchpad/ui/policy/privacy_policy.dart';
import 'package:catchpad/v2/screens/game/game_setup/game_setup_screen.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:showcaseview/showcaseview.dart';

import '../prov/global_providers.dart';
import '../ui/app_settings_toggles_screen.dart';
import '../ui/event/choose_event.dart';
import '../ui/event/choose_user_event.dart';
import '../ui/game/detail/game_detail_screen.dart';
import '../ui/game/game_screen.dart';
import '../ui/welcome_screen.dart';
import '../ui/widgets/error_screen.dart';
import 'utils.dart';

String initialLocation = RouteTable.rHomeScreen;
String initialIGALocation = RouteTable.rBaseIGAScreen;

class RouteTable {
  RouteTable._();

  static const String
      //
      rHomeScreen = 'home',
      rSandbox = 'sandbox',
      rWelcomeScreen = 'welcome',
      rToggleScreen = 'togglescreen',
      rCreateCatchpadEvent = 'createevent',
      rChooseCatchpadEvent = 'chooseEvent',
      rChooseCatchpadEventCompetitor = 'choosecompatitor',
      rPreferences = 'preferences',
      rLogin = 'login',
      rRegister = 'register',
      rPrivacyPolicy = 'privacypolicy',
      rGameDetailScreen = 'game_detail',
      rGameScreen = 'game';
  static const String rBaseIGAScreen = 'igaBase';

  static final refreshListenableProvider = Provider(
    (ref) => Listenable.merge(
      [
        // here put the providers you wanna listen to
        // and refresh your route's state when they change

        // this is an example of listening to the auth state
        // ValueNotifier(ref.watch(authProvider).authState),
        // ValueNotifier(ref.watch(authProvider).authState),
        ValueNotifier(ref.watch(appLangProv)),
      ],
    ),
  );

  static final routerEmbProvider = Provider<GoRouter>(
    (ref) {
      return GoRouter(
        initialLocation: '/$rBaseIGAScreen',
        routes: [
          GoRoute(
            name: rBaseIGAScreen,
            path: '/$rBaseIGAScreen',
            builder: (context, state) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
                  overlays: []);

              ///Set Flag This a EMB Project
              ///Get Mobile ID and then get responsibility own catchpads from firebase EMB
              ///Scan all devices and connect

              return Screenshot(
                  controller: ref.read(currentShareController),
                  child: const IGABase());
            },
            /*routes: [

            ],*/
          ),
        ],
        errorBuilder: (context, state) {
          logger.e('error ${state.error}');
          logger.d('qPA ${state.queryParametersAll}');
          return const ErrorScreen.empty();
        },
        // turn off the # in the URLs on the web
      );
    },
  );

  static final routerProvider = Provider<GoRouter>(
    (ref) {
      return GoRouter(
        initialLocation: '/$initialLocation',
        routes: [
          GoRoute(
            name: rHomeScreen,
            path: '/$rHomeScreen',
            builder: (context, state) {
              final auth = FirebaseAuth.instance;
              final curUser = auth.currentUser;

              if (curUser != null) {
                /* try { */

                UsersApi.instance.getUserFromUserId(curUser.uid).then((user) {
                  ref.read(currentUserProv.notifier).update(user);
                });

                /* if (user == null) {
                    return '/welcome';
                  } */
                /* } catch (e) {
                  return '/welcome';
                } */
              }

              return ShowCaseWidget(
                onStart: (index, key) {},
                onComplete: (index, key) {},
                blurValue: 1,
                builder: Builder(builder: (context) {
                  return const HomeScreen();
                }),
                disableBarrierInteraction: true,
                autoPlayDelay: const Duration(seconds: 1),
              );
            },
            routes: [
              GoRoute(
                name: rSandbox,
                path: rSandbox,
                builder: (context, state) => const Sandbox(),
              ),
              GoRoute(
                name: rGameScreen,
                path: rGameScreen,
                builder: (context, state) => const GameScreen(),
              ),
              GoRoute(
                name: rGameDetailScreen,
                path: rGameDetailScreen,
                pageBuilder: (context, state) {
                  if (Platform.isIOS) {
                    return CupertinoPage(
                        child: ShowCaseWidget(
                      onStart: (index, key) {},
                      onComplete: (index, key) {},
                      blurValue: 1,
                      builder: Builder(builder: (context) {
                        return const GameDetailScreen();
                      }),
                      autoPlayDelay: const Duration(seconds: 1),
                    ));
                  } else {
                    return MaterialPage(
                        child: ShowCaseWidget(
                      onStart: (index, key) {},
                      onComplete: (index, key) {},
                      blurValue: 1,
                      builder: Builder(builder: (context) {
                        return const GameDetailScreen();
                      }),
                      autoPlayDelay: const Duration(seconds: 1),
                    ));
                  }
                },
              ),
              GoRoute(
                name: rToggleScreen,
                path: rToggleScreen,
                builder: (context, state) => const AppSettingTogglesScreen(),
              ),
              GoRoute(
                name: rCreateCatchpadEvent,
                path: rCreateCatchpadEvent,
                builder: (context, state) => const CreateNewEvent(),
              ),
              GoRoute(
                name: rChooseCatchpadEvent,
                path: rChooseCatchpadEvent,
                builder: (context, state) => const ChooseEvent(),
              ),
              GoRoute(
                name: rChooseCatchpadEventCompetitor,
                path: rChooseCatchpadEventCompetitor,
                builder: (context, state) => const ChooseUserEvent(),
              ),
              GoRoute(
                name: rPreferences,
                path: rPreferences,
                builder: (context, state) => const Preferences(),
              ),
            ],
          ),
          GoRoute(
            name: rWelcomeScreen,
            path: '/$rWelcomeScreen',
            builder: (context, state) => const WelcomeScreen(),
          ),
          GoRoute(
              name: rLogin,
              path: '/$rLogin',
              builder: (context, state) => const LoginFormBody()),
          GoRoute(
              name: rRegister,
              path: '/$rRegister',
              builder: (context, state) => const RegisterFormBody()),
          GoRoute(
              name: rPrivacyPolicy,
              path: '/$rPrivacyPolicy',
              builder: (context, state) => const PrivacyPolicyScreen()),
        ],
        errorBuilder: (context, state) {
          logger.e('error ${state.error}');
          logger.d('qPA ${state.queryParametersAll}');
          return const ErrorScreen.empty();
        },
        // turn off the # in the URLs on the web
      );
    },
  );
}

class WhiteScreen extends StatefulWidget {
  const WhiteScreen({super.key});

  @override
  State<WhiteScreen> createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
    ));
  }
}
