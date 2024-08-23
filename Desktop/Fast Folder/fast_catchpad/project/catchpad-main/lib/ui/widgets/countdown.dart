import 'dart:async';

import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';

///Good job!


class Countdown extends ConsumerStatefulWidget {
  const Countdown({
    super.key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
  });

  final Duration duration;
  final Duration interval;
  final void Function()? onFinish;
  final Widget Function(BuildContext context, Duration remaining) builder;

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends ConsumerState<Countdown> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    _duration = widget.duration;
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(widget.interval, (timer) =>
        timerCallback(timer, ref.read(currentEmbModeManager) == 1));
  }

  void timerCallback(Timer timer, bool isIga) {
    setState(() {
      if (_duration.inSeconds == 0) {
        timer.cancel();
        widget.onFinish?.call();
      } else {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _duration);
  }
}

class CountdownFormatted extends ConsumerWidget {
  const CountdownFormatted({
    super.key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
    this.formatter,
  });

  final Duration duration;
  final Duration interval;
  final void Function()? onFinish;

  /// An function to format the remaining time
  final String Function(Duration)? formatter;

  final Widget Function(BuildContext context, String remaining, bool finished)
  builder;

  Function(Duration) _formatter() {
    if (formatter != null) return formatter!;
    if (duration.inHours >= 1) return formatByHours;
    if (duration.inMinutes >= 1) return formatByMinutes;
    return formatBySeconds;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Countdown(
      interval: interval,
      onFinish: onFinish,
      duration: duration,
      builder: (BuildContext ctx, Duration remaining) {
        return builder(
          ctx,
          _formatter()(remaining),
          remaining == Duration.zero,
        );
      },
    );
  }
}
