import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'player_model.dart';
import 'staged_player_model.dart';

part 'selected_player_model.freezed.dart';

@freezed
class SelectedPlayerModel with _$SelectedPlayerModel {
  const SelectedPlayerModel._();

  const factory SelectedPlayerModel({
    required PlayerModel player,
    required StagedPlayerModel staged,
  }) = _SelectedPlayerModel;

  String get id => player.id;

  bool get playerSatisfiesConditions {
    return player.satisfiesConditions(staged);
  }

  bool playerSatisfiesConditionsWithWidgetRef(WidgetRef ref,{bool isIga = false}) =>
      player.satisfiesConditions(staged,ref: ref,isIga: isIga);

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedPlayerModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
