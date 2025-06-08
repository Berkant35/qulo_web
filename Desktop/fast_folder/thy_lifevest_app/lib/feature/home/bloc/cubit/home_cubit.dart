import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/preferences/i_pref.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/home/bloc/state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> saveBleDeviceNameAndIdToLocale({
    required String deviceName,
    required String deviceAddress,
  }) async {
    loadingInstance();
    await sl<BlePref>().saveBleDeviceName(deviceName);
    await sl<BlePref>().saveBleDeviceAddress(deviceAddress);
    idleInstance();
  }

  void loadingInstance() {
    emit(state.copyWith(status: UIStateStatus.loading));
  }

  void idleInstance() {
    emit(state.copyWith(status: UIStateStatus.idle));
  }
}
