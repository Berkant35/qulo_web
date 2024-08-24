import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/audiotodo/current_meeting_states.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/components/sheets/save_to_microsoft_sheet.dart';
import 'package:audiotodo/utilities/constants/enums/app/image_picker_states.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/audio_steppers.dart';
import 'package:audiotodo/utilities/constants/enums/meet/speech_states.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../line/viewmodel/app/utilities/show_case_manager.dart';
import '../../../ui/subscriptions/subscription_base.dart';
import '../../constants/custom_assets/asset_paths.dart';
import '../buttons/neu_stadium_button.dart';
import '../texts/image_text.dart';
import 'save_to_third_party_sheet.dart';

class Sheets {
  ///This method shows the bottom sheet for saving to third party
  static void saveToThirdPartySheetFunction(
      BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        barrierLabel: S.current.utilities_save,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(EdgeExtension.hugeEdge.edgeValue),
          ),
        ),
        builder: (BuildContext context) {
          return  SizedBox(height: 90.h, child: const SaveToThirdPartySheet());
        });
  }

  ///This method shows the bottom sheet for saving to microsoft file
  static void saveToMicrosoftFileSheetFunction(
      BuildContext cc, WidgetRef ref) {
    showModalBottomSheet(
        context: cc,
        barrierLabel: S.current.utilities_save,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(EdgeExtension.hugeEdge.edgeValue),
          ),
        ),
        builder: (BuildContext cc) {
          return SizedBox(
              height: 90.h, child: const SaveToMicrosoftFileSheet());
        });
  }

  ///This method shows the bottom sheet for canceling current meeting
  static Future<void> cancelCurrentMeeting(
      BuildContext context, WidgetRef _) async {
    return await showModalBottomSheet(
        context: context,
        barrierLabel: S.current.result_are_u_sure_for_close_title,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(EdgeExtension.hugeEdge.edgeValue),
          ),
        ),
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, subRef, child) {
              return SizedBox(
                height: 32.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        S.current.result_are_u_sure_for_close_title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        S.current.result_are_u_sure_for_close_content,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NeuStadiumTextButton(
                            onPressed: () async => await refreshMeeting(subRef)
                                .then((value) =>
                                    NavigationService.instance.navigatePopUp()),
                            text: S.current.done,
                            isPrimaryButton: false,
                          ),
                          NeuStadiumTextButton(
                            onPressed: () =>
                                NavigationService.instance.navigatePopUp(),
                            text: S.current.cancel,
                            isPrimaryButton: true,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  ///This method do refreshes to all states about on current meet
  static Future<void> refreshMeeting(WidgetRef ref) async {
    {
      ref
          .read(currentAudioStepManager.notifier)
          .changeState(AudioToDoSteps.idle);
      ref
          .read(currentMeetingManagerState.notifier)
          .changState(CurrentMeetStates.idle);
      ref.read(currentWaveAnimationControlState.notifier).changState(false);

      return await ref
          .read(currentMeetControllerManager.notifier)
          .destroyMeetingAndRefresh(ref)
          .then((value) async {
        ref.read(currentRecorderControllerManager.notifier).disposeRecord(ref);

        ref
            .read(currentSpeechStateManager.notifier)
            .changeStateOfSpeechState(SpeechStates.idle, ref);
      });
      //ref.read(currentSpeechToTextManager.notifier).destroy(); unnecessary destroy!
    }
  }

  ///This method shows the bottom sheet for image picking by camera or gallery
  static Future<void> getImageFromGalleryOrCameraAndSetCurrentImage(
      WidgetRef ref) async {
    return await showModalBottomSheet(
        context: ref.context,
        barrierLabel: S.current.utilities_save,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(EdgeExtension.hugeEdge.edgeValue),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 30.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageWithText(
                    IconPaths.icCameraPng,
                    S.current.utilities_camera,
                    () async => imageFromGalleryOrCamera(
                        ref, TypeCameraOrGallery.camera),
                  ),
                  ImageWithText(
                      IconPaths.icGalleryPng,
                      S.current.utilities_gallery,
                      () async => imageFromGalleryOrCamera(
                          ref, TypeCameraOrGallery.gallery)),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> imageFromGalleryOrCamera(
      WidgetRef ref, TypeCameraOrGallery typeCameraOrGallery) {
    return ref
        .read(currentPhotoManagerState.notifier)
        .getImageFromGalleryOrCamera(ref, typeCameraOrGallery)
        .then((value) {});
  }

  static Future<void> showLicence(BuildContext context) async {
    // Show the bottom sheet
    return showLicensePage(
      context: context,
      applicationName: 'AudioToDo',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.ad_units),
      applicationLegalese: '© 2024 AudioToDo. All rights reserved.',
      // The content of the bottom sheet
    );
  }

  // Offers
  static Future<void> offersBottomSheet(BuildContext context) async {
    // Show the bottom sheet
    return showBarModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: const SubscriptionBase(),
      ),
    );
  }
}
