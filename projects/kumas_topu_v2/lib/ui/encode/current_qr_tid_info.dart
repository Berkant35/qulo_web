import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumas_topu/line/global_providers.dart';
import 'package:kumas_topu/models/barcode_info.dart';
import 'package:kumas_topu/ui/encode/select_standart.dart';
import 'package:kumas_topu/utilities/components/custom_elevated_button.dart';
import 'package:kumas_topu/utilities/components/dialogs.dart';
import 'package:kumas_topu/utilities/components/row_form_field.dart';
import 'package:kumas_topu/utilities/components/seperate_padding.dart';
import 'package:kumas_topu/utilities/constants/app/enums.dart';
import 'package:kumas_topu/utilities/constants/extension/context_extensions.dart';
import 'package:kumas_topu/utilities/init/navigation/navigation_constants.dart';
import 'package:kumas_topu/utilities/init/navigation/navigation_service.dart';
import 'package:kumas_topu/utilities/init/theme/custom_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utilities/components/appbars/title_app_bar.dart';

class CurrentQrTIDInfoPage extends ConsumerStatefulWidget {
  const CurrentQrTIDInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CurrentQrTIDInfoPageState();
}

class _CurrentQrTIDInfoPageState extends ConsumerState<CurrentQrTIDInfoPage> {
  late TextEditingController tidQrEditingController;
  late TextEditingController barcodeEditingController;
  final qrTidFormState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    barcodeModeOn(ref);

