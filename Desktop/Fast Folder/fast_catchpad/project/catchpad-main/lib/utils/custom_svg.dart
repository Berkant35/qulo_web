import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  final String imagepath;
  final int? customFlex;
  final BoxFit? customBoxFit;
  final double? height;
  final double? width;
  final Color? iconColor;

  const CustomSvg({
    Key? key,
    required this.imagepath,
    this.customFlex,
    this.customBoxFit,
    this.width,
    this.iconColor,
    this.height,
  }) : super(key: key);

  CustomSvg copyWith({
    String? imagepath,
    int? customFlex,
    BoxFit? customBoxFit,
    double? height,
    double? width,
    Color? iconColor,
  }) {
    return CustomSvg(
      imagepath: imagepath ?? this.imagepath,
      customFlex: customFlex ?? this.customFlex,
      customBoxFit: customBoxFit ?? this.customBoxFit,
      height: height ?? this.height,
      width: width ?? this.width,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(
        imagepath,
        fit: customBoxFit == null ? BoxFit.fill : customBoxFit!,
        height: height,
        width: width,
        color: iconColor,
      ),
    );
  }
}
