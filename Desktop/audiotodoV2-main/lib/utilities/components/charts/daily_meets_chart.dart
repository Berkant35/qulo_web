import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/models/meet/meet_model.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/time_frames.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';

class DailyMeetsChart extends ConsumerStatefulWidget {
  final TimeFrame timeFrame;

  const DailyMeetsChart({
    Key? key,
    required this.timeFrame,
  }) : super(key: key);

  @override
  _DailyMeetsChartState createState() => _DailyMeetsChartState();
}

class _DailyMeetsChartState extends ConsumerState<DailyMeetsChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h,),
        Text(
          widget.timeFrame == TimeFrame.last7Days
              ? S.current.last_7_days
              : S.current.last_30_days,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: CustomColors.fillBlackElevationColor,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 3.h,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.px, horizontal: 12.px),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.px),
              color: CustomColors.fillWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.accentColor.withOpacity(0.25),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: FutureBuilder<List<Meet>>(
              future:
                  ref.read(currentSelectMeetState.notifier).getMeetList(ref),
              builder: (context, snapshot) {
                int maxX = 0;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        const Icon(Icons.error),
                        Text(S.current.something_went_wrong),
                      ],
                    ),
                  );
                }

                final List<BarChartGroupData> showingBarGroups = [];
                int days = widget.timeFrame == TimeFrame.last7Days ? 7 : 30;

                for (int i = days - 1; i >= 0; i--) {
                  final double x = (days - 1 - i).toDouble();
                  final double y = snapshot.data!
                      .where((element) =>
                          element.createdDateTime!.day ==
                              DateTime.now().subtract(Duration(days: i)).day &&
                          element.createdDateTime!.isAfter(
                              DateTime.now().subtract(Duration(days: days))))
                      .length
                      .toDouble();
                  showingBarGroups
                      .add(BarChartGroupData(x: x.toInt(), barRods: [
                    BarChartRodData(
                      toY: y,
                      color: CustomColors.primaryColor,
                      width: 3.w,
                    ),
                  ]));
                }

                return BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      //when touch the bar change color
                      touchTooltipData: BarTouchTooltipData(
                        //color
                        getTooltipColor: (group) => CustomColors.vanillaIce,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            "${rod.toY.round()} ${S.current.meeting}",
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: CustomColors.fillWhiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            final day = DateTime.now().subtract(
                                Duration(days: (days - 1 - value.toInt())));
                            final dayLabel =
                                widget.timeFrame == TimeFrame.last7Days
                                    ? DateFormat.E().format(day)
                                    : (days - value.toInt()).toString();
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.25.h),
                              child: Text(
                                dayLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: CustomColors.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          interval: 1,
                          getTitlesWidget: (double value, TitleMeta meta) {

                            if (value >= 0) {
                              return Text(
                                value.toInt().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: CustomColors.grey2Color,
                                      fontWeight: FontWeight.bold,
                                    ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(
                            color: CustomColors.grey2Color, width: 1),
                      ),
                    ),
                    minY: 0,
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                      // Dikey çizgileri kaldırma
                      horizontalInterval: 1,
                      // Yatay çizgileri 0.5 aralıklarla çizme
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: CustomColors.grey2Color,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    barGroups: showingBarGroups,
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 2.5.h,
        ),
      ],
    );
  }
}
