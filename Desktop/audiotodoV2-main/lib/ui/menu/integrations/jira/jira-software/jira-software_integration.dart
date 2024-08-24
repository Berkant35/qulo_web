import 'package:audiotodo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../line/viewmodel/global_providers.dart';
import '../../../../../utilities/components/bars/app_bars/basic_back_app_bar.dart';
import '../../../../../utilities/components/form_fields/api_key_form_field.dart';
import '../../../../../utilities/components/form_fields/complex_inherited.dart';
import '../../../../../utilities/constants/custom_assets/asset_paths.dart';
import '../../../../../utilities/constants/enums/integration/todo_platforms.dart';
import '../../../../../utilities/constants/extensions/context_extension.dart';
import '../../../../../utilities/constants/extensions/edge_extension.dart';

class JiraSoftwareIntegration extends ConsumerStatefulWidget {
  const JiraSoftwareIntegration({
    super.key,
  });

  @override
  ConsumerState createState() => _JiraSoftwareIntegrationState();
}

class _JiraSoftwareIntegrationState
    extends ConsumerState<JiraSoftwareIntegration> {
  @override
  Widget build(BuildContext context) {
    final cmplx = ComplexInherited.of(context);

    cmplx.jiraSoftwareIntegrationApiKey.text = ref
            .read(authManager)!
            .todoPlatformTokens?[TodoPlatforms.jiraSoftware.name] ??
        "";
    cmplx.jiraSoftwareIntegrationDomainUserName.text = ref.read(authManager)!.todoPlatformTokens?[TodoPlatforms.jiraSoftwareDomain.name] ?? "";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicBackAppBar(
        contentTitle: S.current.integration_menu_jira_software,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EdgeExtension.lowEdge.edgeValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: EdgeExtension.normalEdge.edgeValue),
              child: Image.asset(
                AssetPaths.icJiraSoftware,
                width: 15.w,
                height: 15.w,
                fit: BoxFit.contain,
              ),
            )),
            Text(
              S.current.integration_jira_software_explain,
              style: ThemeValueExtension.highBody,
            ),
            ApiKeyFormFieldAndSave(
              cmplx: cmplx,
              formState: cmplx.jiraSoftwareIntegrationApiKeyForm,
              brandTextInputController:
                  ComplexInherited.of(context).jiraSoftwareIntegrationApiKey,
              brandApiKeyTitle: S.current.integration_jira_software_api_key,
              secondBrandInputHintText: cmplx.jiraSoftwareExampleDomainText,
              secondBrandInputLeadingIcon: Icons.language_outlined,
              secondBrandTextInputController:
                  cmplx.jiraSoftwareIntegrationDomainUserName,
              secondBrandTitle: S.current.integration_jira_Software_domain_name,
              secondTodoPlatform: TodoPlatforms.jiraSoftwareDomain,
            ),
          ],
        ),
      ),
    );
  }
}
