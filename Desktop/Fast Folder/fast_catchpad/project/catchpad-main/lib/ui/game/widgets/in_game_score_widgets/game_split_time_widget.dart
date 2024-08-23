import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplitTimeWidget extends ConsumerStatefulWidget {
  final List<DateTime> dateTimes;

  //final List<String> bleNumberList;
  const SplitTimeWidget({
    required this.dateTimes,
    //required this.bleNumberList,
    super.key,
  });

  @override
  ConsumerState createState() => _SplitTimeWidgetState();
}

class _SplitTimeWidgetState extends ConsumerState<SplitTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          splitOfTitles(context),
          listOfSplits(context),
        ],
      ),
    );
  }

  ListTile splitOfTitles(BuildContext context) {
    return ListTile(
      leading: Text(
        L10n.inst(context).activity_default_station,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      title: Text(
        L10n.inst(context).activity_default_scores_average_split,
        style: Theme.of(context).textTheme.titleSmall,
        overflow: TextOverflow.clip,
      ),
      trailing: Text(
        L10n.inst(context).activity_default_scores_average_time,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Padding listOfSplits(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.43,
        decoration: BoxDecoration(
          color: (const Color.fromARGB(58, 255, 255, 255)),
          border: Border.all(color: const Color.fromARGB(18, 255, 255, 255)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02, bottom: 8.h),
          child: ListView.builder(
            itemCount: widget.dateTimes.length,
            itemBuilder: (context, index) {
              return Column(
                children: [perSplitTile(index, context), const Divider()],
              );
            },
          ),
        ),
      ),
    );
  }

  Row perSplitTile(int index, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              "${(widget.dateTimes.length - 1) - index + 1}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16.sp),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Text(
              getDiffDateTime(
                      widget.dateTimes[((widget.dateTimes.length - 1) - index)],
                      (widget.dateTimes.length - 1) - index == 0
                          ? null
                          : widget.dateTimes[
                              (widget.dateTimes.length - 1) - index - 1]) ??
                  "-",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16.sp),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Center(
            child: ref
                        .read(currentFirstActionTimeManager.notifier)
                        .roundPoints
                        .length >
                    (widget.dateTimes.length - 1 - index)
                ? Text(
                    DateFormat('mm:ss:SSS').format(
                        DateTime.fromMillisecondsSinceEpoch(ref
                            .read(currentFirstActionTimeManager.notifier)
                            .roundPoints[(widget.dateTimes.length - 1 - index)]
                            .inMilliseconds)),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16.sp),
                  )
                : const SizedBox(),
          ),
        )
      ],
    );
  }

  Padding buildContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: halfDefPaddingSize),
      child: Container(
        color: CpColors.cpYellow,
        width: MediaQuery.of(context).size.width * 0.008,
        height: MediaQuery.of(context).size.height * 0.01,
      ),
    );
  }

  String? getDiffDateTime(DateTime dateTime, DateTime? preTime) {
    if (preTime == null && ref.read(currentFirstActionTimeManager) != null) {
      final dateDiffByZeroPoint =
          dateTime.difference(ref.read(currentFirstActionTimeManager)!);
      final minutes = dateDiffByZeroPoint.inMinutes
          .remainder(60)
          .abs() // Negatif değeri pozitif yapmak için 'abs()' kullanılır.
          .toString()
          .padLeft(2, '0');
      final seconds = dateDiffByZeroPoint.inSeconds
          .remainder(60)
          .abs()
          .toString()
          .padLeft(2, '0');
      final milliseconds = dateDiffByZeroPoint.inMilliseconds
          .remainder(1000)
          .abs()
          .toString()
          .padLeft(3, '0');

      return '$minutes:$seconds:$milliseconds';
    }

    if (preTime == null) return null;

    final dateDiffDuration = dateTime.difference(preTime);
    final minutes = dateDiffDuration.inMinutes
        .remainder(60)
        .abs()
        .toString()
        .padLeft(2, '0');
    final seconds = dateDiffDuration.inSeconds
        .remainder(60)
        .abs()
        .toString()
        .padLeft(2, '0');
    final milliseconds = dateDiffDuration.inMilliseconds
        .remainder(1000)
        .abs()
        .toString()
        .padLeft(3, '0');

    return '$minutes:$seconds:$milliseconds';
  }
}
