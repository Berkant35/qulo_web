import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:catchpad/prov/admins_prov.dart';
import 'package:catchpad/prov/dialogs/show_case_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';

import '../data/api/user_api.dart';
import '../managers/static_games_list.dart';
import '../models/bottom_bar_item.dart';
import '../models/enums/utility/show_case_enum.dart';
import '../prov/auth/current_user_prov.dart';
import '../prov/game/selected_players_prov.dart';
import '../utils/cp_colors.dart';
import '../utils/utils.dart';
import '../utils/widgets/error_snackbar.dart';

bool isAdmin = false;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  bool waitOnceTime = true;

  Future initUsers() async {
    // SchedulerBinding.instance.addPersistentFrameCallback(
    //   (timeStamp) {
    //     Loading.load(context);
    //   },
    // );

    final allUsers = await UsersApi.instance.getAllUsers();
    if (allUsers == null) {
      if (ref.watch(appSettingsToggleProvider).isDebuggingByDeveloper &&
          isAdmin) {
        const ErrorSnackbar('Kullanicilar Çekilemedi').show(context);
      }
      return;
    }

    ref.read(allUsersProv.notifier).state = [...allUsers];

    // SchedulerBinding.instance.addPersistentFrameCallback(
    //   (timeStamp) {
    //     Loading.unload(context);
    //   },
    // );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeApp();
    });

    BackButtonInterceptor.add(myInterceptor);
  }

  Future<void> _initializeApp() async {
    ref.read(currentAllShowCases.notifier).showCaseIn(context: context, ref: ref);
    await ref.read(currentAllShowCases.notifier).initializeShowCases(ref);
    await ref.read(userPermissionProvider.notifier).setAdminEmails();

    final adminEmails = ref.read(userPermissionProvider).adminEmails;
    final curUser = ref.read(currentUserProv);

    if (!adminEmails.contains(curUser?.email)) {
      ref.read(appSettingsToggleProvider.notifier).setNonAdminUsersValues();
      isAdmin = false;
    } else {
      isAdmin = true;
      await initUsers();
      EasyLoading.showToast('Firestore adding is ${ref.read(appSettingsToggleProvider).enableAddingToFirestore ? 'enabled' : 'disabled'}');
    }

    waitOnceTime = false;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.remove(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return false;
  }

  @override
  Widget build(BuildContext context) {


    final currentItem = ref.watch(bottomBarProvider);
    instForGameScreen = L10n.inst(context);

    if (ref.context.mounted &&
        !ref.read(currentSafeInGameToggleState.notifier).state) {
      ref
          .read(currentDevicesManagerProvider.notifier)
          .connectedDevice
          .forEach((key, value) {
        PadManager.toggleInGame(key, ref: ref, inGame: false);
      });
      // ref.read(currentSafeInGameToggleState.notifier).changState(false,ref);
    }

    return waitOnceTime
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Loading(
            child: WillPopScope(
              onWillPop: () async => false,
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(currentDevicesManagerProvider)
                      .keys
                      .forEach((deviceId) {
                    ref
                        .read(currentAutoDisposeTimerManager.notifier)
                        .restartTimer(deviceId, ref);
                  });
                },
                child: Scaffold(
                  appBar: (ref.read(bottomBarProvider).index == 2 &&
                          ref
                              .read(appSettingsToggleProvider)
                              .enableLeaderboardViewer)
                      ? null
                      : AppBar(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (ref.watch(currentUserProv) != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: defPaddingSize),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CpColors.blue,
                                    ),
                                    child: Text(ref
                                        .watch(currentUserProv)!
                                        .fName!
                                        .substring(0, 1)),
                                  ),
                                ),
                              //Yeah i know this code is bullshit but i must be faster i will back to this code if i dont remember :)
                              ref.watch(currentUserProv) != null
                                  ? CustomShowCaseWidget(
                                      showCaseInfo: ref
                                          .read(currentAllShowCases)
                                          .firstWhere((element) =>
                                              element.key == Tips.welcome.name),
                                      showCaseContentWidget: Text(
                                        ref.watch(currentUserProv) == null
                                            ? '  CatchPad'
                                            : '  ${instForGameScreen.hello}${ref.watch(currentUserProv)!.fName!}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    )
                                  : Text(
                                      ref.watch(currentUserProv) == null
                                          ? '  CatchPad'
                                          : '  ${instForGameScreen.hello}${ref.watch(currentUserProv)!.fName!}',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    )
                            ],
                          ),
                          centerTitle: false,
                        ),
                  body: currentItem.body,
                  bottomNavigationBar: (ref.read(bottomBarProvider).index ==
                              2 &&
                          ref
                              .read(appSettingsToggleProvider)
                              .enableLeaderboardViewer)
                      ? null
                      : BottomNavigationBar(
                          backgroundColor: CpColors.bottomBarColor,
                          type: BottomNavigationBarType.fixed,
                          showUnselectedLabels: false,
                          showSelectedLabels: false,
                          selectedItemColor: CpColors.defTextColor,
                          unselectedItemColor: CpColors.bottomBarDisabledColor,
                          currentIndex: currentItem.index,
                          onTap: (val) => ref
                              .read(bottomBarProvider.notifier)
                              .setBottomBarItem(val, ref),
                          items: bottomBarItems.map(
                            (item) {
                              final isSelected =
                                  currentItem.index == item.index;
                              return BottomNavigationBarItem(
                                icon: CustomShowCaseWidget(
                                  showCaseInfo: ref
                                      .read(currentAllShowCases)
                                      .firstWhere((element) =>
                                          element.key ==
                                          getTipFromIndex(item.index).name),
                                  showCaseContentWidget: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(item.icon),
                                      if (item.indexEnum.isSearch)
                                        Consumer(
                                          builder: (context, ref, _) {
                                            final currentDeviceCount =
                                                ref.watch(bleConPr).keys.length;
                                            return Text(
                                              currentDeviceCount.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                    color: isSelected
                                                        ? CpColors.defTextColor
                                                        : CpColors
                                                            .defDisabledColor,
                                                  ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                label: '',
                                backgroundColor: CpColors.bottomBarColor,
                              );
                            },
                          ).toList(),
                        ),
                  /*floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      final strList = [];
                      final snapshot = await FirebaseCollectionEnums
                          .catchpad_event_results.reference
                          .doc("K-slYD07r3u0oXf4khycjzY4")
                          .collection("s16")
                          .get();

                      for (var perDoc in snapshot.docs) {
                        logger.i("Per Doc: $perDoc");
                        final perUserId = perDoc['userId'];
                        debugPrint(perUserId);
                        strList.add(perUserId);
                      }
                      final registerSnapshot =
                          await FirebaseCollectionEnums.users.reference.get();
                      for (var perRegister in registerSnapshot.docs) {
                        final _user = RegisterUser.fromJson(
                            perRegister.data() as Map<String, dynamic>);
                        if (strList.contains(_user.uid)) {
                          debugPrint(
                              "${_user.fName!} ${_user.lName!}, ${_user.email},${_user.phoneNum!.isNotEmpty ? _user.phoneNum : ""}");
                        }
                      }
                    },
                  ),*/
                ),
              ),
            ),
          );
  }

  Tips getTipFromIndex(int index) {
    switch (index) {
      case 0:
        return Tips.exercisesShowCase;
      case 1:
        return Tips.padConnection;
      case 2:
        return Tips.sorting;
      case 3:
        return Tips.profile;
      default:
        return Tips.none;
    }
  }


}
