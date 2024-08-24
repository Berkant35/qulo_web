


import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/custom_colors.dart';
import '../../../constants/extensions/icon_size_extensions.dart';
import '../../containers/custom_bar_container.dart';

class CustomWithBackAppBar extends StatelessWidget {
  final String barText;

  final bool showLeadingIcon;

  final VoidCallback? onPressed;
  const CustomWithBackAppBar({required this.barText,this.onPressed,this.showLeadingIcon = true,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          mainAxisAlignment: showLeadingIcon ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            if(showLeadingIcon)
            Padding(
              padding: EdgeInsets.only(left: 4.w,top: 2.h),
              child: IconButton(
                  onPressed: onPressed ?? () =>NavigationService.instance.navigatePopUp(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: IconSizeExtension.medium.sizeValue,
                    color: CustomColors.primaryColor,
                  )),
            ),
            Center(child: CustomBarContainer(text: barText,doubleValueForHeight: 10.5.h,)),
            if(showLeadingIcon)
            SizedBox(
              width: 17.5.w,
            )
          ],
        ));
  }
}
