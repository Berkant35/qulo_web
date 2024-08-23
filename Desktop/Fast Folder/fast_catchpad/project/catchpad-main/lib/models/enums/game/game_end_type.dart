import 'package:json_annotation/json_annotation.dart';

import '../../../utils/consts.dart';

/// for now there are 3 game types:
/// - the ones that end after [durationSeconds] seconds
/// - the ones that ends when a player reaches [maxScore] points
/// - the ones that end as specified in [instructions]
@JsonEnum(fieldRename: defaultFieldRename)
enum GameEndType {
  duration,
  score,
  instructions;

}
Map<String, dynamic> gameEndTypeToJson(GameEndType type) {
        return {"type": type.name};
  }

  GameEndType gameEndTypeFromJson(Map<String, dynamic> json) {
    return GameEndType.values.firstWhere((e) => e.name == json['type']);
  }