import 'dart:async';

import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/emb/iga/iga_home_page.dart';
import 'package:catchpad/ui/emb/iga/iga_onboarding/onboarding_four_page.dart';
import 'package:catchpad/ui/emb/iga/iga_onboarding/onboarding_one_page.dart';
import 'package:catchpad/ui/emb/iga/iga_onboarding/onboarding_three_page.dart';
import 'package:catchpad/ui/emb/iga/iga_onboarding/onboarding_two_page.dart';
import 'package:catchpad/ui/emb/iga/iga_res/register/iga_register.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/utils/util_widgets/util_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restart_app/restart_app.dart';

import '../../../managers/static_games_list.dart';
import '../../../prov/emb/emb_global_providers.dart';
import '../../../prov/emb/iga/iga_background_ble.dart';
import '../../../prov/end_game_prov.dart';
import '../../../prov/game/round_prov.dart';
import '../../../utils/emb/iga/iga_enums.dart';
import '../../../utils/l10n/l10n.dart';
import 'iga_res/iga_leaderboard.dart';
import 'iga_res/iga_result.dart';

// Import necessary libraries and packages

class IGABase extends ConsumerStatefulWidget {
  const IGABase({
    super.key,
  });

  @override
  ConsumerState createState() => _IGABaseState();
}

class _IGABaseState extends ConsumerState<IGABase> {
  // Initialize variables
  bool onceTimeScan = false;
  bool padShowStatus = false;
  static const int _mustDeviceCount = 12;
  bool _isOpen = false;

  // Toggle the container
  void toggleContainer() {
    setState(() {
      _isOpen = !_isOpen;
    });

    if (_isOpen) ref.read(currentIgaResultManager.notifier).incrementChatBot();
  }

