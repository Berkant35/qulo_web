import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../ui/game/setup_widgets/challenge_detail_setup.dart';
import '../cp_colors.dart';
import 'period_pad_color_selector.dart';

class PadPeriods extends ConsumerStatefulWidget {
  final List<DiscoveredDevice>? listOfDevice;
  final String? nameOfPeriod;
  final bool updatePeriodStatus;

  const PadPeriods({
    super.key,
    this.listOfDevice,
    this.nameOfPeriod,
    this.updatePeriodStatus = false,
  });

  @override
  ConsumerState createState() => _PadPeriodsState();
}

class _PadPeriodsState extends ConsumerState<PadPeriods> {
  final formkey = GlobalKey<FormState>();
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();
  final GlobalKey _five = GlobalKey();

  late TextEditingController? periodNameController;

  ValueNotifier<Map<String, DiscoveredDevice?>> selectedDevices =
      ValueNotifier({});

  @override
  void initState() {
    super.initState();

    showCase();
    periodNameController = TextEditingController(text: widget.nameOfPeriod);

    if (widget.listOfDevice != null) {
      selectedDevices.value.addAll({
        for (int i = 0; i < widget.listOfDevice!.length; i++)
          i.toString(): widget.listOfDevice![i]
      });
    }
  }

  Future<void> showCase() async {
    final pref = await SharedPreferences.getInstance();
    final showCaseStart = pref.get(PrefKeys.showCase) as bool?;
    if (showCaseStart == null || !showCaseStart) {
      showCaseIn(pref: pref);
    }
  }

