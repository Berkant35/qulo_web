import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuHeadline extends StatelessWidget {
  final String text;
  const MenuHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold));
  }
}
