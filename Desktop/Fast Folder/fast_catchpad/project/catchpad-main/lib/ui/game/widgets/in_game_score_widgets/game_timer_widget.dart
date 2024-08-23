import 'dart:async';

import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../prov/auth/current_user_prov.dart';
import '../../../../prov/end_game_prov.dart';
import '../../../../prov/game/curr_game_prov.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/widgets/cp_counter.dart';

class TimerWidget extends ConsumerStatefulWidget {
  const TimerWidget(
      {super.key,
        this.countDown = true,
        this.inGameTime = true,
        this.lastTotalDuration = '00:00'});

  final bool countDown, inGameTime;
  final String lastTotalDuration;

  @override
  ConsumerState<TimerWidget> createState() => _TimerWidgettState();
}

class _TimerWidgettState extends ConsumerState<TimerWidget> {
  Stopwatch? mywatcher;
  late Timer mytimer;
  int? gameTime;
  int? secondsLeft;
  bool isDone = false;
  bool forceStarted = false;

  @override
  void initState() {
    Future(() {
      ref.read(currentShowTimerWidget.notifier).changState(false);
    });

    if (widget.inGameTime) {
      final game = ref.read(currentGameProv);

      gameTime = game?.setup.duration?.def;

      if ((game?.id == 's16' || game?.id == 's14') &&
          ((game?.setup.duration?.def == 120 && game?.id == 's16') ||
              (game?.setup.duration?.def == 40 && game?.id == 's14')) &&
          adminIdList.contains(ref.read(currentUserProv)!.uid)) {
        gameTime = 8000000;
      }

      if (gameTime != null) {
        mywatcher = Stopwatch();
        mywatcher!.start();
        SchedulerBinding.instance.addPostFrameCallback(
              (timeStamp) {
            mytimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
              setState(() {});
            });
          },
        );
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // if (widget.inGameTime && gameTime != null) {
    //   mywatcher.stop();
    //   mywatcher.reset();
    //   mytimer.cancel();
    // }
    if (mywatcher != null) {
      mywatcher!.stop();
      mywatcher!.reset();
      mytimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTimerWidgetState = ref.watch(currentShowTimerWidget);
    final gameId = ref.watch(currentGameProv)!.id;
    final embMode = ref.read(currentEmbModeManager);
    TextStyle timerStyle = ref.read(currentEmbModeManager) == 1
        ? Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500)
        : Theme.of(context).textTheme.headlineLarge!;

    if ((embMode == 1 && gameId == 's35' && showTimerWidgetState)) {
      if (!forceStarted) forceInitializeWatcher();
    } else if ((embMode == 1 && gameId == 's35' && !showTimerWidgetState)) {
      return const SizedBox();
    }

    // if (gameTime == null) {
    //   logger.i("Game Time Null");
    //   return const SizedBox();
    // }

    if (widget.countDown && widget.inGameTime) {
      if ((embMode == 1 && gameId == 's35' && showTimerWidgetState)) {
        secondsLeft =
            ref.read(gameEndingProvider.notifier).remainDuration.inSeconds;
      } else {
        if (gameTime != null) {
          secondsLeft = gameTime! - (mywatcher!.elapsedMilliseconds ~/ 1000);
        }
      }
    }

    String timeText = timeTextFunction();
    if (timeText == '0') {
      isDone = true;
    }
    if (isDone) {
      timeText = '0';
    }
    return Padding(
      padding: EdgeInsets.only(
          top: ref.read(currentEmbModeManager) == 0 ? 0 : defPaddingSize * 4),
      child: SizedBox.square(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Image.asset(
                //   'assets/images/decorations/countdown_app_logo.png',
                // ),
                // Image.asset(
                //   'assets/images/decorations/countdown_app_logo_shadow.png',
                // ),
                const CpLogo2(),
                (widget.inGameTime)
                    ? inGameTimeRichText(timeText, timerStyle, context)
                    : Text.rich(
                  TextSpan(
                    text: widget.lastTotalDuration,
                    style: timerStyle,
                  ),
                ), //:${mywatcher.elapsedMilliseconds % 100}
              ],
            ),
                () {
              if (ref.read(currentEmbModeManager) == 1 &&
                  ref.read(currentGameProv) != null &&
                  ref.read(currentGameProv)!.id == 's35') {
                final remain = int.parse(timeText);
                var contentText = "";
                if (remain <= 5) {
                  contentText = L10n.inst(context).iga_pad_match_in_game_alert;
                } else if (remain > 5 && remain < 10) {
                  contentText =
                      L10n.inst(context).iga_pad_match_in_game_reminder;
                }
                Future(() {
                  ref
                      .read(currentRemainBulBakalim.notifier)
                      .changState(contentText.isNotEmpty);
                });
                return Text(
                  contentText,

                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 12.sp
                  ),

                  textAlign: TextAlign.center,
                );
              } else {
                Future(() {
                  ref.read(currentRemainBulBakalim.notifier).changState(false);
                });

                return const SizedBox();
              }
            }()
          ],
        ),
      ),
    );
  }

  Text inGameTimeRichText(
      String timeText, TextStyle timerStyle, BuildContext context) {
    return Text.rich(
      TextSpan(
          text: widget.countDown
              ? timeText
              : '${(mywatcher!.elapsedMilliseconds ~/ 60000) % 60}:${(mywatcher!.elapsedMilliseconds ~/ 1000) % 60}',
          style: timerStyle,
          children: [
            TextSpan(text: "S", style: timerStyle.copyWith(fontSize: 15.sp))
          ]),
    );
  }

  void forceInitializeWatcher() {
    forceStarted = true;
    mywatcher = Stopwatch();
    mywatcher!.start();
    SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) {
        mytimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
          setState(() {
            gameTime =
                ref.read(gameEndingProvider.notifier).remainDuration.inSeconds;
          });
        });
      },
    );
  }

  String timeTextFunction() {
    return secondsLeft != null
        ? (secondsLeft! ~/ 60 == 0)
        ? '${secondsLeft! % 60}'
        : '${secondsLeft! ~/ 60}:' '${secondsLeft! % 60}'
        : '0';
  }
}

class TimerLogo extends StatelessWidget {
  const TimerLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        CpLogo2(),
      ],
    );
  }
}

class CpLogo2 extends ConsumerWidget {
  const CpLogo2({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return CpCounter(size: ref.read(currentEmbModeManager) == 1 ? 5.w :14.w,currentIndex: 0);

  }
}