import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/core/shared/app_live_bluetooth_icon.dart';

class AppLiveHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? appHeaderName;

  const AppLiveHeader({super.key, required this.appHeaderName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appHeaderName.getValueOrDefault,
        style: AppTextStyles.px14w600,
      ),
      automaticallyImplyLeading: true,
      centerTitle: false,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 24),
          child: AppLiveBluetoothIcon(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
