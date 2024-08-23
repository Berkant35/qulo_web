import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'global_providers.dart';

class DeadListManagerNotifier extends StateNotifier<List<String>> {
  DeadListManagerNotifier(List<String> state) : super([]);

  void addDeadListOfPad(String deviceId,WidgetRef ref) {
    List<String> currentList = state;
    currentList.add(deviceId);
    state = currentList;
    ref
        .read(bleScannerProv)
        .deleteDevices(state);
    clear();

  }
  void deleteFromDeadList(String deviceId) {
    List<String> currentList = state;
    currentList.remove(deviceId);
    state = currentList;
  }
  void clear(){
    state = [];
  }
}
