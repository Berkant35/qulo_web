import 'package:json_annotation/json_annotation.dart';

import '../../../utils/consts.dart';

/// {@template cp.InstructionExecutionType}
///
/// specifies how an insturction should be excuted,
/// if [InstructionExecutionType.duration], then the [instructions]
/// will keep executing until the specified duration is over.
///
/// if [InstructionExecutionType.repeat], then the [instructions]
/// will keep executing until the specified repeat value is over.
///
/// if [InstructionExecutionType.oneTime], then the [instructions]
/// will execute only once.
///
/// if [InstructionExecutionType.gameEnder], then the [instructions]
/// will execute in parelell and the game will return once any
/// instruction has returned.
///
/// {@endtemplate}
@JsonEnum(fieldRename: defaultFieldRename)
enum InstructionExecutionType {
  gameEnder,
  oneTime,
  duration,
  repeat,
}
