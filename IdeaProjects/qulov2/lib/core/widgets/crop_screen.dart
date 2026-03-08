import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_loading_widget.dart';

class CropScreen extends StatefulWidget {
  final Uint8List imageBytes;

  const CropScreen({super.key, required this.imageBytes});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final _cropController = CropController();
  bool _isCropping = false;
  int _rotationTurns = 0;

  void _rotate() {
    setState(() {
      _rotationTurns = (_rotationTurns + 1) % 4;
    });
  }

  void _confirm() {
    setState(() => _isCropping = true);
    _cropController.cropCircle();
  }

  void _onCropped(CropResult result) {
    if (!mounted) return;
    switch (result) {
      case CropSuccess(:final croppedImage):
        Navigator.of(context).pop(croppedImage);
      case CropFailure():
        setState(() => _isCropping = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Crop failed')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_right),
            tooltip: 'Rotate',
            onPressed: _isCropping ? null : _rotate,
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: TextButton(
              onPressed: _isCropping ? null : _confirm,
              child: _isCropping
                  ? const AppLoadingWidget.small()
                  : Text(
                      'OK',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: RotatedBox(
        quarterTurns: _rotationTurns,
        child: Crop(
          controller: _cropController,
          image: widget.imageBytes,
          aspectRatio: 1,
          withCircleUi: true,
          baseColor: AppColors.background,
          maskColor: AppColors.background.withAlpha(200),
          cornerDotBuilder: (size, edgeAlignment) => const SizedBox.shrink(),
          onCropped: _onCropped,
          initialSize: 0.8,
          interactive: true,
        ),
      ),
    );
  }
}
