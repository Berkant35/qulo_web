import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_cubit.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/state/app_bluetooth_state.dart';

class AppLiveBluetoothIcon extends StatelessWidget {
  const AppLiveBluetoothIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AppBluetoothCubit>();
    return BlocBuilder<AppBluetoothCubit, AppBluetoothState>(
      bloc: cubit,
      builder: (context, state) {
        return Icon(
          iconData(
            state.bleConnectionState ?? BluetoothConnectionState.disconnected,
          ),
          size: 24,
          color: getColor(
            state.bleConnectionState ?? BluetoothConnectionState.disconnected,
          ),
        );
      },
    );
  }

  /// Bluetooth durumuna göre renk döndürür
  Color getColor(BluetoothConnectionState connectionState) {
    if (connectionState.isEquals(BluetoothConnectionState.connected)) {
      return AppColors.green;
    } else {
      return AppColors.gray500;
    }
  }

  /// Bluetooth durumuna göre ikon döndürür
  IconData iconData(BluetoothConnectionState connectionState) {
    if (connectionState.isEquals(BluetoothConnectionState.connected)) {
      return Icons.bluetooth_connected;
    } else {
      return Icons.bluetooth_disabled;
    }
  }
}
