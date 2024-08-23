import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final bool? isbluetoothButton;
  final bool? isBackButtonColored;
  final AppBarLeadingType? appBarLeadingType;
  const CustomAppBar(
      {this.appBarLeadingType = AppBarLeadingType.empty,
      this.isbluetoothButton,
      this.isBackButtonColored,
      required this.title,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.white),
      ), 
      leading: Padding(
          padding: EdgeInsets.only(left: 5.w, top: 1.h),
          child: () {
            if (widget.appBarLeadingType == AppBarLeadingType.backButton) {
              return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: CatchpadIconsV2.backArrow.copyWith(
                  iconColor: (widget.isBackButtonColored ?? false)
                      ? CpColors.cpPrimary
                      : Colors.white,
                  height: 18.sp,
                ),
              );
            }

            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/camera.png',
                height: 100,
              ),
            );
          }()),
      actions: [
        (widget.isbluetoothButton ?? true)
            ? Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 5.w,
                    backgroundColor: CpColors.cpDireWolf,
                    child: Image.asset('assets/images/bluetooth.png'),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

enum AppBarLeadingType { backButton, camera, empty }
