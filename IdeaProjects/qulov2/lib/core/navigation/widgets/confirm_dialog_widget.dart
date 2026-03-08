import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../l10n/l10n.dart';
import '../models/app_dialog.dart';

class ConfirmDialogWidget extends StatelessWidget {
  final ConfirmDialog dialog;
  const ConfirmDialogWidget({super.key, required this.dialog});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialog.title),
      content: Text(dialog.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            dialog.cancelText ?? context.tr('cancel'),
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            dialog.confirmText ?? context.tr('confirm'),
            style: TextStyle(
              color: dialog.isDestructive ? AppColors.error : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
