import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/consts.dart';

class DefColorSelector extends ConsumerStatefulWidget {
  final void Function(List<Color>) onChange;
  final int? min;
  final int max;
  final List<Color>? defaultColors;
  final List<Color>? unavailableColors;
  const DefColorSelector({
    required this.onChange,
    required this.max,
    this.min,
    this.defaultColors,
    this.unavailableColors,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DefColorSelector> createState() => _DefColorSelectorState();
}

class _DefColorSelectorState extends ConsumerState<DefColorSelector> {
  final selected = <Color>{};
  final unavailable = <Color>{};
  late final Set<Color> colors;

  bool isSelected(Color color) => selected.contains(color);

  bool get underMax => selected.length < widget.max;

  bool selectable(Color c) {
    return underMax || isSelected(c);
  }

  void addColor(Color c) {
    if (isSelected(c)) {
      selected.remove(c);
    } else if (underMax) {
      selected.add(c);
    }

    widget.onChange(selected.toList());
    setState(() {});
  }

  Color selectedColor(Color c) {
    bool isLight = c.red + c.green + c.blue > 500;

    return isLight ? Colors.black : Colors.white;
  }

  @override
  void initState() {
    super.initState();

    colors = defaultConstColors(ref).toSet();

    final def = widget.defaultColors;

    if (def != null && def.isNotEmpty) {
      colors.addAll(def);
      selected.addAll(def);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onChange(selected.toList());
      });
    }
    final unavai = widget.unavailableColors;

    if (unavai != null && unavai.isNotEmpty) {
      unavailable.addAll(unavai);
      colors.removeWhere(
        (c) {
          return unavailable.contains(c);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: colors.map(
            (color) {
              bool isSelected = selected.contains(color);
              return Padding(
                padding: const EdgeInsets.all(quarterDefPaddingSize),
                child: InkWell(
                  focusColor: Colors.transparent,
                  onTap: selectable(color)
                      ? () {
                          addColor(color);
                        }
                      : null,
                  child: CircleAvatar(
                    backgroundColor: isSelected ? selectedColor(color) : color,
                    radius: 28,
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 20,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        Text(
          '${selected.length}/${widget.max}',
          style: TextStyle(
            color: (widget.min != null && selected.length < widget.min!)
                ? Colors.red
                : null,
          ),
        ),
      ],
    );
  }
}
