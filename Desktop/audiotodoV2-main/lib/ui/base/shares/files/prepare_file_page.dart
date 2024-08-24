import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/custom_with_back_app_bar.dart';
import 'package:audiotodo/utilities/components/buttons/neu_text_button.dart';
import 'package:audiotodo/utilities/components/switch/basic_switch.dart';
import 'package:audiotodo/utilities/components/texts/basic_header.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/mc_files.dart';
import 'package:audiotodo/utilities/helper/office/ofice_file_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrepareFilePage extends ConsumerStatefulWidget {
  const PrepareFilePage({
    super.key,
  });

  @override
  ConsumerState createState() => _PrepareFilePageState();
}

class _PrepareFilePageState extends ConsumerState<PrepareFilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: CustomWithBackAppBar(
                barText:
                    ref.read(currentMicrosoftFileState) == MicrosoftFiles.pdf
                        ? S.current.office_pdf
                        : S.current.microsoft_file_word,
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                child: BasicTitleWithHeader(
                  title:
                      ref.read(currentMicrosoftFileState) == MicrosoftFiles.pdf
                          ? S.current.office_pdf_settings
                          : S.current.office_word_settings,
                  explain:
                      ref.read(currentMicrosoftFileState) == MicrosoftFiles.pdf
                          ? S.current.office_pdf_explain_to_settings
                          : S.current.office_word_explain_to_settings,
                  titleTextColor: CustomColors.primaryColor,
                ),
              )),
          Expanded(flex: 10, child: pdfConfigSwitchList()),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: NeuTextButton(
                    isPrimaryButton: false,
                    text: ref.read(currentMicrosoftFileState) ==
                            MicrosoftFiles.pdf
                        ? S.current.office_create_pdf
                        : S.current.office_create_word,
                    onPressed: () => ref.read(currentMicrosoftFileState) ==
                            MicrosoftFiles.pdf
                        ? ref
                            .read(officeFileManagerState.notifier)
                            .createPdfFileAndShow(ref)
                        : ref
                            .read(officeFileManagerState.notifier)
                            .createWordFileAndShow(ref)),
              )),
        ],
      ),
    );
  }

  Widget pdfConfigSwitchList() {
    final pdfConfigs = ref.watch(officeFileManagerState);
    return ListView(
      children: OfficeFilesAttributeMap.defaultPdfAttribute.keys
          .map((e) => BasicSwitch(
              switchValue: pdfConfigs[e],
              content: OfficeFilesAttributeMap.defaultPdfAttributeTexts[e],
              onChanged: (val) {
                setState(() {
                  ref
                      .read(officeFileManagerState.notifier)
                      .setAttributeState(e, val);
                });
              }))
          .toList(),
    );
  }
}
