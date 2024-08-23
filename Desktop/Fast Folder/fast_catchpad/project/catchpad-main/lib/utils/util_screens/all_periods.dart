import 'dart:io';

import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_screens/pad_periods.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../models/bottom_bar_item.dart';

class AllPeriods extends ConsumerStatefulWidget {
  final bool selectableForm;

  const AllPeriods({
    super.key,
    this.selectableForm = false,
  });

  @override
  ConsumerState createState() => _AllPeriodsState();
}

class _AllPeriodsState extends ConsumerState<AllPeriods> {
  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(inst.profile_screen_saved_periods),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              if (ref
                  .read(currentDevicesManagerProvider.notifier)
                  .connectedDevice
                  .values
                  .isEmpty) {
                logger.i("There is no connected device!");
                CustomDialogs.failed(
                    ref,
                    inst.all_period_screen_any_connection_title,
                    inst.all_period_screen_any_connection_explain,
                    customTitle:
                        inst.activity_not_enough_devices_connect_to_pads,
                    pressOk: () {
                  ref
                      .read(bottomBarProvider.notifier)
                      .setBottomBarItem(BottomBarItemIndex.search.index, ref);

                  Navigator.of(context).pop();
                });
                return;
              }

              ref.read(currentPeriodColorQueueManager.notifier).changeState({});

              if (Platform.isIOS) {
                await Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ShowCaseWidget(
                                builder: Builder(
                                    builder: (context) => const PadPeriods()))))
                    .then((value) => setState(() {}));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowCaseWidget(
                          builder: Builder(
                              builder: (context) => const PadPeriods())),
                    )).then((value) => setState(() {}));
              }
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return Future.delayed(const Duration(seconds: 0));
        },
        child: FutureBuilder<List<String>>(
          future: ref
              .read(currentPeriodicallyQueueManager.notifier)
              .getAllPeriods(ref),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: efficientlyWidget(snapshot, index),
                        title: Text(snapshot.data[index]),
                        onTap: () async {
                          final List<DiscoveredDevice> currentConnectedDevice =
                              ref
                                  .read(currentDevicesManagerProvider.notifier)
                                  .connectedDevice
                                  .values
                                  .toList();

                          final perPeriod = await ref
                              .read(currentPeriodicallyQueueManager.notifier)
                              .getPerPeriod(ref, snapshot.data[index]);

                          bool currentConnectedCheck = true;
                          List<DiscoveredDevice> padPeriodList = [];
                          for (var briefInfo in perPeriod.devices!) {
                            final listIdsConnected = currentConnectedDevice
                                .map((e) => e.id)
                                .toList();
                            final perCheck =
                                listIdsConnected.contains(briefInfo.id);
                            if (!perCheck) {
                              currentConnectedCheck = false;
                              break;
                            }
                          }
                          if (!currentConnectedCheck) {
                            CustomDialogs.failed(
                                ref,
                                inst.all_period_screen_need_connection_dialog_title,
                                inst.all_period_screen_need_connection_dialog_content);
                            return;
                          }
                          int tempCounter = 0;
                          for (var periodPadInfo in perPeriod.devices!) {
                            padPeriodList.add(ref
                                .read(currentDevicesManagerProvider.notifier)
                                .connectedDevice[periodPadInfo.id]!);
                            ref
                                .read(currentPeriodColorQueueManager.notifier)
                                .add(ref,
                                    deviceId: periodPadInfo.id!,
                                    color: periodPadInfo.colorStr != null
                                        ? Color(int.parse(
                                                periodPadInfo.colorStr!
                                                    .replaceFirst('#', ''),
                                                radix: 16) |
                                            0xFF00000)
                                        : null,
                                    queue: tempCounter);
                            tempCounter++;
                          }

                          if (Platform.isIOS) {
                            await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ShowCaseWidget(
                                      builder: Builder(
                                          builder: (context) => PadPeriods(
                                                listOfDevice: padPeriodList,
                                                nameOfPeriod:
                                                    snapshot.data[index],
                                                updatePeriodStatus: true,
                                              ))),
                                ));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowCaseWidget(
                                      builder: Builder(
                                          builder: (context) => PadPeriods(
                                                listOfDevice: padPeriodList,
                                                nameOfPeriod:
                                                    snapshot.data[index],
                                                updatePeriodStatus: true,
                                              ))),
                                ));
                          }
                        },
                      );
                    },
                  )
                : const Center(child: SizedBox());
          },
        ),
      ),
    );
  }

  Widget efficientlyWidget(AsyncSnapshot<dynamic> snapshot, int index) {
    if (widget.selectableForm) {
      return Checkbox(
          value: (ref.read(currentPeriodicallyQueueManager).isNotEmpty &&
              ref.read(currentPeriodicallyQueueManager).keys.first.toString() ==
                  snapshot.data[index].toString()),
          onChanged: (val) async {
            if (val == true) {
              final List<DiscoveredDevice> currentConnectedDevice = ref
                  .read(currentDevicesManagerProvider.notifier)
                  .connectedDevice
                  .values
                  .toList();

              final perPeriod = await ref
                  .read(currentPeriodicallyQueueManager.notifier)
                  .getPerPeriod(ref, snapshot.data[index]);

              ref
                  .read(currentPeriodicallyQueueManager.notifier)
                  .changeCurrentPerPeriodList(perPeriod);

              bool currentConnectedCheck = true;
              List<DiscoveredDevice> padPeriodList = [];
              for (var briefInfo in perPeriod.devices!) {
                final listIdsConnected =
                    currentConnectedDevice.map((e) => e.id).toList();
                final perCheck = listIdsConnected.contains(briefInfo.id);
                if (!perCheck) {
                  currentConnectedCheck = false;
                  break;
                }
              }
              if (!currentConnectedCheck) {
                CustomDialogs.failed(
                    ref,
                    L10n.inst(context)
                        .all_period_screen_need_connection_dialog_title,
                    L10n.inst(context)
                        .all_period_screen_need_connection_dialog_content);
                return;
              }
              for (var periodPadInfo in perPeriod.devices!) {
                padPeriodList.add(ref
                    .read(currentDevicesManagerProvider.notifier)
                    .connectedDevice[periodPadInfo.id]!);
              }
              ref.read(currentPeriodicallyQueueManager.notifier).changState({
                snapshot.data[index]: padPeriodList.toList(),
              });

              logger.w(ref.read(currentPeriodicallyQueueManager).values.first);
              setState(() {});
            }
          });
    } else {
      return IconButton(
        onPressed: () async {
          await ref
              .read(currentPeriodicallyQueueManager.notifier)
              .delete(snapshot.data[index], ref)
              .then((value) {
            setState(() {});
          });
        },
        icon: const Icon(Icons.delete),
      );
    }
  }
}
