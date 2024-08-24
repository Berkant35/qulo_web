import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/components/fabs/done_fab.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListCard extends ConsumerWidget {
  final bool isDone;
  final bool showFab;
  final VoidCallback donePressed;
  final VoidCallback? onPressed;
  final String customTitle;
  final String subtitleText;
  final DateTime? date;

  const ListCard(
      {required this.isDone,
      required this.showFab,
      required this.donePressed,
      this.onPressed,
      required this.customTitle,
      required this.subtitleText,
      required this.date,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.75.w),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          color: CustomColors.fillWhiteColor,
          child: ListTile(
            leading: showFab ? DoneFab(
              isDone: isDone,
              onPressed: donePressed,
            ) : null,
            title: title(),
            isThreeLine: true,
            selectedColor: Colors.red,
            selectedTileColor: Colors.pink,
            subtitle: customSubTitle(),
          ),
        ),
      ),
    );
  }

  Text title() {
    return Text(
      customTitle,
      maxLines: 1,
      style: ThemeValueExtension.titleTextStyle,
      overflow: TextOverflow.ellipsis,
    );
  }

  SizedBox customSubTitle() {
    return SizedBox(
      height: 10.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          summarizeText(),
          dateRow(),
        ],
      ),
    );
  }

  Flexible summarizeText() {
    return Flexible(
      child: Text(
        subtitleText,
        style: ThemeValueExtension.highBody,
        maxLines: 2,
      ),
    );
  }

  Row dateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        perRow(Icons.calendar_month, date != null ? date!.dayDifference() : ""),
        perRow(Icons.access_time, date != null ? date!.timeHour : ""),
      ],
    );
  }

  Row perRow(IconData iconData, String text) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 2.h,
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(text)
      ],
    );
  }
}
