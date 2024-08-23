import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/enums/utility/loading_status.dart';

typedef UpdateFilePercent = Map<String, double>;
typedef AllDeviceUploadingStates = Map<String, LoadingStates>;

class UpdateFilePercentNotifier extends StateNotifier<UpdateFilePercent> {
  UpdateFilePercentNotifier(UpdateFilePercent state) : super({});
  void addNewUpdateFilePercentStatus(String deviceId, WidgetRef ref) {
      state.addAll({deviceId: 0.0});
  }
  void updateFilePercentStatus(String deviceId, WidgetRef ref,double percentage)
  {
    state[deviceId] = percentage;
  }
}

class AllDeviceUploadingStatesNotifier extends StateNotifier<AllDeviceUploadingStates> {
  AllDeviceUploadingStatesNotifier(AllDeviceUploadingStates state) : super({});

  void changeState(AllDeviceUploadingStates value){
    state = value;
  }


  void addNewUpdateFilePercentStatus(String deviceId, WidgetRef ref) {
    state.addAll({deviceId: LoadingStates.loaded});
    AllDeviceUploadingStates value = state;
    changeState(value);
  }
  void updateStatus(String deviceId,LoadingStates loadingStates,WidgetRef ref)
  {
    state[deviceId] = loadingStates;
    AllDeviceUploadingStates value = state;
    changeState(value);
  }
}