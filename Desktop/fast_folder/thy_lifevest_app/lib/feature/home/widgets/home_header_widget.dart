import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/gap_extension.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.thyPrimary, AppColors.thyPrimary.withValues75],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.topPaddingGap,
          Text(
            'THY Lifevest',
            style: AppTextStyles.px24w700.copyWith(color: AppColors.white),
          ),
          context.gap8,
          Text(
            'Tracking System',
            style: AppTextStyles.px16w400.copyWith(color: AppColors.white),
          ),
          context.gap16,
          Text(
            'Select the module you want to operate',
            style: AppTextStyles.px14w400.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
