import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final EdgeInsetsGeometry? padding;
  final bool showBackground;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;
  final Color? backgroundColor;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.padding = const EdgeInsets.all(AppSpacing.pagePadding),
    this.showBackground = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasAppBar = title != null;

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: hasAppBar
          ? AppBar(
              title: Text(title!),
              leading: leading,
              actions: actions,
              automaticallyImplyLeading: showBackButton,
            )
          : null,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        top: !hasAppBar,
        bottom: bottomNavigationBar == null,
        child: Stack(
          children: [
            if (showBackground)
              Positioned.fill(
                child: CustomPaint(
                  painter: _BackgroundPainter(),
                ),
              ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
                child: padding != null
                    ? Padding(padding: padding!, child: body)
                    : body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Sağ üst — mor gradient daire
    final purpleCenter = Offset(size.width * 1.1, size.height * -0.1);
    final purpleRadius = size.width * 0.5;
    final purplePaint = Paint()
      ..shader = ui.Gradient.radial(
        purpleCenter,
        purpleRadius,
        [
          const Color(0xFFBB86FC).withValues(alpha: 0.06),
          const Color(0xFFBB86FC).withValues(alpha: 0.0),
        ],
      );
    canvas.drawCircle(purpleCenter, purpleRadius, purplePaint);

    // Sol alt — yeşil gradient daire
    final greenCenter = Offset(size.width * -0.1, size.height * 1.1);
    final greenRadius = size.width * 0.45;
    final greenPaint = Paint()
      ..shader = ui.Gradient.radial(
        greenCenter,
        greenRadius,
        [
          const Color(0xFF69F0AE).withValues(alpha: 0.04),
          const Color(0xFF69F0AE).withValues(alpha: 0.0),
        ],
      );
    canvas.drawCircle(greenCenter, greenRadius, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
