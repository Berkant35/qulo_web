import 'package:catchpad/models/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextInputFormatter? inputFormatter;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Student? student;
  final String hintText;
  final leadingText;
  final bool? autofocus;

  const CustomTextField(
      {super.key,
      this.inputFormatter,
      this.autofocus = false,
      required this.controller,
      required this.textInputType,
      this.student,
      required this.hintText,
      required this.leadingText});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(leadingText ?? ''),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          autofocus: autofocus!,
          keyboardType: textInputType,
          controller: controller,
          inputFormatters: [
            inputFormatter ??
                TextInputFormatter.withFunction(
                    (oldValue, newValue) => newValue)
          ],
          decoration: InputDecoration(
              suffixIcon: const Icon(Icons.edit), hintText: hintText),
        ),
      ),
    );
  }
}
