import 'dart:math' as math;

import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../prov/game/selected_players_prov.dart';
import '../../utils/consts.dart';
import '../../utils/util_methods/util_methods.dart';
import '../game/setup_widgets/exercise_setup_widget.dart';

extension on Color {
  double contrastWithColor(Color other) {
    final thisBrightness = computeLuminance();
    final otherBrightness = other.computeLuminance();

    final brightest = math.max(thisBrightness, otherBrightness);
    final darkest = math.min(thisBrightness, otherBrightness);

    return (brightest + 0.05) / (darkest + 0.05);
  }

  bool hasGoodContrastWithColor(Color other) {
    return contrastWithColor(other) > 4.5;
  }

  Color get contrastingColor {
    if (hasGoodContrastWithColor(Colors.white)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}

class InlineColorSelector extends ConsumerStatefulWidget {
  final void Function(Set<Color>) onChange;
  final int? min;
  final int? max;
  final ColorSet selectedColors;
  final ColorSet disabledColors;
  final bool isOrdered;

  const InlineColorSelector({
    required this.onChange,
    required this.selectedColors,
    required this.disabledColors,
    required this.isOrdered,
    this.min,
    this.max,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InlineColorSelectorState();
}

class _InlineColorSelectorState extends ConsumerState<InlineColorSelector> {
  ColorSet get selected => widget.selectedColors;

  List<Color> get selectedFiltered {
    List<Color> temp = [];
    for (var clr in selected.toList()) {
      temp.add(fakeColorGenerator(clr));
    }
    return temp;
  }

  bool get isOrder => widget.isOrdered;

  ColorSet get disabled => widget.disabledColors;

  late ColorSet colors = defaultConstColors(ref).toSet();

  int? get min => widget.min;

  int get max => widget.max ?? colors.length;

  bool isSelected(Color color) => selected.contains(color);

  bool isDisabled(Color c) => disabled.contains(c);

  bool get underMax {
    return min == max || selected.length < max;
  }

  bool selectable(Color c) {
    return (underMax || isSelected(c)) && !isDisabled(c);
  }

  void addColor(Color c) {
    var sel = selected;
    if (selected.length == max) {
      final rem = sel.toList()..removeLast();
      sel = rem.toSet();
    }
    print(c);
    sel = sel..add(c);
    widget.onChange(sel);
  }

  void removeColor(Color c) {
    final sel = selected..remove(c);
    widget.onChange(sel);
  }

  Color selectedColor(Color c) {
    bool isLight = c.red + c.green + c.blue > 500;

    return isLight ? Colors.black : Colors.white;
  }

  @override
  void initState() {
    /* SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

    }); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.read(currentGameProv);
    return Padding(
      padding: const EdgeInsets.only(bottom: defPaddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (game != null && !assignColorGames.contains(game.id))
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                sequenceGames.contains(game.id!)
                    ? L10n.inst(context).game_ui_pick_color
                    : game.setup.isContainMainBase
                        ? L10n.inst(context).game_ui_pick_target_colors
                        : L10n.inst(context).game_ui_pick_target_color,
                textAlign: TextAlign.start,
              ),
            ),
          if (game != null &&
              assignColorGames.contains(
                  game.id)) //TODO EKLENECEK OYUNLAR VAR DAHA BURAYA!!!
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                L10n.inst(context).game_ui_exercise_with_picked_colors,
                textAlign: TextAlign.start,
              ),
            ),
          Wrap(
            alignment: WrapAlignment.end,
            children: colors.map(
              (color) {
                final isSelected = selected.contains(color);
                final isDisabled = disabled.contains(color);

                Color originalColor = color;
                color = fakeColorGenerator(color);
                return InkWell(
                  onTap: selectable(originalColor)
                      ? () {
                          isSelected
                              ? removeColor(originalColor)
                              : addColor(originalColor);
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: isSelected ? color.contrastingColor : color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                          child: Builder(
                            builder: (context) {
                              if (isSelected) {
                                return Center(
                                    child: (!isOrder)
                                        ? Icon(
                                            Icons.check,
                                            color: color.contrastingColor,
                                          )
                                        : Text(
                                            (selectedFiltered.indexOf(color) +
                                                    1)
                                                .toString(),
                                            style: TextStyle(
                                                color: color.contrastingColor),
                                          ));
                              }

                              if (isDisabled) {
                                return Center(
                                  child: Icon(
                                    Icons.close,
                                    color: color.contrastingColor,
                                  ),
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
          if (game != null &&
              game.setup.controlsSetup.gameExerciseOpeartionsSelectionSetup !=
                  null)
            Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: const ExerciseSetup(),
            )),
        ],
      ),
    );
  }
}

class InlineColorSelectorV2 extends ConsumerStatefulWidget {
  final void Function(Set<Color>) onChange;
  final int? min;
  final int? max;
  final ColorSet selectedColors;
  final ColorSet disabledColors;
  final bool isOrdered;

  const InlineColorSelectorV2({
    required this.onChange,
    required this.selectedColors,
    required this.disabledColors,
    required this.isOrdered,
    this.min,
    this.max,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InlineColorSelectorV2State();
}

class _InlineColorSelectorV2State extends ConsumerState<InlineColorSelectorV2> {
  ColorSet get selected => widget.selectedColors;

  List<Color> get selectedFiltered {
    List<Color> temp = [];
    for (var clr in selected.toList()) {
      temp.add(fakeColorGenerator(clr));
    }
    return temp;
  }

  bool get isOrder => widget.isOrdered;

  ColorSet get disabled => widget.disabledColors;

  late ColorSet colors = defaultConstColors(ref).toSet();

  int? get min => widget.min;

  int get max => widget.max ?? colors.length;

  bool isSelected(Color color) => selected.contains(color);

  bool isDisabled(Color c) => disabled.contains(c);

  bool get underMax {
    return min == max || selected.length < max;
  }

  bool selectable(Color c) {
    return (underMax || isSelected(c)) && !isDisabled(c);
  }

  void addColor(Color c) {
    var sel = selected;
    if (selected.length == max) {
      final rem = sel.toList()..removeLast();
      sel = rem.toSet();
    }
    sel = sel..add(c);
    widget.onChange(sel);
  }

  void removeColor(Color c) {
    final sel = selected..remove(c);
    widget.onChange(sel);
  }

  Color selectedColor(Color c) {
    bool isLight = c.red + c.green + c.blue > 500;

    return isLight ? Colors.black : Colors.white;
  }

  @override
  void initState() {
    /* SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

    }); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 90.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: colors.map(
              (color) {
                final isSelected = selected.contains(color);
                final isDisabled = disabled.contains(color);
                Color originalColor = color;
                color = fakeColorGenerator(color);
                return InkWell(
                  onTap: selectable(originalColor)
                      ? () {
                          isSelected
                              ? removeColor(originalColor)
                              : addColor(originalColor);
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: circleRadius2(),
                          width: circleRadius2(),
                          decoration: BoxDecoration(
                            color: isSelected ? color.contrastingColor : color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: circleRadius2() * 1.13,
                              width: circleRadius2() * 1.13,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              height: circleRadius2() * 1.12,
                              width: circleRadius2() * 1.12,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            if (isSelected)
                              Container(
                                height: circleRadius3() * 1.10,
                                width: circleRadius3() * 1.10,
                                decoration: BoxDecoration(
                                  color: color,
                                  border:
                                      Border.all(color: Colors.black, width: 4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Container(
                              height: circleRadius3(),
                              width: circleRadius3(),
                              decoration: BoxDecoration(
                                color: color,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                shape: BoxShape.circle,
                              ),
                              /*child: Builder(
                                builder: (context) {
                                  if (isSelected) {
                                    return Center(
                                        child: (!isOrder)
                                            ? Icon(
                                                Icons.check,
                                                color: color.contrastingColor,
                                              )
                                            : Text(
                                                (selectedFiltered
                                                            .indexOf(color) +
                                                        1)
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        color.contrastingColor),
                                              ));
                                  }

                                  if (isDisabled) {
                                    return Center(
                                      child: Icon(
                                        Icons.close,
                                        color: color.contrastingColor,
                                      ),
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),*/
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        /*Text(
          '${selected.length}/$max',
          style: (Theme.of(context).textTheme.caption ?? const TextStyle())
              .copyWith(
            color: (widget.min != null && selected.length < widget.min!)
                ? Colors.red
                : null,
          ),
        ),*/
      ],
    );
  }

  double circleRadius3() => 9.w;

  double circleRadius2() => 9.w;

  double circleRadius() => 6.w;
}
