


import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../line/viewmodel/global_export.dart';

class BasicBackButton extends StatelessWidget {
  final String title;
  const BasicBackButton({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.instance.navigatePopUp(),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios,
            size: 4.h,
            color: Colors.black,
          ),
          Text(S.current.language,
              style: ThemeValueExtension.titleTextStyle
                  .copyWith(color: Colors.black))
        ],
      ),
    );
  }
}
