import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InformationCard extends ConsumerStatefulWidget {
  final String iconPath;
  final String title;
  final bool? isMs;
  final String result;
  final double size;
  const InformationCard(
      {required this.size,
      required this.iconPath,
      this.isMs,
      required this.title,
      required this.result,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InformationCardState();
}

class _InformationCardState extends ConsumerState<InformationCard> {
  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final imageSize = size * 0.58;
    return SizedBox(
      height: size,
      width: size * 0.675,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size * 0.6,
              width: size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -size * 0.05,
                    child: Image.asset(widget.iconPath, height: imageSize),
                  ),
                  Positioned(
                    bottom: -size * 0.21,
                    child: SizedBox(
                        height: size * 0.45,
                        width: size * 0.35,
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: size*0.8.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size * 0.1, vertical: size * 0.05),
              child: Container(
                width: size,
                height: size * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: CpColors.cpDavysGrey,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Center(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                    text: widget.result,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: CpColors.cpPrimary, fontWeight: FontWeight.bold),
                  ),
                  if (widget.isMs ?? false)
                    TextSpan(
                      text: 'ms',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: CpColors.cpPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                ]))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
