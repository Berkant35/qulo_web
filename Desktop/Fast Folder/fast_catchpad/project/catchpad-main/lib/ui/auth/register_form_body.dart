import 'package:catchpad/models/bottom_bar_item.dart';
import 'package:catchpad/ui/auth/auth_top_part_widget.dart';
import 'package:catchpad/ui/policy/privacy_policy.dart';
import 'package:catchpad/ui/widgets/cp_dialog.dart';
import 'package:catchpad/ui/widgets/default_bg.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/route_table.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../managers/auth_manager_new.dart';
import '../../models/auth/register_user.dart';
import '../../models/enums/auth/auth_error.dart';
import '../../utils/utils.dart';
import '../widgets/buttons/cp_button_1.dart';

class RegisterFormBody extends ConsumerStatefulWidget {
  const RegisterFormBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterFormBodyState();
}

class _RegisterFormBodyState extends ConsumerState<RegisterFormBody> {
  String phone = (kDebugMode) ? '05234132135' : '';
  String email = (kDebugMode) ? 'gh@irebah.com' : '';
  String firstName = (kDebugMode) ? 'Test' : '';
  String lastName = (kDebugMode) ? 'Test' : '';
  String password = (kDebugMode) ? '315513' : '';
  String rPassword = (kDebugMode) ? '315513' : '';
  String userName = (kDebugMode) ? 'test' : '';
  bool isAcceptedValue = false;
  late TextEditingController passwordController;
  late TextEditingController rPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController(text: password);
    rPasswordController = TextEditingController(text: rPassword);
  }

  /* String phone = (kDebugMode) ? '05416553398' : '';
  String email = (kDebugMode) ? 'catchpadgames@gmail.com' : '';
  String firstName = (kDebugMode) ? 'CatchPad' : '';
  String lastName = (kDebugMode) ? 'R' : '';
  String password = (kDebugMode) ? '111111' : '';
  String userName = (kDebugMode) ? 'CatchPad' : ''; */
  /* String phone = (kDebugMode) ? '05324013818' : '';
  String email = (kDebugMode) ? 'catchpadzekiyazgac@gmail.com' : '';
  String firstName = (kDebugMode) ? 'Zeki' : '';
  String lastName = (kDebugMode) ? 'Yazgaç' : '';
  String password = (kDebugMode) ? '123456' : '';
  String userName = (kDebugMode) ? 'zekiyazgac' : ''; */
  /* String phone = '05319747239';
  String email = 'ozkanmeltem110@gmail.com';
  String firstName = 'Meltem';
  String lastName = 'Özkan';
  String password = '315513';
  String userName = 'melly39'; */

  bool get isPhone => true;

  bool isUserNameEdited = false;

  Future<AuthError?> register() async {
    if (_formKey.currentState?.validate() == false) {
      return AuthError.failed;
    }

    RegisterUser user;

    user = RegisterUser.phone(
      phoneNum: phone,
      userName: userName,
      password: password,
      fName: firstName,
      lName: lastName,
      email: email,
    );
    user.uid = userName;

    EasyLoading.show();
    AuthError? reg;

    try {
      reg = await FireAuth.register(
        context: context,
        ref: ref,
        user: user,
      );
    } catch (e) {
      EasyLoading.dismiss();
      reg = e is AuthError ? e : AuthError.failed;
    }

    // did not run successfully
    if (reg != null && mounted) {
      EasyLoading.dismiss();

      FireAuth.handleAuthError(context, reg);
    }

    EasyLoading.dismiss();
    return reg;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Scaffold(
      appBar: PreferredSize(
        child: Container(),
        preferredSize: Size.zero,
      ),
      body: DefaultBg(
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              // if keyboard is open, then we dont wanna show
              // this widget
              KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  if (isKeyboardVisible) {
                    return const SliverPadding(padding: EdgeInsets.zero);
                  }

                  return SliverAppBar(
                    expandedHeight: 220,
                    // it is displaying a back button,
                    // which we do not want to show
                    leading: IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(Icons.adaptive.arrow_back)),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          color: CpColors.button2Color,
                        ),
                        child: const AuthTopPartWidget(),
                      ),
                    ),
                  );
                },
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(defPaddingSize),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inst.form_full_name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Row(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: inst.form_first_name,
                                    ),
                                    initialValue: firstName,
                                    onChanged: (value) {
                                      setState(() {
                                        firstName = value;
                                      });
                                    },
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return inst
                                            .form_the_first_name_is_required;
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: inst.form_last_name,
                                    ),
                                    initialValue: lastName,
                                    onChanged: (value) {
                                      setState(() {
                                        lastName = value;
                                      });
                                    },
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return inst
                                            .form_the_last_name_is_required;
                                      }
                                      return null;
                                    },
                                  ),
                                ]
                                    .map((e) => Expanded(
                                          child: e,
                                        ))
                                    .joinWidgetList(
                                      (index) => const SizedBox(
                                        width: defPaddingSize,
                                      ),
                                    ),
                              ),
                            ].joinWidgetList((index) =>
                                const SizedBox(height: halfDefPaddingSize)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inst.form_user_name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: inst.form_user_name,
                                ),
                                initialValue: userName,
                                onChanged: (value) {
                                  userName = value;
                                  setState(() {});
                                },
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    RegisterUser.validateUserName(
                                  context: context,
                                  value: value,
                                ),
                              ),
                            ].joinWidgetList((index) =>
                                const SizedBox(height: halfDefPaddingSize)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inst.form_email,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: inst.form_email,
                                ),
                                initialValue: email,
                                onChanged: (value) {
                                  email = value;
                                  setState(() {});
                                },
                                validator: (value) =>
                                    RegisterUser.validateEmail(
                                  context: context,
                                  value: value,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ].joinWidgetList((index) =>
                                const SizedBox(height: halfDefPaddingSize)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inst.form_phone_num+inst.form_phone_num_optional,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: inst.form_phone_num,
                                ),
                                initialValue: phone,
                                onChanged: (value) {
                                  phone = value;

                                  if (isPhone) {
                                    if (value.startsWith('0')) {
                                      value = value.substring(1);
                                    }
                                  }

                                  setState(() {});
                                },
                                validator: (value) =>
                                    RegisterUser.validatePhone(
                                  context: context,
                                  value: value,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ].joinWidgetList((index) =>
                                const SizedBox(height: halfDefPaddingSize)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inst.form_password,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              PasswordField(
                                controller: rPasswordController,
                                initialValue: password,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                    passwordController.text = password;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inst.re_form_password,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              PasswordField(
                                controller: passwordController,
                                initialValue: rPassword,
                                onChanged: (value) {
                                  setState(() {
                                    rPassword = value;
                                    rPasswordController.text = rPassword;
                                  });
                                },
                              ),
                            ],
                          ),
                          AcceptPrivacyPolicy(
                            isAccepted: (bool val) {
                              isAcceptedValue = val;
                            },
                          ),
                          CpButton1(
                            onPressed: () async {
                              //bool confirmed = false;
                              //----

                              if (isAcceptedValue) {
                                final err = await register();
                                if (mounted &&
                                    err == null &&
                                    rPasswordController.text ==
                                        passwordController.text) {
                                  //Sometimes doesn't send confirm email by Firebase.
                                  //So we thinked remove  this task it .
                                  /*confirmed = await showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(inst.form_verify_email),
                                      content: Text(
                                          inst.form_verify_email_spam_warning),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            var curuser =
                                                FireAuth.auth.currentUser;
                                            if (curuser != null) {
                                              EasyLoading.show();
                                              await curuser
                                                  .sendEmailVerification();
                                              await curuser.reload();
                                              EasyLoading.showToast(
                                                  inst.form_verify_email_sent);
                                              EasyLoading.dismiss();
                                            }
                                          },
                                          child: Text(inst.form_verify_resend),
                                        ),
                                        TextButton(
                                          onPressed: () async {

                                            var curuser =
                                                FireAuth.auth.currentUser;

                                            if (curuser != null)
                                            {
                                              EasyLoading.show();
                                              await curuser.reload();
                                              var curuser2 =
                                                  FireAuth.auth.currentUser;
                                              await curuser2?.reload();
                                              EasyLoading.dismiss();
                                              /*if (curuser2?.emailVerified ??
                                                  false)
                                              {
                                                Navigator.pop(context, true);
                                              }*/
                                              Navigator.pop(context, true);
                                            }
                                          },
                                          child: Text(inst.ok),
                                        ),
                                      ],
                                    );
                                  },
                                );*/
                                  /*if (confirmed) {*/
                                  ref
                                      .read(bottomBarProvider.notifier)
                                      .setBottomBarItem(0,ref);
                                  context.goNamed(RouteTable.rHomeScreen);
                                  /*}*/
                                } else {
                                  logger.d(err.toString());
                                }
                              } else {
                                CatchPadFeedBackDialog.notAcceptedPolicy(ref);
                              }
                            },
                            child: Text(
                              inst.form_create_account,
                            ),
                            fullWidth: true,
                          ),
                        ].joinWidgetList(
                          (_) => const SizedBox(height: defPaddingSize),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AcceptPrivacyPolicy extends StatefulWidget {
  final void Function(bool) isAccepted;

  const AcceptPrivacyPolicy({Key? key, required this.isAccepted})
      : super(key: key);

  @override
  State<AcceptPrivacyPolicy> createState() => _AcceptPrivacyPolicyState();
}

class _AcceptPrivacyPolicyState extends State<AcceptPrivacyPolicy> {
  var accepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: accepted,
            onChanged: (val) {
              setState(() {
                accepted = val!;
              });
              widget.isAccepted(accepted);
            }),
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PrivacyPolicyScreen())),
          child: Text(
            L10n.inst(context).i_accept_privacy_policy,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}

class PasswordField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const PasswordField({
    required this.initialValue,
    required this.onChanged,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passObscure = true;

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: inst.form_password,
            ),
            initialValue: widget.initialValue,
            onChanged: widget.onChanged,
            obscureText: passObscure,
            keyboardType: passObscure
                ? TextInputType.text
                : TextInputType.visiblePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return inst.form_the_password_is_required;
              }

              if (value.length < 6) {
                return inst.form_password_must_be_at_least_6_characters;
              }

              //This controller keep other controller.So passwordController
              // keep to rPasswordController and rPasswordController
              // keep to passwordController
              if (widget.controller != null &&
                  widget.controller!.text != value) {
                return inst.password_must_be_same;
              }

              return null;
            },
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
            icon: passObscure
                ? const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
            onPressed: () {
              setState(() {
                passObscure = !passObscure;
              });
            },
          ),
        ),
      ],
    );
  }
}
