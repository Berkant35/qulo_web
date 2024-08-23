import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectPlayerCount extends ConsumerStatefulWidget {
  final bool? isSelected;
  final Function()? onPressed;
  final String cardTitle;
  final String cardImagePath;

  const SelectPlayerCount(
      {required this.cardTitle,
      required this.cardImagePath,
      required this.isSelected,
      required this.onPressed,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectPlayerCountState();
}

class _SelectPlayerCountState extends ConsumerState<SelectPlayerCount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          clipBehavior: Clip.hardEdge,
          style: ButtonStyle(
              overlayColor: const MaterialStatePropertyAll(CpColors.cpPrimary),
              backgroundColor: const MaterialStatePropertyAll(CpColors.cpLead),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(34)))),
              fixedSize: MaterialStatePropertyAll(Size(33.w, 55.h))),
          onPressed: widget.onPressed,
          onLongPress: widget.onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.cardImagePath,
                width: 15.w,
                height: 15.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                widget.cardTitle,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        IconButton(
          onPressed: widget.onPressed,

          iconSize: 80,



          icon: Image.asset(
            (widget.isSelected ?? false)
                ? 'assets/iga/radio_button_active.png'
                : 'assets/iga/radio_button.png',
          ),
        )
      ],
    );
  }
}
