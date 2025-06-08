import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/gap_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/theme/app_box_decorations.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_state.dart';
import 'package:thy_lifevest_app/feature/inventory/widgets/inventory_filter_widget.dart';

/// Inventory durum bilgileri widget'ı
/// Tag sayısı, durum mesajı ve inventory durumunu gösterir
/// .cursorrules uyumlu: StatelessWidget, AppTextStyles, AppBoxDecorations, AppStrings, AppColors
class InventoryStatusWidget extends StatelessWidget {
  const InventoryStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inventoryCubit = sl<InventoryCubit>();

    return BlocBuilder<InventoryCubit, InventoryState>(
      bloc: inventoryCubit,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: AppBoxDecorations.elevatedCardDecoration,
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tag sayısı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppStrings.totalTags}:',
                    style: AppTextStyles.px14w600,
                  ),
                  Text('${state.totalTagCount}', style: AppTextStyles.px16w700),
                ],
              ),
              // Filter Tag sayısı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppStrings.filterTags}:',
                    style: AppTextStyles.px14w600,
                  ),
                  Text('${state.totalTagCount}', style: AppTextStyles.px16w700),
                ],
              ),
              // Durum mesajı varsa göster
              if (state.statusMessage != null) ...[
                context.gap8,
                Text(
                  state.statusMessage!,
                  style: AppTextStyles.px12w500,
                  textAlign: TextAlign.center,
                ),
              ],

             
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      state.isInventoryRunning
                          ? AppColors.success.withValues10
                          : AppColors.gray500.withValues10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  state.isInventoryRunning
                      ? AppStrings.running
                      : AppStrings.stopped,
                  style: AppTextStyles.px12w600.copyWith(
                    color:
                        state.isInventoryRunning
                            ? AppColors.success
                            : AppColors.gray500,
                  ),
                ),
              ),
              const InventoryFilterWidget(),
            ],
          ),
        );
      },
    );
  }
}
