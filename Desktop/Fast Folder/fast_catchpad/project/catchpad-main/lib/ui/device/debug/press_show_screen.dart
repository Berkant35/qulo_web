import 'dart:math';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

import '../../../utils/cp_colors.dart';

class PressShowScreen extends ConsumerStatefulWidget {
  final DeviceModel device;

  const PressShowScreen({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PressShowScreenState();
}

class _PressShowScreenState extends ConsumerState<PressShowScreen> {
  late TextEditingController controller = TextEditingController(text: "4");
  int tareValue = 0;
  int demoVal = 0;

  num calculateGres(double V_fsr) {
    const double coefficient = 153.18;
    const double exponent = 0.699;

    num gForce =
        pow((coefficient / (calculateFsrRes(V_fsr) / 1000.0)), (1 / exponent));

    return gForce == double.infinity ? 0 : gForce;
  }

  num calculateFsrRes(double V_fsr) {
    double fsrRes = 0;
    fsrRes = ((V_fsr * 4700) / 3300) / (1 - V_fsr / 3300);
    return fsrRes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            child: TextFormField(
                controller: controller,
                onChanged: (text) =>
                    controller.text = text.replaceAll(",", ".")),
          ),
          StreamBuilder(
            stream: PadManager.listenFSR(widget.device.id, ref: ref),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) return const Text("---");

              double valx = double.parse(snapshot.data);
              valx = valx - tareValue;
              if (valx < 0) valx = 0;
              if(kDebugMode) valx = valx + demoVal;
              //250 min
              //2000
              var manimuplatedVal = (
                  (calculateFsrRes(valx) * double.parse(controller.text)));

              if(manimuplatedVal.isNaN) manimuplatedVal = 0;
              if(manimuplatedVal.isInfinite) manimuplatedVal = maxValue();

              return Column(
                children: [
                  header(valx),
                  Gap(4.h),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(1.0, 1.0),
                    child: SpeedometerChart(
                      dimension: 300,
                      minValue: 250,
                      maxValue: maxValue(),
                      value: manimuplatedVal > maxValue()
                          ? maxValue()
                          : manimuplatedVal < 0
                              ? 0
                              : manimuplatedVal,
                      graphColor: const [
                        CpColors.red,
                        CpColors.cpPrimary,
                        CpColors.cpFrenchLime,
                      ],
                      minWidget: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..scale(1.0, 1.0),
                          child: const Text("Max 100")),
                      maxWidget: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..scale(1.0, 1.0),
                          child: const Text("Min 0")),
                      pointerColor: Colors.white,
                      // valueVisible: true,
                      // rangeVisible: true,
                    ),
                  ),
                  Gap(14.h),
                  ElevatedButton(
                      onPressed: () {
                        if (tareValue == 0) {
                          tareValue = valx.toInt();
                        } else {
                          tareValue = 0;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CpColors.cpPrimary,
                        backgroundColor: CpColors.cpChineseBlack,
                      ),
                      child: Text(
                        "Kalibrasyon",
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  Gap(14.h),
                  if(kDebugMode)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          demoVal = Random().nextInt(2000);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CpColors.cpPrimary,
                        backgroundColor: CpColors.cpChineseBlack,
                      ),
                      child: Text(
                        "Demo",
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  double maxValue() => 3500;

  Center header(double valx) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
            "G Force:  ${calculateGres(valx).toStringAsFixed(2)} x ${controller.text} = ${(calculateGres(valx) * double.parse(controller.text)).toStringAsFixed(2)}"),
        Text("FSR Res: ${calculateFsrRes(valx).toStringAsFixed(2)}")
      ],
    ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("FSR"),
      leading: IconButton(
        onPressed: () async {
          await PadManager.toggleFSR(widget.device.id, ref: ref, fsrOn: false);
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
