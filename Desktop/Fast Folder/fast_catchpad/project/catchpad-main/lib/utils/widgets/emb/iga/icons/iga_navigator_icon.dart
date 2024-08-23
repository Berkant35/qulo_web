import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../cp_colors.dart';

class IgaNavigatorIconWidget extends ConsumerWidget {
  final Function()? onTap;
  final bool isRight;

  const IgaNavigatorIconWidget({this.isRight = true, this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40.h,
      width: 8.w,
      child: Padding(
        padding: EdgeInsets.only(left: !isRight ? 1.2.w : 0, bottom: 20),
        child: IconButton(
          
          onPressed: onTap,
          icon: Icon(
            isRight ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            color: CpColors.cpLightGrey,
            size: 10.h,
          ),
        ),
      ),
    );
  }
}