  // Initialize state
  @override
  void initState() {
    ref.read(currentIgaPageManager.notifier).initializePageController();

    super.initState();

    // Send a message to Telegram when the device is turned on
    // TelegramManager.instance?.sendMobileReportMessage("Cihaz: ${ref.read(igaBackGroundManager.notifier).igaTableDeviceId} ayağa kalktı!", ref);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Periodically check the device connection state
    Timer.periodic(Duration(seconds: !onceTimeScan ? 2 : 4), (timer) async {
      if (!ref.context.mounted) return;

      // Check the connection state of each device
      final length = ref
          .read(bleConPr)
          .values
          .where((element) =>
              element.connectionState == DeviceConnectionState.connected)
          .length;

      final anyConnectionState = ref.read(bleConPr).values.any((element) =>
          element.connectionState == DeviceConnectionState.connecting ||
          element.connectionState == DeviceConnectionState.connecting);

      if (anyConnectionState) return;
      if (!onceTimeScan) {
        ref.read(igaBackGroundManager.notifier).flagTrueAllPad(ref);
        onceTimeScan = true;
      }

      // Check the number of devices discovered
      final easyDiscoveredDeviceslength =
          ref.read(igaBackGroundManager.notifier).easyDiscoveredDevices.length;
      final firstPlayerDiscoveredDeviceslength = ref
          .read(igaBackGroundManager.notifier)
          .firstPlayerDiscoveredDevices
          .length;
      final secondPlayerDiscoveredDeviceslength = ref
          .read(igaBackGroundManager.notifier)
          .secondPlayerDiscoveredDevices
          .length;
      final count = ref.read(bleConPr).keys.length;
      //Must 1.player Count equal To 2.player and must be easy discovered
      //devices length equal to 6 and also total count equal to 12

      // Check if the number of devices discovered meets certain conditions
      if (length < _mustDeviceCount ||
          firstPlayerDiscoveredDeviceslength !=
              secondPlayerDiscoveredDeviceslength ||
          count !=
              (firstPlayerDiscoveredDeviceslength +
                  secondPlayerDiscoveredDeviceslength) ||
          easyDiscoveredDeviceslength < 6) {
        if (ref.read(currentIgaAllPadConnectionOnceTimeManager)) {
          // Disconnect all devices and restart the app if the conditions are not met
          await ref
              .read(igaBackGroundManager.notifier)
              .disconnectedPadToTelegram(ref, ref.read(bleConPr).keys.toList());
          ref
              .read(currentIgaAllPadConnectionOnceTimeManager.notifier)
              .changState(false);
          try {
            ref.read(gameRoundProv.notifier).setPaused();
          } catch (e) {
            logger.d(e.toString());
          }
          try {
            ref.read(gameEndingProvider.notifier).end();
            ref.read(forceEndProvider.notifier).changState(true);
          } catch (e) {
            logger.d(e.toString());
          }
          ref.read(checkDisconnectingFlagManager.notifier).changState(true);
          //TODO OYUNDA FLAG'İ OLUŞTUR ONA BAKARAK BURDAKİ FLAGİ GÜNCELLE!
          // CustomCatchpadDialogs.connectionWait(context, ref,

          //     inGameDisconnected: true);
          // Restart the app
          Restart.restartApp();
        }
        ref.read(igaBackGroundManager.notifier).initializeScanAndConnect(ref);
      } else {
        if (!ref.read(currentIgaAllPadConnectionOnceTimeManager)) {
          ref.read(igaBackGroundManager.notifier).telegramReport(ref);
          ref
              .read(currentSafeInGameToggleState.notifier)
              .changState(false, ref);
        }
        ref
            .read(currentIgaAllPadConnectionOnceTimeManager.notifier)
            .changState(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentIgaPageManager);

    instForGameScreen = L10n.inst(context);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //  FloatingActionButton(
          //    onPressed: () async {
          //      padShowStatus = true;
          //
          //      final allConDevs = ref.read(bleConPr).keys.toList();
          //      final colors = defaultConstColors(ref);
          //
          //      Future.doWhile(() async {
          //        final ftrList = <Future>[];
          //
          //        for (var perDevice in allConDevs) {
          //
          //          final randomColorIndex = Random().nextInt(colors.length);
          //
          //          ftrList.add(PadManager.ledColor(
          //              perDevice.id,
          //              SidesColorsModel.all(colors[randomColorIndex]),
          //              ref: ref));
          //
          //        }
          //
          //        await Future.wait(ftrList);
          //
          //        await Future.delayed(
          //            const Duration(milliseconds: IgaConsts.padShowIntervalMs));
          //
          //        return padShowStatus;
          //      });
          //
          //
          //
          //    },
          //    child: Text("Start"),
          //  ),
          // FloatingActionButton(
          //   onPressed: ()  {
          //     padShowStatus = false;
          //   },
          //   child: Text("Stop"),
          // ),
          //  FloatingActionButton.extended(
          //    onPressed: () {
          //      ref.read(bleDeviceConnectorProv).disconnect(ref
          //          .watch(currentDevicesManagerProvider.notifier)
          //          .connectedDevice
          //          .values
          //          .first);
          //    },
          //    label: const Text("Disconnect Demo"),
          //  ),
          const Spacer(),
          if (currentPage == IGAStates.onBoardingOne ||
              currentPage == IGAStates.onBoardingTwo ||
              currentPage == IGAStates.onBoardingThree ||
              currentPage == IGAStates.onBoardingFour)
            Align(alignment: Alignment.bottomRight, child: _chatBot()),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (_isOpen) {
            setState(() {
              _isOpen = false;
            });
          }
        },
        child: Stack(
          children: [
            Image.asset(
              ref.watch(currentIgaPageManager) == IGAStates.home
                  ? IgaAssets.landing_background.getPath
                  : IgaAssets.background.getPath,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.fill,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller:
                      ref.watch(currentIgaPageManager.notifier).pageController,
                  itemCount: onBoardingPages.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (!ref.read(currentSafeInGameToggleState)) {
                      Future(() {
                        ref
                            .read(currentSafeInGameToggleState.notifier)
                            .changState(false, ref);
                        ref
                            .read(currentSafeInGameToggleState.notifier)
                            .startPadShow(ref,[], forcedVal: true);
                      });
                    }

                    return onBoardingPages[index];
                  },
                );
              },
            ),
            if (ref.watch(currentIgaPageManager) == IGAStates.result)
              _sharePerformanceVideoGetDiscount(context),
            if (_isOpen) _contactContainer(context),
            if (ref.watch(currentIgaPageManager) == IGAStates.onBoardingThree ||
                ref.watch(currentIgaPageManager) == IGAStates.onBoardingTwo)
              _leaderboardButton()
          ],
        ),
      ),
    ));
  }

  Positioned _sharePerformanceVideoGetDiscount(BuildContext context) {
    return Positioned(
      left: 1.5.w,
      bottom: 1.5.w,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(1.3.h),
            decoration: const BoxDecoration(
                color: CpColors.cpDavysGrey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Image.asset(
              IgaAssets.qr_get_discount.getPath,
              height: 9.h,
            ),
          ),
          Text(
            instForGameScreen.iga_share_performance_video,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white, fontSize: 12.sp),
          ),
          Text(
            instForGameScreen.iga_get_discount_code,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: CpColors.cpPrimary, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _chatBot() {
    return SizedBox(
      width: 8.w,
      height: 8.w,
      child: FittedBox(
        fit: BoxFit.contain,
        child: FloatingActionButton(
            onPressed: toggleContainer,
            shape: const CircleBorder(),
            child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [CpColors.cpPrimary, CpColors.cpDividerGradient],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Image.asset(
                  IgaAssets.contact.getPath,
                ))),
      ),
    );
  }

  Align _leaderboardButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: CustomCatchpadButtons.buildBackGroundGradientButton(
              onPressed: () => ref
                  .read(currentIgaPageManager.notifier)
                  .changState(IGAStates.seeLeaderboard, ref: ref),
              width: 200,
              fontSize: 14.sp,
              text: instForGameScreen.iga_see_leaderboard,
              height: 9.h,
              icon: IgaAssets.people.getIcon),
        ));
  }

  Positioned _contactContainer(BuildContext context) {
    return Positioned(
        right: 25.0,
        bottom: 25.0,
        child: Container(
          width: 30.w,
          height: 45.h,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 77, 77, 77),
          ),
          child: Stack(
            children: [
              Container(
                width: 30.w,
                height: 27.h,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [CpColors.cpPrimary, CpColors.cpDividerGradient],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(instForGameScreen.hello_2,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black)),
                    Text(instForGameScreen.iga_qr_text,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black)),
                    Gap(0.2.h),
                    const IgaChatBotTextField(),
                    Gap(1.h),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset(
                        height: 17.h,
                        IgaAssets.qr_chatbot.getPath,
                      ),
                    ),
                    Gap(1.h),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: CpColors.cpDavysGrey,
                        ),
                        child: Text(
                          instForGameScreen.more_info,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Gap(1.h)
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomLeft,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 2.w, bottom: 2.h),
              //     child: Row(
              //       children: [
              //         Text(
              //           ref
              //               .watch(bleConPr)
              //               .values
              //               .where((element) =>
              //                   element.connectionState ==
              //                   DeviceConnectionState.connected)
              //               .length
              //               .toString(),
              //           style: Theme.of(context)
              //               .textTheme
              //               .displaySmall
              //               ?.copyWith(fontSize: 10.sp, color: Colors.grey),
              //         ),
              //         SizedBox(
              //           width: 1.w,
              //         ),
              //         Image.asset(
              //           AssetManager.getImgPath('instagram.png'),
              //           width: 2.w,
              //           height: 2.w,
              //         ),
              //         SizedBox(
              //           width: 1.w,
              //         ),
              //         Image.asset(
              //           AssetManager.getImgPath('twitter_logo.png'),
              //           width: 2.w,
              //           height: 2.w,
              //         ),
              //         SizedBox(
              //           width: 1.w,
              //         ),
              //         Image.asset(
              //           AssetManager.getImgPath('linkedin_logo.png'),
              //           width: 2.w,
              //           height: 2.w,
              //         ),
              //         SizedBox(
              //           width: 0.25.w,
              //         ),
              //         Text(
              //           "@catchpad",
              //           style: TextStyle(fontSize: 12.sp),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ));
  }
}

