import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_constant.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/navigation/navigation_constants.dart';
import 'package:thy_lifevest_app/core/navigation/navigation_service.dart';
import 'package:thy_lifevest_app/core/preferences/i_pref.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/auth/bloc/state/splash_state.dart';
import 'package:thy_lifevest_app/feature/auth/data/param/login_param.dart';
import 'package:thy_lifevest_app/feature/auth/data/repo/auth_repo.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());
  final repo = sl<AuthRepo>();
  final authPref = sl<AuthPref>();

  Future<void> init() async {
    onLoading();
    final loginDto = await repo.login(LoginParam(email: AppConstants.demoEmail, password: AppConstants.demoPassword));
    loginDto.fold(
      (failure) {
        emit(state.copyWith(status: UIStateStatus.error));
      },
      (data) {
        emit(state.copyWith(status: UIStateStatus.success));
        
        authPref.saveAccessToken((data.data?.accessToken).getValueOrDefault);
        NavigationService.instance.navigateToPageClear(path: NavigationConstants.homePage);
      },
    );
    onIdle();
  }

  void onLoading() {
    emit(state.copyWith(status: UIStateStatus.loading));
  }

  void onIdle() {
    emit(state.copyWith(status: UIStateStatus.idle));
  }
}