  void showCaseIn({SharedPreferences? pref}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([_one, _two, _three, _four]);
      if (pref != null) {
        pref.setBool(PrefKeys.showCase, true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    periodNameController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final currentDevices = ref
        .read(currentDevicesManagerProvider.notifier)
        .connectedDevice
        .values
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(inst.period_set_queue_screen_app_bar_title),
        actions: [
          ValueListenableBuilder(
            valueListenable: selectedDevices,
            builder: (BuildContext context,
                Map<String, DiscoveredDevice?> value, Widget? child) {
              return IconButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      if (selectedDevices.value.isNotEmpty &&
                          selectedDevices.value.values
                              .where((element) => element == null)
                              .isEmpty) {
                        await ref
                            .read(currentPeriodicallyQueueManager.notifier)
                            .add(
                              selectedDevices.value.values.toList(),
                              periodNameController != null
                                  ? periodNameController!.text
                                  : "",
                              ref,
                            )
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        CustomDialogs.failed(
                            ref,
                            L10n.inst(context).period_can_not_be_empty_title,
                            L10n.inst(context).period_can_not_be_empty_explain);
                      }
                    }
                  },
                  icon: const Icon(Icons.save));
            },
          ),
          IconButton(
              onPressed: () => showCaseIn(),
              icon: const Icon(Icons.help_outline))
        ],
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          inst.period_set_queue_screen_period_name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Padding(
                        padding: context.padding.low,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText:
                                inst.period_set_queue_screen_period_name_enter,
                          ),
                          validator: (value) => value!.isNotEmpty
                              ? null
                              : inst.classes_screen_empty_field,
                          controller: periodNameController,
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(L10n.inst(context).connected_pods,
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Showcase(
                key: _three,
                description: inst.period_show_case_3,
                disableDefaultTargetGestures: true,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Center(
                      child: Row(
                        children: [
                          for (int i = 0; i < currentDevices.length; i++)
                            PerDraggableCatchPadIcon(
                                lbl: currentDevices[i].name.substring(
                                    0,
                                    currentDevices[i].name.substring(1, 2) !=
                                            " "
                                        ? 2
                                        : 2),deviceId: null,index: i.toString(),)
                        ],
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Expanded(
                      flex: 1, child: plusMinusField(currentDevices, context)),
                  Expanded(
                    flex: 3,
                    child:
                        ValueListenableBuilder<Map<String, DiscoveredDevice?>>(
                            valueListenable: selectedDevices,
                            builder: (context, value, _) {
                              return tempList(currentDevices);
                            }),
                  ),
                  Spacer(
                    flex: 3,
                    // child: SelectPadColorOnPeriod(
                    //   currentDiscoveredDevice:
                    //   selectedDevices.value.values.toList()[0],
                    //   index: 0,
                    //   selectedDevices: selectedDevices,
                    // ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tempList(List<DiscoveredDevice?> currentDevices) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
          /*onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }


            logger.i("Selected Device: ${selectedDevices.value[oldIndex.toString()]?.name}");
            logger.i("Selected Device: ${selectedDevices.value[newIndex.toString()]?.name}");

            selectedDevices.notifyListeners();
          },*/
          itemCount: selectedDevices.value.values.toList().length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    key: ValueKey(index),
                    margin: context.padding.low,
                    decoration: BoxDecoration(
                        color: CpColors.bgGC2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: MediaQuery.of(context).size.width * 0.12,
                              //Circle Decoration
                              decoration: BoxDecoration(
                                  color: CpColors.success,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width)),
                              child: Center(
                                  child: Text(
                                "${index + 1}",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ))),
                          Showcase(
                            key: index == 0 ? _four : GlobalKey(),
                            onBarrierClick: () {},
                            description: L10n.inst(context).period_show_case_4,
                            child: DragTarget(
                              onAccept: (data) async {
                                final namePad = data as String;
                                final discoveredDevice = currentDevices
                                    .toList()
                                    .firstWhere((element) {
                                  if (element == null) {
                                    return false;
                                  }
                                  return element.name.contains(namePad);
                                });

                                selectedDevices.value[(index).toString()] =
                                    discoveredDevice;
                                selectedDevices.notifyListeners();

                                await PadManager.toggleLight(
                                    discoveredDevice!.id,
                                    ref: ref);
                                await Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () => PadManager.ledOff(discoveredDevice.id,
                                        ref: ref));
                              },
                              builder: (BuildContext context,
                                  List<Object?> candidateData,
                                  List<dynamic> rejectedData) {
                                final discoveredDevice = selectedDevices
                                    .value.values
                                    .toList()[index];
                                return PerDraggableCatchPadIcon(
                                  lbl: discoveredDevice != null
                                      ? discoveredDevice.name.substring(
                                          0,
                                          discoveredDevice.name
                                                      .substring(1, 2) !=
                                                  " "
                                              ? 2
                                              : 2)
                                      : "-",
                                  deviceId: discoveredDevice?.id,
                                  index: index.toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
                SelectPadColorOnPeriod(
                  currentDiscoveredDevice:
                      selectedDevices.value.values.toList()[index],
                  index: index,
                  selectedDevices: selectedDevices,
                )
              ],
            );
          }),
    );
  }

  Padding plusMinusField(
      List<DiscoveredDevice> currentDevices, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(L10n.inst(context).period_set_queue_screen_number_of_pods,
              style: Theme.of(context).textTheme.headlineSmall),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Showcase(
                key: _two,
                disableDefaultTargetGestures: true,
                description: L10n.inst(context).period_show_case_2,
                child: IconButton(
                    onPressed: () {
                      selectedDevices.value.removeWhere((key, value) =>
                          key == selectedDevices.value.keys.last);

                      selectedDevices.notifyListeners();
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove)),
              ),
              ValueListenableBuilder(
                  valueListenable: selectedDevices,
                  builder: (context, value, _) =>
                      Text(selectedDevices.value.length.toString())),
              Showcase(
                disableDefaultTargetGestures: true,
                key: _one,
                description: L10n.inst(context).period_show_case_1,
                child: IconButton(
                    onPressed: () {
                      selectedDevices.value.addAll({
                        (selectedDevices.value.values.length).toString(): null
                      });
                      selectedDevices.notifyListeners();
                    },
                    icon: const Icon(Icons.add_circle_outline)),
              ),
            ],
          ),
        ].joinWidgetList((index) => const SizedBox(
              width: defPaddingSize,
            )),
      ),
    );
  }
}
