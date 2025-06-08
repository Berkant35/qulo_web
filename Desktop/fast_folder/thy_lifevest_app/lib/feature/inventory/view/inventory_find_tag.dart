import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/app_button/app_button.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_find_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_find_state.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_state.dart';
import 'package:thy_lifevest_app/feature/inventory/data/model/lifevest_tag_model.dart';

class InventoryFindTag extends StatelessWidget {
  final LifevestTagModel? lifevestTagModel;

  const InventoryFindTag({super.key, this.lifevestTagModel});

  @override
  Widget build(BuildContext context) {
    final inventoryCubit = sl<InventoryCubit>();
    final inventoryFindCubit = sl<InventoryFindCubit>();
    return BlocBuilder<InventoryCubit, InventoryState>(
      bloc: inventoryCubit,
      builder: (context, state) {
        return BlocBuilder<InventoryFindCubit, InventoryFindState>(
          bloc: inventoryFindCubit,
          builder: (context, state) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  spacing: 12,
                  children: [
                    Text(AppStrings.findAndRecordTag, style: AppTextStyles.px14w600),
                    
                    const AppButton.filled(text: AppStrings.findTag),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
