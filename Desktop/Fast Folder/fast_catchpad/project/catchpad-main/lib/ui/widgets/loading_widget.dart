import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../utils/l10n/l10n.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = L10n.inst(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            lang.request_activate_bluetooth,
            style: context.general.textTheme.headlineSmall,
          ),
          Text(
            lang.request_activate_bluetooth_description,
            style: context.general.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
