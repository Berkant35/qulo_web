import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/utils.dart';
import '../enums/auth/login_mode.dart';
import 'register_user.dart';

class LoginUser {
  String? phoneNum;
  String? email;
  String? userName;

  @JsonKey(ignore: true)
  String? password;

  @JsonKey(ignore: true)
  LoginMode? mode;

  LoginUser({
    this.mode,
    required this.userName,
    this.phoneNum,
    this.email,
    this.password,
  });

  LoginUser.email({
    required this.email,
    required this.password,
  }) : mode = LoginMode.email;

  LoginUser.phone({
    required this.phoneNum,
  }) : mode = LoginMode.phone;

  LoginUser.username({
    required this.userName,
    this.email,
    this.password,
    this.phoneNum,
  }) : mode = LoginMode.username;

  static bool loginModeIsEmail(String phoneOrEmail) =>
      _getLoginMode(phoneOrEmail) == LoginMode.email;

  static bool loginModeIsPhone(String phoneOrEmail) =>
      _getLoginMode(phoneOrEmail) == LoginMode.phone;

  static bool loginModeIsUsername(String phoneOrEmail) =>
      _getLoginMode(phoneOrEmail) == LoginMode.username;

  static LoginMode _getLoginMode(String phoneOrEmail) {
    final parse = int.tryParse(phoneOrEmail);

    if (parse != null) {
      return LoginMode.phone;
    }

    if (phoneOrEmail.contains('@')) {
      return LoginMode.email;
    }

    return LoginMode.username;
  }

  static String? validateLoginValue({
    required BuildContext context,
    required String? value,
  }) {
    if (value == null || value.isEmpty) {
      return L10n.inst(context).form_the_email_is_required;
    }
    return RegisterUser.validateEmail(
      context: context,
      value: value,
    );
    if (loginModeIsEmail(value)) {
      return RegisterUser.validateEmail(
        context: context,
        value: value,
      );
    } else if (loginModeIsPhone(value)) {
      return RegisterUser.validatePhone(
        context: context,
        value: value,
      );
    } else if (loginModeIsUsername(value)) {
      return RegisterUser.validateUserName(
        context: context,
        value: value,
      );
    }

    return null;
  }

  bool get isEmail => mode == LoginMode.email;
  bool get isPhone => mode == LoginMode.phone;
  bool get isUsername => mode == LoginMode.username;
}
