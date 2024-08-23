import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CpCounterV2 extends ConsumerStatefulWidget {
  final double size;
  final int? currentIndex;
  final String? centerText;
  const CpCounterV2(
      {required this.size, this.centerText, this.currentIndex, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CpCounterState();
}

class _CpCounterState extends ConsumerState<CpCounterV2> {
  @override
  Widget build(BuildContext context) {
    final double tileSize = widget.size * 0.37;

    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Stack(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            widget.currentIndex == 0
                ? IgaAssets.tile_green_active.getPath
                : IgaAssets.tile_green.getPath,
            height: tileSize,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            widget.currentIndex == 1
                ? IgaAssets.tile_yellow_active.getPath
                : IgaAssets.tile_yellow.getPath,
            height: tileSize,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset(
              widget.currentIndex == 2
                  ? IgaAssets.tile_blue_active.getPath
                  : IgaAssets.tile_blue.getPath,
              height: tileSize),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset(
            widget.currentIndex == 3
                ? IgaAssets.tile_red_active.getPath
                : IgaAssets.tile_red.getPath,
            height: tileSize,
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              widget.centerText ?? '',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: (tileSize * 0.49).sp, color: Colors.white),
            )),
      ]),
    );
  }
}
