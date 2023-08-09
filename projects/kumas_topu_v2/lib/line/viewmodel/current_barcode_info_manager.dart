import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../models/barcode_info.dart';

class CurrentBarcodeInfoManager extends StateNotifier<BarcodeInfo>{
  CurrentBarcodeInfoManager(BarcodeInfo state) : super(BarcodeInfo());

  changeState(BarcodeInfo value)
  {
    debugPrint("Barcode Info -> ${value.barcodeInfo}");
    debugPrint("Filter TID -> ${value.tid.toString()}");
    state = value;
  }

}