    tidQrEditingController = TextEditingController(
        text: ref.read(currentBarcodeInfoProvider).tid ?? "-");
    barcodeEditingController = TextEditingController(
        text: ref.read(currentBarcodeInfoProvider).barcodeInfo ?? "-");
  }

  @override
  void dispose() {
    super.dispose();
    tidQrEditingController.clear();
    barcodeEditingController.clear();

    tidQrEditingController.dispose();
    barcodeEditingController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        onTap: () {
          var standart = ref.read(currentBarcodeStandartProvider);
          standart = null;
          ref
              .read(currentBarcodeStandartProvider.notifier)
              .changeState(standart);

          ref.read(currentBarcodeInfoProvider.notifier).changeState(BarcodeInfo());



          NavigationService.instance
              .navigateToPageClear(path: NavigationConstants.mainPage);
        },
        label: "QR Kodlama",
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back, size: 4.h),
          onPressed: () {
            var standart = ref.read(currentBarcodeStandartProvider);
            standart = null;
            ref
                .read(currentBarcodeStandartProvider.notifier)
                .changeState(standart);

            ref.read(currentBarcodeInfoProvider.notifier).changeState(BarcodeInfo());


            NavigationService.instance
                .navigateToPageClear(path: NavigationConstants.mainPage);
          },
        ),
      ),
      body: Consumer(
        builder: (context, customref, child) {



          String initialBarcodeText =
              ref.watch(currentBarcodeInfoProvider).barcodeInfo ?? "-";
          String initialTidText =
              ref.read(currentBarcodeInfoProvider).tid ?? "-";

          int barcodeCursorPosition = barcodeEditingController.selection.baseOffset;
          int tidCursorPosition = tidQrEditingController.selection.baseOffset;

// Eğer bir karakter silindi ise ve silinen karakterin pozisyonu 3 ise,
// metinde 3. karakterin pozisyonuna gidilir.

          barcodeEditingController.text = initialBarcodeText;
          tidQrEditingController.text = initialTidText;

          TextSelection barcodeSelection = TextSelection.fromPosition(
              TextPosition(offset: barcodeCursorPosition));
          barcodeEditingController.selection = barcodeSelection;

          TextSelection tidSelection = TextSelection.fromPosition(
              TextPosition(offset: tidCursorPosition));
          tidQrEditingController.selection = tidSelection;

          return Form(
            key: qrTidFormState,
            child: Padding(
              padding: seperatePadding(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SelectStandart(),
                    const Divider(),
                    standartCheck(),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget standartCheck() {
    return (ref.watch(currentBarcodeStandartProvider)?.encodeName != '' &&
            ref.watch(currentBarcodeStandartProvider)?.encodeName != null)
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Barkod Numarası", style: ThemeValueExtension.headline6),
                  ref.read(loginButtonStateProvider) != LoadingStates.loading
                      ? IconButton(
                          onPressed: () {
                            ref
                                .read(viewModelStateProvider.notifier)
                                .getSerialNumber(ref)
                                .then((value) {
                              if (value != null) {
                                var barcodeProvider =
                                    ref.read(currentBarcodeInfoProvider);
                                barcodeProvider.barcodeInfo =
                                    value.data!.serialNumber.toString();
                                ref
                                    .watch(currentBarcodeInfoProvider.notifier)
                                    .changeState(barcodeProvider);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.add_box,
                            size: 5.h,
                          ))
                      : const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                ],
              ),
              RowFormField(
                headerName: "",
                verticalContentPadding: 0.h,
                prefixIcon: Icons.document_scanner,
                hintText: "Barcode Numarası",
                editingController: barcodeEditingController,
                custValidateFunction: (value) {
                  (ref.read(currentBarcodeInfoProvider).barcodeInfo != "" &&
                          ref.read(currentBarcodeInfoProvider).barcodeInfo !=
                              null &&
                          ref.read(currentBarcodeInfoProvider).barcodeInfo !=
                              "-")
                      ? null
                      : "Boş Bırakılamaz";
                  return null;
                },
                onChanged: (value) {
                  ref.read(currentBarcodeInfoProvider.notifier).changeState(ref
                      .read(currentBarcodeInfoProvider)
                      .copyWith(barcodeInfo: value));
                },
              ),
              anyBarcode()
                  ? Column(
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            "TID Numarası",
                            style: ThemeValueExtension.headline6,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        RowFormField(
                          headerName: "",
                          verticalContentPadding: 0.h,
                          prefixIcon: Icons.qr_code_scanner_rounded,
                          hintText: "Tid Numarası",
                          editingController: tidQrEditingController,
                          custValidateFunction: (value) {
                            (ref.read(currentBarcodeInfoProvider).tid != "" &&
                                    ref.read(currentBarcodeInfoProvider).tid !=
                                        null &&
                                    ref.read(currentBarcodeInfoProvider).tid !=
                                        "-")
                                ? value!.length != 24
                                    ? "Gerçersiz TID"
                                    : null
                                : "Boş Bırakılamaz";
                            return null;
                          },
                          onChanged: (value) {
                            ref
                                .read(currentBarcodeInfoProvider.notifier)
                                .changeState(ref
                                    .read(currentBarcodeInfoProvider)
                                    .copyWith(
                                        tid: tidQrEditingController.text));
                          },
                          onChangedEnd: () {},
                        ),
                      ],
                    )
                  : const SizedBox(),
              const Divider(),
              SizedBox(
                height: 4.h,
              ),
              buttons(),
            ],
          )
        : const SizedBox();
  }

  bool anyBarcode() {
    return (barcodeEditingController.text.isNotEmpty &&
        ref.watch(currentBarcodeInfoProvider).barcodeInfo != null &&
        ref.watch(currentBarcodeInfoProvider).barcodeInfo!.isNotEmpty);
  }

  Widget buttons() {
    return ref.watch(loginButtonStateProvider) != LoadingStates.loading
        ? Column(
            children: [
              Center(
                child: CustomElevatedButton(
                  onPressed: () {
                    ref
                        .read(currentTriggerModeProvider.notifier)
                        .nativeManager!
                        .scanBarcodeButton(ref);
                  },
                  inButtonText: "TARA",
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              ((ref.read(currentBarcodeInfoProvider).tid != null &&
                          ref
                              .read(currentBarcodeInfoProvider)
                              .tid!
                              .isNotEmpty && ref
                  .read(currentBarcodeInfoProvider)
                  .tid!.length == 24 && ref
                  .read(currentBarcodeInfoProvider)
                  .tid!.startsWith("E2") && ref
                  .read(currentBarcodeInfoProvider)
                  .tid!.isNotEmpty &&
                          ref.read(currentBarcodeInfoProvider).barcodeInfo !=
                              null) &&
                      ref.watch(currentBarcodeInfoProvider).barcodeInfo !=
                          "-" &&
                      ref.watch(currentBarcodeInfoProvider).barcodeInfo !=
                          null &&
                      ref
                              .watch(currentBarcodeInfoProvider)
                              .barcodeInfo!
                              .length >
                          1)
                  ? Center(
                      child: CustomElevatedButton(
                        onPressed: () {
                          qrTidFormState.currentState!.save();
                          if (qrTidFormState.currentState!.validate()) {
                            ref
                                .read(viewModelStateProvider.notifier)
                                .createEPCForMatch(ref)
                                .then((value) {
                              if (ref.read(currentBarcodeInfoProvider).epc !=
                                      null &&
                                  value != null) {
                                var barcodeInfo =
                                    ref.read(currentBarcodeInfoProvider);

                                ref
                                    .read(currentBarcodeInfoProvider.notifier)
                                    .changeState(barcodeInfo);

                                NavigationService.instance.navigateToPage(
                                    path: NavigationConstants.matchWithRFIDPage,
                                    data: {
                                      "controller": barcodeEditingController,
                                      "controller2": tidQrEditingController
                                    });
                              }
                            });
                          } else {
                            Dialogs.showFailed(
                                "Lütfen standart seçimini gerçekleştirin");
                          }
                        },
                        inButtonText: "RFID Eşleştirme",
                        primaryColor: CustomColors.darkPurpleColorM,
                      ),
                    )
                  : const Center(
                      child: SizedBox(),
                    ),
            ],
          )
        : Center(
            child: Text(
              "Epc oluşturuluyor...",
              style: ThemeValueExtension.subtitle,
            ),
          );
  }

  Future<void> barcodeModeOn(WidgetRef ref) async {
    ref
        .read(currentTriggerModeProvider.notifier)
        .nativeManager!
        .scanBarcode(ref, false);
  }
}
