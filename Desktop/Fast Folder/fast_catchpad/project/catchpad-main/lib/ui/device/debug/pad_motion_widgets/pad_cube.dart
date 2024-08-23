import 'package:flutter/material.dart';

import 'pad_3d.dart';

class PadCube extends StatelessWidget {
  final Color color;

  final double fullSize;
  final double halfSize;
  const PadCube({
    required this.color,
    required this.fullSize,
    required this.halfSize,
    Key? key,
  }) : super(key: key);

  double get threeFourthsSize => fullSize - halfSize / 2;

  double get quarterSize => halfSize / 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PadCubeFace(
          color: Colors.pink,
          translateX: -quarterSize,
          rotateY: -halfPi,
          width: halfSize,
          height: fullSize,
        ),
        PadCubeFace(
          color: Colors.purple,
          translateX: threeFourthsSize,
          rotateY: -halfPi,
          width: halfSize,
          height: fullSize,
        ),
        PadCubeFace(
          color: Colors.pink,
          translateZ: quarterSize,
          width: fullSize,
          height: fullSize,
        ),
        PadCubeFace(
          color: Colors.yellow,
          translateZ: -quarterSize,
          width: fullSize,
          height: fullSize,
        ),
        PadCubeFace(
          color: Colors.red,
          translateY: -quarterSize,
          rotateX: -halfPi,
          width: fullSize,
          height: halfSize,
        ),
        PadCubeFace(
          color: Colors.blue,
          translateY: threeFourthsSize,
          rotateX: -halfPi,
          width: fullSize,
          height: halfSize,
        ),
      ],
    );
  }
}

class PadCubeFace extends StatelessWidget {
  final double? rotateX;
  final double? rotateY;
  final double? rotateZ;

  final double? translateX;
  final double? translateY;
  final double? translateZ;

  final double width;
  final double height;

  final Color color;

  const PadCubeFace({
    this.rotateX,
    this.rotateY,
    this.rotateZ,
    this.translateX,
    this.translateY,
    this.translateZ,
    required this.color,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Matrix4 transform = Matrix4.identity();

    if (translateX != null || translateY != null || translateZ != null) {
      transform.translate(translateX ?? .0, translateY ?? .0, translateZ ?? .0);
    }

    if (rotateX != null) {
      transform.rotateX(rotateX!);
    }

    if (rotateY != null) {
      transform.rotateY(rotateY!);
    }

    if (rotateZ != null) {
      transform.rotateZ(rotateZ!);
    }

    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height,
        color: Colors.green,
      ),
    );
  }
}
// #endregion
