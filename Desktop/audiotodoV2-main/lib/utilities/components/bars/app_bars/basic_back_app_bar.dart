import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BasicBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String contentTitle;
  final IconButton? trailingButton;

  final Color? customBackGroundColor;

  const BasicBackAppBar(
      {super.key, required this.contentTitle, this.trailingButton,this.customBackGroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: customBackGroundColor ?? Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: false,
      leadingWidth: 6.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 2.w),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: CustomColors.primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [trailingButton ?? const SizedBox()],
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          contentTitle,
          style: ThemeValueExtension.headline6.copyWith(
            color: CustomColors.primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
