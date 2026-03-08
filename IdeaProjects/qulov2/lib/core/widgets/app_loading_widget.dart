import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';

class AppLoadingWidget extends StatefulWidget {
  final double size;
  final bool showGlow;

  const AppLoadingWidget({
    super.key,
    this.size = 48,
    this.showGlow = false,
  });

  const AppLoadingWidget.small({super.key})
      : size = 24,
        showGlow = false;

  const AppLoadingWidget.large({super.key})
      : size = 48,
        showGlow = true;

  @override
  State<AppLoadingWidget> createState() => _AppLoadingWidgetState();
}

class _AppLoadingWidgetState extends State<AppLoadingWidget>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    if (widget.showGlow) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final painter = _QLogoPainter(color: AppColors.primary);

    if (!widget.showGlow) {
      return AnimatedBuilder(
        animation: _rotationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationController.value * 2 * math.pi,
            child: child,
          );
        },
        child: CustomPaint(
          size: Size(widget.size, widget.size),
          painter: painter,
        ),
      );
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _glowController]),
      builder: (context, child) {
        final glow = _glowController.value;
        final glowSize = widget.size * (1.4 + glow * 0.3);

        return SizedBox(
          width: glowSize,
          height: glowSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ambient glow
              Container(
                width: glowSize,
                height: glowSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.20 + glow * 0.10),
                      AppColors.primary.withValues(alpha: 0.05),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
              // Rotating Q logo
              Transform.rotate(
                angle: _rotationController.value * 2 * math.pi,
                child: child,
              ),
            ],
          ),
        );
      },
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: painter,
      ),
    );
  }
}

class _QLogoPainter extends CustomPainter {
  final Color color;

  _QLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;
    final strokeWidth = size.width * 0.08;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Main circle arc — open arc with gap for arrow tip
    const startAngle = math.pi * 0.35;
    const sweepAngle = math.pi * 1.65;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Arrow head at the end of arc
    final arrowAngle = startAngle + sweepAngle;
    final arrowTip = Offset(
      center.dx + math.cos(arrowAngle) * radius,
      center.dy + math.sin(arrowAngle) * radius,
    );

    final arrowSize = size.width * 0.12;
    final arrowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Arrow triangle — follows arc direction
    final tangentAngle = arrowAngle + math.pi / 2;
    final p1 = Offset(
      arrowTip.dx + math.cos(tangentAngle) * arrowSize,
      arrowTip.dy + math.sin(tangentAngle) * arrowSize,
    );
    final p2 = Offset(
      arrowTip.dx + math.cos(arrowAngle + math.pi * 0.75) * arrowSize,
      arrowTip.dy + math.sin(arrowAngle + math.pi * 0.75) * arrowSize,
    );
    final p3 = Offset(
      arrowTip.dx + math.cos(arrowAngle - math.pi * 0.75) * arrowSize,
      arrowTip.dy + math.sin(arrowAngle - math.pi * 0.75) * arrowSize,
    );

    final arrowPath = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(_QLogoPainter old) => old.color != color;
}
