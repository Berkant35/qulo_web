import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_distance_config.freezed.dart';

@freezed
class GameDistanceConfig with _$GameDistanceConfig {
  const GameDistanceConfig._();
  const factory GameDistanceConfig({
    /// unit is mm
    required int distance,
  }) = _GameDistanceConfig;

  factory GameDistanceConfig.fromCm({required int distance}) {
    return GameDistanceConfig(distance: distance * 10);
  }

  int get distanceCm => distance ~/ 10;
}
