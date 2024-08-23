import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenShotBottomSheet extends ConsumerStatefulWidget {
  final File file;

  const ScreenShotBottomSheet({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ScreenShotBottomSheetState();
}

class _ScreenShotBottomSheetState extends ConsumerState<ScreenShotBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Image.file(widget.file, fit: BoxFit.cover));
  }
}
