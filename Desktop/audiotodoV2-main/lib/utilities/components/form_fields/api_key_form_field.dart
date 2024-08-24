import 'package:audiotodo/utilities/components/form_fields/complex_inherited.dart';
import 'package:audiotodo/utilities/components/form_fields/row_form_field.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/navigation_constants.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../core/theme/custom_colors.dart';
import '../../../generated/l10n.dart';
import '../../../line/viewmodel/global_providers.dart';
import '../../constants/extensions/context_extension.dart';
import '../../constants/extensions/icon_size_extensions.dart';
import '../buttons/neu_text_button.dart';
import '../dialogs/basic_dialogs.dart';

class ApiKeyFormFieldAndSave extends ConsumerStatefulWidget {
  final ComplexInherited cmplx;
  final String brandApiKeyTitle;
  final String? secondBrandTitle;
  final String? secondBrandInputHintText;

  final TodoPlatforms? secondTodoPlatform;
  final GlobalKey<FormState> formState;
  final TextEditingController brandTextInputController;
  final TextEditingController? secondBrandTextInputController;

  final IconData? secondBrandInputLeadingIcon;

  const ApiKeyFormFieldAndSave(
      {super.key,
      this.secondBrandTextInputController,
      this.secondBrandInputLeadingIcon,
      this.secondBrandTitle,
      this.secondBrandInputHintText,
      this.secondTodoPlatform,
      required this.cmplx,
      required this.formState,
      required this.brandTextInputController,
      required this.brandApiKeyTitle});

  @override
  ConsumerState createState() => _ApiKeyFormFieldAndSaveState();
}

class _ApiKeyFormFieldAndSaveState
    extends ConsumerState<ApiKeyFormFieldAndSave> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formState,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GapSizedBox.miniGap,
              apiKeyTitleAndHelp(helpText: widget.brandApiKeyTitle),
              pasteInputControl(context, widget.cmplx,
                  textEditingController: widget.brandTextInputController),
              GapSizedBox.miniGap,
              if (widget.secondBrandTitle != null)
                Column(
                  children: [
                    apiKeyTitleAndHelp(
                        helpText: widget.secondBrandTitle!,
                        helpCondition: false),
                    GapSizedBox.miniGap,
                    pasteInputControl(
                      context,
                      widget.cmplx,
                      textEditingController:
                          widget.secondBrandTextInputController!,
                      iconData: widget.secondBrandInputLeadingIcon,
                      hintText: widget.secondBrandInputHintText,
                    ),
                    GapSizedBox.miniGap
                  ],
                ),
              Center(
                  child: NeuTextButton(
                      text: S.current.utilities_save,
                      isPrimaryButton: false,
                      onPressed: () async {
                        if (widget.formState.currentState!.validate()) {
                          ref.read(authManager.notifier).addNewPlatformLink(
                              ref,
                              widget.brandTextInputController.text,
                              ref.read(currentIntegrationHelpState));
                          if (widget.secondBrandTextInputController != null) {
                            final res = await ref
                                .read(authManager.notifier)
                                .addNewPlatformLink(
                                    ref,
                                    widget.secondBrandTextInputController!.text,
                                    widget.secondTodoPlatform!);
                            if (res) await BasicDialogs.successfullySavedDialog(ref);
                          }
                        }
                      })),
              GapSizedBox.hugeGap
            ],
          ),
        ),
      ),
    );
  }

  Row apiKeyTitleAndHelp(
      {required String helpText, bool helpCondition = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          //brandApiKeyTitle
          helpText,
          style: ThemeValueExtension.headline6.copyWith(
            color: CustomColors.primaryColor,
          ),
        ),
        if (helpCondition)
          IconButton(
              onPressed: () {
                NavigationService.instance.navigateToPage(
                    path: NavigationConstants.helpIntegrationPage);
              },
              icon: Icon(
                Icons.help_outline,
                size: IconSizeExtension.normal.sizeValue,
                color: CustomColors.accentColor,
              ))
      ],
    );
  }

  Row pasteInputControl(BuildContext context, ComplexInherited cmplx,
      {required TextEditingController textEditingController,
      IconData? iconData,
      String? hintText}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            iconData ?? Icons.key,
            size: IconSizeExtension.normal.sizeValue,
            color: CustomColors.accentColor,
          ),
        ),
        Expanded(
          flex: 12,
          child: RowFormField(
              headerName: "",
              hintText: hintText ?? S.current.utilities_paste,
              visibleStatus: iconData == null ? true : null,
              editingController: textEditingController,
              custValidateFunction: (val) =>
                  val == null || val.isEmpty ? "" : null),
        ),
      ],
    );
  }
}
