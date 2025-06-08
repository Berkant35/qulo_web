import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/app_button/app_button.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_cubit.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/state/app_bluetooth_state.dart';
import 'package:thy_lifevest_app/feature/home/bloc/cubit/home_cubit.dart';
import 'package:thy_lifevest_app/feature/home/bloc/state/home_state.dart';

class HomeAutoConnect extends StatelessWidget {
  const HomeAutoConnect({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = sl<HomeCubit>();
    final appBluetoothCubit = sl<AppBluetoothCubit>();

    return BlocBuilder<AppBluetoothCubit, AppBluetoothState>(
      bloc: appBluetoothCubit,
      builder: (context, bleState) {
        // Eğer locale device yoksa widget'ı gösterme
        if (bleState.byLocaleDevice.isNull && bleState.connectedDevice.isNull) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          builder: (context, homeState) {
            return SizedBox(
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _ConnectionContentWidget(
                  bleState: bleState,
                  cubit: appBluetoothCubit,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ConnectionContentWidget extends StatelessWidget {
  const _ConnectionContentWidget({
    super.key,
    required this.bleState,
    required this.cubit,
  });

  final AppBluetoothState bleState;
  final AppBluetoothCubit cubit;

  @override
  Widget build(BuildContext context) {
    // Eğer bağlı cihaz varsa, bağlı durumu göster
    if (bleState.connectedDevice.isNotNull) {
      return _ConnectedDeviceContentWidget(bleState: bleState, cubit: cubit);
    }

    // Eğer locale device varsa, auto connect seçeneğini göster
    if (bleState.byLocaleDevice.isNotNull) {
      return _AutoConnectContentWidget(bleState: bleState, cubit: cubit);
    }

    return const SizedBox.shrink();
  }
}

class _ConnectedDeviceContentWidget extends StatelessWidget {
  const _ConnectedDeviceContentWidget({
    super.key,
    required this.bleState,
    required this.cubit,
  });

  final AppBluetoothState bleState;
  final AppBluetoothCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Text(
              '${AppStrings.connectedDevice}: ${bleState.connectedDeviceName ?? AppStrings.noConnectedDevice}',
              style: AppTextStyles.px14w600,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: AppButton.filled(
              text: AppStrings.disconnect,
              onTap: () {
                cubit.disconnectDevice();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AutoConnectContentWidget extends StatelessWidget {
  const _AutoConnectContentWidget({
    super.key,
    required this.bleState,
    required this.cubit,
  });

  final AppBluetoothState bleState;
  final AppBluetoothCubit cubit;

  @override
  Widget build(BuildContext context) {
    final isLoading = bleState.status.isLoading;
    final deviceName = bleState.byLocaleDeviceName.getValueOrDefault;

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.lastDeviceName, style: AppTextStyles.px14w600),
              Text(
                deviceName.isEmpty ? AppStrings.noDeviceSaved : deviceName,
                style: AppTextStyles.px12w400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: AppButton.filled(
            text: isLoading ? AppStrings.connecting : AppStrings.autoConnect,
            onTap:
                isLoading
                    ? null
                    : () {
                      cubit.connectToLocalDevice();
                    },
          ),
        ),
      ],
    );
  }
}
