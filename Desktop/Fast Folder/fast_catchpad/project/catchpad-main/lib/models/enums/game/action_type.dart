import 'package:json_annotation/json_annotation.dart';

import '../../../utils/consts.dart';

@JsonEnum(fieldRename: defaultFieldRename)
enum ActionType {
  led,
  ledOff,
  increaseScore,
  startTimer,
  endTimer,
}
