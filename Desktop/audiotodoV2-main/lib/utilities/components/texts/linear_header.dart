import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LinearHeader extends ConsumerWidget {
  final String leftText;
  final String rightText;

  const LinearHeader(
      {super.key, required this.leftText, required this.rightText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          Text(
            rightText,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
