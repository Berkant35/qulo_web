import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:audiotodo/utilities/components/form_fields/complex_inherited.dart';
import 'package:audiotodo/utilities/components/form_fields/row_form_field.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utilities/components/form_fields/api_key_form_field.dart';

class ClickUpIntegration extends ConsumerStatefulWidget {
  const ClickUpIntegration({
    super.key,
  });

  @override
  ConsumerState createState() => _ClickUpIntegrationState();
}

class _ClickUpIntegrationState extends ConsumerState<ClickUpIntegration> {
  @override
  Widget build(BuildContext context) {
    final cmplx = ComplexInherited.of(context);

    cmplx.clickUpApiKey.text = ref
            .read(authManager)!
            .todoPlatformTokens?[TodoPlatforms.clickUp.name] ??
        "";

    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle: S.current.integration_click_up,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 4.w),
        child: bodyOfIntegration(context),
      ),
    );
  }

  Column bodyOfIntegration(BuildContext context) {
    final cmplx = ComplexInherited.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: EdgeExtension.normalEdge.edgeValue),
          child: Image.asset(
            AssetPaths.icClickUp,
            width: 15.w,
            height: 15.w,
            fit: BoxFit.contain,
          ),
        )),
        Text(
          S.current.integration_click_up_explain,
          style: ThemeValueExtension.highBody,
        ),
        ApiKeyFormFieldAndSave(
          cmplx: cmplx,
          formState: cmplx.clickUpApiKeyForm,
          brandTextInputController:
              ComplexInherited.of(context).clickUpApiKey,
          brandApiKeyTitle: S.current.integration_click_up_api_key,
        ),

      ],
    );
  }

  Row apiKeyTitleAndHelp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          S.current.integration_click_up_api_key,
          style: ThemeValueExtension.headline6.copyWith(
            color: CustomColors.primaryColor,
          ),
        ),
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

  Row pasteInputControl(BuildContext context, ComplexInherited cmplx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            Icons.key,
            size: IconSizeExtension.normal.sizeValue,
            color: CustomColors.accentColor,
          ),
        ),
        Expanded(
          flex: 8,
          child: Form(
            key: cmplx.clickUpApiKeyForm,
            child: RowFormField(
                headerName: "",
                hintText: S.current.utilities_paste,
                visibleStatus: true,
                editingController: ComplexInherited.of(context).clickUpApiKey,
                custValidateFunction: (val) =>
                    val == null || val.isEmpty ? "" : null),
          ),
        ),
      ],
    );
  }
}
