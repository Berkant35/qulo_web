import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/mixins/form_mixin.dart';
import '../../../core/mixins/loading_mixin.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with FormMixin, LoadingMixin {
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() => withLoading(() async {
        if (!validateForm()) return;
        await ref
            .read(authProvider.notifier)
            .forgotPassword(_emailCtrl.text.trim());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('reset_email_sent')),
            ),
          );
          context.pop();
        }
      });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: context.tr('reset_password'),
      body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                context.tr('reset_password_desc'),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xl),
              AppTextField(
                controller: _emailCtrl,
                label: context.tr('email'),
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: context.tr('send_reset_link'),
                isLoading: isLoading,
                onPressed: isLoading ? null : _send,
              ),
            ],
          ),
        ),
    );
  }
}
