import 'dart:math';

import 'package:catchpad/prov/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../managers/static_games_list.dart';
import 'cp_colors.dart';

class InputDecorations {
  static InputDecoration nickNameDec(
          TextEditingController controller, bool error,
          [WidgetRef? ref, Function? setstate]) =>
      (error)
          ? InputDecoration(
              enabledBorder: Borders.whiteBorder,
              focusedBorder: Borders.yellowBorder,
              border: Borders.whiteBorder,
              disabledBorder: Borders.whiteBorder,
              errorBorder: Borders.errorBorder,
              focusedErrorBorder: Borders.errorBorder,
              hintText: instForGameScreen.classes_screen_student_type_nickname,
              hintStyle: const TextStyle(color: Colors.white),
              filled: true,
              fillColor: CpColors.inputBorderBg,
              suffixIcon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        while (true) {
                          final randint = Random().nextInt(1000);
                          if (!ref!
                              .read(classProvider.notifier)
                              .checkIfUsernameExists(
                                  controller.text + randint.toString())) {
                            controller.text =
                                controller.text + randint.toString();
                            setstate?.call();
                            break;
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      )),
                ],
              ),
              errorText: instForGameScreen.classes_screen_student_type_nickname,
              errorStyle: const TextStyle(color: Colors.red),
            )
          : InputDecoration(
              enabledBorder: Borders.whiteBorder,
              focusedBorder: Borders.yellowBorder,
              border: Borders.whiteBorder,
              disabledBorder: Borders.whiteBorder,
              errorBorder: Borders.errorBorder,
              focusedErrorBorder: Borders.errorBorder,
              hintText: instForGameScreen.classes_screen_student_type_nickname,
              hintStyle: const TextStyle(color: Colors.white),
              filled: true,
              fillColor: CpColors.inputBorderBg,
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  )),
              //errorText: instForGameScreen.branch_code_error,
              //errorStyle: const TextStyle(color: Colors.red),
            );

  static final firstNameDec = InputDecoration(
    enabledBorder: Borders.whiteBorder,
    focusedBorder: Borders.yellowBorder,
    border: Borders.whiteBorder,
    disabledBorder: Borders.whiteBorder,
    errorBorder: Borders.errorBorder,
    focusedErrorBorder: Borders.errorBorder,
    hintText: instForGameScreen.form_first_name,
    hintStyle: const TextStyle(color: Colors.white),
    filled: true,
    fillColor: CpColors.inputBorderBg,
    //errorText: instForGameScreen.branch_code_error,
    //errorStyle: const TextStyle(color: Colors.red),
  );


  static InputDecoration getDynamicDecoration(String hintText){
    return firstNameDec.copyWith(
      hintText: hintText
    );
  }



  static final lastNameDec = InputDecoration(
    enabledBorder: Borders.whiteBorder,
    focusedBorder: Borders.yellowBorder,
    border: Borders.whiteBorder,
    disabledBorder: Borders.whiteBorder,
    errorBorder: Borders.errorBorder,
    focusedErrorBorder: Borders.errorBorder,
    hintText: instForGameScreen.form_last_name,
    hintStyle: const TextStyle(color: Colors.white),
    filled: true,
    fillColor: CpColors.inputBorderBg,
    //errorText: instForGameScreen.username_error,
    //errorStyle: const TextStyle(color: Colors.red),
  );

  static final numberDec = InputDecoration(
    enabledBorder: Borders.whiteBorder,
    focusedBorder: Borders.yellowBorder,
    border: Borders.whiteBorder,
    disabledBorder: Borders.whiteBorder,
    errorBorder: Borders.errorBorder,
    focusedErrorBorder: Borders.errorBorder,
    hintText: instForGameScreen.classes_screen_number,
    hintStyle: const TextStyle(color: Colors.white),
    filled: true,
    fillColor: CpColors.inputBorderBg,
    //errorText: instForGameScreen.password_error,
    //errorStyle: const TextStyle(color: Colors.red),
  );
}

class Borders {
  static const whiteBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.white, style: BorderStyle.solid, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  static const yellowBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: CpColors.cpYellow, style: BorderStyle.solid, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  static const errorBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.red, style: BorderStyle.solid, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));
}
