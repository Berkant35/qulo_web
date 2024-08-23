enum VariantsType {
  PRO,
  SPORT,
  EDU,
  EMB,
  GO;

  int getModeNumber() {
    switch (this) {
      case VariantsType.PRO:
        return 3;
      case VariantsType.SPORT:
        return 0;
      case VariantsType.EDU:
        return 1;
      case VariantsType.EMB:
        return 2;
      case VariantsType.GO:
        return 4;
    }
  }

  String getModeString() {
    switch (this) {
      case VariantsType.PRO:
        return "PRO";
      case VariantsType.SPORT:
        return "SPORT";
      case VariantsType.EDU:
        return "EDU";
      case VariantsType.EMB:
        return "EMB";
      case VariantsType.GO:
        return "GO";
    }
  }

  static String getName(int value){
    switch(value){
      case 0:
        return VariantsType.SPORT.name;
      case 1:
        return VariantsType.EDU.name;
      case 2:
        return VariantsType.EMB.name;
      case 3:
        return VariantsType.PRO.name;
      case 4:
        return VariantsType.GO.name;
      default:
        return VariantsType.SPORT.name;
    }
  }

}
