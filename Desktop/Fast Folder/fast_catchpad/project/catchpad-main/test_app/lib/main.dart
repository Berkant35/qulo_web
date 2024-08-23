import 'package:catchpad/utils/cp_theme.dart';
import 'package:flutter/material.dart';

import 'theme_test.dart';

void main() {
  runApp(
    const TestApp(),
  );
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ThemeTestScreen(),
      theme: CpTheme.theme,
    );
  }
}
