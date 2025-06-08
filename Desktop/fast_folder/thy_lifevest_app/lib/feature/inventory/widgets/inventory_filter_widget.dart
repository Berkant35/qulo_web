import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/theme/app_box_decorations.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_content_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_content_state.dart';

class InventoryFilterWidget extends StatelessWidget {
  const InventoryFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final contentCubit = sl<InventoryContentCubit>();

    return BlocBuilder<InventoryContentCubit, InventoryContentState>(
      bloc: contentCubit,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: AppBoxDecorations.elevatedCardDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 4,
                children:
                    InventoryContentFilters.values
                        .map(
                          (filter) => Expanded(
                            child: _FilterRadioTile(
                              filter: filter,
                              isSelected: state.selectedFilter == filter,
                              onTap: () => contentCubit.setFilter(filter),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterRadioTile extends StatelessWidget {
  final InventoryContentFilters filter;
  final bool isSelected;

  final VoidCallback onTap;

  const _FilterRadioTile({required this.filter, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          constraints: const BoxConstraints(maxWidth: 120),
          decoration: BoxDecoration(
            color: isSelected ? _getFilterColor(filter).withValues10 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSelected ? _getFilterColor(filter) : AppColors.gray300, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<bool>(
                value: true,
                groupValue: isSelected,
                onChanged: (_) => onTap(),
                activeColor: _getFilterColor(filter),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              FittedBox(
                child: Text(
                  _getFilterLabel(filter),
                  style: AppTextStyles.px12w500.copyWith(
                    color: isSelected ? _getFilterColor(filter) : AppColors.gray600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFilterLabel(InventoryContentFilters filter) {
    switch (filter) {
      case InventoryContentFilters.all:
        return AppStrings.filterAll;
      case InventoryContentFilters.valid:
        return AppStrings.filterValid;
      case InventoryContentFilters.nearExpiry:
        return AppStrings.filterNearExpiry;
      case InventoryContentFilters.expired:
        return AppStrings.filterExpired;
      case InventoryContentFilters.pending:
        return AppStrings.filterPending;
    }
  }

  Color _getFilterColor(InventoryContentFilters filter) {
    switch (filter) {
      case InventoryContentFilters.all:
        return AppColors.primary;
      case InventoryContentFilters.valid:
        return AppColors.success;
      case InventoryContentFilters.nearExpiry:
        return AppColors.warning;
      case InventoryContentFilters.expired:
        return AppColors.red200;
      case InventoryContentFilters.pending:
        return AppColors.gray500;
    }
  }
}
