import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class ProChronometerWidget extends ConsumerStatefulWidget {
  final int? endMillisecond;

  const ProChronometerWidget({
    this.endMillisecond,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProChronometerWidgetState();
}

class _ProChronometerWidgetState extends ConsumerState<ProChronometerWidget> {
  int milliseconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.endMillisecond == null) {
      startTimer();
    }
  }

  @override
  void dispose() {
    if (widget.endMillisecond == null) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/decorations/countdown_app_logo.png'),
        Image.asset('assets/images/decorations/countdown_app_logo_shadow.png'),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: flex(),),
              Expanded(
                flex:  3,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        flex:6,
                        child: Text(
                          DateFormat('mm:ss:')
                              .format(DateTime.fromMillisecondsSinceEpoch(
                              widget.endMillisecond != null
                                  ? widget.endMillisecond!
                                  : milliseconds)
                          )
                              .toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex:5,
                        child: Text(
                          DateFormat('SSS')
                              .format(DateTime.fromMillisecondsSinceEpoch(
                              widget.endMillisecond != null
                                  ? widget.endMillisecond!
                                  : milliseconds))
                              .toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(flex: flex(),),
            ],
          ),
        ),
      ],
    );
  }

  int flex() => 2;

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
      setState(() {
        milliseconds ++;
      });
    });
  }
}