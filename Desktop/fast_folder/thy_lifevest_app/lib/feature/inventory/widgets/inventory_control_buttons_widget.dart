import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/app_button/app_button.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/shared/app_loading_widget.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_state.dart';

/// Inventory kontrol butonları widget'ı
/// Start/Stop işlemlerini inventory_cubit'ten yapar
/// .cursorrules uyumlu: StatelessWidget, const constructor
class InventoryControlButtonsWidget extends StatelessWidget {
  const InventoryControlButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inventoryCubit = sl<InventoryCubit>();

    return BlocBuilder<InventoryCubit, InventoryState>(
      bloc: inventoryCubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: state.isInventoryRunning
              ? AppButton.filled(
                text: AppStrings.stopInventory,
                onTap: state.isLoading ? null : () => inventoryCubit.stop(),
              )
              : AppButton.filled(
                text: AppStrings.startInventory,
                onTap: state.isLoading ? null : () => inventoryCubit.start(),
              ),
        );
      },
    );
  }
}
