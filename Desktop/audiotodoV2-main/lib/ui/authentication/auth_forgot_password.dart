import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../line/viewmodel/global_export.dart';
import '../../line/viewmodel/global_providers.dart';
import '../../utilities/components/adt_widgets.dart';

class AuthForgotPasswordPage extends ConsumerStatefulWidget {
  const AuthForgotPasswordPage({
    super.key,
  });

  @override
  ConsumerState createState() => _AuthForgotPasswordPageState();
}

class _AuthForgotPasswordPageState
    extends ConsumerState<AuthForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Dismiss keyboard when tapping outside
      },
      child: Scaffold(
        appBar: BasicBackAppBar(contentTitle: S.current.forgot_password),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: contentDecoration(), // Apply custom decoration
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: S.current.email,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.current.email;
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return S.current.invalid_email_format;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: 4.h),
                Center(
                  child: ValueListenableBuilder<bool>(
                      valueListenable: isLoading,
                      builder: (context, loading, c) {
                        if (loading) {
                          return const CircularProgressIndicator();
                        }

                        return NeuTextButton(
                          onPressed: _submitForm,
                          text: S.current.submit,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration contentDecoration() {
    return BoxDecoration(
      color: CustomColors.fillWhiteColor,
      borderRadius: BorderRadius.circular(25), // Stadium shape
      boxShadow: const [
        BoxShadow(
          color: CustomColors.greyColor,
          blurRadius: 0,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.white,
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    isLoading.value = true;
    isLoading.notifyListeners();
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      await ref.read(authManager.notifier).forgotPassword(email, ref);
      // You can show a confirmation message or navigate to another screen here
    }
    isLoading.value = false;
    isLoading.notifyListeners();
  }
}