const onBoardingPages = [
  // IgaRegisterPage(),
  IgaHomePage(),
  OnboardingOnePage(),
  OnboardingTwoPage(),
  OnboardingThreePage(),
  OnboardingFourPage(),
  IGAResult(),
  IgaRegisterPage(),
  IgaLeaderboardPage()
];

class IgaChatBotTextField extends ConsumerStatefulWidget {
  const IgaChatBotTextField({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaChatBotTextFieldState();
}

class _IgaChatBotTextFieldState extends ConsumerState<IgaChatBotTextField> {
  final TextEditingController _controller = TextEditingController();
  ValueNotifier<bool> loadingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.25.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (context, val, _) {
            return val
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                          // text rengi
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'info@catchpad.com',
                            hintStyle: TextStyle(
                                color: Colors.white54, fontSize: 12.sp),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right_alt_outlined,
                            color: CpColors.cpPrimary),
                        onPressed: () async {
                          loadingNotifier.value = true;

                          final list = await FirebaseIgaCollectionEnumsWithField
                              .iga_cached_emails.reference
                              .where(
                              "mail", isEqualTo: _controller.text
                          ).get();

                          if (list.docs.isEmpty) {
                            loadingNotifier.value = false;
                            await FirebaseIgaCollectionEnumsWithField
                                .iga_qr_chatbot_mails.reference
                                .add(
                              {
                                "mail": _controller.text,
                                "language": L10n.inst(context).language,
                                "date": DateTime.now().nowTimeddMMyyyyHHmmss,
                                "kDebugMode": kDebugMode,
                                "pier": kDebugMode
                                    ? "DEMO"
                                    : ref
                                    .read(currentIgaResultManager.notifier)
                                    .currentLocation
                                    ?.igaLocationName,
                              },
                            );
                            _controller.clear();
                            return;
                          }

                          loadingNotifier.value = false;
                        },
                        padding: EdgeInsets.zero,
                        // padding sıfırlanarak butonun hizalanması sağlanır
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  );
          }),
    );
  }
}
