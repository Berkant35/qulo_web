import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:catchpad/data/api/user_api.dart';
import 'package:catchpad/managers/asset_manager.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/analysis/performance_analysis_main.dart';
import 'package:catchpad/ui/widgets/buttons/circullar_image_button.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_screens/all_periods.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../prov/admins_prov.dart';
import '../../prov/app_settings_prov.dart';
import '../../prov/auth/current_user_prov.dart';
import '../../prov/class_provider.dart';
import '../../utils/route_table.dart';
import '../../utils/util_screens/classes_screen.dart' as clas;
import '../../utils/util_screens/exercises_screen.dart';
import '../../utils/util_screens/quiz_screen.dart';
import '../../utils/utils.dart';
import '../leaderboard/leaderboard_game_history_bigbody.dart';
import '../widgets/buttons/cp_button_1.dart';
import '../widgets/cp_chip.dart';
import '../widgets/default_bg.dart';

Widget getPlatformSpecificArrowIcon() {
  return Platform.isIOS
      ? const Icon(Icons.arrow_forward_ios)
      : const Icon(Icons.arrow_forward);
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    final user = ref.watch(currentUserProv);
    final adminEmails = ref.watch(userPermissionProvider).adminEmails;


    return DefaultBg(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(defPaddingSize),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  if (user?.name != null)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    user?.email ?? "",
                                    style: const TextStyle(fontSize: 16),
                                  ),

                                  IconButton(
                                    icon: const Icon(Icons.content_copy),
                                    iconSize: 16,
                                    onPressed: () {
                                      final email = user?.email ?? "";
                                      Clipboard.setData(
                                          ClipboardData(text: email));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              CpColors.cpBasicWhite,
                                          content: Text(
                                              'E-posta kopyalandı: $email'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const Divider(
                    thickness: 3,
                  ),
                  if (ref.watch(appSettingsToggleProvider).enableAddingUser)
                    Consumer(
                      builder: (context, ref, _) {
                        return CpButton1(
                          onPressed: () {
                            ref
                                .read(appSettingsProv.notifier)
                                .setRegisterd(false);
                          },
                          fullWidth: true,
                          child: Text(inst.add_user),
                        );
                      },
                    ),
                  /* CpButton1(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginFormBody()));
                      ref.read(appSettingsProv.notifier).setRegisterd(false);
                    },
                    fullWidth: true,
                    child: Text(inst.form_login),
                  ), */
                  Column(
                    children: [
                      /*ListTile(
                        enabled: false,
                        leading: Text(
                          inst.profile_screen_account_settings,
                        ),
                        trailing: Icon(Icons.adaptive.arrow_forward),
                      ),
                      ListTile(
                        enabled: false,
                        leading: Text(
                          inst.profile_screen_rating,
                        ),
                        trailing: Icon(Icons.adaptive.arrow_forward),
                      ),
                      ListTile(
                        enabled: false,
                        leading: Text(
                          inst.profile_screen_saved_games,
                        ),
                        trailing: Icon(Icons.adaptive.arrow_forward),
                      ),*/
                      ExpansionTile(
                        title: Text(
                          inst.profile_screen_exercise_settings,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        children: inExpansionTileList(
                            inst, getPlatformSpecificArrowIcon, context),
                      ),
                      ListTile(
                        leading: Text(
                          inst.preferences,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          context.pushNamed(RouteTable.rPreferences);
                        },
                      ),
                      ListTile(
                        leading: Text(
                          inst.profile_screen_performance_analysis,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          //await ref.read(quizProvider.notifier).loadQuizes(ref);
                          if (Platform.isIOS) {
                            await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const PerformanceAnalysis()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PerformanceAnalysis(),
                                ));
                          }
                        },
                      ),
                      ListTile(
                        leading: Text(
                          inst.profile_screen_saved_groups,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          EasyLoading.show(
                              maskType: EasyLoadingMaskType.black,
                              dismissOnTap: true);
                          await UsersApi.instance.getGroupGameHistories(
                              ref.read(currentUserProv)!.uid!, ref);
                          await ref
                              .read(currentUserAssetsProv.notifier)
                              .loadAssets(ref);
                          ref.read(selectedClassProvider.notifier).loadClass(
                              ref); // needs to be loaded after loadclasses function
                          ref.read(classProvider.notifier).removeClass(ref,
                              className: 'uniqallusersdevcode');
                          ref
                              .read(classProvider.notifier)
                              .checkAndLoad(ref, context);
                          EasyLoading.dismiss();
                          if (Platform.isIOS) {
                            await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const clas.ClassesScreen()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const clas.ClassesScreen(),
                                ));
                          }
                        },
                      ),
                      ListTile(
                        leading: Text(
                          inst.profile_screen_past_games,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          if (Platform.isIOS) {
                            await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const LeaderBoardScreenHistory()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LeaderBoardScreenHistory(),
                                ));
                          }
                        },
                      ),
                      ListTile(
                        leading: Text(
                          inst.profile_screen_contact_us,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          Future<void> _launchUrl(String url) async {
                            final _url = Uri.parse(url);
                            if (!await launchUrl(_url)) {
                              logger.e('failed to launch url: $_url');
                            }
                          }

                          const url = 'https://catchpad.com/pages/contact';

                          await _launchUrl(url);
                        },
                      ),
                      ListTile(
                        leading: Text(
                          inst.password_reset,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          EasyLoading.show(
                              maskType: EasyLoadingMaskType.black,
                              dismissOnTap: true);
                          final response = await ref
                              .read(currentUserProv.notifier)
                              .resetPassword();
                          EasyLoading.dismiss();
                          if (response) {
                            EasyLoading.showToast(inst.password_reset_toast);
                            return;
                          }
                          EasyLoading.showToast(inst.form_autherror_failed);
                        },
                      ),
                      //RepairOfNames

                      if (adminIdList.contains(user
                          ?.uid)) // based on admin permissions provided by backend
                        ListTile(
                          leading: const Text(
                            'App Settings Toggles Screen',
                          ),
                          trailing: getPlatformSpecificArrowIcon(),
                          onTap: () async {
                            context.pushNamed(RouteTable.rToggleScreen);
                          },
                        ),
                      if (adminIdList.contains(user?.uid))
                        ListTile(
                          leading: const Text(
                            'Create Catchpad Event',
                          ),
                          trailing: getPlatformSpecificArrowIcon(),
                          onTap: () async {
                            context.pushNamed(RouteTable.rCreateCatchpadEvent);
                          },
                        ),
                      if (adminIdList.contains(user?.uid))
                        ListTile(
                          leading: const Text(
                            'Choose Event',
                          ),
                          trailing: getPlatformSpecificArrowIcon(),
                          onTap: () async {
                            context.pushNamed(RouteTable.rChooseCatchpadEvent);
                          },
                        ),

                      ListTile(
                        leading: Text(
                          inst.profile_screen_language,
                        ),
                        trailing: const SizedBox(
                          width: 200,
                          child: _AppLangChanger(),
                        ),
                        onTap: () async {},
                      ),
                      ListTile(
                        enabled: true,
                        leading: Text(
                          inst.profile_screen_close_account,
                        ),
                        onTap: () => CustomDialogs.sureDialog(
                            ref, inst.profile_screen_close_account_explain,
                            pressOk: () => ref
                                .read(currentUserProv.notifier)
                                .deleteAccount(ref)),
                        trailing: Icon(Icons.adaptive.arrow_forward),
                      ),
                      ListTile(
                        leading: Text(
                          inst.profile_screen_signout,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          ref.read(currentUserProv.notifier).logOut(ref);
                          context.goNamed(RouteTable.rWelcomeScreen);
                        },
                      ),
                        ListTile(
                        leading: Text(
                          inst.privacy_policy_title,
                        ),
                        trailing: getPlatformSpecificArrowIcon(),
                        onTap: () async {
                          ref.read(currentVersionManager.notifier).launchUrlX(
                              Uri.parse(L10n.inst(context).privacy_url));
                        },
                      ),


                 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircullarImageButton(
                              imagePath: AssetManager.getImgPath('cp_logo.png'),
                              url: "https://catchpad.com/"),
                          CircullarImageButton(
                              imagePath:
                                  AssetManager.getImgPath('instagram.png'),
                              url: "https://www.instagram.com/catchpad/"),
                          CircullarImageButton(
                              imagePath:
                                  AssetManager.getImgPath('twitter_logo.png'),
                              url: "https://twitter.com/catchpad"),
                          CircullarImageButton(
                              imagePath:
                                  AssetManager.getImgPath('linkedin_logo.png'),
                              url:
                                  "https://www.linkedin.com/company/catchpad/"),
                          // CircullarImageButton(
                          //     imagePath:
                          //         AssetManager.getImgPath('youtube_logo.png'),
                          //     url: "https://www.youtube.com/@catchpad"),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Version: " +
                            ref.watch(currentVersionManager).deviceValue,
                        style: const TextStyle(color: Colors.white24),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> inExpansionTileList(AppLocalizations inst,
      Widget Function() getPlatformSpecificArrowIcon, BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            ListTile(
              leading: Text(
                inst.profile_screen_saved_quizes,
              ),
              trailing: getPlatformSpecificArrowIcon(),
              onTap: () async {
                //await ref.read(quizProvider.notifier).loadQuizes(ref);
                if (Platform.isIOS) {
                  await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const QuizScreen()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ));
                }
              },
            ),
            ListTile(
              leading: Text(
                inst.profile_screen_saved_exercises,
              ),
              trailing: getPlatformSpecificArrowIcon(),
              onTap: () async {
                //await ref.read(exerciseProvider.notifier).loadMoves(ref);
                if (Platform.isIOS) {
                  await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const ExerciseScreen()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExerciseScreen(),
                      ));
                }
              },
            ),
            ListTile(
              leading: Text(
                inst.profile_screen_saved_periods,
              ),
              trailing: getPlatformSpecificArrowIcon(),
              onTap: () async {
                //await ref.read(quizProvider.notifier).loadQuizes(ref);

                if (Platform.isIOS) {
                  await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const AllPeriods()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllPeriods(),
                      ));
                }
              },
            ),
          ],
        ),
      )
    ];
  }
}

class _AppLangChanger extends ConsumerStatefulWidget {
  const _AppLangChanger({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __AppLangChangerState();
}

class __AppLangChangerState extends ConsumerState<_AppLangChanger> {
  @override
  Widget build(BuildContext context) {
    final langs = L10n.allLangModels();

    final currentLang = ref.watch(appLangProv);

    return ListView(
      scrollDirection: Axis.horizontal,
      children: langs.map(
        (lang) {
          final isSelected = currentLang == lang;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: halfDefPaddingSize,
            ),
            child: CpChip(
              key: ValueKey('${lang.code} $isSelected'),
              text: lang.name,
              initialSelected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(appLangProv.notifier).setLanguage(lang);
                }
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
