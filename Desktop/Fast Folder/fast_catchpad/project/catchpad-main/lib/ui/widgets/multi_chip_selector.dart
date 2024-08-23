import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui/widgets/cp_chip.dart';

class MultiChipSelector<T> extends ConsumerStatefulWidget {
  final void Function(Set<T>) onChange;
  final int? min;
  final int? max;

  final Set<T> allElements;
  final Set<T> selectedElements;

  /// these are the elements that will
  /// be displayed disabled and be
  /// unselectable
  final Set<T> disabledElements;

  final String Function(T) getId;
  final String Function(T) getLabel;

  final Widget Function(T item, bool isSelected, void Function()? onSelected, )?
      builder;
  //TODO CREATE MAİN BASE CREATE FUNCTION

  const MultiChipSelector({
    required this.onChange,
    this.min,
    this.max,
    required this.allElements,
    required this.selectedElements,
    required this.disabledElements,
    required this.getId,
    required this.getLabel,
    this.builder,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MultiChipSelector<T>> createState() =>
      _MultiChipSelectorState<T>();
}

class _MultiChipSelectorState<T> extends ConsumerState<MultiChipSelector<T>> {
  Set<T> get all => widget.allElements.toSet();

  /// here we're filtering only elements that are contained
  /// in all elements domain. this case is useful in
  /// mentorControlsState selection, as by default .ask may
  /// be selected and we dont want to show that option to
  /// the user.
  Set<T> get selected => widget.selectedElements
      .where(
        (element) => all.contains(element),
      )
      .toSet();
  Set<T> get disabled => widget.disabledElements
      .where(
        (element) => all.contains(element),
      )
      .toSet()
      .toSet();

  int get allCount => all.length;
  int get selectedCount => selected.length;
  int get disabledCount => disabled.length;

  int? get min => widget.min;
  int get max => widget.max ?? allCount;

  bool isSelected(T d) => selected.contains(d);
  bool isDisabled(T d) => disabled.contains(d);

  bool get underMax {
    return min == max || selected.length < max;
  }

  bool selectable(T c) {
    return underMax || isSelected(c);
  }

  void addElement(T c) {
    var sel = selected;
    if (selected.length == max) {
      final rem = sel.toList()..removeLast();
      sel = rem.toSet();
    }
    sel = sel..add(c);
    widget.onChange(sel);
  }

  void removeElement(T c) {
    // we cannot restrict what the player can and cannot deselect,
    // for example previously there way a restriction here for unselection
    // if all elements are selected, we cannot deselect any of them. but that
    // did not work out, as I was trying to select specific 2 pads where
    // `min == max == 2
    final sel = selected..remove(c);
    widget.onChange(sel);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          alignment: WrapAlignment.end,
          children: all.map(
            (element) {
              bool isSelected = selected.contains(element);

              void onSelected(val) {
                if (val) {
                  addElement(element);
                } else {
                  removeElement(element);
                }
              }




              void Function(bool)? onSelectedGenerator() {
                final isDis = isDisabled(element);
                final isS = isSelected;
                final und = underMax;

                if (!isDis && (isS || und)) {
                  return onSelected;
                }

                return null;
              }

              if (widget.builder != null) {
                return widget.builder!(
                  element,
                  isSelected,
                  () {
                    final ons = onSelectedGenerator();

                    ons?.call(!isSelected);
                  }
                );
              }

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: CpChip(
                  key: Key('${widget.getId(element)} ${isSelected.toString()}'),
                  text: widget.getLabel(element),
                  fontSize: Theme.of(context).textTheme.caption?.fontSize,
                  initialSelected: isSelected,
                  onSelected: onSelectedGenerator(),
                ),
              );
            },
          ).toList(),
        ),
       
      ],
    );
  }
}
