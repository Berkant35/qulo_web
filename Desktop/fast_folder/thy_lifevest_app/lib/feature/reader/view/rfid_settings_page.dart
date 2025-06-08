import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/gap_extension.dart';
import 'package:thy_lifevest_app/ui_kit/responsive_scaffold.dart';

class RfidSettingsPage extends StatefulWidget {
  const RfidSettingsPage({super.key});

  @override
  State<RfidSettingsPage> createState() => _RfidSettingsPageState();
}

class _RfidSettingsPageState extends State<RfidSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return AppResponsiveScaffold(
      appBar: AppBar(
        title: Text('RFID Settings', style: AppTextStyles.px18w600),
      ),
      body: Column(
        children: [
          context.gap24,
          Text('RFID Settings Page', style: AppTextStyles.px20w600),
        ],
      ),
    );
  }
}
