import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/models/enums/product/variants_type.dart';
import 'package:catchpad/models/product/product.dart';
import 'package:catchpad/models/product/product_group.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetSerialNumbers extends ConsumerStatefulWidget {
  const SetSerialNumbers({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SetSerialNumbersState();
}

class _SetSerialNumbersState extends ConsumerState<SetSerialNumbers> {
  Map<String, TextEditingController> editingControllerMap = {};
  late TextEditingController userNameController;
  late TextEditingController typeProductsController;
  final _db = FirebaseFirestore.instance;

  int lastSerialNumber = 0;

  @override
  void initState() {
    fillTextEditingController();
    super.initState();
    userNameController = TextEditingController();
    typeProductsController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    editingControllerMap.forEach((key, value) {
      value.dispose();
    });
    userNameController.dispose();
    typeProductsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("User Name"),
            TextFormField(
              controller: userNameController,
            ),
            const Text("Pad Group Type"),
            TextFormField(
              controller: typeProductsController,
            ),
            textFormFields(context),
            ElevatedButton(
                onPressed: () async {
                  //Set to pads of new serial numbers
                  editingControllerMap.forEach((key, value) async {
                    await Future.delayed(const Duration(milliseconds: 30));
                    await PadManager.setDeviceBleName(key,
                        ref: ref,
                        name: "-1",
                        cpSN: value.text,
                        noTM: int.parse(value.text.substring(6, 9)).toString(),
                        variantId: "-1",
                        stickerId: "-1");
                  });

                  //We will check to all serial number is setted.
                  bool checkAllSerialNumber = false;

                  //Wait to pads because sometimes may conflict datas on pad.
                  await Future.delayed(
                      const Duration(milliseconds: 1500), () {});

                  //We compare  fill text and pad infos for serials.
                  for (var curKey
                      in ref.read(currentDevicesManagerProvider).keys) {
                    await PadManager.getDeviceInfo(curKey, ref: ref)
                        .then((value) async {
                      await ref
                          .read(currentDevicesManagerProvider.notifier)
                          .setDevice(value!, curKey, ref);

                      if (value.cpId != editingControllerMap[curKey]!.text) {
                        logger.e("FAILED FOR $curKey");
                        checkAllSerialNumber = false;
                      } else {
                        logger.d("SUCCESS FOR $curKey");
                        checkAllSerialNumber = true;
                      }
                    });
                    if (!checkAllSerialNumber) {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.bottomSlide,
                          title: 'Failed!',
                          desc: 'This serial number not unique!',
                          btnOkOnPress: () => Navigator.of(context).pop());
                    }
                  } //1092300001

                  var collection = _db.collection("product_groups");
                  var referenceProductGroups = collection.doc();

                  var newProductGroupId = referenceProductGroups.id;
                  var newProductGroup =
                      ProductGroup(productGroupId: newProductGroupId);
                  //Update new products to firestore
                  if (checkAllSerialNumber) {
                    ref
                        .read(currentDevicesManagerProvider)
                        .forEach((key, value) async {

                      var newProduct = Product(
                          productId: value.macId,
                          isSaleStatus: false,
                          saleNo: "",
                          productOwnerUserName: userNameController.text,
                          productGroupId: newProductGroupId,
                          productGroupName: typeProductsController.text,
                          cpId: editingControllerMap[key]!.text,
                          stickerType: value.stickerType,
                          hwVersion: value.hwVersion,
                          swVersion: value.swVersion,
                          createdAt: DateTime.now().toString().substring(0, 18),
                          updatedAt: DateTime.now().toString().substring(0, 18),
                          variantId:
                              VariantsType.getName(int.parse(value.variantId!)),
                          bleName: value.bleName,
                          noTm: int.parse(
                              editingControllerMap[key]!.text.substring(6, 9)));

                      //Check before created any product cpId
                      var response = await _db
                          .collection("products")
                          .where("cpId", isEqualTo: value.cpId)
                          .get();

                      if (response.docs.isEmpty) {
                        //Not created before NİCE!.In that case CREATE!
                        await _db
                            .collection("products")
                            .doc(newProduct.productId)
                            .set(newProduct.toJson());

                        newProductGroup = newProductGroup.copyWith(
                          productGroupName: typeProductsController.text,
                          productGroupOwnerUserId: "",
                          productGroupOwnerUserName: userNameController.text,
                          productGroupProductIdList: [
                            ...newProductGroup.productGroupProductIdList ?? [],
                            newProduct.productId ?? "-"
                          ],
                          productMacIdList: [
                            ...newProductGroup.productMacIdList ?? [],
                            newProduct.productId ?? "-"
                          ],
                          productSerialNumberList: [
                            ...newProductGroup.productSerialNumberList ?? [],
                            editingControllerMap[key]!.text
                          ],
                        );

                        await collection
                            .doc(newProductGroup.productGroupId)
                            .set(newProductGroup.toJson());
                      } else {
                        //Oh come on!! who created before!
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.bottomSlide,
                            title: 'Failed!',
                            desc: 'This serial number not unique!',
                            btnOkOnPress: () => Navigator.of(context).pop());
                        checkAllSerialNumber = false;
                        return;
                      }
                    });

                    //Go next serial number update!
                    try {
                      _db
                          .collection("serial_config")
                          .doc(
                              "current_configs_${VariantsType.getName(int.parse(ref.read(currentDevicesManagerProvider).values.first.variantId!)).toLowerCase()}")
                          .update({
                        "auto_increment": lastSerialNumber,
                      }).then((value) => updateStatus(true));
                    } catch (e) {
                      checkAllSerialNumber = false;
                      updateStatus(true);
                      logger.e(e);
                    }
                  }

                  //Everything is ok or not!
                  if (!checkAllSerialNumber) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.bottomSlide,
                      title: 'Failed!',
                      desc: 'Something Went Wrong',
                      btnOkOnPress: () => Navigator.of(context).pop(),
                    ).show();
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.bottomSlide,
                      title: 'Success!',
                      desc: 'Good Job Well Played!',
                      btnOkOnPress: () => Navigator.of(context).pop(),
                    ).show();
                  }
                },
                child: const Text("SET SERIALS")),
            ElevatedButton(
                onPressed: getLastSerialAndSet,
                child: const Text("FILL INPUTS")),
            ElevatedButton(
                onPressed: () => AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      title: 'Are you sure you want to activate',
                      desc: 'Be sure your teammate in not action',
                      btnCancelOnPress: () => Navigator.of(context).pop(),
                      btnOkOnPress: () => updateStatus(true)
                          .then((value) => Navigator.of(context).pop()),
                    ).show(),
                child: const Text("SET ACTIVATE AUTO INCREMENT")),
          ],
        ),
      ),
    );
  }

  void getLastSerialAndSet() async {
    String path =
        "current_configs_${VariantsType.getName(int.parse(ref.read(currentDevicesManagerProvider).values.first.variantId!)).toLowerCase()}";

    var result = await _db.collection("serial_config").doc(path).get();
    int i = result.data()!['auto_increment'];
    bool availableForAutoIncrement = result.data()!['status'];

    if (availableForAutoIncrement) {
      await updateStatus(false);

      lastSerialNumber = i;

      //CP04

      /*editingControllerMap.forEach((key, value) {
        value.text = "${ref.read(currentDevicesManagerProvider)[key]!.variantId!}03230${i.toString().padLeft(3, '0')}-${ref
                .read(currentDevicesManagerProvider)[key]!
                .bleName!
                .substring(0, 3)
                .toString()
                .replaceAll("C", "")
                .trim()}";
        i++;
      });*/

      //CP05

      editingControllerMap.forEach((key, value) {
        value.text = "${ref.read(currentDevicesManagerProvider)[key]!.variantId!}0124${i.toString().padLeft(4, '0')}-${ref
            .read(currentDevicesManagerProvider)[key]!
            .bleName!
            .substring(0, 3)
            .toString()
            .replaceAll("C", "")
            .trim()}";
        i++;
      });

      lastSerialNumber = i++;
      setState(() {});
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'We Need Time!',
        desc: 'Service busy by another person',
      ).show();
    }
  }

  Future<void> updateStatus(bool value) async {
    await _db
        .collection("serial_config")
        .doc(
            "current_configs_${VariantsType.getName(int.parse(ref.read(currentDevicesManagerProvider).values.first.variantId!)).toLowerCase()}")
        .update({"status": value});
  }

  //All formfields
  SingleChildScrollView textFormFields(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: editingControllerMap.entries.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                customPrefix(e, context),
                contentFormField(e),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  //Per TextFormField
  Expanded contentFormField(MapEntry<String, TextEditingController> e) {
    return Expanded(
      flex: 8,
      child: TextFormField(
        controller: e.value,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Set Cp ID',
        ),
        maxLength: 25,
        onChanged: (val) {},
      ),
    );
  }

  //This widget help to person who sets of serial number  for which catchpad will set serial number.
  Expanded customPrefix(
      MapEntry<String, TextEditingController> e, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(ref.watch(currentDevicesManagerProvider)[e.key]!.bleName!),
    );
  }

  //When before initialize on ui we need to fill of text editing controller map.
  void fillTextEditingController() {
    var devices = ref.read(currentDevicesManagerProvider);

    for (var key in devices.keys) {
      editingControllerMap.addAll({key: TextEditingController()});
    }
  }
}
