import 'package:catchpad/prov/global_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/consts.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/l10n/l10n.dart';

class DottedChartWidget extends ConsumerWidget {
  const DottedChartWidget(
      {super.key,
        required this.tapCount,
        required this.averageDuration,
        required this.spots});

  final int tapCount;
  final List<FlSpot> spots;
  final double averageDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    return AspectRatio(
      aspectRatio: 1.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: ref.read(currentEmbModeManager) == 0
              ? LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )
              :  LinearGradient(
            colors: [
              CpColors.cpChineseBlack.withOpacity(0.15),
              CpColors.cpEerieBlack.withOpacity(0.15),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: defPaddingSize,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  ' + inst.game_ui_chart_left_title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(
                        tapCount: tapCount,
                        spots: spots,
                        maxY: /* timespans.toSet().length.toDouble() */ spots
                            .map((e) => e.y.toInt())
                            .toSet()
                            .length
                            .toDouble()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LineChart extends ConsumerWidget {
  const _LineChart(
      {required this.tapCount, required this.spots, required this.maxY});

  final int tapCount;
  final List<FlSpot> spots;
  final double maxY;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double maxValue = 0.0;
    double minValue = 0.0;
    for (var element in spots) {
      if (element.y > maxValue) {
        maxValue = element.y;
      }
    }
    for (var element in spots) {
      if (element.y < maxValue) {
        minValue = element.y;
      }
    }

    return LineChart(
      chartData(maxValue, minValue, ref: ref),
      chartRendererKey: UniqueKey(),
      curve: Curves.bounceIn,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData chartData(double maxY, double minY, {WidgetRef? ref}) {
    return LineChartData(
      lineTouchData: lineTouchData,
      gridData: gridData,
      titlesData: titlesData(maxY, ref: ref),
      borderData: borderData(ref: ref),
      lineBarsData: dotData(ref: ref),
      clipData:
      const FlClipData(top: true, bottom: false, left: false, right: false),
      minX: 0.5,
      maxX: tapCount.toDouble() + 0.45,
      maxY: maxY.toDouble() + 0.45,
      minY: 0,
    );
  }

  LineTouchData get lineTouchData => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData titlesData(double maxValue, {WidgetRef? ref}) {
    return FlTitlesData(
      bottomTitles: const AxisTitles(
        //sideTitles: bottomTitles,
        /* axisNameWidget: Text(
          '${instForGameScreen.activity_default_graph_tap_count} : $tapCount ',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
          ) */
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles(maxValue, ref: ref),
        /* axisNameWidget: Text(
            instForGameScreen.activity_default_scores_average_duration,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.5)),
          ), */
      ),
    );
  }

  List<LineChartBarData> dotData({WidgetRef? ref}) => [
    LineChartBarData(
      barWidth: 1,
      isStrokeCapRound: true,
      isStrokeJoinRound: true,
      color: ref?.read(currentEmbModeManager) == 1
          ? CpColors.cpPrimary
          : Colors.white,
      dotData: FlDotData(
        show: true,
        getDotPainter: (p0, p1, p2, p3) {
          if (spots.length > 1) {
            try {
              if (spots.every((spot) => spot.y <= p0.y)) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: ref?.read(currentEmbModeManager) == 0
                      ? Colors.red
                      : CpColors.cpPrimary,
                  strokeWidth: 1,
                  strokeColor: ref?.read(currentEmbModeManager) == 0
                      ? Colors.red
                      : CpColors.cpPrimary,
                );
              }
              if (spots.every((spot) => spot.y >= p0.y)) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: ref?.read(currentEmbModeManager) == 0
                      ? Colors.green
                      : CpColors.cpPrimary,
                  strokeWidth: 1,
                  strokeColor: ref?.read(currentEmbModeManager) == 0
                      ? Colors.green
                      : CpColors.cpPrimary,
                );
              }
            } catch (e) {
              return FlDotCirclePainter(
                radius: 3,
                color: ref?.read(currentEmbModeManager) == 0
                    ? Colors.white
                    : CpColors.cpPrimary,
                strokeWidth: 1,
                strokeColor: ref?.read(currentEmbModeManager) == 0
                    ? Colors.white
                    : CpColors.cpPrimary,
              );
            }
          }
          return FlDotCirclePainter(
            radius: 3,
            color: ref?.read(currentEmbModeManager) == 0
                ? Colors.white
                : CpColors.cpPrimary,
            strokeWidth: 1,
            strokeColor: ref?.read(currentEmbModeManager) == 0
                ? Colors.white
                : CpColors.cpPrimary,
          );
        },
      ),
      show: true,
      belowBarData: BarAreaData(show: false),
      spots: [...spots],
    ),
  ];

  Widget leftTitleWidgets(double value, TitleMeta meta, {WidgetRef? ref}) {
    TextStyle style = TextStyle(
      color: ref?.read(currentEmbModeManager) == 0
          ? const Color(0xff75729e)
          : Colors.white,
      fontWeight: ref?.read(currentEmbModeManager) == 0 ?  FontWeight.bold : FontWeight.w500,
      fontSize: ref?.read(currentEmbModeManager) == 0 ? 12 : 8,
    );

    final valText = value.toStringAsFixed(1);

    value = double.parse(valText);

    //6.4
    if (value > 5.8 && value < 6.4) {
      value = 6.4;
    }

    if (value > 5.2 && value < 5.8) {
      value = 5.8;
    }

    if (value > 2.4 && value < 2.8) {
      value = 2.7;
    }

    if (value > 1.59 && value < 1.61) {
      value = 1.6;
    }

    if (value < 1.1 && value > 0.8) {
      value = 1.0;
    }

    if (value < 0.81 && value > 0.61) {
      value = 0.8;
    }

    if (value < 0.61 && value > 0.41) {
      value = 0.6;
    }

    if (value < 0.41 && value > 0.20) {
      value = 0.4;
    }

    if (value < 0.21 && value > 0.09) {
      value = 0.2;
    }

    if (value < 0.01 && value > -0.01) {
      value = 0;
    }

    return Text(value.toString(), //spots.elementAt(value.toInt()).y.toString()
        style: style,
        textAlign: TextAlign.center);
  }

  SideTitles leftTitles(double maxValue, {WidgetRef? ref}) {
    final dividedValue = maxValue * 0.25;

    double max = 0.9;
    if (dividedValue > max) {
      max = dividedValue;
    }
    max = max.roundToDouble();
    final text = max.toStringAsExponential(3);
    final convertedMax = double.parse(text);
    return SideTitles(
      getTitlesWidget: (x, y) => leftTitleWidgets(x, y, ref: ref),
      showTitles: true,
      interval: maxValue <= 2 ? 0.2 : convertedMax,
      //reservedSize: 8.w,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, {WidgetRef? ref}) {
    TextStyle style = TextStyle(
      color: ref?.read(currentEmbModeManager) == 0
          ? const Color(0xff72719b)
          : Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    text = Text(/* value.toInt().toString() */ '',
        style: style, textAlign: TextAlign.center);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles bottomTitles({WidgetRef? ref}) {
    return SideTitles(
      showTitles: false,
      interval: 1,
      getTitlesWidget: (x, y) => bottomTitleWidgets(x, y, ref: ref),
    );
  }

  FlGridData get gridData =>
      const FlGridData(show: true, drawVerticalLine: true);

  FlBorderData borderData({WidgetRef? ref}) => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
          color: ref?.read(currentEmbModeManager) == 0
              ? const Color(0xff4e4965)
              : Colors.white,
          width: 4),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );
}