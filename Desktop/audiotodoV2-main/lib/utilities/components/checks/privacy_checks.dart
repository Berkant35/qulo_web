import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/components/texts/underline_launcher_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyChecks extends ConsumerStatefulWidget {
  final Function(bool checked) onPrivacyCheck;

  const PrivacyChecks({required this.onPrivacyCheck, super.key});

  @override
  ConsumerState createState() => _PrivacyChecksState();
}

class _PrivacyChecksState extends ConsumerState<PrivacyChecks> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: checked,
          checkColor: CustomColors.fillWhiteColor,
          hoverColor: CustomColors.accentColor,
          activeColor: CustomColors.accentColor,
          onChanged: (bool? newValue) {
            setState(() => checked = newValue ?? false);
            widget.onPrivacyCheck(newValue ?? false);
          },
        ),
        UnderlineLauncherTextWidget(
          contentText: S.current.privacy_policy_content_text,
          underLineTexts: {
            S.current.privacy_policy_attractive_1: "www.gooogle.com",
            S.current.privacy_policy_attractive_2: "www.google.com"
          },
          customOnTap: ()  async {
            await NavigationService.instance
                .navigateToPage(path: NavigationConstants.privacyPolicyPage);
          },
        ),
      ],
    );
  }
}
