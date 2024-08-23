import 'package:json_annotation/json_annotation.dart';

import '../../../utils/consts.dart';

@JsonEnum(fieldRename: defaultFieldRename)
enum EventType {
  touch,
}
