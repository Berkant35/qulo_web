import 'package:flutter/material.dart';

import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/extension/gap_extension.dart';
import 'package:thy_lifevest_app/core/navigation/navigation_constants.dart';
import 'package:thy_lifevest_app/core/navigation/navigation_service.dart';
import 'package:thy_lifevest_app/feature/home/widgets/home_auto_connect.dart';
import 'package:thy_lifevest_app/feature/home/widgets/home_header_widget.dart';
import 'package:thy_lifevest_app/feature/home/widgets/menu_card_widget.dart';
import 'package:thy_lifevest_app/ui_kit/responsive_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppResponsiveScaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          const HomeHeaderWidget(),
          context.gap24,
          const HomeAutoConnect(),
          Expanded(child: _MenuGridWidget()),
        ],
      ),
    );
  }
}

class _MenuGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          MenuCardWidget(
            title: 'Bluetooth Connection',
            description: 'Connect to RFID reader',
            icon: Icons.bluetooth,
            iconColor: AppColors.blue,
            onTap: () => _navigateToPage(NavigationConstants.bluetoothPage),
          ),
          MenuCardWidget(
            title: 'RFID Settings',
            description: 'RFID reader configuration',
            icon: Icons.settings_remote,
            iconColor: AppColors.green,
            onTap: () => _navigateToPage(NavigationConstants.rfidSettingsPage),
          ),
          MenuCardWidget(
            title: 'Inventory Operations',
            description: 'Lifevest inventory management',
            icon: Icons.inventory_2,
            iconColor: AppColors.thyPrimary,
            onTap: () => _navigateToPage(NavigationConstants.inventoryPage),
          ),
          MenuCardWidget(
            title: 'Reports',
            description: 'View inventory reports',
            icon: Icons.analytics,
            iconColor: AppColors.purple800,
            onTap: () => _showComingSoonDialog(),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(String routeName) {
    NavigationService.instance.navigateToPage(path: routeName);
  }

  void _showComingSoonDialog() {
    // Coming soon dialog implementation
  }
}
