import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/catch_pad_icons.dart';
import 'package:catchpad/models/enums/utility/loading_status.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/sticker_match_provider.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../managers/sticker_manager.dart';
import '../../../models/game/player/player_model.dart';
import '../../../models/game/player/selected_player_model.dart';
import '../../../prov/game/selected_players_prov.dart';
import '../../../prov/global_providers.dart';
import '../../../utils/consts.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/l10n/l10n.dart';
import '../../widgets/buttons/cp_button_1.dart';
import '../../widgets/buttons/cp_button_2.dart';

class StickerSetup extends ConsumerWidget {
  const StickerSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    final SelectedPlayerModel? selectedPlayer =
        ref.watch(selectedGeneralPlayerProv);
    final Set<SelectedPlayerModel>? selectedPlayers =
        ref.watch(selectedPlayersProv);
    final stickers = ref.watch(stickerProvider);
    PlayerModel? player = selectedPlayer?.player;
    List<String> devices = [];
    List<String> deviceids = [];

    if (player != null) {
      for (var dev in player.devs) {
        devices.add(dev.deviceNameId!);
        deviceids.add(dev.id);
      }
    }

    if (selectedPlayers != null) {
      for (var player in selectedPlayers) {
        for (var dev in player.player.devs) {
          devices.add(dev.deviceNameId!);
        }
      }
    }

