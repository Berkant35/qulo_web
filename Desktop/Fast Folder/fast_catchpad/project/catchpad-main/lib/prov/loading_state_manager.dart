

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums/utility/loading_status.dart';



class LoadingStateManager extends StateNotifier<LoadingStates>{
  LoadingStateManager(LoadingStates state) : super(LoadingStates.loaded);

  changeState(LoadingStates value)
  {
    state = value;
  }

}
