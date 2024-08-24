import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/models/auth/user_model.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/audio_steppers.dart';
import 'package:audiotodo/utilities/constants/enums/user/plan_type.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/theme/custom_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utilities/constants/app/config.dart';

class AudioStepIdleOfMiddle extends ConsumerStatefulWidget {
  const AudioStepIdleOfMiddle({
    super.key,
  });

  @override
  ConsumerState createState() => _AudioStepIdleOfMiddleState();
}

class _AudioStepIdleOfMiddleState extends ConsumerState<AudioStepIdleOfMiddle>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.read(authManager);

    return AnimatedContainer(
      duration: const Duration(milliseconds: Configs.mainPageDurationTime),
      curve: Curves.slowMiddle,
      // İsteğe bağlı, geçiş eğrisini belirleyebilirsiniz
      width:
          ref.watch(currentAudioStepManager) == AudioToDoSteps.idle ? 100.w : 0,
      color: CustomColors.fillWhiteColor,
      child: hasPlan(currentUser),
    );
  }

  Column hasPlan(UserModel? currentUser) {
    return Column(
      children: [
        // if (kDebugMode)
        //   FloatingActionButton(
        //     onPressed: () => ref
        //         .read(currentAllShowCases.notifier)
        //         .clearAllOnboardingShowCaseFromLocale(ref),
        //     child: const Icon(Icons.clear_all),
        //   ),
        CustomShowCaseWidget(
          showCaseInfo: ref.read(currentAllShowCases).firstWhere(
              (element) => element.key == ShowCaseStates.startMeeting.name),
          showCaseContentWidget: Stack(
            children: [
              // NeuTextButton(text: "Test", onPressed: (){
              //   ApplicationExceptions.handleRecordException("Test", ref,title: "Title");
              //   throw Exception("Test");
              // }),
              CustomPlayStopButton(
                onPressed: () => onPressPlayButton(currentUser),
                circleRadius: 35.w,
                iconSize: 10.h,
                recordingOrPlayer: true,
              ),
              if (currentUser!.planType == PlanType.none)
                Positioned(
                    right: 3.25.w,
                    top: 2.h,
                    child:
                        const Icon(Icons.lock, color: CustomColors.vanillaIce)
                ),
            ],
          ),
          onPressedTarget: () => onPressPlayButton(currentUser),
        ),
        SizedBox(height: 4.h),
        Text(
          S.current.press_for_meet,
          style: ThemeValueExtension.titleTextStyle.copyWith(
              color: CustomColors.profileGreyColor,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.clip),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref.watch(currentLanguageManager)?.name ?? "-",
              style: ThemeValueExtension.titleTextStyle.copyWith(
                  color: CustomColors.profileGreyColor,
                  fontWeight: FontWeight.w400),
            ),
            IconButton(
                onPressed: () => NavigationService.instance.navigateToPage(
                    path: NavigationConstants.languageSettingsPage),
                icon: Icon(
                  Icons.language_sharp,
                  size: 4.h,
                  color: CustomColors.profileGreyColor,
                ))
            //IconPaths.icSettings.customSvgIcon(color: CustomColors.primaryColor)
          ],
        ),
      ],
    );
  }

  void onPressPlayButton(UserModel? currentUser) {
    {
      if (currentUser!.planType != PlanType.none &&
          (currentUser.totalRecordSeconds ?? 0) > 0) {
        ref
            .read(currentAudioStepManager.notifier)
            .changeState(AudioToDoSteps.record);
      } else {
        if (currentUser.planType != PlanType.none &&
            (currentUser.totalRecordSeconds ?? 0) <= 0) {
          RecordDialogs.noHaveRecordTime();
        } else {
          Sheets.offersBottomSheet(ref.context);
        }
      }
    }
  }
}
