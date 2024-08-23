import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RankPlate extends ConsumerWidget {
  final double size;
  final int rank;

  const RankPlate({
    super.key,
    required this.size,
    required this.rank,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            IgaAssets.rank_plate.getPath,
            width: size,
          ),
          Positioned(
            top: 4.h,
            right: 3.2.w,
            child: Text(
              '$rank.',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
          )
        ],
      ),
    );
  }
}