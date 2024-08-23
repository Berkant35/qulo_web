import 'package:flutter_riverpod/flutter_riverpod.dart';

final boolValueProvider =
    StateNotifierProvider<CancelStreamProvider, BoolModel>(
  (_) => CancelStreamProvider(BoolModel(resetEverythingAfterGameEnds: true)),
);

class CancelStreamProvider extends StateNotifier<BoolModel> {
  CancelStreamProvider(BoolModel state) : super(state);

  enableResetEverythingAfterGameEnds() {
    state = state.copyWith(resetEverythingAfterGameEnds: true);
  }

  disableResetEverythingAfterGameEnds() {
    state = state.copyWith(resetEverythingAfterGameEnds: false);
  }
}

class BoolModel {
  bool resetEverythingAfterGameEnds = false;
  BoolModel({required this.resetEverythingAfterGameEnds});

  BoolModel copyWith({
    bool? resetEverythingAfterGameEnds,
  }) =>
      BoolModel(
        resetEverythingAfterGameEnds:
            resetEverythingAfterGameEnds ?? this.resetEverythingAfterGameEnds,
      );
}
