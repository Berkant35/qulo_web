// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.assetPath,
    this.height,
    this.width,
    this.color,
    this.colorFilter,
    this.blocCirculars = false,
    this.fit = BoxFit.contain,
  });

  final String assetPath;
  final double? height;
  final double? width;
  final Color? color;
  final ColorFilter? colorFilter;
  final BoxFit fit;
  final bool blocCirculars;

  @override
  Widget build(BuildContext context) {
    if (assetPath.startsWith("http")) {
      if (assetPath.endsWith(".svg")) {
        return SvgPicture.network(
          assetPath,
          colorFilter:
              color.isNull ? null : ColorFilter.mode(color!, BlendMode.srcIn),
          height: height,
          width: width,
          fit: fit,
          placeholderBuilder:
              (BuildContext context) =>
                  blocCirculars != true
                      ? const CircularProgressIndicator.adaptive()
                      : const SizedBox.shrink(),
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        );
      } else {
        return CachedNetworkImage(
          imageUrl: assetPath,
          color: color,
          height: height,
          width: width,
          fit: fit,
          placeholder:
              (context, url) =>
                  blocCirculars != true
                      ? const CircularProgressIndicator.adaptive()
                      : const SizedBox.shrink(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
    } else {
      if (assetPath.endsWith(".svg")) {
        return SvgPicture.asset(
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          assetPath,
          color: color,
          height: height,
          width: width,
          colorFilter: colorFilter,
          fit: fit,
        );
      } else {
        return Image.asset(
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          assetPath,
          height: height,
          width: width,
          color: color,
          fit: fit,
        );
      }
    }
  }
}
