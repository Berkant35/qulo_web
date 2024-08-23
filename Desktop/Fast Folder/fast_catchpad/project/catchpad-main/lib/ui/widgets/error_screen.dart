import 'package:flutter/material.dart';

import 'error_widget.dart';

class ErrorScreen extends StatelessWidget {
  final Object? error;
  final StackTrace? stack;
  const ErrorScreen(this.error, this.stack, {Key? key}) : super(key: key);

  const ErrorScreen.error(this.error, {Key? key})
      : stack = null,
        super(key: key);

  const ErrorScreen.empty({Key? key})
      : error = null,
        stack = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ErrWidget(error, stack),
    );
  }
}
