import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../shared/components/components.dart';

/// Login page
/// Basit ve şık login formu
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: AppSpacing.xl),
                  _buildLoginForm(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildLoginButton(),
                  const SizedBox(height: AppSpacing.md),
                  _buildForgotPassword(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            FontAwesomeIcons.chartLine,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Title
        Text(
          'Tabul Dashboard',
          style: AppTypography.h3.copyWith(
            color: AppColors.textPrimaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Subtitle
        Text(
          'Dashboard\'a giriş yapın',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Card(
      elevation: 8,
      shadowColor: AppColors.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@domain.com',
                  prefixIcon: const Icon(FontAwesomeIcons.envelope),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.borderLight,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email adresi gerekli';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleLogin(),
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  hintText: 'Şifrenizi girin',
                  prefixIcon: const Icon(FontAwesomeIcons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.borderLight,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre gerekli';
                  }
                  if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalı';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Remember Me
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Text(
                    'Beni hatırla',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Giriş Yap',
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {
        // TODO: Implement forgot password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Şifre sıfırlama özelliği yakında eklenecek'),
          ),
        );
      },
      child: Text(
        'Şifremi unuttum?',
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login request
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // TODO: Implement actual login logic with cubit
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Login başarılı! Dashboard\'a yönlendiriliyorsunuz...'),
            backgroundColor: AppColors.success,
          ),
        );

        // Navigate to dashboard
        context.go(AppRoutes.dashboard);
      });
    }
  }
}
