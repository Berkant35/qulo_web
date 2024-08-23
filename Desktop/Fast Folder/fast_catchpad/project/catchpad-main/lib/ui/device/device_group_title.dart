import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/prov/dialogs/show_case_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/home_screen.dart';
import 'package:catchpad/ui/widgets/buttons/cp_elevated_haptic.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';
import 'package:catchpad/utils/util_methods/util_methods.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/device/device_group_model.dart';
import '../../models/enums/utility/show_case_enum.dart';
import '../../models/feedback/traces/connections/connection_log.dart';
import '../../utils/cp_colors.dart';
import '../../utils/cp_icons.dart';
import '../../utils/l10n/l10n.dart';
import '../../utils/widgets/custom_dialogs.dart';

class DeviceGroupTitle extends ConsumerStatefulWidget {
  final DeviceGroupModel model;

  const DeviceGroupTitle(
    this.model, {
    super.key,
  });

  @override
  ConsumerState createState() => _DeviceGroupTitleState();
}

class _DeviceGroupTitleState extends ConsumerState<DeviceGroupTitle> {
  @override
  Widget build(BuildContext context) {
    final deviceConnector = ref.read(bleDeviceConnectorProv);
    final deviceLedState = ref.read(currentDevLedManager);
    return Container(
      color: CpColors.padGroupTitleColor,
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: widget.model.title == L10n.inst(context).connected_pods
              ? CustomShowCaseWidget(
                  showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                      (element) => element.key == Tips.connectedPads.name),
                  showCaseContentWidget: Text(
                      '${widget.model.title} (${widget.model.devices.length})'))
              : Text('${widget.model.title} (${widget.model.devices.length})'),
        ),
        contentPadding: EdgeInsets.zero,
        trailing: SizedBox(
          width: (isAdmin) ? 62.w : 55.w,
          child: Padding(
            padding: EdgeInsets.all(1.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // if (AppSettingsToggles.enableDeviceAdminOptions &&
                //     model.connected)
                //   IconButton(
                //     onPressed: () {
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => const DevDebugScreen(),
                //         ),
                //       );
                //     },
                //     icon: const Icon(Icons.settings),
                //   ),
                if (widget.model.connected) ...[
                  if (isAdmin)
                    CpElevatedHaptic(
                      icon: FontAwesomeIcons.powerOff,
                      onPressed: () async {
                        EasyLoading.show();
                        ref.read(bleScannerProv).pauseScan();
                        for (final dev in widget.model.devices) {
                          //await deviceConnector.disconnect(dev);
                          await PadManager.resetDevice(dev.id, ref: ref);
                        }
                        EasyLoading.dismiss();
                        ref.read(bleScannerProv).resumeScan();
                      },
                    ),
                  CustomShowCaseWidget(
                    showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                        (element) => element.key == Tips.sleepMode.name),
                    showCaseContentWidget: CpElevatedHaptic(
                      icon: Icons.bedtime_outlined,
                      onPressed: () {
                        if (!ref.context.mounted) return;

                        CustomDialogs.sureDialog(
                            ref,
                            L10n.inst(context)
                                .content_dialog_sure_tag_sleep_content,
                            pressOk: () {
                          final currentChargingStatus =
                              ref.read(currentChargingStatusManager);

                          ref
                              .read(currentDevicesManagerProvider)
                              .keys
                              .forEach((deviceId) async {
                            if (currentChargingStatus[deviceId] != null &&
                                !currentChargingStatus[deviceId]!) {
                              //ref.read(bleConPr.notifier).deleteFromId(deviceId);

                              ref
                                  .read(currentDeadListManager.notifier)
                                  .addDeadListOfPad(deviceId, ref);

                              ref.read(bleConPr.notifier).update(
                                  ref
                                      .read(currentDevicesManagerProvider
                                          .notifier)
                                      .connectedDevice[deviceId]!,
                                  DeviceConnectionState.disconnected);

                              if (ref
                                      .read(currentDevicesManagerProvider
                                          .notifier)
                                      .connectedDevice[deviceId] !=
                                  null) {
                                ref.read(bleConPr.notifier).update(
                                    ref
                                        .read(currentDevicesManagerProvider
                                            .notifier)
                                        .connectedDevice[deviceId]!,
                                    DeviceConnectionState.disconnected);
                              }

                              PadManager.sleepDevice(deviceId, ref: ref);

                              ref
                                  .read(currentBatteryOfPadsManager.notifier)
                                  .remove(ref, deviceId);
                            }
                          });
                          ref
                              .read(currentChargingStatusManager.notifier)
                              .clear();
                          ref
                              .read(currentBatteryOfPadsManager.notifier)
                              .clear();
                        });
                      },
                    ),
                  ),
                  CustomShowCaseWidget(
                    showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                        (element) => element.key == Tips.lightOnOff.name),
                    showCaseContentWidget: CpElevatedHaptic(
                      icon: deviceLedState['all']!
                          ? CpIcons.light
                          : CpIcons.lightOff,
                      onPressed: () {
                        ref
                            .read(currentDevLedManager.notifier)
                            .allOnOff(ref)
                            .then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  ),
                ],
                CustomShowCaseWidget(
                  showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                      (element) =>
                          element.key ==
                          (widget.model.title ==
                                  L10n.inst(context).connected_pods
                              ? Tips.disconnect.name
                              : Tips.connectToPads.name)),
                  showCaseContentWidget: CpElevatedHaptic(
                      onPressed: () async {
                        ref
                            .watch(connectingStateControlProv.notifier)
                            .changeState(true, ref);
                  
                        try {
                          ref.read(bleScannerProv).pauseScan();
                          for (final device in widget.model.devices) {
                            if (widget.model.connected) {
                              await deviceConnector.disconnect(device);
                              if (!ref.context.mounted) return;
                              ref
                                  .watch(connectingStateControlProv.notifier)
                                  .changeState(true, ref);
                              ref
                                  .watch(currentBatteryOfPadsManager.notifier)
                                  .remove(ref, device.id);
                            } else {
                              await deviceConnector.connect(device);
                              if (!ref.context.mounted) return;
                              ref
                                  .read(currentConnectionByCustomerManager
                                      .notifier)
                                  .addConnectionLog(
                                      ConnectionLog(
                                        lastConnectionTime: DateTime.now()
                                            .nowTimeTextddMMyyyyHHmm,
                                        macId: device.id,
                                      ),
                                      ref);
                              ref
                                  .watch(connectingStateControlProv.notifier)
                                  .changeState(true, ref);
                            }

                            ref.read(bleScannerProv).resumeScan();

                        
                            await Future.delayed(Duration(
                                milliseconds:
                                    StandartConfigs.getConnectionDelayTime));
                            if (!ref.context.mounted) return;
                          }
                        
                               await Future.delayed(Duration(
                                milliseconds:
                                    StandartConfigs.getConnectionLongDelayTime));
                          ref
                              .watch(connectingStateControlProv.notifier)
                              .changeState(false, ref);
                         



                        } catch (e) {
                          logger.d(e.toString());
                        }
                      },
                      icon: Icons.bluetooth),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
