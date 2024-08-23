import 'package:catchpad/data/api/user_api.dart';
import 'package:catchpad/models/bottom_bar_item.dart';
import 'package:catchpad/ui/auth/auth_top_part_widget.dart';
import 'package:catchpad/ui/widgets/default_bg.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../managers/auth_manager_new.dart';
import '../../models/auth/login_user.dart';
import '../../models/auth/register_user.dart';
import '../../models/enums/auth/auth_error.dart';
import '../../prov/auth/current_user_prov.dart';
import '../../prov/class_provider.dart';
import '../../utils/route_table.dart';
import '../../utils/utils.dart';
import '../widgets/buttons/cp_button_1.dart';
import 'register_form_body.dart';

class LoginFormBody extends ConsumerStatefulWidget {
  const LoginFormBody({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends ConsumerState<LoginFormBody> {
  String emailOrPhone = (kDebugMode) ? 'berkantC93@gmail.com' : '';
  String password = (kDebugMode) ? 'xcx.153hb' : '';
  /* String emailOrPhone = 'ozkanmeltem110@gmail.com';
  String password = '315513'; */
  /* String emailOrPhone = (kDebugMode) ? 'catchpadzekiyazgac@gmail.com' : '';
  String password = (kDebugMode) ? '123456' : ''; */

  RegisterUser? get userNameUser => userNamesModes[emailOrPhone];

  /* bool get isEmail =>
      userNameUser?.isEmail == true || LoginUser.loginModeIsEmail(emailOrPhone);
  bool get isPhone =>
      userNameUser?.isPhone == true || LoginUser.loginModeIsPhone(emailOrPhone); */

  bool get isUserNameCheckedYet =>
      //  !isEmail && !isPhone;
      false;

  bool get isUsername => LoginUser.loginModeIsUsername(emailOrPhone);

  bool passObscure = true;

  String get email => userNameUser?.email ?? emailOrPhone;
  String get phone => userNameUser?.phoneNum ?? emailOrPhone;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, RegisterUser> userNamesModes = {};

  Future<AuthError?> login() async {
    if (_formKey.currentState?.validate() == false) {
      return null;
    }

    EasyLoading.show();

    LoginUser? _u;

    /* if (isEmail) { */
    _u = LoginUser.email(
      email: email,
      password: password,
    );
    /* } else if (isPhone) {
      _u = LoginUser.phone(
        phoneNum: phone,
      );
    } else if (isUsername) {
      _u = LoginUser.username(
        userName: emailOrPhone,
        email: email,
        phoneNum: phone,
        password: password,
      );
    } */

    /* assert(_u != null); */
    final user = _u /* ! */;

    AuthError? reg;

    Future<AuthError?> _tryHandleLogin(LoginUser user) async {
      AuthError? reg;

      try {
        reg = await FireAuth.login(
          context: context,
          ref: ref,
          user: user,
        );
      } catch (e) {
        reg = e is AuthError ? e : AuthError.failed;
      }

      return reg;
    }

    /// the isEmail and isPhone checked
    /// also check if the current user name's
    /// mode is email or phone (it is retrieved
    /// from the firestore).
    /* if (isUserNameCheckedYet) {
      /// if not retrieved, we wanna retrieve that
      final user = await UsersApi.instance.getUserFromUserId(emailOrPhone);

      /* if (user == null || user.mode == null) {
        reg = AuthError.userNotFound;
      } else {
        userNamesModes[emailOrPhone] = user;
        setState(() {});

        /*  if (user.isPhone) {
          reg = await _tryHandleLogin(user.toLoginUser());
        } */
      } */
    } else {
      reg = await _tryHandleLogin(user);
    } */
    reg = await _tryHandleLogin(user);
    EasyLoading.dismiss();

    // did not run successfully
    if (reg != null && mounted) {
      FireAuth.handleAuthError(context, reg);
      return reg;
    }
    return reg;
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    Future<bool> verifyDialog() async {
      return await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) {
          return AlertDialog(
            title: Text(inst.form_verify_email),
            content: Text(inst.form_verify_email_spam_warning),
            actions: [
              TextButton(
                onPressed: () async {
                  final curuser = FireAuth.auth.currentUser;
                  if (curuser != null) {
                    EasyLoading.show();
                    await curuser.sendEmailVerification();
                    EasyLoading.showToast(inst.form_verify_email_sent);
                    EasyLoading.dismiss();
                  }
                },
                child: Text(inst.form_verify_resend),
              ),
              TextButton(
                onPressed: () async {
                  var curuser = FireAuth.auth.currentUser;
                  if (curuser != null) {
                    EasyLoading.show();
                    await curuser.reload();
                    var curuser2 = FireAuth.auth.currentUser;
                    await curuser2?.reload();
                    EasyLoading.dismiss();
                    /*if (curuser2?.emailVerified ?? false)
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
      );
    }

    return WillPopScope(
      onWillPop: () async {
        //add counter


        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: Container(),
        ),
        body: DefaultBg(
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                // if keyboard is open, then we dont wanna show
                // this widget
                KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {

                    if (isKeyboardVisible)
                    {
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
                                  inst.form_email,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: inst.form_email,
                                  ),
                                  initialValue: emailOrPhone,
                                  onChanged: (value) {
                                    emailOrPhone = value;
                                  },
                                  validator: (value) =>
                                      LoginUser.validateLoginValue(
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
                                  inst.form_password,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                PasswordField(
                                  initialValue: password,
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CpButton1(
                                  onPressed: () async {
                                   //bool confirmed = false;
                                    try {
                                      await login();
                                    } catch (e) {
                                      final _auth = FirebaseAuth.instance;
                                      final curUser = _auth.currentUser;
                                      /*confirmed =
                                          curUser?.emailVerified ?? false;

                                      if (curUser?.emailVerified != true) {
                                        await curUser?.sendEmailVerification();
                                        confirmed = await verifyDialog();
                                      }*/
                                      if (curUser != null &&
                                          mounted /*&&
                                          confirmed*/) {
                                        ref
                                            .read(bottomBarProvider.notifier)
                                            .setBottomBarItem(0,ref);
                                        await ref
                                            .read(
                                                currentUserAssetsProv.notifier)
                                            .loadAssets(ref);
                                        ref
                                            .read(
                                                selectedClassProvider.notifier)
                                            .loadClass(
                                                ref); // needs to be loaded after loadclasses function
                                        String email = curUser.email!;
                                        final user = await UsersApi.instance
                                            .getUserFromEmailAddress(email);
                                        ref
                                            .read(currentUserProv.notifier)
                                            .update(user);
                                        context.goNamed(RouteTable.rHomeScreen);
                                        return;
                                      }
                                      return;
                                    }
                                    final _auth = FirebaseAuth.instance;
                                    final curUser = _auth.currentUser;
                                    /*
                                    confirmed = curUser?.emailVerified ?? false;


                                   if (curUser?.emailVerified != true) {
                                      await curUser?.sendEmailVerification();
                                      confirmed = await verifyDialog();
                                    }*/

                                    if (curUser != null &&
                                        mounted /*&&
                                        confirmed*/) {
                                      ref
                                          .read(bottomBarProvider.notifier)
                                          .setBottomBarItem(0,ref);
                                      await ref
                                          .read(currentUserAssetsProv.notifier)
                                          .loadAssets(ref);
                                      ref
                                          .read(selectedClassProvider.notifier)
                                          .loadClass(
                                              ref); // needs to be loaded after loadclasses function
                                      String email = curUser.email!;
                                      final user = await UsersApi.instance
                                          .getUserFromEmailAddress(email);
                                      ref
                                          .read(currentUserProv.notifier)
                                          .update(user);
                                      context.goNamed(RouteTable.rHomeScreen);
                                      return;
                                    }
                                    return;
                                  },
                                  child: Text(
                                    isUserNameCheckedYet
                                        ? inst.form_continue
                                        : inst.form_login,
                                  ),
                                  fullWidth: true,
                                ),
                                // const AuthSkipButton(AuthPageType.login),
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
                            RichText(
                                text: TextSpan(
                                    text: inst.password_forgot + ' ',
                                    children: [
                                  TextSpan(
                                      text: inst.password_forgot_click_here,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          if (emailOrPhone.isEmpty) {
                                            EasyLoading.showToast(inst
                                                .form_the_email_is_required);
                                            return;
                                          }
                                          EasyLoading.show();
                                          final response = await ref
                                              .read(currentUserProv.notifier)
                                              .resetPasswordWithoutLogin(
                                                  emailOrPhone);
                                          EasyLoading.dismiss();
                                          if (response) {
                                            EasyLoading.showToast(
                                                inst.password_reset_toast);
                                            return;
                                          }
                                          EasyLoading.showToast(
                                              inst.form_autherror_failed);
                                        },
                                      style: const TextStyle(
                                          color: CpColors.cpYellow))
                                ])),

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
      ),
    );
  }
}
