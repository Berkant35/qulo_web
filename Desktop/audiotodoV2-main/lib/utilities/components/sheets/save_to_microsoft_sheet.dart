import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/buttons/neu_stadium_button.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/mc_files.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../generated/l10n.dart';
import '../../../line/viewmodel/app/utilities/show_case_manager.dart';
import '../../constants/app/application_constants.dart';
import '../../constants/custom_assets/asset_paths.dart';
import '../../constants/enums/app/show_case_states.dart';
import '../../constants/extensions/context_extension.dart';
import '../../constants/extensions/edge_extension.dart';

final class SaveToMicrosoftFileSheet extends ConsumerStatefulWidget {
  const SaveToMicrosoftFileSheet({
    super.key,
  });

  @override
  ConsumerState createState() => _SaveToMicrosoftFileSheetState();
}

class _SaveToMicrosoftFileSheetState
    extends ConsumerState<SaveToMicrosoftFileSheet> {
  @override
  Widget build(BuildContext context) {
    ref
        .read(currentAllShowCases.notifier)
        .showCaseIn(context: context, ref: ref);
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: EdgeExtension.mediumEdge.edgeValue,
          right: EdgeExtension.normalEdge.edgeValue,
          left: EdgeExtension.normalEdge.edgeValue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.microsoft_file_choose,
              style: ThemeValueExtension.headline6,
            ),
            Text(
              S.current.microsoft_file_choose_explain,
              style: ThemeValueExtension.subtitle,
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  imageWithText(AssetPaths.icPdf, ThirdTodoAppConstants.pdfName,
                          () {
                        ref
                            .read(currentMicrosoftFileState.notifier)
                            .changState(MicrosoftFiles.pdf);
                        //Navigate Prepare File
                        NavigationService.instance.navigateToPage(
                            path: NavigationConstants.prepareMicrosoftFilePage);
                      }, ThirdTodoAppConstants.pdfName),
                  // imageWithText(
                  //     AssetPaths.icDocx, ThirdTodoAppConstants.docxName, () {
                  //   ref
                  //       .read(currentMicrosoftFileState.notifier)
                  //       .changState(MicrosoftFiles.word);
                  //   //Navigate Prepare File
                  //   NavigationService.instance.navigateToPage(
                  //       path: NavigationConstants.prepareMicrosoftFilePage);
                  // }, ThirdTodoAppConstants.docKey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  NeuStadiumTextButton neuStadiumTextButton(VoidCallback? onTap) {
    return NeuStadiumTextButton(
      onPressed: onTap,
      text: S.current.contiune,
    );
  }

  Widget imageWithText(
      String path, String text, VoidCallback? onTap, String todoAppKeyName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(path,
                  width: IconSizeExtension.medium.sizeValue,
                  height: IconSizeExtension.medium.sizeValue,
                  fit: BoxFit.contain),
              GapSizedBox.smallGapW,
              headerTitle(text, todoAppKey: todoAppKeyName),
            ],
          ),
          neuStadiumTextButton(onTap),
        ],
      ),
    );
  }

  Widget headerTitle(String text, {String? todoAppKey}) {
    return Text(text, style: ThemeValueExtension.headline6);
  }
}
