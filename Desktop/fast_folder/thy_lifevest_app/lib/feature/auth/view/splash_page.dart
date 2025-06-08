import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/app_button/app_button.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/navigation/navigation_constants.dart';
import 'package:thy_lifevest_app/core/navigation/navigation_service.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/auth/bloc/cubit/splash_cubit.dart';
import 'package:thy_lifevest_app/feature/auth/bloc/state/splash_state.dart';
import 'package:thy_lifevest_app/ui_kit/responsive_scaffold.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final cubit = sl<SplashCubit>();
    await cubit.init();
   
  }

  @override
  Widget build(BuildContext context) {
    final cubit = sl<SplashCubit>();

    return BlocBuilder<SplashCubit, SplashState>(
      bloc: cubit,
      builder: (context, state) {
        return AppResponsiveScaffold(
          isLoading: cubit.state.status.isEquals(UIStateStatus.loading),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.splashPage),
                AppButton.text(
                  text: AppStrings.goToHome,
                  onTap: () {
                    NavigationService.instance.navigateToPage(path: NavigationConstants.homePage);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
