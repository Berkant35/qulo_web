import 'package:flutter/material.dart';

import '../cp_colors.dart';

class ErrorSnackbar {
  final String error;
  final SnackBarAction? action;

  const ErrorSnackbar(
    this.error, {
    this.action,
  });

  void show(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

  SnackBar get snackBar => SnackBar(
        content: Text(
          error,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        action: action == null
            ? null
            : SnackBarAction(
                label: action!.label,
                onPressed: action!.onPressed,
                textColor: Colors.white,
              ),
        backgroundColor: CpColors.error,
      );
}
