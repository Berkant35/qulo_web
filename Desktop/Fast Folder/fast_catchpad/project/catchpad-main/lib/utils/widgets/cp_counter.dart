import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CpCounter extends ConsumerStatefulWidget {
  final double size;
  final int? currentIndex;
  final String? centerText;
  const CpCounter(
      {required this.size, this.centerText, this.currentIndex, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CpCounterState();
}

class _CpCounterState extends ConsumerState<CpCounter> {
  // final isEmb = ref.read(currentEmbModeManager);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size * other(),
      width: widget.size * other(),
      child: Stack(children: [
        if (widget.currentIndex == 0)
          Image.asset(
            IgaAssets.pad_stage_4.getPathWithoutIga,
            height: widget.size * other(),
            width: widget.size * other(),
            fit: BoxFit.cover,
          ),
        if (widget.currentIndex == 1)
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Image.asset(
              IgaAssets.pad_stage_3.getPathWithoutIga,
              height: widget.size * other(),
              width: widget.size * other(),
              fit: BoxFit.cover,
            ),
          ),
        if (widget.currentIndex == 2)
          Image.asset(
            IgaAssets.pad_stage_2.getPathWithoutIga,
            height: widget.size * other(),
            width: widget.size * other(),
            fit: BoxFit.cover,
          ),
        if (widget.currentIndex == 3)
          Image.asset(
            IgaAssets.pad_stage_1.getPathWithoutIga,
            height: widget.size * other(),
            width: widget.size * other(),
            fit: BoxFit.cover,
          ),
        Center(
          child: Text(
            widget.centerText ?? '',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontSize: 25.sp, color: Colors.white),
          ),
        ),
      ]),
    );
  }

  double other() => 3.00;
}
