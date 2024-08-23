import 'dart:math';

import 'package:flutter/material.dart';

import 'pad_cube.dart';

//https://github.com/adnanjpg/flutter_3d_demo

const twoPis = 2 * pi;
const halfPi = pi / 2;

// #region 3D
class Pad3D extends StatefulWidget {
  final double? xRotate;
  final double? yRotate;

  const Pad3D({
    required this.xRotate,
    required this.yRotate,
    Key? key,
  }) : super(key: key);

  @override
  State<Pad3D> createState() => _Pad3DState();
}

class _Pad3DState extends State<Pad3D> {
  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.identity()..setEntry(3, 2, 0.001);

    if (widget.xRotate != null) {
      transform.rotateX(widget.xRotate!);
    }
    if (widget.yRotate != null) {
      transform.rotateY(widget.yRotate!);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: const Center(
          child: PadCube(
            color: Colors.green,
            fullSize: 200,
            halfSize: 120,
          ),
        ),
      ),
    );
  }
}
