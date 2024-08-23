import 'package:flutter_riverpod/flutter_riverpod.dart';



///  [0] : Normal App
///  [1] : Iga App
class CurrentEmbModeControlNotifier extends StateNotifier<int> {
  CurrentEmbModeControlNotifier(int state) : super(0);

  void changState(int val) => state = val;
}
