import 'package:catchpad/ui/game/widgets/in_game_score_widgets/game_leave_button_widget.dart';
import 'package:catchpad/ui/widgets/default_bg.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/enums/background_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Sandbox extends ConsumerStatefulWidget {
  const Sandbox({
    super.key,
  });

  @override
  ConsumerState createState() => _SandboxState();
}

class _SandboxState extends ConsumerState<Sandbox> {
  @override
  Widget build(BuildContext context) {
    return const PadPunch();
  }

  double height() => 100;
}

class PadPunch extends ConsumerStatefulWidget {
  const PadPunch({
    super.key,
  });

  @override
  ConsumerState createState() => _PadPunchState();
}

class _PadPunchState extends ConsumerState<PadPunch> {
  @override
  Widget build(BuildContext context) {
    return const Type1();
  }
}

class Type1 extends ConsumerStatefulWidget {
  const Type1({super.key});

  @override
  ConsumerState<Type1> createState() => _Type1State();
}

class _Type1State extends ConsumerState<Type1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _linearProgressAnimation;
  late Animation<double> _radialGaugeAnimation;
  late Duration _remainingDuration = const Duration(seconds: 4);

  @override
  void initState() {
    super.initState();

    // AnimationController 4 saniyelik bir süre boyunca animasyon yapacak şekilde ayarlanıyor.
    _controller = AnimationController(
      duration: _remainingDuration,
      vsync: this,
    );

    // Tween'ler ve animasyonlar.
    _linearProgressAnimation =
        Tween<double>(begin: 1, end: 0).animate(_controller);
    _radialGaugeAnimation =
        Tween<double>(begin: 76.5, end: 127).animate(_controller);

    // Animasyon sırasında geçen süreyi güncellemek için dinleyici ekleyin.
    _controller.addListener(() {
      setState(() {
        // Kalan süreyi hesaplayın ve güncelleyin.
        _remainingDuration = _controller.duration! * (1.0 - _controller.value);
      });
    });

    // Animasyonu başlat.
    _controller.forward();
  }

  @override
  void dispose() {
    // AnimationController'ı kapat.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultBg(
        backgroundEnum: BackgroundEnums.typeOneHalf,
        child: Column(
          children: [
            Expanded(flex: 2, child: _defaultHeader()),
            Expanded(flex: 4, child: _textsAndLinearHeaders()),
            Expanded(flex: 2, child: Container()),
            Expanded(flex: 6, child: _getRadialGauge()),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _getRadialGauge() {
    // AnimatedBuilder ile _radialGaugeAnimation'da değişikliklere yanıt veriyoruz.
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _radialGaugeAnimation,
          builder: (context, child) {
            return SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  startAngle: 180,
                  endAngle: 0,
                  radiusFactor: 1.2,
                  showLastLabel: true,
                  interval: 20,
                  minimum: 0,
                  maximum: 200,
                  majorTickStyle: const MajorTickStyle(length: 0, thickness: 0),
                  minorTickStyle: const MinorTickStyle(length: 0, thickness: 0),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: _radialGaugeAnimation.value,
                      // Animasyon değerini kullanarak barı güncelliyoruz.
                      width: 10,
                      gradient: const SweepGradient(
                        colors: [CpColors.cpProgressColor],
                        stops: [0.0],
                      ),
                    ),
                  ],
                  ticksPosition: ElementsPosition.outside,
                  labelsPosition: ElementsPosition.outside,
                ),
              ],
            );
          },
        ),
        AnimatedBuilder(
          animation: _radialGaugeAnimation,
          builder: (context, child) {
            // Animasyon değerini bir kez alın ve metni güncelleyerek metin dalgalanmasını azaltın.
            final currentValue = _radialGaugeAnimation.value;

            // Metni bir ondalık basamak ile sınırlayın.
            final displayValue = currentValue.toStringAsFixed(1);

            return Text(
              '$displayValue\nkg',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 25.sp,
                    letterSpacing: -0.6,
                  ),
              softWrap: false,
              textAlign: TextAlign.center,
            );
          },
        )
      ],
    );
  }

  Widget _textsAndLinearHeaders() {
    return AnimatedBuilder(
      animation: _linearProgressAnimation,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Right Leg Extension",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
            ),
            Text(
              "Test 1 of 1",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  letterSpacing: -0.6),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    minHeight: 3.h,
                    backgroundColor:
                        CpColors.linearProgressEmptyColor.withOpacity(0.8),
                    color: CpColors.cpProgressColor,
                    value: _linearProgressAnimation.value,
                    // Animation değerini kullanarak LinearProgressIndicator'ı güncelliyoruz.
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  // Kalan süreyi güncellenmiş olarak göster.
                  Text(
                    "${_remainingDuration.inSeconds} Seconds",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16.sp,
                          letterSpacing: -0.1,
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _defaultHeader() {
    return Align(
      alignment: Alignment.centerRight,
      child: GameLeaveButton(
        borderRadius: 12,
        backColor: Colors.white.withOpacity(0.05),
        customText: "Exit",
        customFontWeight: FontWeight.w800,
      ),
    );
  }
}
