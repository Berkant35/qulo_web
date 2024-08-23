import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/enums/background_enums.dart';
import 'package:catchpad/v2/ui/backgrounds/cp_glow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/cp_colors.dart';

class DefaultBg extends ConsumerWidget {
  final Widget? child;
  final String? bgimage;
  final Color? bgcolor;

  final BackgroundEnums? backgroundEnum;
  const DefaultBg(
      {this.child, this.backgroundEnum, this.bgcolor, this.bgimage, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNewVersion = ref.read(currentNewVersionState);

    return isNewVersion
        ? switch (backgroundEnum) {
            BackgroundEnums.typeOne => CpGlowBackGround(
                child: child,
              ),
            BackgroundEnums.typeTwo => DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: child,
              ),

            // it may change
            BackgroundEnums.typeThree => const CpGlowBackGround(),
            BackgroundEnums.old => DecoratedBox(
                decoration: BoxDecoration(
                  // gradient: CpColors.backgroundGradient,
                  image: bgimage == null
                      ? null
                      : DecorationImage(image: AssetImage(bgimage!)),
                  color: (bgcolor == null) ? CpColors.bgGC2 : bgcolor,
                ),
                child: child,
              ),
            null => CpGlowBackGround(
                child: child,
              ),
            // TODO: Handle this case.
            BackgroundEnums.typeOneHalf => DecoratedBox(
                decoration: BoxDecoration(
                  // gradient: CpColors.backgroundGradient,
                  image: bgimage == null
                      ? null
                      : DecorationImage(image: AssetImage(bgimage!)),
                  color: (bgcolor == null) ? CpColors.bgGC2 : bgcolor,
                ),
                child: child,
              ),
          }
        : DecoratedBox(
            decoration: BoxDecoration(
              // gradient: CpColors.backgroundGradient,
              image: bgimage == null
                  ? null
                  : DecorationImage(image: AssetImage(bgimage!)),
              color: (bgcolor == null) ? CpColors.bgGC2 : bgcolor,
            ),
            child: child,
          );

    DecoratedBox(
      decoration: BoxDecoration(
        // gradient: CpColors.backgroundGradient,
        image: bgimage == null
            ? null
            : DecorationImage(image: AssetImage(bgimage!)),
        color: (bgcolor == null) ? CpColors.cpDarkGrey : bgcolor,
      ),
      child: child,
    );
  }
}
