import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class TraceBase {
  Future<void> create(WidgetRef ref);

  void calculateDiffTimeWithEndState(WidgetRef ref);

  void incrementClickCount();

  void disposeCurrentTrace();




}
