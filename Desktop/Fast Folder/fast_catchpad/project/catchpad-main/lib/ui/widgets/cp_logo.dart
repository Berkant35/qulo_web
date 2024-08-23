import 'package:catchpad/models/enums/utility/loading_status.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../managers/asset_manager.dart';
import '../../utils/consts.dart';

class CpLogo extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const CpLogo({
    this.height,
    this.width,
    super.key,
  });

  @override
  ConsumerState createState() => _CpLogoState();
}

class _CpLogoState extends ConsumerState<CpLogo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetManager.cpLogo,
      height: widget.height ?? 100,
      width: widget.width ?? 100,
    );
  }
}

class CpLogoWithText extends StatelessWidget {
  final double? height;
  final double? width;
  const CpLogoWithText({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetManager.cpLogoText,
      height: height ?? 60,
      width: width ?? 100,
    );
  }
}

class CpLogoV2 extends StatelessWidget {
  const CpLogoV2({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetManager.cpLogoNew,
      height: size ?? 100,
      width: size ?? 100,
    );
  }
}
