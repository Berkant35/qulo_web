import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class GameDialogWrapper extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const GameDialogWrapper({
    required this.children,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defPaddingSize),
          child: IntrinsicWidth(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: defPaddingSize),
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
