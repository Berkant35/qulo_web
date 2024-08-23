import 'package:catchpad/ui/auth/register_form_body.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/v2/screens/authentication/login/login_mixin.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:catchpad/v2/utils/widgets/buttons/social_button.dart';
import 'package:catchpad/v2/utils/widgets/textfields/password_textfield.dart';
import 'package:catchpad/v2/utils/widgets/textfields/textfield_with_headline.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with LoginMixin {
  String emailOrNumber = 'E-posta';
  bool isEmail = true;
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Tekrar Hoş geldin!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Gap(10.h),
                    //email
                    TextField(
                        keyboardType: isEmail
                            ? TextInputType.emailAddress
                            : TextInputType.phone,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(hintText: emailOrNumber)),
                    Gap(1.h),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isEmail) {
                            emailOrNumber = 'Telefon Numarası';
                            isEmail = false;
                          } else {
                            emailOrNumber = 'E-posta';
                            isEmail = true;
                          }
                        });
                      },
                      child: Text(
                        isEmail ? 'veya telefon numarası' : 'veya e-posta',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 13.sp,
                            decorationColor: Colors.white),
                      ),
                    ),
                    Gap(4.h),
                    const PasswordTextfield(
                      hintText: 'Şifrenizi girin',
                    ),
                    Gap(1.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text('Şifremi unuttum',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12.sp,
                                decorationColor: Colors.white)),
                      ),
                    ),
                    Gap(5.h),
                    CustomCatchpadButtons.buildGradientAccentButton(
                      color: Colors.white,
                      customGradientColor: [
                        CpColors.cpPrimary.withOpacity(0.03),
                        CpColors.cpPrimary.withOpacity(0.07)
                      ],
                      onPressed: () {},
                      text: 'giris yap',
                    ),
                    Gap(8.h),
                    Text(
                      'Ya da',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    Gap(4.h),
                    // social buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialButton(
                          imagePath: 'assets/images/google.png',
                          size: 30,
                          onTap: () {},
                        ),
                        SocialButton(
                          imagePath: 'assets/images/facebook.png',
                          size: 30,
                          onTap: () {},
                        ),
                        SocialButton(
                          imagePath: 'assets/images/apple.png',
                          size: 30,
                          onTap: () {},
                        ),
                      ],
                    ),
                    Gap(5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Henüz bir hesabınız yok mu? ',
                          style: TextStyle(
                              fontSize: 13.sp, decorationColor: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigate to register screen
                          },
                          child: Text(
                            'Kayıt olun',
                            style: TextStyle(
                                fontSize: 13.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Gap(5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp, // Metin boyutunu ayarlayın
                          ),
                          children: const <TextSpan>[
                            TextSpan(text: 'Devam ederek, '),
                            TextSpan(
                              text: 'gizlilik politikasını',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white, // Metin rengi
                              ),
                            ),
                            TextSpan(text: ' onayladığınızı '),
                            TextSpan(
                              text: 'kabul etmiş oluyorsunuz.',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white, // Metin rengi
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
