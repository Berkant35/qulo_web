import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_state.dart';
import 'package:thy_lifevest_app/feature/inventory/widgets/inventory_tag_list_tile_widget.dart';

/// Inventory tag listesi widget'ı
/// Okunan tag'leri inventory_cubit'ten alır ve listeler
/// .cursorrules uyumlu: StatelessWidget, AppTextStyles, AppStrings, AppColors, Extension kullanımı
class InventoryTagListWidget extends StatelessWidget {
  const InventoryTagListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inventoryCubit = sl<InventoryCubit>();

    return BlocBuilder<InventoryCubit, InventoryState>(
      bloc: inventoryCubit,
      builder: (context, state) {
        final reversedTags = state.discoveredTags.reversed.toList();

        if (reversedTags.isEmpty) {
          return Center(
            child: Text(AppStrings.noTagsFound, style: AppTextStyles.px14w500.copyWith(color: AppColors.gray500)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: reversedTags.length,
          itemBuilder: (context, index) {
            final tag = reversedTags[index];
            final lifevestModel = state.lifevestTags[tag.epc.getValueOrDefault];
            final tagIndex = reversedTags.length - index;
            return InventoryTagListTileWidget(tag: tag, lifevestModel: lifevestModel, tagIndex: tagIndex);
          },
        );
      },
    );
  }
}
