import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/record/help_record/record_options.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/exceptions/record_exceptions.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

class RecordDialogs {
  static notAvailableDialog(WidgetRef ref) => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentState!.context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: S.current.something_went_wrong,
        desc: S.current.please_give_feed_back,
        btnCancelOnPress: () => RecordExceptions.handleRecordException(
            "Not Available Speech To Text!", ref),
      ).show();

  static noHaveRecordTime() {
    AwesomeDialog(
      context: NavigationService.instance.navigatorKey.currentContext!,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: S.current.plans_has_no_time_dialog_title,
      desc: S.current.plans_has_no_time_dialog_content,
      btnOkText: S.current.contiune,
      btnOkOnPress: () => Sheets.offersBottomSheet(
          NavigationService.instance.navigatorKey.currentContext!),
      btnCancelOnPress: () {},
    ).show();
  }

  static noHaveRecreate() {
    AwesomeDialog(
      context: NavigationService.instance.navigatorKey.currentContext!,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: S.current.plans_has_no_recreate_title,
      desc: S.current.plans_has_no_recreate_content,
      btnOkText: S.current.contiune,
      btnOkOnPress: () => Sheets.offersBottomSheet(
          NavigationService.instance.navigatorKey.currentContext!),
      btnCancelOnPress: () {},
    ).show();
  }

  static sureChangeCurrentTap(WidgetRef ref, int currentIndex) => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentState!.context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: S.current.dialog_sure_change_current_tap_title,
        desc: S.current.dialog_sure_change_current_tap_content,
        btnCancelText: S.current.cancel,
        btnCancelOnPress: () {},
        btnOkText: S.current.contiune,
        btnOkOnPress: () => saveOptions(ref),
      ).show();

  static sendingGptPleaseWait() => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentState!.context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: S.current.dialog_todos_generating_please_wait_title,
        desc: S.current.dialog_todos_generating_please_wait_content,
      ).show();

  static pleaseEndCurrentMeeting() => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentState!.context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: S.current.dialog_please_finish_current_meet_title,
        desc: S.current.dialog_please_finish_current_meet_content,
      ).show();

  static noRecognitionWordDialog(WidgetRef ref) => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentState!.context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: S.current.dialog_no_recognition_title,
        desc: S.current.dialog_no_recognition_content,
        btnOkText: S.current.contiune,
        btnOkOnPress: () => ref
            .read(currentMeetControllerManager.notifier)
            .controlMeetingManageButton(ref),
        btnCancelOnPress: () {},
      ).show();

  static meetContentNullStateThenFinishedApp(WidgetRef ref) => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentState!.context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: S.current.dialog_no_recognition_title,
        desc: S.current.dialog_no_recognition_content,
        btnOkText: S.current.contiune,
        // btnOkOnPress: () => NavigationService.instance.navigatePopUp(),
        // btnCancelOnPress: () {},
      ).show();

  static saveOptions(WidgetRef ref) => AwesomeDialog(
          context:
              NavigationService.instance.navigatorKey.currentState!.context,
          dialogType: DialogType.noHeader,
          animType: AnimType.bottomSlide,
          title: S.current.dialog_no_recognition_title,
          desc: S.current.dialog_no_recognition_content,
          body: SizedBox(
              width: 100.w, height: 30.h, child: const RecordOptions()))
      .show();

  static notFindAnyMeet(WidgetRef ref) => AwesomeDialog(
          context:
              NavigationService.instance.navigatorKey.currentState!.context,
          dialogType: DialogType.noHeader,
          animType: AnimType.bottomSlide,
          title: S.current.dialog_have_not_meet_title,
          desc: S.current.dialog_have_not_meet_content,
          body: SizedBox(
              width: 100.w, height: 30.h, child: const RecordOptions()))
      .show();

  static giveRateAboutMeet(WidgetRef ref) => AwesomeDialog(
      context: NavigationService.instance.navigatorKey.currentState!.context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      title: S.current.dialog_give_rate_about_meet_title,
      desc: S.current.dialog_give_rate_about_meet_content,
      body:  RatingBar.builder(
        initialRating: ref.read(currentMeetControllerManager)!.likeRate ?? 3,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: CustomColors.primaryColor,
        ),
        onRatingUpdate: (rating) {
          ref
              .read(currentMeetControllerManager.notifier)
              .giveRateToMeet(ref, rating);
        },
      ),).show();
}
