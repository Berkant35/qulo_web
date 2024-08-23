import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../ui/widgets/inline_color_selector.dart';
import '../cp_colors.dart';
import '../util_methods/util_methods.dart';

class SelectPadColorOnPeriod extends ConsumerStatefulWidget {
  final DiscoveredDevice? currentDiscoveredDevice;
  final int index;
  final ValueNotifier<Map<String, DiscoveredDevice?>> selectedDevices;

  const SelectPadColorOnPeriod(
      {super.key,
      required this.currentDiscoveredDevice,
      required this.index,
      required this.selectedDevices});

  @override
  ConsumerState createState() => _SelectPadColorOnPeriodState();
}

class _SelectPadColorOnPeriodState
    extends ConsumerState<SelectPadColorOnPeriod> {
  bool isOpen = true;
  bool onceTimeOpen = false;

  @override
  Widget build(BuildContext context) {

    // Color selector that will open when the user places a pad on the target

    if (widget.selectedDevices.value[widget.index.toString()] != null &&
        !onceTimeOpen) {
      isOpen = false;
      if (!onceTimeOpen) onceTimeOpen = true;
    }

    return GestureDetector(
      onTap: closeOpen,
      child: Container(
        child: isOpen
            ? onClose() : onOpen(),
      ),
    );

  }

  void closeOpen() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  Widget onClose() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(24.px),
            ),
            color: widget.currentDiscoveredDevice != null &&
                    ref.read(currentPeriodColorQueueManager)[
                            widget.currentDiscoveredDevice!.id +
                                widget.index.toString()] !=
                        null
                ? fakeColorGenerator(ref.read(currentPeriodColorQueueManager)[
                    widget.currentDiscoveredDevice!.id +
                        widget.index.toString()]!)
                : null,
          ),
          child: (widget.currentDiscoveredDevice == null ||
                  ref.read(currentPeriodColorQueueManager)[
                          widget.currentDiscoveredDevice!.id +
                              widget.index.toString()] ==
                      null)
              ? const Icon(Icons.cancel_rounded)
              : const SizedBox(),
        ),
      );

  Widget onOpen() => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Container(
            width: 98.w,
            height: 35.h,
            decoration: BoxDecoration(
                color: CpColors.backgroundGradient.colors.first,
                borderRadius: BorderRadius.all(Radius.circular(24.px))),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: InlineColorSelector(
                          onChange: (Set<Color> clr) {
                            if (widget.currentDiscoveredDevice != null) {
                              ref
                                  .read(currentPeriodColorQueueManager.notifier)
                                  .add(ref,
                                      deviceId:
                                          widget.currentDiscoveredDevice!.id,
                                      color: clr.last,
                                      queue: widget.index);

                              setState(() {});
                            }
                          },
                          max: 1,
                          min: 1,
                          selectedColors: colorLogic(),
                          disabledColors: colorLogic(),
                          isOrdered: false,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: Colors.white,
                      onPressed: closeOpen,
                      icon: const Icon(Icons.cancel),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Set<Color> colorLogic() {
    return widget.currentDiscoveredDevice != null &&
            ref.watch(currentPeriodColorQueueManager)[
                    widget.currentDiscoveredDevice!.id +
                        widget.index.toString()] !=
                null
        ? {
            ref.watch(currentPeriodColorQueueManager)[
                widget.currentDiscoveredDevice!.id + widget.index.toString()]!
          }
        : {};
  }
}
