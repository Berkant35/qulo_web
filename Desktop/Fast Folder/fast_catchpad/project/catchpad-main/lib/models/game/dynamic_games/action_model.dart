import 'dart:ui';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../prov/game_result_prov.dart';
import 'dynamic_game_model.dart';

export '../../enums/game/action_type.dart';
export '../../enums/game/color_index.dart';

part 'action_model.g.dart';

@JsonSerializable()
class ActionModel {
  final ActionType type;

  /// as we cant use generic types in json serialization,
  /// we're gonna take value as a string, and also take [valueType]
  /// so we can compare the type and use the value accordingly
  final String? value;
  final String? valueType;

  ActionModel({
    required this.type,
    this.value,
    this.valueType,
  });

  Future<bool> execute(WidgetRef ref, InstructionModel parent) async {
    final playerId = parent.playerId(ref);
    final devs = parent.getDevices(ref);

    switch (type) {
      case ActionType.increaseScore:
        {
          if (playerId == null) return false;

          ref.read(gameResultProv.notifier).increaseScore(ref,playerId);

          return true;
        }
      case ActionType.ledOff:
        {
          if (devs == null || devs.isEmpty) {
            assert(false);
            return false;
          }
          var res = false;
          for (var dev in devs) {
            res = await PadManager.ledOff(
              dev.id,
              ref: ref,
            );
          }

          return res;
        }
      case ActionType.startTimer:
        {
          if (playerId == null) return false;

          ref
              .read(gameResultProv.notifier)
              .setPlayerStartTime(playerId: playerId);
          return true;
        }
      case ActionType.endTimer:
        {
          if (playerId == null) return false;

          ref
              .read(gameResultProv.notifier)
              .setPlayerEndTime(playerId: playerId);
          return true;
        }

      case ActionType.led:
        {
          if (devs == null || devs.isEmpty) {
            assert(false);
            return false;
          }

          var res = false;
          for (var dev in devs) {
            final val = _val(ref, parent);
            if (val == null) {
              assert(false);
              return false;
            }
            res = await PadManager.ledColor(
              dev.id,
              // DYNAMIC_GAME_TODO: let the game model take different colors as input
              SidesColorsModel.all(val as Color),
              ref: ref,
            );
          }

          return res;
        }
    }
  }

  /// when we're gonna have [ColorIndex.constRandom],
  /// we wanna reuse this, which will be created only once
  Color? _savedClr;

  dynamic _val(WidgetRef ref, InstructionModel parent) {
    if (valueType == null || value == null) {
      assert(false);
      return null;
    }

    if (valueType == valueTypeColorIndex) {
      final clrI =
          EnumToString.fromString<ColorIndex>(ColorIndex.values, value!);
      if (clrI == null) {
        assert(false);
        return null;
      }

      /// if [ColorIndex.constRandom], then reuse the same color
      if (clrI == ColorIndex.constRandom && _savedClr != null) {
        return _savedClr;
      }

      final clr = parent.getColor(ref, clrI);

      if (clr == null) {
        return null;
      }

      return _savedClr = CpColorExt.fromJson(clr);
    }
  }

  static const String valueTypeInt = 'int';
  static const String valueTypeColorIndex = 'ColorIndex';

  factory ActionModel.fromJson(Map<String, dynamic> json) =>
      _$ActionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActionModelToJson(this);
}
