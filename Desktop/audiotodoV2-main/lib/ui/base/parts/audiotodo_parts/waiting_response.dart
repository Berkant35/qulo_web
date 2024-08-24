import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/custom_colors.dart';

class WaitingResponse extends ConsumerWidget {
  const WaitingResponse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.current.waiting_response_ui_content,
            style: ThemeValueExtension.titleTextStyle.copyWith(
                color: CustomColors.greyColor,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.clip),
            textAlign: TextAlign.center,
          ),
          const CircularProgressIndicator.adaptive(),
          Text(
            S.current.please_wait,
            style: ThemeValueExtension.titleTextStyle.copyWith(
                color: CustomColors.greyColor,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.clip),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
