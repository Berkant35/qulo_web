


import 'dart:async';

import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/beep_model.dart';
import '../ui/device/debug/dev_debug_options.dart';

class BuzzerManagerProvider extends StateNotifier<bool> {
  BuzzerManagerProvider(bool state) : super(false);

  var isSportModel = true;

  ///Kullanıcı eğer true olarak ayarlamışsa eğer herhangi bir pad'e vurulduğunda
  ///burdaki parametreye bakıp çalıp çalmayacağını kontrol eder.
  void changeBuzzerStatus(WidgetRef ref,{bool? customValue}){
    state = customValue ?? !state;
    if(state){

      debugPrint("Activated Buzzer!");
    }else{
      debugPrint("Deactivated Buzzer!");

    }
  }



  Future<void> getDeviceInfoAndUpdate(WidgetRef ref,String devId) async {
    PadManager.getDeviceInfo(devId, ref: ref).then((padManager) async {
      if (padManager!.variantId.toString() == "0") {
        isSportModel = true;
      }else{
        isSportModel = false;
      }
    });
  }



}