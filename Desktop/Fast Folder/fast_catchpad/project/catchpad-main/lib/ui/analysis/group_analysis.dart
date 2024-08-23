import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class GroupAnalysis extends ConsumerStatefulWidget {
  const GroupAnalysis({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GroupAnalysisState();
}

class _GroupAnalysisState extends ConsumerState<GroupAnalysis> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.height,
      width: context.sized.width,
      child: Center(
        child: Text(
          "Yapım Aşamasında",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
