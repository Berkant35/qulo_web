import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:thy_lifevest_app/core/app_button/app_button.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/shared/app_live_header.dart';
import 'package:thy_lifevest_app/core/shared/app_loading_widget.dart';
import 'package:thy_lifevest_app/core/utils/enum/ui_status.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_cubit.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/state/app_bluetooth_state.dart';
import 'package:thy_lifevest_app/ui_kit/responsive_scaffold.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  final cubit = sl<AppBluetoothCubit>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit.startScanAndAddResults(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveScaffold(
      appBar: const AppLiveHeader(
        appHeaderName: AppStrings.bluetoothConnectionPage,
      ),
      isLoading: cubit.state.status.isEquals(UIStateStatus.loading),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.startScanAndAddResults(refresh: true);
        },
        backgroundColor: AppColors.gray500,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
      body: BlocBuilder<AppBluetoothCubit, AppBluetoothState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.discoveredScanResults.isEmpty &&
              FlutterBluePlus.isScanningNow == true) {
            return const AppLoadingWidget();
          }

          return Visibility(
            visible: state.connectedDevice.isNull,
            replacement: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        '${AppStrings.connectedDevice}: ${state.connectedDeviceName ?? AppStrings.noConnectedDevice}',
                        style: AppTextStyles.px14w600,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: AppButton.filled(
                        text: AppStrings.disconnect,
                        onTap: () {
                          cubit.loadingInstance();
                          cubit.disconnectDevice();
                          cubit.idleInstance();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 64),
              itemCount: state.discoveredScanResults.length,
              itemBuilder: (context, index) {
                final perDiscoverDevice = state.discoveredScanResults[index];
                return ListTile(
                  title: Text(
                    perDiscoverDevice.device.advName,
                    style: AppTextStyles.px12w400.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    perDiscoverDevice.device.remoteId.toString(),
                    style: AppTextStyles.px10w600,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.warning,
                    child: Text(
                      perDiscoverDevice.rssi.toString(),
                      style: AppTextStyles.px12w600.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  trailing: AppButton.filled(
                    width: 100,
                    height: 36,
                    onTap: () async {
                      cubit.loadingInstance();
                      await cubit.connectDevice(perDiscoverDevice);
                      cubit.idleInstance();
                    },
                    text: AppStrings.connect,
                    textStyle: AppTextStyles.px12w600.copyWith(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
