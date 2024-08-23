import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeoutRangeSetupWidget extends ConsumerStatefulWidget {
  final bool isRange;

  const TimeoutRangeSetupWidget({Key? key, required this.isRange})
      : super(key: key);

  @override
  ConsumerState createState() => _TimeoutRangeSetupWidgetState();
}

class _TimeoutRangeSetupWidgetState
    extends ConsumerState<TimeoutRangeSetupWidget> {
  double sliderValue = 0.5; // Örnek bir değer
  double rangeStartValue = 0.3; // Örnek bir değer
  double rangeEndValue = 0.7; // Örnek bir değer

  @override
  Widget build(BuildContext context) {
    return widget.isRange ? getSlider(): getRange() ;
  }

  Slider getSlider() {
    return Slider(
      thumbColor: Colors.white,
      activeColor: CpColors.cpPrimary,
      inactiveColor: CpColors.cpPlatinum,
      value: sliderValue,

      onChanged: (value) => onChanged(value),
      label: sliderValue.toString(),
      // Baloncukta gösterilecek değer
      divisions: 10, // Slider'ın bölümlerini belirtir
    );
  }

  RangeSlider getRange() {
    return RangeSlider(
      activeColor: CpColors.cpPrimary,
      inactiveColor: CpColors.cpPlatinum,

      values: RangeValues(rangeStartValue, rangeEndValue),
      onChanged: (values) => onRangeChanged(values),
      labels: RangeLabels(
        rangeStartValue.toString(),
        rangeEndValue.toString(),

      ),

      // Baloncukta gösterilecek değerler
      divisions: 10, // RangeSlider'ın bölümlerini belirtir
    );
  }

  void onChanged(double value) {
    setState(() {
      sliderValue = value;
    });
    // Diğer işlemleri burada yapabilirsiniz.
  }

  void onRangeChanged(RangeValues values) {
    setState(() {
      rangeStartValue = values.start;
      rangeEndValue = values.end;
    });
    // Diğer işlemleri burada yapabilirsiniz.
  }

  Widget _buildSliderLabel() {
    return Tooltip(
      message: 'Değer: ${sliderValue.toString()}',
      preferBelow: false,
      decoration: BoxDecoration(
        color: CpColors.cpPrimary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Text(
        sliderValue.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
