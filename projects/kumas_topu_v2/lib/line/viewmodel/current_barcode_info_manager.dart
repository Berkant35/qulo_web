import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumas_topu/utilities/components/dialogs.dart';

import '../../models/barcode_info.dart';

class CurrentBarcodeInfoManager extends StateNotifier<BarcodeInfo> {
  CurrentBarcodeInfoManager(BarcodeInfo state) : super(BarcodeInfo());

  changeState(BarcodeInfo value, WidgetRef? ref) {
    if (value.barcodeInfo == null && value.tid == null) {
      state = BarcodeInfo();
      return;
    }

    if (barcodeCondition(value) && (value.tid == null || value.tid!.isEmpty)) {
      state = value;
      return;
    } else if (!barcodeCondition(value) &&
        (value.tid == null || value.tid!.isEmpty)) {
      if (!(value.barcodeInfo!.length < 50)) {
        Dialogs.showFailed("Barcode Uzunluğu 50 Karakterden Fazla Olamaz");
        return;
      }

      if ((value.barcodeInfo!.startsWith('E2') && value.barcodeInfo!.length == 24)) {
        Dialogs.showFailed("Geçersiz Barcode");
        return;
      }

      return;
    }

    if (tidConditionIsOk(value)) {
      state = value;
      return;
    } else {
      debugPrint("Data Code: ${value.tid} Barcode: ${value.barcodeInfo}");

      if (value.tid!.toString().trim() ==
          value.barcodeInfo!.toString().trim()) {
        Dialogs.showFailed("Data Code ve Barcode Aynı Olamaz");
        return;
      }
      if (value.tid!.length != 24) {
        Dialogs.showFailed("Data Code 24 Karakter Olmalıdır");
        return;
      }
      if (!value.tid!.startsWith('E2')) {
        Dialogs.showFailed("Geçerli olmayan TID");
        return;
      }

      return;
    }
  }

  bool barcodeCondition(BarcodeInfo value) =>
      value.barcodeInfo != null &&
      value.barcodeInfo!.length < 50 &&
      (!value.barcodeInfo!.startsWith('E2') && value.barcodeInfo!.length != 24);

  bool updateTid(BarcodeInfo value) =>
      barcodeCondition(value) && (value.tid == null || value.tid!.isEmpty);

  bool tidConditionIsOk(BarcodeInfo value) =>
      barcodeCondition(value) &&
      (value.tid!.length == 24 &&
          value.tid!.startsWith('E2') &&
          value.tid! != value.barcodeInfo);
}
