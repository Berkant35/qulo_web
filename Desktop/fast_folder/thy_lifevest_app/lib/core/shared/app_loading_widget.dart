import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key}) : isButton = false;

  const AppLoadingWidget.button({super.key}) : isButton = true;

  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: !isButton ? 64 : null,
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
