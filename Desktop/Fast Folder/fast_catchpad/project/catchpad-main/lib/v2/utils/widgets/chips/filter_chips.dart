import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilterChips extends ConsumerStatefulWidget {
  final List<String> filters;
  const FilterChips({required this.filters, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FilterChipsState();
}

class FilterChipsState extends ConsumerState<FilterChips> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 2.w)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    isSelected
                        ? Colors.white.withOpacity(0.1)
                        : Colors.white.withOpacity(0.04),
                  ),
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: isSelected ? CpColors.cpPrimary : Colors.white,
                      width: 1.5,
                    ),
                  )),
              child: Text(
                widget.filters[index],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400),
              ),
            ),
          );
        },
        itemCount: widget.filters.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}
