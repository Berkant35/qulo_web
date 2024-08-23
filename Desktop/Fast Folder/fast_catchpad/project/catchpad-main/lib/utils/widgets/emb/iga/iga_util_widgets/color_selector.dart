import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../prov/game/curr_game_prov.dart';
import '../../../../../prov/game/selected_players_prov.dart';
import '../../../../consts.dart';
import '../../../../util_methods/util_methods.dart';

class ColorSelector extends ConsumerStatefulWidget {
  final void Function(Set<Color>) onChange;
  final int? min;
  final int? max;
  final ColorSet selectedColors;
  final ColorSet disabledColors;
  final bool isOrdered;

  const ColorSelector(
      {required this.onChange,
      required this.selectedColors,
      required this.disabledColors,
      required this.isOrdered,
      this.min,
      this.max,
      super.key});

  @override
  ConsumerState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends ConsumerState<ColorSelector> {
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

  late ColorSet colors = defaultConstColors(ref, isIga: true).toSet();

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
  Widget build(BuildContext context) {
    final game = ref.read(currentGameProv);

    return Container(
      width: 35.w,
      height: 8.h,
      decoration: ShapeDecoration(
        color: const Color(0xFF202020),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: Colors.white.withOpacity(0.20000000298023224),
          ),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: colors.map((color) {
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
                child: ColorContainer(
                  color,
                  isSelected: isSelected,
                  isDisabled: isDisabled,
                ),
              );
            }).toList()),
      ),
    );
  }
}

class ColorContainer extends ConsumerWidget {
  final Color pickColor;
  final bool isSelected;

  final bool isDisabled;

  const ColorContainer(this.pickColor,
      {super.key, this.isSelected = false, this.isDisabled = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 3.w,
      height: 3.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 1.8.w,
              height: 1.8.w,
              decoration: ShapeDecoration(
                color: pickColor,
                shape: const OvalBorder(),
              ),
            ),
          ),
          Container(
            width: 2.3.w,
            height: 2.3.w,
            decoration: ShapeDecoration(
              shape: OvalBorder(
                side: BorderSide(
                  width: 2,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),
          if (isSelected)
            Container(
              width: 5.w,
              height: 5.w,
              decoration: ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(
                    width: 2,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          if (isSelected)

             const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.done,
                color: Colors.black
              ),
            ),
          if (isDisabled)
             const Align(

              alignment: Alignment.center,
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
