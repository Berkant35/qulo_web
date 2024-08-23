import 'dart:convert';
import 'dart:io';

import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/utils/cp_icons.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

import '../../../utils/cp_colors.dart';

class DebugLogScreen extends ConsumerStatefulWidget {
  final DeviceModel device;

  const DebugLogScreen({
    required this.device,
    super.key,
  });

  @override
  ConsumerState createState() => _DebugLogScreenState();
}

class _DebugLogScreenState extends ConsumerState<DebugLogScreen> {
  ValueNotifier<bool> listenStatus = ValueNotifier(false);
  ValueNotifier<bool> padLedStatus = ValueNotifier(false);
  ValueNotifier<bool> vibrationStatus = ValueNotifier(false);
  ValueNotifier<bool> nfcStatus = ValueNotifier(false);
  ValueNotifier<List<String>> currentLogs = ValueNotifier([]);
  Map<String, String> dateLogs = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Logs"),
        actions: [
          ValueListenableBuilder(
              valueListenable: listenStatus,
              builder: (BuildContext context, bool listening, Widget? child) {
                return listenStatus.value
                    ? IconButton(
                        onPressed: () {
                          toggleFunc;
                          dateLogs.clear();
                          currentLogs.value.clear();
                          currentLogs.notifyListeners();
                          currentLogs.value.add("Restarted!");
                          dateLogs.addAll(
                              {"Restarted!": DateTime.now().nowTimeHHmmss});
                          toggleFunc;
                          if (!listenStatus.value) {}
                        },
                        icon: const Icon(Icons.delete),
                      )
                    : const SizedBox();
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: listenStatus,
                builder: (BuildContext context, bool listening, Widget? child) {
                  return ValueListenableBuilder(
                      valueListenable: padLedStatus,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return listening
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: restart,
                                        icon: Icon(
                                          padLedStatus.value
                                              ? CpIcons.light
                                              : CpIcons.lightOff,
                                          size: 32,
                                        ),
                                      ),
                                      const Text("Led")
                                    ],
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: vibrationStatus,
                                      builder: (BuildContext context,
                                          bool value, Widget? child) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: !vibrationStatus.value
                                                  ? () async {
                                                      vibrationStatus.value =
                                                          !vibrationStatus
                                                              .value;
                                                      vibrationStatus
                                                          .notifyListeners();

                                                      await PadManager
                                                              .toggleVibration(
                                                                  widget.device
                                                                      .id,
                                                                  ref: ref,
                                                                  vibrationOn:
                                                                      true)
                                                          .then((value) async {
                                                        await Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        50))
                                                            .then(
                                                                (value) async {
                                                          await PadManager
                                                              .toggleVibration(
                                                                  widget.device
                                                                      .id,
                                                                  ref: ref,
                                                                  vibrationOn:
                                                                      false);
                                                          vibrationStatus
                                                                  .value =
                                                              !vibrationStatus
                                                                  .value;
                                                          vibrationStatus
                                                              .notifyListeners();
                                                        });
                                                      });
                                                    }
                                                  : null,
                                              icon: Icon(
                                                Icons.waves,
                                                size: 32,
                                                color: vibrationStatus.value
                                                    ? CpMainColors.cpGreen
                                                    : Colors.white,
                                              ),
                                            ),
                                            const Text("Titreşim")
                                          ],
                                        );
                                      }),
                                  ValueListenableBuilder(
                                      valueListenable: nfcStatus,
                                      builder: (BuildContext context,
                                          bool value, Widget? child) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: !nfcStatus.value
                                                  ? () async {
                                                      nfcStatus.value =
                                                          !nfcStatus.value;
                                                      nfcStatus
                                                          .notifyListeners();

                                                      await PadManager
                                                              .toggleNfc(
                                                                  widget.device
                                                                      .id,
                                                                  ref: ref,
                                                                  nfcOn: true)
                                                          .then((value) async {
                                                        await Future.delayed(
                                                                const Duration(
                                                                    seconds: 1))
                                                            .then(
                                                                (value) async {
                                                          await PadManager
                                                              .toggleNfc(
                                                                  widget.device
                                                                      .id,
                                                                  ref: ref,
                                                                  nfcOn: false);
                                                          nfcStatus.value =
                                                              !nfcStatus.value;
                                                          nfcStatus
                                                              .notifyListeners();
                                                        });
                                                      });
                                                    }
                                                  : null,
                                              icon: Icon(
                                                Icons.nfc,
                                                size: 32,
                                                color: nfcStatus.value
                                                    ? CpMainColors.cpGreen
                                                    : Colors.white,
                                              ),
                                            ),
                                            const Text("Nfc")
                                          ],
                                        );
                                      }),
                                ],
                              )
                            : const SizedBox();
                      });
                }),
          ),
          Expanded(
            flex: 2,
            child: ValueListenableBuilder(
                valueListenable: listenStatus,
                builder: (BuildContext context, bool value, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: toggleFunc,
                        child: Text(listenStatus.value
                            ? 'Testi Sonlandır'
                            : 'Testi Başlat'),
                      ),
                      if (!listenStatus.value)
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              EasyLoading.show();
                              final Directory appDocumentsDir =
                                  await getTemporaryDirectory();

                              final String timestamp = DateTime.now()
                                  .toString()
                                  .replaceAll(" ", "")
                                  .trim();

                              final String fileName = '$timestamp.txt';

                              final file = await File(
                                      '${appDocumentsDir.path}/$fileName')
                                  .create(recursive: true);
                              final stringBuffer = StringBuffer();
                              for (int i = 0;
                                  i < currentLogs.value.length;
                                  i++) {
                                stringBuffer.write(
                                    "${i + 1}-)${currentLogs.value[i]}:::::${dateLogs[currentLogs.value[i]]!}\n");
                              }

                              List<int> bytes =
                                  utf8.encode(stringBuffer.toString());

                              await file
                                  .writeAsBytes(bytes)
                                  .whenComplete(() => logger.i("Completed!"));

                              final xFile = XFile(file.path);
                              EasyLoading.dismiss();
                              final result = await Share.shareXFiles([xFile]);

                              if (result.status == ShareResultStatus.success) {
                                debugPrint(
                                    'Thank you for sharing the picture!');
                              }
                            },
                            child: const Text("Paylaş"),
                          ),
                        ),
                    ],
                  );
                }),
          ),
          Expanded(
            flex: 5,
            child: StreamBuilder(
              stream:
                  PadManager.listenDebugLogsFromPad(widget.device.id, ref: ref),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null) return const SizedBox();
                final date = DateTime.now().nowTimeHHmmss;

                dateLogs.addAll({snapshot.data: date});
                currentLogs.value = [...currentLogs.value, snapshot.data];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ValueListenableBuilder(
                      valueListenable: listenStatus,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return ListView.builder(
                            itemCount: currentLogs.value.length,
                            reverse: false,
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${(currentLogs.value.length - index - 1) + 1})',
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 9,
                                          child: Text(
                                              currentLogs.value[
                                                      currentLogs.value.length -
                                                          index -
                                                          1]
                                                  .replaceAll(date, ""),
                                              overflow: TextOverflow.clip),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(dateLogs[currentLogs.value[
                                            currentLogs.value.length -
                                                index -
                                                1]]!),
                                      ))
                                ],
                              );
                            });
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void restart() {
    padLedStatus.value = !padLedStatus.value;
    if (padLedStatus.value) {
      PadManager.toggleLight(widget.device.id, ref: ref);
    } else {
      PadManager.ledOff(widget.device.id, ref: ref);
    }
  }

  void toggleFunc() {
    listenStatus.value = !listenStatus.value;
    listenStatus.notifyListeners();
    PadManager.toggleDebug(widget.device.id,
        enable: listenStatus.value, type: AdminMonitorType.ble, ref: ref);
  }
}
