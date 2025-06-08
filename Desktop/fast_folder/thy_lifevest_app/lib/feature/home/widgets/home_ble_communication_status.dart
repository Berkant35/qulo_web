import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/context_extension.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/cubit/app_bluetooth_communication_cubit.dart';
import 'package:thy_lifevest_app/feature/bluetooth/bloc/state/app_bluetooth_communication_state.dart';

/// BLE Communication durumunu ve bilgilerini gösteren widget
class HomeBLECommunicationStatus extends StatelessWidget {
  const HomeBLECommunicationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AppBluetoothCommunicationCubit,
      AppBluetoothCommunicationState
    >(
      bloc: sl<AppBluetoothCommunicationCubit>(),
      builder: (context, commState) {
        // Communication initialize edilmemişse gizle
        if (!commState.isInitialized) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray200),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _HeaderWidget(commState: commState),
              SizedBox(height: context.space12),
              _StatusGridWidget(commState: commState),
              if (commState.hasReaderCharacteristics) ...[
                SizedBox(height: context.space16),
                _ReaderCharacteristicsWidget(commState: commState),
              ],
              if (commState.lastReceivedData.isNotEmpty) ...[
                SizedBox(height: context.space16),
                _LastDataWidget(commState: commState),
              ],
              if (commState.isReaderReady) ...[
                SizedBox(height: context.space16),
                _ActionButtonsWidget(),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key, required this.commState});

  final AppBluetoothCommunicationState commState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.bluetooth_connected,
          color: commState.isReaderReady ? AppColors.green : AppColors.warning,
          size: 24,
        ),
        SizedBox(width: context.space8W),
        Expanded(
          child: Text(
            commState.isReaderReady
                ? AppStrings.readerReady
                : AppStrings.communicationInitialized,
            style: AppTextStyles.px16w600,
          ),
        ),
        if (commState.connectedDevice != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              commState.connectedDevice!.advName ?? AppStrings.notFound,
              style: AppTextStyles.px12w600.copyWith(color: AppColors.primary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

class _StatusGridWidget extends StatelessWidget {
  const _StatusGridWidget({super.key, required this.commState});

  final AppBluetoothCommunicationState commState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatusItem(
            icon: Icons.search,
            title: AppStrings.characteristicsDiscovered,
            value: '${commState.availableCharacteristics.length}',
            isActive: commState.isDiscoveryComplete,
          ),
        ),
        SizedBox(width: context.space12W),
        Expanded(
          child: _StatusItem(
            icon: Icons.notifications_active,
            title: AppStrings.notificationsEnabled,
            value:
                '${commState.notificationStates.values.where((active) => active).length}',
            isActive: commState.hasActiveNotifications,
          ),
        ),
      ],
    );
  }
}

class _StatusItem extends StatelessWidget {
  const _StatusItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isActive,
  });

  final IconData icon;
  final String title;
  final String value;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? AppColors.green.withOpacity(0.1) : AppColors.gray100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? AppColors.green : AppColors.gray300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? AppColors.green : AppColors.gray500,
              ),
              SizedBox(width: context.space4W),
              Text(
                value,
                style: AppTextStyles.px16w700.copyWith(
                  color: isActive ? AppColors.green : AppColors.gray500,
                ),
              ),
            ],
          ),
          SizedBox(height: context.space4),
          Text(
            title,
            style: AppTextStyles.px12w500.copyWith(color: AppColors.gray600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ReaderCharacteristicsWidget extends StatelessWidget {
  const _ReaderCharacteristicsWidget({super.key, required this.commState});

  final AppBluetoothCommunicationState commState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Reader Characteristics',
          style: AppTextStyles.px14w600.copyWith(color: AppColors.gray700),
        ),
        SizedBox(height: context.space8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (commState.readerDataCharacteristic != null)
              _CharacteristicChip(title: 'Data', isAvailable: true),
            if (commState.readerControlCharacteristic != null)
              _CharacteristicChip(title: 'Control', isAvailable: true),
            if (commState.readerStatusCharacteristic != null)
              _CharacteristicChip(title: 'Status', isAvailable: true),
            if (commState.readerConfigCharacteristic != null)
              _CharacteristicChip(title: 'Config', isAvailable: true),
          ],
        ),
      ],
    );
  }
}

class _CharacteristicChip extends StatelessWidget {
  const _CharacteristicChip({
    super.key,
    required this.title,
    required this.isAvailable,
  });

  final String title;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            isAvailable
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.gray200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAvailable ? AppColors.primary : AppColors.gray400,
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.px12w500.copyWith(
          color: isAvailable ? AppColors.primary : AppColors.gray600,
        ),
      ),
    );
  }
}

class _LastDataWidget extends StatelessWidget {
  const _LastDataWidget({super.key, required this.commState});

  final AppBluetoothCommunicationState commState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.dataReceived,
          style: AppTextStyles.px14w600.copyWith(color: AppColors.gray700),
        ),
        SizedBox(height: context.space8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                commState.lastReceivedData.entries
                    .take(3) // Son 3 data'yı göster
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '${entry.key.substring(0, 8)}...: ${entry.value.take(8).join(', ')}${entry.value.length > 8 ? '...' : ''}',
                          style: AppTextStyles.px12w400.copyWith(
                            fontFamily: 'monospace',
                            color: AppColors.gray700,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

class _ActionButtonsWidget extends StatelessWidget {
  const _ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final communicationCubit = sl<AppBluetoothCommunicationCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Test Commands',
          style: AppTextStyles.px14w600.copyWith(color: AppColors.gray700),
        ),
        SizedBox(height: context.space8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Test command 1: Reader status sorgula
                  final success = await communicationCubit.sendReaderCommand([
                    0x01,
                    0x00,
                    0x01,
                  ]);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppStrings.commandSent)),
                    );
                  }
                },
                icon: const Icon(Icons.info_outline, size: 16),
                label: const Text('Status'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
            SizedBox(width: context.space8W),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Test command 2: Inventory başlat
                  final success = await communicationCubit.sendReaderCommand([
                    0x02,
                    0x01,
                    0x01,
                  ]);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppStrings.inventoryStarted)),
                    );
                  }
                },
                icon: const Icon(Icons.play_arrow, size: 16),
                label: const Text('Start'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.space8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              // Test data okuma
              final data = await communicationCubit.readFromCharacteristic(
                '6E400002-B5A3-F393-E0A9-E50E24DCCA9E',
              );
              if (data != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${AppStrings.dataReceived}: ${data.take(5).join(', ')}',
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.download, size: 16),
            label: const Text('Read Data'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gray500,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }
}
