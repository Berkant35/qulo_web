import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/init/injection_container.dart';
import 'package:thy_lifevest_app/core/shared/app_live_header.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_content_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/cubit/inventory_cubit.dart';
import 'package:thy_lifevest_app/feature/inventory/bloc/state/inventory_state.dart';
import 'package:thy_lifevest_app/feature/inventory/widgets/inventory_control_buttons_widget.dart';
import 'package:thy_lifevest_app/feature/inventory/widgets/inventory_status_widget.dart';
import 'package:thy_lifevest_app/feature/inventory/widgets/inventory_tag_list_widget.dart';
import 'package:thy_lifevest_app/ui_kit/responsive_scaffold.dart';

/// Inventory sayfası - sadece InventoryCubit kullanır
/// Clean Architecture prensiplerine uygun olarak reader'a direk erişmez
/// Widget'lar widgets/ klasöründe organize edilmiştir
class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void deactivate() {
    super.deactivate();
    sl<InventoryContentCubit>().stopPeriodicRequests();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryCubit = sl<InventoryCubit>();

    return BlocBuilder<InventoryCubit, InventoryState>(
      bloc: inventoryCubit,
      builder: (context, state) {
        return AppResponsiveScaffold(
          appBar: const AppLiveHeader(appHeaderName: AppStrings.inventory),
          isLoading: state.isLoading.isEquals(true),
          body: const Column(
            spacing: 16,
            children: [
              InventoryControlButtonsWidget(),
              InventoryStatusWidget(),
              Expanded(child: InventoryTagListWidget()),
            ],
          ),
        );
      },
    );
  }
}