    return CpButtonWithIcon2(
        iconWidget: (stickers.stickers.values
                    .toSet()
                    .intersection(devices.toSet())
                    .length ==
                devices.length)
            ? const Icon(
                Icons.check,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
        onPressed: () {

          showGeneralDialog(
              context: context,
              pageBuilder: (BuildContext context, first, last) {
                return AssignStickerToDeviceDialog(
                    devices: devices, deviceids: deviceids);
              });
        },
        child: Text(inst.game_ui_set_stickers_with_devices));
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://catchpad.com/en/products');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class AssignStickerToDeviceDialog extends ConsumerStatefulWidget {
  const AssignStickerToDeviceDialog(
      {super.key, required this.devices, required this.deviceids});
  final List<String> devices;
  final List<String> deviceids;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignColorToMoveDialogState();
}

class _AssignColorToMoveDialogState
    extends ConsumerState<AssignStickerToDeviceDialog> {

  List<String> get devices => widget.devices.map((e) => e).toList();
  final listOfFutures = <Future>[];

  List<String> get deviceids => widget.deviceids.map((e) => e).toList();
  List<ScrollController> controllers = [];
  static final clr = SidesColorsColor(0, 0, 70);
  static final clr2 = SidesColorsColor(70, 0, 0);
  static final clr3 = SidesColorsColor(0, 70, 0);
  static final clr4 = SidesColorsColor(70, 70, 0);
  final mdl = SidesColorsModel.from100Colors(
    bl: clr2,
    br: clr3,
    tl: clr4,
    tr: clr,
  );
  Stream<String>? _stream;

  SidesColorsModel gameSuccessColor = SidesColorsModel.all(CpColors.green);

  @override
  void initState() {
    super.initState();

    Future(() {
      ref
          .read(currentLoadingManager.notifier)
          .changeState(LoadingStates.loaded);
    });

    for (var i = 0; i < devices.length; i++) {
      controllers.add(ScrollController(initialScrollOffset: 0));
    }

  }

  getId(String devicenameid) {
    return deviceids[devices.indexOf(devicenameid)];
  }

  getIndex(String devicenameid) {
    return devices.indexOf(devicenameid);
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final SelectedPlayerModel? selectedPlayer =
        ref.watch(selectedGeneralPlayerProv);
    final Set<SelectedPlayerModel>? selectedPlayers =
        ref.watch(selectedPlayersProv);
    final stickerprov = ref.watch(stickerProvider);
    final curgame = ref.watch(currentGameProv);
    final stickers =
        stickerprov.getStickerSet(curgame!.id, devices, context, ref);
    final stickerStoreMove = stickerprov.stickers.entries.toList();

    for (var mapstck in stickerStoreMove) {
      if (mapstck.value != null) {
        stickers.remove(mapstck.key);
      }
    }

    PlayerModel? player = selectedPlayer?.player;
    return Material(
        child: Consumer(
      builder: (context, consumerRef, child) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: ListView(
            key: UniqueKey(),
            padding: const EdgeInsets.only(top: defPaddingSize * 1.75),
            children: (player != null || selectedPlayers!.isNotEmpty)
                ? [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              for (var id in deviceids) {
                                PadManager.ledOffNoResponse(id, ref: ref);
                              }
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ],
                    ),
                    if (ref.watch(currentLoadingManager) ==
                        LoadingStates.loaded)
                      ...devices.map((device) {
                        final index = devices.indexOf(device);
                        bool visibility = true;
                        String? assignedSticker;
                        try {
                          assignedSticker = stickerprov.stickers.entries
                              .firstWhere((element) => element.value == device)
                              .key;
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                        if (assignedSticker != null) {
                          visibility = false;
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defPaddingSize),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: defPaddingSize),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          CatchPadIcons.cpCircle,
                                          color: CpColors.defTextColor,
                                          size: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              ?.fontSize,
                                        ),
                                        Text(
                                          device,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                  color: CpColors.defTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (assignedSticker != null)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Card(
                                          elevation: 9,
                                          color:
                                              CpColors.green.withOpacity(0.4),
                                          child: InkWell(
                                            onTap: () {
                                              ref
                                                  .read(
                                                      stickerProvider.notifier)
                                                  .removeStickerFromDevice(
                                                      assignedSticker!, ref);
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(assignedSticker)),
                                          )),
                                    )
                                ],
                              ),
                              Visibility(
                                key: UniqueKey(),
                                visible: visibility,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Scrollbar(
                                    key: UniqueKey(),
                                    thumbVisibility: ref.read(currentLoadingManager) == LoadingStates.loaded ? true : false,
                                    trackVisibility: true,
                                    interactive: false,
                                    controller: controllers[index],
                                    child: ListView.builder(
                                      key: UniqueKey(),
                                      itemCount: stickers.length,
                                      itemBuilder: (context, index) {
                                        final sticker = stickers[index];
                                        return perChips(context, sticker, consumerRef,
                                            device, visibility);
                                      },
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      controller: controllers[index],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    Text(
                      inst.color_warning_description,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer(
                          builder: (context, buttonRef, child) {
                            final loading =
                                buttonRef.watch(currentLoadingManager);

                            return loading != LoadingStates.loading
                                ? CpButton1(
                                    onPressed: () async {
                                      for (var id in deviceids) {
                                        await PadManager.ledOffNoResponse(id,
                                            ref: ref);
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Text(inst.save))
                                : const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                          },
                        )
                      ],
                    )
                  ].joinWidgetList(
                    (index) => const SizedBox(
                      height: defPaddingSize * 2,
                    ),
                  )
                : [
                    Center(
                      child: Text(inst.color_warning),
                    )
                  ]),
      ),
    ));
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://catchpad.com/en/products');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  SizedBox perChips(BuildContext context, String? sticker, WidgetRef ref,
      String device, bool visibility) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Card(
          elevation: 9,
          color: CpColors.bottomBarColor,
          child: InkWell(
            onTap: () async {
              bool startGameConditions = true;
              String showDesc = "";
              final deviceId = getId(devices[getIndex(device)]);
              final tempDev =
                  ref.watch(currentDevicesManagerProvider)[deviceId];

              debugPrint(tempDev!.variantId);
              startGameConditions =
                  tempDev.variantId == "1" || tempDev.variantId == "3" || tempDev.variantId == "-1";

              if (!startGameConditions) {
                showDesc = L10n.inst(context).unsupported_sticker_content_desc;
                logger.w("Start Game Condition Not Okey");
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.bottomSlide,
                  title: L10n.inst(context).unsupported_content,
                  desc: showDesc,
                  btnOkOnPress: _launchUrl,
                  btnOkText: L10n.inst(context).go_store_for_buy,
                  btnCancelOnPress: () {},
                ).show();
                return;
              }

              PadManager.ledColorNoResponse(deviceId, mdl, ref: ref);

              ref
                  .read(currentLoadingManager.notifier)
                  .changeState(LoadingStates.loading);

              final devInfo = ref
                  .read(currentDevicesManagerProvider)
                  .values
                  .toList()
                  .firstWhere((devInfo) {
                return (devInfo.deviceId == deviceId);
              });

              final res = await uploadMusicFile(
                  sticker, ref, device, devInfo.hwVersion != "v2.0");
              if (res) {
                ref
                    .read(stickerProvider.notifier)
                    .setStickerToDevice(sticker, device);
              }

              ref
                  .read(currentLoadingManager.notifier)
                  .changeState(LoadingStates.loaded);
              PadManager.ledOffNoResponse(deviceId, ref: ref);
              setState(() {
                visibility = false;
              });
            },
            child:
                Container(alignment: Alignment.center, child: Text(sticker!)),
          )),
    );
  }

  Future<bool> uploadMusicFile(
      String? sticker, WidgetRef ref, String device, bool isCP04) async {
    //delete music file
    const deleteByte = [1];
    String? path =
        StickerManager.idToStickerAudioSoundPath(val: sticker!, ref: ref);

    ref
        .read(currentAudioProvManager.notifier)
        .setPathOfAudioOnPad(getId(device), "sticker");

    ByteData byteData = await rootBundle.load(path!);

    Uint8List byteList2 = byteData.buffer.asUint8List();



    bool successUpload = isCP04;

    _stream = PadManager.listenToResponseForUploadMusicFile(
        getId(devices[getIndex(device)]),
        ref: ref);

    if (_stream == null) return false;

    final subscribe = _stream!.listen((event) {
      if (event.contains("/") && event.split("/").first == "OK") {
        final infoList = event.split("/");
        final sendData509PackageCount = int.parse(infoList[1]);
        final lastDataByteLen = int.parse(infoList[2]);

        successUpload =
            ((sendData509PackageCount - 1) * 509 + lastDataByteLen ==
                    byteList2.length) &&
                !isCP04;
        logger.i("Last Split: ${event.split("/").first}");

      } else if (event.toString() == "OK" && isCP04) {
        successUpload = true;
      }
    });

    PadManager.sendPartMusicFile(
      getId(devices[getIndex(device)]),
      byteList: deleteByte,
      ref: ref,
      withResponse: false,
    );

    List<int> perList = [];

    logger.i("---- Device: $device Sticker: $sticker Path:$path ----");
    //int counter = 0;
    for (int i = 0; i < byteList2.length; i) {
      bool exitFromLoop = true;
      /* counter++;

      if(counter>5)
      {
        break;
      }*/

      while (exitFromLoop) {
        if (byteList2.length > i && perList.length < 509) {
          perList.add(byteList2[i]);
          i++;
        } else {
          exitFromLoop = false;
        }
      }

      Uint8List list = Uint8List.fromList(perList);

      try {
        await Future.delayed(const Duration(milliseconds: 30));
        await PadManager.sendPartMusicFile(
          getId(devices[getIndex(device)]),
          byteList: list,
          ref: ref,
          withResponse: false,
        );

        if (list.length < 509) {
          ref
              .read(currentAudioProvManager.notifier)
              .setPathOfAudioOnPad(getId(device), path);

          logger.i("Finished bip.mp3 uploading!");
        }
        perList.clear();
      } catch (e) {
        throw Exception("$e sendPart512");
      }
    }
    logger.i("Finished!!!!1");
    final startPointMs = DateTime.now().millisecondsSinceEpoch;
    int tempMs = startPointMs;
    bool wait = true;

    while (wait && !isCP04) {
      await Future.delayed(const Duration(milliseconds: 5));
      tempMs = DateTime.now().millisecondsSinceEpoch;
      if (tempMs - startPointMs > 15000) {
        wait = false;
      }
      if (successUpload) {
        wait = false;
      }
    }

    subscribe.cancel();
    return successUpload;
  }
}
