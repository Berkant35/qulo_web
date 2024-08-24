import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../core/theme/custom_colors.dart';
import '../../../../../../generated/l10n.dart';

class RecordOptions extends ConsumerStatefulWidget {
  const RecordOptions({
    super.key,
  });

  @override
  ConsumerState createState() => _RecordOptionsState();
}

class _RecordOptionsState extends ConsumerState<RecordOptions> {
  @override
  Widget build(BuildContext context) {
    final firstEnter = ref.read(authManager)!.firstEnter;

    if (firstEnter != null && !firstEnter) Future(() => upload());

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
            child: Text(
              S.current.dialog_save_title,
              style: ThemeValueExtension.headline6.copyWith(
                  fontWeight: FontWeight.w900,
                  color: CustomColors.textGreyColor),
            ),
          ),
          buildDivider(),
          perOption(S.current.dialog_save_create, Icons.message, upload),
          buildDivider(),
          if(firstEnter != null && firstEnter)
          perOption(
              S.current.dialog_save_option_none,
              Icons.delete,
              () => Sheets.cancelCurrentMeeting(context, ref)
                  .then((value) => Navigator.of(context).pop())),
        ],
      ),
    );
  }

  upload() async => uploadToCloud().then((value) {
        NavigationService.instance.navigatePopUp();
      });

  Future<bool> uploadToCloud() async {
    await ref.read(currentRecorderControllerManager.notifier).stop(ref);

    await ref
        .read(currentMeetControllerManager.notifier)
        .reviewCurrentMeetingState(ref);

    return true;
  }

  Future<bool> terminate() async {
    return true;
  }

  Divider buildDivider() => Divider(
        endIndent: 7.w,
        indent: 7.w,
        color: CustomColors.grey2Color,
        thickness: 0.5,
      );

  Widget perOption(String content, IconData iconData, Function function) {
    return TextButton(
        onPressed: () => function(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Icon(
                  iconData,
                  size: 4.h,
                  color: CustomColors.accentColor,
                )),
            Expanded(
                flex: 8,
                child: Text(
                  content,
                  style: ThemeValueExtension.buttonTextStyle
                      .copyWith(color: CustomColors.fillBlackElevationColor),
                )),
          ],
        ));
  }
}
