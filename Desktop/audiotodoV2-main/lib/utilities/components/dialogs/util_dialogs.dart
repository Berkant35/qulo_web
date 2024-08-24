// Select date select country whatever

import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UtilDialogs {
  static const int day = 3000;


  static Future<DateTime?> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    return await showDialog(
        context: context,
        builder: (context) {
          return DatePickerDialog(

              initialDate: selectedDate,
              firstDate: selectedDate,
              lastDate: selectedDate.add(const Duration(days: day)));
        });
  }
  // static Future<DateTime?> selectDateFromIos(BuildContext context) async {
  //   DateTime selectedDate = DateTime.now();
  //   DateTime? pickedDate;
  //
  //   return await showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) {
  //       return CupertinoActionSheet(
  //         actions: [
  //           Container(
  //             height: 216.0,
  //             child: CupertinoDatePicker(
  //               mode: CupertinoDatePickerMode.,
  //               initialDateTime: selectedDate,
  //               minimumDate: selectedDate,
  //               maximumDate: selectedDate.add(const Duration(days: day)),
  //               onDateTimeChanged: (DateTime newDate) {
  //                 pickedDate = newDate;
  //               },
  //             ),
  //           ),
  //         ],
  //
  //
  //       );
  //     },
  //   );
  // }


  static Future<String?> getName(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    // get string dialog
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              S.current.dialog_label_enter_name,
              style: ThemeValueExtension.titleTextStyle,
            ),
            content: TextField(
              controller: nameController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    nameController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.current.cancel,
                    style: ThemeValueExtension.buttonTextStyle,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.current.utilities_save,
                    style: ThemeValueExtension.buttonTextStyle,
                  )),
            ],
          );
        });

    return nameController.text.isNotEmpty ? nameController.text : null;
  }
}

/*CupertinoDatePicker(
              minimumDate: selectedDate,
              maximumDate: selectedDate.add(Duration(days: 30)),
              initialDateTime: selectedDate,
              onDateTimeChanged: (val) {
                logger.i("val: $val");
              })*/
