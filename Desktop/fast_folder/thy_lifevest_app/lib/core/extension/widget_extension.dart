import 'package:flutter/material.dart';

extension WidgetExtension on Widget? {
  Widget get toSliver => SliverToBoxAdapter(child: this);
  Widget toSliverPadding({required EdgeInsetsGeometry padding}) =>
      SliverPadding(sliver: this, padding: padding);
  Widget toSliverWithPadding({required EdgeInsetsGeometry padding}) =>
      SliverPadding(sliver: toSliver, padding: padding);
}
