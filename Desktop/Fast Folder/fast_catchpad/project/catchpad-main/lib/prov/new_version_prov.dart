


import 'package:flutter_riverpod/flutter_riverpod.dart';



class NewVersionManager extends StateNotifier<bool>{
  NewVersionManager(bool state) : super(false);

  changeState(bool value)
  {
    state = value;
  }

}