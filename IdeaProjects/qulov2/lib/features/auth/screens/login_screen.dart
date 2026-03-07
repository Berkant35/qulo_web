import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/error/api_exception.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/mixins/form_mixin.dart';
import '../../../core/mixins/loading_mixin.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_button.dart';
import '../../../providers/auth_provider.dart';
import '../../../routing/route_names.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with FormMixin, LoadingMixin {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  String? _loginError;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() => withLoading(() async {
        setState(() => _loginError = null);
        if (!validateForm()) return;
        try {
          await ref.read(authProvider.notifier).login(
                email: _emailCtrl.text.trim(),
                password: _passwordCtrl.text,
              );
        } on DioException catch (e) {
          final data = e.response?.data;
          if (data is Map<String, dynamic>) {
            final apiEx =
                ApiException.fromResponse(data, e.response?.statusCode);
            setState(
                () => _loginError = context.l10n.errorMessage(apiEx.code));
          } else {
            setState(() => _loginError = context.l10n.errorMessage('UNKNOWN'));
          }
        } catch (_) {
          setState(() => _loginError = context.l10n.errorMessage('UNKNOWN'));
        }
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxxl),
                Text(
                  context.tr('app_name'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: AppColors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.tr('welcome_back'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                AppTextField(
                  controller: _emailCtrl,
                  label: context.tr('email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: emailValidator,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _passwordCtrl,
                  label: context.tr('password'),
                  obscureText: _obscure,
                  textInputAction: TextInputAction.done,
                  validator: passwordValidator,
                  onFieldSubmitted: (_) => _login(),
                  errorText: _loginError,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        context.pushNamed(RouteNames.forgotPassword),
                    child: Text(context.tr('forgot_password')),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: context.tr('login'),
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _login,
                ),
                const SizedBox(height: AppSpacing.xxl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.tr('no_account'),
                        style: theme.textTheme.bodyMedium),
                    TextButton(
                      onPressed: () =>
                          context.pushNamed(RouteNames.register),
                      child: Text(context.tr('register')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
