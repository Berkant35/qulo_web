import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PasswordTextfield extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const PasswordTextfield(
      {this.inputFormatters,
      this.keyboardType,
      this.controller,
      this.hintText,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordTextfieldState();
}

class _PasswordTextfieldState extends ConsumerState<PasswordTextfield> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: Icon(
            isObscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
