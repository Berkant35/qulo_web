import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/app_button/app_button.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/gap_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/shared/app_loading_widget.dart';
import 'package:thy_lifevest_app/core/theme/app_box_decorations.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_find_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_find_state.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';

class InventoryFindTag extends StatelessWidget {
  final LifevestTagModel? lifevestTagModel;

  const InventoryFindTag({super.key, this.lifevestTagModel});

  @override
  Widget build(BuildContext context) {
    final inventoryFindCubit = sl<InventoryFindCubit>();

    // Set the tag if provided
    if (lifevestTagModel != null && inventoryFindCubit.state.setTagModel == null) {
      inventoryFindCubit.setFindTag(lifevestTagModel!);
    }

    return BlocBuilder<InventoryFindCubit, InventoryFindState>(
      bloc: inventoryFindCubit,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: AppBoxDecorations.elevatedCardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(AppStrings.findAndRecordTag, style: AppTextStyles.px16w600),
             
              if (state.setTagModel != null) ...[const _SelectedTagWidget()],

            
              const _FindStatusWidget(),
          

              const _FindActionButtons(),
            ],
          ),
        );
      },
    );
  }
}

/// Widget showing the selected tag information
class _SelectedTagWidget extends StatelessWidget {
  const _SelectedTagWidget();

  @override
  Widget build(BuildContext context) {
    final cubit = sl<InventoryFindCubit>();
    return BlocBuilder<InventoryFindCubit, InventoryFindState>(
      bloc: cubit,
      builder: (context, state) {
        final tag = state.setTagModel!;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.thyPrimary.withValues10,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.thyPrimary.withValues30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.epcLabel, style: AppTextStyles.px12w600.copyWith(color: AppColors.thyPrimary)),
              context.gap4,
              Text(tag.epcHex, style: AppTextStyles.px14w500, maxLines: 2, overflow: TextOverflow.ellipsis),
              if (tag.eMfr != null) ...[
                context.gap8,
                Row(
                  children: [
                    Text("${AppStrings.mfrLabel}: ", style: AppTextStyles.px12w600),
                    Text(tag.eMfr!, style: AppTextStyles.px12w500),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Widget showing the current find status and progress
class _FindStatusWidget extends StatelessWidget {
  const _FindStatusWidget();

  @override
  Widget build(BuildContext context) {
    final cubit = sl<InventoryFindCubit>();
    return BlocBuilder<InventoryFindCubit, InventoryFindState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          children: [
            // Status text
            Text(
              _getStatusText(state.findStatus),
              style: AppTextStyles.px14w500.copyWith(color: _getStatusColor(state.findStatus)),
              textAlign: TextAlign.center,
            ),

            if (state.findStatus == InventoryFindStatus.searching) ...[
              context.gap12,
              const AppLoadingWidget(),
              context.gap8,
              Text("${state.searchDuration}s", style: AppTextStyles.px12w400.copyWith(color: AppColors.gray500)),
            ],

            if (state.isTargetFound) ...[
              context.gap12,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues10,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.success.withValues30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.signal_cellular_alt, color: AppColors.success, size: 20),
                    context.gap8W,
                    Text(
                      "Signal: ${state.signalStrength} dBm",
                      style: AppTextStyles.px12w600.copyWith(color: AppColors.success),
                    ),
                  ],
                ),
              ),
            ],

            if (state.findStatus == InventoryFindStatus.timeout) ...[
              context.gap12,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues10,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warning.withValues30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer_off, color: AppColors.warning, size: 20),
                    context.gap8W,
                    Text("Search timeout (30s)", style: AppTextStyles.px12w600.copyWith(color: AppColors.warning)),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  String _getStatusText(InventoryFindStatus status) {
    switch (status) {
      case InventoryFindStatus.idle:
        return AppStrings.readyToStartSearch;
      case InventoryFindStatus.searching:
        return AppStrings.searchingForTag;
      case InventoryFindStatus.found:
        return AppStrings.targetTagFound;
      case InventoryFindStatus.timeout:
        return AppStrings.searchTimeout;
      case InventoryFindStatus.error:
        return AppStrings.searchError;
    }
  }

  Color _getStatusColor(InventoryFindStatus status) {
    switch (status) {
      case InventoryFindStatus.idle:
        return AppColors.gray500;
      case InventoryFindStatus.searching:
        return AppColors.thyPrimary;
      case InventoryFindStatus.found:
        return AppColors.success;
      case InventoryFindStatus.timeout:
        return AppColors.warning;
      case InventoryFindStatus.error:
        return AppColors.red200;
    }
  }
}

/// Action buttons for find operations
class _FindActionButtons extends StatelessWidget {
  const _FindActionButtons();

  @override
  Widget build(BuildContext context) {
    final cubit = sl<InventoryFindCubit>();
    return BlocBuilder<InventoryFindCubit, InventoryFindState>(
      bloc: cubit,
      builder: (context, state) {
        final cubit = sl<InventoryFindCubit>();

        if (state.setTagModel == null) {
          return Text(AppStrings.noTagSelected, style: AppTextStyles.px14w500.copyWith(color: AppColors.gray500));
        }

        return Row(
          children: [
            // Start/Stop button
            Expanded(
              child:
                  state.findStatus == InventoryFindStatus.searching
                      ? AppButton.filled(
                        text: AppStrings.stopSearch,
                        backgroundColor: AppColors.red200,
                        onTap: () => cubit.stopSearch(),
                      )
                      : AppButton.filled(text: AppStrings.findTag, onTap: () => cubit.startSearch()),
            ),

            if (state.findStatus != InventoryFindStatus.searching) ...[
              context.gap12W,
              Expanded(child: AppButton.outline(text: AppStrings.clearTag, onTap: () => cubit.clearSelectedTag())),
            ],
          ],
        );
      },
    );
  }
}
