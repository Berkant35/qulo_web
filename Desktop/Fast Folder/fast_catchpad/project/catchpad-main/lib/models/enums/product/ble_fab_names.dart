


enum BleFabNames {
  ONE,
  TWO,
  THREE,
  FOUR;

  String getModeString() {
    switch (this) {
      case BleFabNames.ONE:
        return "1 CatchPad";
      case BleFabNames.TWO:
        return "2 CatchPad";
      case BleFabNames.THREE:
        return "3 CatchPad";
      case BleFabNames.FOUR:
        return "4 CatchPad";
    }
  }

}