import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/constants/app_sizes.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/widgets/language_picker_sheet.dart';
import 'package:qulo_v2/core/mixins/form_mixin.dart';
import 'package:qulo_v2/core/mixins/loading_mixin.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';
import 'package:qulo_v2/core/widgets/app_text_field.dart';
import 'package:qulo_v2/features/auth/widgets/background_video.dart';
import 'package:qulo_v2/features/auth/widgets/staggered_column.dart';
import 'package:qulo_v2/providers/auth_provider.dart';
import 'package:qulo_v2/providers/locale_provider.dart';
import 'package:qulo_v2/routing/route_names.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with FormMixin, LoadingMixin {
  static const _videoAsset = 'assets/videos/login_bg.mp4';

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  String? _loginError;

  final _staggeredKey = GlobalKey<StaggeredColumnState>();
  bool _videoReady = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _showLanguagePicker() async {
    final currentLocale = ref.read(localeProvider).languageCode;
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      builder: (_) => LanguagePickerSheet(
        selectedLanguages: [currentLocale],
        multiSelect: false,
      ),
    );
    if (result != null && result.isNotEmpty && mounted) {
      ref.read(localeProvider.notifier).setLocale(Locale(result.first));
    }
  }

  void _onVideoInitialized() {
    if (_videoReady) return;
    _videoReady = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _staggeredKey.currentState?.forward();
    });
  }

  Future<void> _login() => withLoading(() async {
        setState(() => _loginError = null);
        if (!validateForm()) return;
        final result = await ref.read(authProvider.notifier).login(
              email: _emailCtrl.text.trim(),
              password: _passwordCtrl.text,
            );
        if (!mounted) return;
        result.when(
          success: (_) {},
          failure: (f) {
            final errorCode = switch (f) {
              ServerFailure(:final code) => code,
              NetworkFailure() => 'NETWORK_ERROR',
              TimeoutFailure() => 'TIMEOUT',
              _ => 'UNKNOWN',
            };
            setState(
                () => _loginError = context.l10n.errorMessage(errorCode));
          },
        );
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Arka plan video + koyu overlay
          BackgroundVideo(
            assetPath: _videoAsset,
            overlayOpacity: 0.5,
            onInitialized: _onVideoInitialized,
          ),

          // Gradient daireler (mevcut AppScaffold'dan)
          const _GradientOverlay(),

          // Form içeriği
          SafeArea(
            child: Stack(
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxWidth: AppSpacing.maxContentWidth),
                    child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.all(AppSpacing.pagePadding),
                  child: Form(
                    key: formKey,
                    child: StaggeredColumn(
                      key: _staggeredKey,
                      children: [
                        const SizedBox(height: AppSpacing.xxxl),
                        // Logo
                        Center(
                          child: SvgPicture.asset(
                            AppAssets.logoSvg,
                            width: AppSizes.logoMd,
                            height: AppSizes.logoMd,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        // App adı
                        Text(
                          context.tr('app_name'),
                          textAlign: TextAlign.center,
                          style:
                              theme.textTheme.displaySmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        // Hoşgeldin text
                        Text(
                          context.tr('welcome_back'),
                          textAlign: TextAlign.center,
                          style:
                              theme.textTheme.bodyLarge?.copyWith(
                            color:
                                theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        // Email
                        AppTextField(
                          controller: _emailCtrl,
                          label: context.tr('email'),
                          keyboardType:
                              TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: emailValidator,
                          prefixIcon:
                              const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        // Password
                        AppTextField(
                          controller: _passwordCtrl,
                          label: context.tr('password'),
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          validator: passwordValidator,
                          onFieldSubmitted: (_) => _login(),
                          errorText: _loginError,
                          prefixIcon:
                              const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(
                                () => _obscure = !_obscure),
                          ),
                        ),
                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => ref
                                .read(navigationServiceProvider)
                                .push(RouteNames.forgotPassword),
                            child: Text(
                                context.tr('forgot_password')),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        // Login butonu
                        AppButton(
                          label: context.tr('login'),
                          isLoading: isLoading,
                          onPressed: isLoading ? null : _login,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        // Register linki
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(context.tr('no_account'),
                                style:
                                    theme.textTheme.bodyMedium),
                            TextButton(
                              onPressed: () => ref
                                  .read(navigationServiceProvider)
                                  .push(RouteNames.register),
                              child:
                                  Text(context.tr('register')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ),
                ),
                // Dil değiştirme butonu — sağ üst köşe
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: IconButton(
                    icon: const Icon(Icons.language),
                    color: Colors.white70,
                    tooltip: context.tr('language'),
                    onPressed: _showLanguagePicker,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// AppScaffold'daki gradient daireler — video üstünde dekoratif katman.
class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Sağ üst — mor gradient daire
    final purpleCenter = Offset(size.width * 1.1, size.height * -0.1);
    final purpleRadius = size.width * 0.5;
    final purplePaint = Paint()
      ..shader = ui.Gradient.radial(
        purpleCenter,
        purpleRadius,
        [
          AppColors.primary.withValues(alpha: 0.06),
          AppColors.primary.withValues(alpha: 0.0),
        ],
      );
    canvas.drawCircle(purpleCenter, purpleRadius, purplePaint);

    // Sol alt — yeşil gradient daire
    final greenCenter = Offset(size.width * -0.1, size.height * 1.1);
    final greenRadius = size.width * 0.45;
    final greenPaint = Paint()
      ..shader = ui.Gradient.radial(
        greenCenter,
        greenRadius,
        [
          AppColors.secondary.withValues(alpha: 0.04),
          AppColors.secondary.withValues(alpha: 0.0),
        ],
      );
    canvas.drawCircle(greenCenter, greenRadius, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
