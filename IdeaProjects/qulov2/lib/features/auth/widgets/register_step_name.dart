import 'package:flutter/material.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class RegisterStepName extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController surnameCtrl;
  final String? nameError;
  final String? surnameError;
  final VoidCallback onContinue;

  const RegisterStepName({
    super.key,
    required this.nameCtrl,
    required this.surnameCtrl,
    this.nameError,
    this.surnameError,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.get('step_name'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.xxl),
          AppTextField(
            controller: nameCtrl,
            label: l10n.get('name'),
            errorText: nameError,
            prefixIcon: const Icon(Icons.person_outline),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: surnameCtrl,
            label: l10n.get('surname'),
            errorText: surnameError,
            prefixIcon: const Icon(Icons.person_outline),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => onContinue(),
          ),
          const Spacer(),
          AppButton(
            label: l10n.get('continue_btn'),
            onPressed: onContinue,
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
