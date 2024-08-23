import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';

typedef PadErrorConfigList = Map<PadErrorTypes, bool>;

enum PadErrorTypes {
  unKnown,
  accInitError,
  dstInitError,

  ///No has battery or Over Powered
  noBatOrOvpError,
  lowBatVoltageError;

  static PadErrorTypes getTypeFromIndex(int indexValue) {
    switch (indexValue) {
      case 0:
        return PadErrorTypes.accInitError;
      case 1:
        return PadErrorTypes.dstInitError;
      case 2:
        return PadErrorTypes.noBatOrOvpError;
      case 3:
        return PadErrorTypes.lowBatVoltageError;
      default:
        return PadErrorTypes.unKnown;
    }
  }

  static bool checkIsError(String value) {
    if (value.trim() == '1') {
      return true;
    } else {
      return false;
    }
  }

  static PadErrorConfigList getAllPadErrorStatus(String errorMessage) {
    PadErrorConfigList padErrorConfigList = {};
    final splitList =
        errorMessage.replaceAll("[", "").replaceAll("]", "").split(",");



    for (int i = 0; i < splitList.length; i++) {
      var key = getTypeFromIndex(i);
      var value = checkIsError(splitList[i]);

      if (padErrorConfigList.containsKey(key) &&
          !padErrorConfigList[key]! &&
          value) {
        //Detected Unknown Error Log!
        padErrorConfigList.update(key, (value) => true);
      } else {
        padErrorConfigList.addAll({key: value});
      }
    }
    return padErrorConfigList;
  }
}
