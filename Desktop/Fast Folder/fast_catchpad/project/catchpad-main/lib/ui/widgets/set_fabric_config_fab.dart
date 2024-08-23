import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/auth/register_user.dart';
import '../../models/beep_model.dart';
import '../../models/enums/product/variants_type.dart';
import '../../models/enums/utility/loading_status.dart';
import '../../models/product/product.dart';
import '../device/debug/set_serial_numbers.dart';
import 'package:http/http.dart' as http;
class SetFabricConfigFab extends ConsumerStatefulWidget {
  const SetFabricConfigFab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SetFabricConfigFabState();
}

class _SetFabricConfigFabState extends ConsumerState<SetFabricConfigFab> {
  VariantsType? variantType = VariantsType.SPORT;
  Map<String, String> deviceIdValue = {};
  late TextEditingController textEditingController;
  bool customSerialNumber = false;
  int i = 1;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: "30");
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.import_export),
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (_) => buildAlertDialog(),
        );
      },
    );
  }

  AlertDialog buildAlertDialog() {
    return AlertDialog(
      title: const Text('Otomatik İsimlendirme'),
      content: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          Future<void> setAutoFabricSet() async {
            return ref
                .read(currentDevicesManagerProvider)
                .forEach((deviceId, value) async {
              await PadManager.setDeviceBleName(deviceId,
                      ref: ref,
                      name: deviceIdValue[deviceId] ?? "-1",
                      cpSN: "-1",
                      noTM: "-1",
                      variantId: variantType!.getModeNumber().toString(),
                      stickerId: "-1")
                  .then((value) async {
                ref
                    .read(currentDevicesManagerProvider.notifier)
                    .setName(deviceId, deviceIdValue[deviceId] ?? "-1", ref);

                //Default Config Set
                PadSensorManager.configAccSensor(
                  deviceId: deviceId,
                  ref: ref,
                  model: const AccConfigModel(
                    scale: ConfigScale.LIS2DH12_8g,
                    mode: ConfigMode.LIS2DH12_HR_12bit,
                    dataRate: DataRate.LIS2DH12_ODR_1kHz620_LP,
                    threshold: 50,
                    timeout: 5,
                  ),
                  intModel: const AccInterruptConfigModel(
                      scale: ConfigScale.LIS2DH12_8g,
                      mode: ConfigMode.LIS2DH12_HR_12bit,
                      dataRate: DataRate.LIS2DH12_ODR_1kHz620_LP,
                      threshold: 50,
                      timeout: 5,
                      duration: 4,
                      sleepEnable: true),
                );

                setState(() {});
              });

              final list = ref.read(bleConPr).keys;
              DeviceModel currentDevice =
                  list.firstWhere((element) => element.id == deviceId).copyWith(
                        name: deviceIdValue[deviceId],
                      );

              ref.read(bleScannerProv).updateDeviceInfo(currentDevice);
              ref
                  .read(bleConPr.notifier)
                  .update(currentDevice, DeviceConnectionState.connected);
            });
          }

          List<DropdownMenuItem<VariantsType>> variantsListDropDownMenu() {
            return VariantsType.values
                .map<DropdownMenuItem<VariantsType>>((VariantsType value) {
              return DropdownMenuItem<VariantsType>(
                value: value,
                child: Text(
                  value.getModeString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            }).toList();
          }

          void onChangedVariantDrop(VariantsType? value) {
            variantType = value!;
            setState(() {});
          }

          return SingleChildScrollView(
            child: InkWell(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  for (int i = 0;
                      i < ref.watch(currentDevicesManagerProvider).keys.length;
                      i++)
                    Text(ref
                            .watch(currentDevicesManagerProvider)[ref
                                .watch(currentDevicesManagerProvider)
                                .keys
                                .toList()[i]]!
                            .bleName ??
                        "Undefined"),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<VariantsType>(
                          value: variantType,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          hint: Text(variantType!.getModeString()),
                          isDense: false,
                          icon:
                              const Icon(Icons.arrow_drop_down_circle_outlined),
                          elevation: 0,
                          style: Theme.of(context).textTheme.titleMedium,
                          onChanged: onChangedVariantDrop,
                          items: variantsListDropDownMenu(),
                        ),
                      ),
                    ],
                  ),
                  ref.watch(currentLoadingManager) == LoadingStates.loaded
                      ? Column(
                          children: [
                            customSerialNumber
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () => setState(() {
                                                i++;
                                              }),
                                          icon: const Icon(Icons.add)),
                                      Text(i.toString()),
                                      IconButton(
                                          onPressed: () => setState(() {
                                                i--;
                                              }),
                                          icon: const Icon(Icons.remove)),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Checkbox(
                                      value: customSerialNumber,
                                      onChanged: (val) => setState(() {
                                            customSerialNumber = val!;
                                          })),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      ref
                                          .read(currentDevicesManagerProvider)
                                          .forEach((key, value) {
                                        deviceIdValue
                                            .addAll({key: "$i CatchPad"});
                                        i++;
                                        ref
                                            .read(currentDevicesManagerProvider
                                                .notifier)
                                            .setName(key, "$i CatchPad", ref);
                                        setState(() {});
                                      });
                                      ref
                                          .read(currentLoadingManager.notifier)
                                          .changeState(LoadingStates.loading);
                                      await setAutoFabricSet().then((value) {
                                        ref
                                            .read(
                                                currentLoadingManager.notifier)
                                            .changeState(LoadingStates.loaded);
                                      });
                                      setState(() {});
                                    },
                                    child: const Text("SORT AND SET FABRIC")),
                              ],
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                  ElevatedButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return const SetSerialNumbers();
                                  },
                                ),
                              )),
                      child: const Text("SERIAL CONFIG")),
                  TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        /*ref
                            .read(currentOtaLoadingManager.notifier)
                            .downloadFileWithHttpUrl()
                            .then((value) async {
                          ref
                              .read(currentDevicesManagerProvider)
                              .keys
                              .forEach((deviceId) {
                            ref
                                .read(currentOtaLoadingManager.notifier)
                                .addNewUpdateToDevice(deviceId, ref);
                          });
                        });*/




                           int sendCounter = 0;

                            http
                                .get(Uri.parse(
                                    "https://github.com/Berkant35/force/raw/main/201223_firmware.bin"))
                                .then((response) async {

                              List<int> byteList2 =
                                  response.bodyBytes.buffer.asUint8List();

                              ref
                                  .read(currentDevicesManagerProvider)
                                  .keys
                                  .forEach((deviceId) async {



                                List<int> perList = [];

                                for (int i = 0; i < byteList2.length; i) {
                                  bool exitFromLoop = true;

                                  while (exitFromLoop) {
                                    if (byteList2.length > i &&
                                        perList.length < 509) {
                                      perList.add(byteList2[i]);
                                      i++;
                                    } else {
                                      exitFromLoop = false;
                                      continue;
                                    }
                                  }

                                  Uint8List list = Uint8List.fromList(perList);

                                  try {
                                    if (!ref
                                        .watch(currentDevicesManagerProvider)
                                        .containsKey(deviceId))
                                    {
                                      i = byteList2.length + 1;
                                    } else {
                                      await PadManager.sendPart512(
                                        deviceId,
                                        byteList: list,
                                        ref: ref,
                                        withResponse: false,
                                      );
                                      //await Future.delayed(const Duration(milliseconds: 30));
                                      debugPrint("Index: $sendCounter");
                                    }
                                    perList.clear();
                                  } catch (e) {
                                    await PadManager.resetDevice(deviceId,
                                        ref: ref);
                                    throw Exception("$e sendPart512");
                                  }
                                }
                              });
                            });
                      },
                      child: const Text("START OTA")),
                  ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((deviceId) async {
                              if(ref
                                  .read(currentDevicesManagerProvider
                                  .notifier)
                                  .connectedDevice[deviceId] != null){
                                ref.read(bleConPr.notifier).update(
                                    ref
                                        .read(currentDevicesManagerProvider
                                        .notifier)
                                        .connectedDevice[deviceId]!,
                                    DeviceConnectionState.disconnected);
                              }

                          PadManager.sleepDevice(deviceId, ref: ref);
                        });

                        Navigator.of(context).pop();
                      },
                      child: const Text("SET ALL SLEEP")),
                  ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((deviceId) async {
                          if(ref
                              .read(currentDevicesManagerProvider
                              .notifier)
                              .connectedDevice[deviceId] != null){
                            ref.read(bleConPr.notifier).update(
                                ref
                                    .read(currentDevicesManagerProvider
                                    .notifier)
                                    .connectedDevice[deviceId]!,
                                DeviceConnectionState.disconnected);
                          }
                          PadManager.iCanSeeYouStillControl(deviceId, ref: ref, enableAttribute: false);
                        });

                        Navigator.of(context).pop();
                      },
                      child: const Text("Ping Pong OFF")),
                  ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((deviceId) async {
                          if(ref
                              .read(currentDevicesManagerProvider
                              .notifier)
                              .connectedDevice[deviceId] != null){
                            ref.read(bleConPr.notifier).update(
                                ref
                                    .read(currentDevicesManagerProvider
                                    .notifier)
                                    .connectedDevice[deviceId]!,
                                DeviceConnectionState.disconnected);
                          }

                          PadManager.iCanSeeYouStillControl(deviceId, ref: ref, enableAttribute: true);
                        });

                        Navigator.of(context).pop();
                      },
                      child: const Text("Ping Pong ON")),
                  ElevatedButton(
                      onPressed: () async {
                        ByteData byteData = await rootBundle
                            .load(SandboxMusic.sandboxMotorcyclePath);
                        Uint8List byteList2 = byteData.buffer.asUint8List();

                        logger.i("Size Of File:${byteList2.length}");

                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((deviceId) async {
                          List<int> perList = [];

                          for (int i = 0; i < byteList2.length; i) {
                            bool exitFromLoop = true;
                            while (exitFromLoop) {
                              if (byteList2.length > i &&
                                  perList.length < 509) {
                                perList.add(byteList2[i]);
                                i++;
                              } else {
                                exitFromLoop = false;
                              }
                            }

                            Uint8List list = Uint8List.fromList(perList);

                            try {
                              await Future.delayed(
                                  const Duration(milliseconds: 15));

                              var result = await PadManager.sendPartMusicFile(
                                deviceId,
                                byteList: list,
                                ref: ref,
                                withResponse: false,
                              );

                              logger.i("Transfer:$result");

                              perList.clear();
                            } catch (e) {
                              await PadManager.resetDevice(deviceId, ref: ref);
                              throw Exception("$e sendPart512");
                            }
                          }
                        });
                      },
                      child: const Text("Upload to All Pads")),
                  ElevatedButton(
                      onPressed: () async {
                        ByteData byteData = await rootBundle
                            .load(SandboxMusic.sandboxBipPath);
                        Uint8List byteList2 = byteData.buffer.asUint8List();

                        logger.i("Size Of File:${byteList2.length}");

                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((deviceId) async {
                          List<int> perList = [];

                          for (int i = 0; i < byteList2.length; i) {
                            bool exitFromLoop = true;
                            while (exitFromLoop) {
                              if (byteList2.length > i &&
                                  perList.length < 509) {
                                perList.add(byteList2[i]);
                                i++;
                              } else {
                                exitFromLoop = false;
                              }
                            }

                            Uint8List list = Uint8List.fromList(perList);

                            try {
                              await Future.delayed(
                                  const Duration(milliseconds: 15));

                              var result = await PadManager.sendPartMusicFile(
                                deviceId,
                                byteList: list,
                                ref: ref,
                                withResponse: false,
                              );

                              logger.i("Transfer:$result");

                              perList.clear();
                            } catch (e) {
                              await PadManager.resetDevice(deviceId, ref: ref);
                              throw Exception("$e sendPart512");
                            }
                          }
                        });
                      },
                      child: const Text("Upload to All AAC BİP")),
                  ElevatedButton(
                      onPressed: () async {
                        final futures = <Future>[];
                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((deviceId) async {
                          futures.add(PadManager.playMusic(deviceId, ref: ref));
                        });
                        Future.wait(futures);
                      },
                      child: const Text("Play")),
                  ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((element) {
                          PadManager.toggleDebug(element,
                              enable: false, ref: ref);
                        });
                      },
                      child: const Text("Debug Kapat")),
                  ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(currentDevicesManagerProvider)
                            .keys
                            .forEach((element) {
                          PadManager.toggleDebug(element,
                              enable: true, ref: ref);
                        });
                      },
                      child: const Text("Debug Aç")),
                  ElevatedButton(
                      onPressed: () async {
                        List<String> emailList = [];
                        List<String> fNameList = [];
                        List<String> lNameList = [];
                        List<String> phoneList = [];
                        List<String> dateList = [];
                        final list =
                            await FirebaseCollectionEnums.users.reference.get();
                        for (var perUser in list.docs) {
                          final registerUser = RegisterUser.fromJson(
                              perUser.data()! as Map<String, dynamic>);
                          if (registerUser.email != null) {
                            emailList.add(registerUser.email.toString());
                            fNameList.add(registerUser.fName.toString());
                            lNameList.add(registerUser.lName.toString());
                            phoneList.add(registerUser.phoneNum.toString());
                            dateList.add(registerUser.createdAt.toString());
                          }
                        }
                        logger.w(emailList);
                        logger.w(fNameList);
                        logger.w(lNameList);
                        logger.w(phoneList);
                        logger.w(dateList);
                      },
                      child: const Text("E posta")),
                  ElevatedButton(
                      onPressed: () async {
                        int matchCounter = 0;
                        int productCounter = 0;
                        final _productsRef =
                            FirebaseCollectionEnums.products.reference;
                        final _demoProductsRef =
                            FirebaseCollectionEnums.demo_products.reference;
                        final _products = await _productsRef.get();
                        final _usersRef =
                            FirebaseCollectionEnums.users.reference;
                        final _users = await _usersRef.get();
                        debugPrint("Product Count:" +
                            _products.docs.length.toString());
                        for (var perProductObject in _products.docs) {
                          Map<String, dynamic> perProductMap =
                              perProductObject.data()! as Map<String, dynamic>;
                          final product = Product.fromJson(perProductMap);

                          if (product.productId != null) {
                            productCounter++;
                          }

                          for (var perUserObject in _users.docs) {
                            Map<String, dynamic> perUserMap =
                                perUserObject.data()! as Map<String, dynamic>;

                            final _perUser = RegisterUser.fromJson(perUserMap);

                            final userNameAndSur = ((_perUser.fName ?? "") +
                                    (_perUser.lName ?? ""))
                                .replaceAll(" ", "")
                                .toLowerCase();

                            final productOwnerUserName =
                                (product.productOwnerUserName ?? "")
                                    .replaceAll(" ", "")
                                    .toLowerCase()
                                    .trim();

                            final userEmail = (_perUser.email!.toLowerCase());
                            //debugPrint("userNameAndSur:"+userNameAndSur);
                            //debugPrint("productOwnerUserName:"+productOwnerUserName);
                            //debugPrint("userEmail:"+userEmail);

                            if (((userNameAndSur == productOwnerUserName) ||
                                    (userEmail == productOwnerUserName ||
                                        product.productOwnerUserName ==
                                            _perUser.email!)) &&
                                product.productId != null) {
                              matchCounter++;

                              final updatedProduct = product.copyWith(
                                  productOwnerId: _perUser.uid);

                              _demoProductsRef
                                  .doc(updatedProduct.productId)
                                  .set(updatedProduct.toJson());
                            }
                          }
                        }
                        debugPrint("Match Count: ${matchCounter.toString()}");
                        debugPrint(
                            "Product Counter: ${productCounter.toString()}");
                      },
                      child: const Text("Get Products")),
                  TextButton(
                    onPressed: () => throw Exception(),
                    child: const Text("Throw Test Exception"),
                  )

                  /*ElevatedButton(
                      onPressed: () async {
                        await PadManager.resetDevice(
                            ref.read(currentDevicesManagerProvider).keys.first,
                            ref: ref);
                      },
                      child: const Text("Reset Device")),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*OTA BUTTONS
/*ElevatedButton(
                          onPressed: () async {
                            //https://raw.githubusercontent.com/fafiunal/OTAFiles/v0.1.1/GithubRepo/v1.2.bin

                            /*ref.read(currentOtaLoadingManager.notifier)
                                .downloadFileWithHttpUrl()
                                .then((value) {
                              ref.read(currentOtaLoadingManager.notifier)
                                  .addNewUpdateToDevice(ref
                                  .read(currentDevicesManagerProvider)
                                  .keys
                                  .first, ref);
                              ref.read(currentOtaLoadingManager.notifier)
                                  .startAllDeviceUpdate(ref);
                            });*/
                            //BU KOD GEÇİCİDİR...
                            http
                                .get(Uri.parse(
                                "https://github.com/fafiunal/OTAFiles/blob/main/GithubRepo/v0.1.1.bin?raw=true"))
                                .then((response) async {
                              List<int> byteList2 =
                              response.bodyBytes.buffer.asUint8List();

                              ref
                                  .read(currentDevicesManagerProvider)
                                  .keys
                                  .forEach((deviceId) async {
                                List<int> perList = [];

                                for (int i = 0; i < byteList2.length; i) {
                                  bool exitFromLoop = true;

                                  while (exitFromLoop) {
                                    if (byteList2.length > i && perList.length < 509) {
                                      perList.add(byteList2[i]);
                                      i++;
                                    } else {
                                      exitFromLoop = false;
                                      continue;
                                    }
                                  }
                                  // TODO NATIVE OLARAK DENE
                                  // TODO Uint32List olarak kullan
                                  // TODO 20 Byte olarak listele
                                  Uint8List list = Uint8List.fromList(perList);
                                  debugPrint(list.length.toString() + '<-listlength');
                                  debugPrint(list.toString() + '<-listlength string');
                                  try {
                                    await PadManager.sendPart512(deviceId,
                                        byteList: list, ref: ref, withResponse: false);

                                    perList.clear();

                                    debugPrint("Delay end up! $i");
                                  } catch (e) {
                                    throw Exception("$e sendPart512");
                                  }
                                }
                              });
                            });
                          },
                          child: const Text("START OTA"))*/*/

/*while (!ref
                                        .watch(
                                        currentDevicesManagerProvider)
                                        .containsKey(deviceId) &&
                                        Platform.isIOS) {
                                      logger.i(
                                          "Connection Breaked!.. Again connecting...");
                                      await Future.delayed(
                                          const Duration(milliseconds: 30));
}*/