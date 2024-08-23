import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/utils.dart';
import '../enums/auth/register_mode.dart';
import 'login_user.dart';

part 'register_user.g.dart';

@JsonSerializable()
class RegisterUser {
  String? phoneNum;
  String? email;
  String? fName;
  String? lName;
  String? uid;
  DateTime? createdAt;

  String get name => fName == null ? '' : fName! + ' ' + lName!;

  @JsonKey(ignore: true)
  String? password;

  String userName;

  RegisterMode? mode;

  RegisterUser({
    this.mode,
    required this.userName,
    this.phoneNum,
    this.email,
    this.fName,
    this.lName,
    this.password,
    this.createdAt,
    this.uid,
  });

  static bool registerModeIsEmail(String phoneOrEmail) =>
      _getRegisterMode(phoneOrEmail) == RegisterMode.email;

  static bool registerModeIsPhone(String phoneOrEmail) =>
      _getRegisterMode(phoneOrEmail) == RegisterMode.phone;

  static RegisterMode _getRegisterMode(String phoneOrEmail) {
    final parse = int.tryParse(phoneOrEmail);

    if (parse != null) {
      return RegisterMode.phone;
    }

    return RegisterMode.email;
  }

  static String? validateUserName({
    required BuildContext context,
    required String? value,
  }) {
    if (value == null || value.isEmpty) {
      return L10n.inst(context).form_the_user_name_is_required;
    }

    if (value.length < 6) {
      return L10n.inst(context).form_user_name_must_be_at_least_6_characters;
    }

    // all characters must be latin letters or numbers
    if (!RegExp(r'[A-Za-zÇçĞğİıÖöŞşÜü]').hasMatch(value)) {
      return L10n.inst(context).form_user_name_must_be_latin_letters_or_numbers;
    }

    return null;
  }

  static String? validateEmail({
    required BuildContext context,
    required String? value,
  }) {
    if (value == null || value.isEmpty) {
       return L10n.inst(context).form_the_email_is_required;
    }

    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {

      return L10n.inst(context).form_email_is_not_valid;
    }

    return null;
  }

  static String? validatePhone({
    required BuildContext context,
    required String? value,
  }) {
    // TODO: removed temporarily for moderator
    return null;
    // if (value == null || value.isEmpty) {
    //   return L10n.inst(context).form_the_phone_is_required;
    // }

    // if (value.startsWith('0')) {
    //   return L10n.inst(context).form_phone_must_not_start_with_zero;
    // }

    // // 555-555-5555
    // if (value.length != 10 || int.tryParse(value) == null) {
    //   return L10n.inst(context).form_phone_is_not_valid;
    // }

    // return null;
  }

  static String? validateRegisterValue({
    required BuildContext context,
    required String? value,
  }) {
    if (value == null || value.isEmpty) {
      return L10n.inst(context).form_the_email_or_phone_is_required;
    }

    if (registerModeIsEmail(value)) {
      return validateEmail(
        context: context,
        value: value,
      );
    } else if (registerModeIsPhone(value)) {
      return validatePhone(
        context: context,
        value: value,
      );
    }

    return null;
  }

  factory RegisterUser.email({
    required String email,
    required String userName,
    required String password,
    required String fName,
    required String lName,
  }) {
    return RegisterUser(
      mode: RegisterMode.email,
      email: email,
      userName: userName,
      password: password,
      fName: fName,
      lName: lName,
      createdAt: DateTime.now(),
    );
  }

  factory RegisterUser.phone({
    required String phoneNum,
    required String userName,
    required String password,
    required String fName,
    required String lName,
    String? email,
  }) {
    return RegisterUser(
      mode: RegisterMode.phone,
      phoneNum: phoneNum,
      userName: userName,
      password: password,
      fName: fName,
      lName: lName,
      email: email,
      createdAt: DateTime.now(),
    );
  }

  factory RegisterUser.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserToJson(this);

  bool get isEmail => mode == RegisterMode.email;

  bool get isPhone => mode == RegisterMode.phone;

  LoginUser toLoginUser() {
    return LoginUser(
      mode: mode?.toLoginMode,
      userName: userName,
      password: password,
      email: email,
      phoneNum: phoneNum,
    );
  }
}
