import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextfieldWithHeadline extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final String headline;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final String? subTitle;
  final TextInputType? keyboardType;
  const TextfieldWithHeadline(
      {required this.headline,
      this.inputFormatters,
      this.keyboardType,
      this.subTitle,
      this.controller,
      this.hintText,
      this.obscureText,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TextfieldWithHeadlineState();
}

class _TextfieldWithHeadlineState extends ConsumerState<TextfieldWithHeadline> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.headline),
        widget.subTitle == null
            ? Gap(2.h)
            : Column(
                children: [
                  Gap(1.h),
                  Text(
                    widget.subTitle!,
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  Gap(0.5.h)
                ],
              ),
        TextFormField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  )
                : null,
            hintText: widget.hintText,
          ),
        )
      ],
    );
  }
}
