import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/error/api_exception.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/mixins/form_mixin.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../providers/auth_provider.dart';
import '../widgets/register_step_birthday.dart';
import '../widgets/register_step_email.dart';
import '../widgets/register_step_gender.dart';
import '../widgets/register_step_name.dart';
import '../widgets/register_step_terms.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with FormMixin {
  static const _totalSteps = 5;

  final _pageController = PageController();
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  int _currentStep = 0;
  DateTime? _birthday;
  String? _gender;
  bool _termsAccepted = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Error state
  String? _nameError;
  String? _surnameError;
  String? _emailError;
  String? _passwordError;
  String? _birthdayError;
  String? _genderError;
  String? _termsError;

  @override
  void dispose() {
    _pageController.dispose();
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentStep = step);
  }

  void _nextStep() {
    if (_validateCurrentStep()) {
      _goToStep(_currentStep + 1);
    }
  }

  bool _validateCurrentStep() {
    final l10n = AppLocalizations.of(context);

    switch (_currentStep) {
      case 0:
        final nameErr = _nameCtrl.text.trim().isEmpty
            ? l10n.get('field_required')
            : null;
        final surnameErr = _surnameCtrl.text.trim().isEmpty
            ? l10n.get('field_required')
            : null;
        setState(() {
          _nameError = nameErr;
          _surnameError = surnameErr;
        });
        return nameErr == null && surnameErr == null;

      case 1:
        String? err;
        if (_birthday == null) {
          err = l10n.get('field_required');
        } else if (_calculateAge() < 18) {
          err = l10n.get('must_be_18');
        }
        setState(() => _birthdayError = err);
        return err == null;

      case 2:
        final err =
            _gender == null ? l10n.get('field_required') : null;
        setState(() => _genderError = err);
        return err == null;

      case 3:
        final emailErr = emailValidator(_emailCtrl.text.trim());
        final passErr = passwordValidator(_passwordCtrl.text);
        setState(() {
          _emailError = emailErr;
          _passwordError = passErr;
        });
        return emailErr == null && passErr == null;

      case 4:
        final err = !_termsAccepted
            ? l10n.get('must_accept_terms')
            : null;
        setState(() => _termsError = err);
        return err == null;

      default:
        return false;
    }
  }

  int _calculateAge() {
    if (_birthday == null) return 0;
    final now = DateTime.now();
    int age = now.year - _birthday!.year;
    if (now.month < _birthday!.month ||
        (now.month == _birthday!.month && now.day < _birthday!.day)) {
      age--;
    }
    return age;
  }

  Future<void> _register() async {
    if (!_validateCurrentStep()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authProvider.notifier).register(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text,
            name: _nameCtrl.text.trim(),
            surname: _surnameCtrl.text.trim(),
            age: _calculateAge(),
            gender: _gender!,
          );

      if (!mounted) return;

      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.get('check_email'))),
      );
      context.pop();
    } on DioException catch (e) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      final apiError = e.error;

      if (apiError is ApiException &&
          apiError.code == 'EMAIL_ALREADY_EXISTS') {
        setState(() {
          _emailError = l10n.errorMessage(apiError.code);
        });
        _goToStep(3);
      } else {
        final code =
            apiError is ApiException ? apiError.code : 'SERVER_ERROR';
        setState(() {
          _termsError = l10n.errorMessage(code);
        });
      }
    } catch (e) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      setState(() {
        _termsError = l10n.errorMessage('UNKNOWN');
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _goToStep(_currentStep - 1),
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppProgressBar(
              currentStep: _currentStep + 1,
              totalSteps: _totalSteps,
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentStep = index);
                },
                children: [
                  RegisterStepName(
                    nameCtrl: _nameCtrl,
                    surnameCtrl: _surnameCtrl,
                    nameError: _nameError,
                    surnameError: _surnameError,
                    onContinue: _nextStep,
                  ),
                  RegisterStepBirthday(
                    selectedDate: _birthday,
                    onDateSelected: (date) {
                      setState(() {
                        _birthday = date;
                        _birthdayError = null;
                      });
                    },
                    errorText: _birthdayError,
                    onContinue: _nextStep,
                  ),
                  RegisterStepGender(
                    selectedGender: _gender,
                    onGenderSelected: (gender) {
                      setState(() {
                        _gender = gender;
                        _genderError = null;
                      });
                    },
                    errorText: _genderError,
                    onContinue: _nextStep,
                  ),
                  RegisterStepEmail(
                    emailCtrl: _emailCtrl,
                    passwordCtrl: _passwordCtrl,
                    emailError: _emailError,
                    passwordError: _passwordError,
                    obscurePassword: _obscurePassword,
                    onToggleObscure: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    onContinue: _nextStep,
                  ),
                  RegisterStepTerms(
                    termsAccepted: _termsAccepted,
                    onTermsChanged: (value) {
                      setState(() {
                        _termsAccepted = value ?? false;
                        _termsError = null;
                      });
                    },
                    errorText: _termsError,
                    isLoading: _isLoading,
                    onRegister: _register,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
