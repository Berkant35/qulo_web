import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/app/custom_functions.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SubContent extends ConsumerStatefulWidget {
  const SubContent({
    super.key,
  });

  @override
  ConsumerState createState() => _SubContentState();
}

class _SubContentState extends ConsumerState<SubContent> {
  @override
  Widget build(BuildContext context) {
    final date = ref.watch(currentMeetControllerManager)?.createdDateTime!;

    final currentDate = DateTime.now();
    return Consumer(
      builder: (context, widgetRef, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            colInfo(
                CustomFunctions.getWeekdayFromInt(
                    date?.weekday ?? currentDate.weekday),
                (date ?? DateTime.now()).timeHour),
            Icon(
              Icons.access_alarm_outlined,
              color: CustomColors.greyColor,
              size: 3.h,
            ),
            colInfo(S.current.date, (date ?? DateTime.now()).ddMMyyyy),
          ],
        );
      },
    );
  }

  Widget colInfo(String title, String content) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: ThemeValueExtension.subtitle2
                .copyWith(color: CustomColors.textGreyColor),
          ),
          Text(content,
              style: ThemeValueExtension.subtitle.copyWith(
                color: CustomColors.fillBlackElevationColor,
              )),
        ],
      ),
    );
  }
}
