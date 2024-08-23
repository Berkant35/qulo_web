import 'dart:async';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xrandom/xrandom.dart';

import '../../../prov/game_prov.dart';
import '../../enums/game/instruction_execution_type.dart';
import '../../enums/game/player_device.dart';
import '../../enums/game/player_index.dart';
import '../player/player_model.dart';
import 'action_model.dart';
import 'event_model.dart';

export '../../enums/game/instruction_execution_type.dart';
export '../../enums/game/player_device.dart';
export '../../enums/game/player_index.dart';
export 'action_model.dart';
export 'event_model.dart';

part 'instruction_model.g.dart';

/// [excutionValue] represents Seconds if [executionType] is [InstructionExecutionType.duration]
/// or number of times if [executionType] is [InstructionExecutionType.repeat]
@JsonSerializable()
class InstructionModel {
  final InstructionExecutionType executionType;
  final int excutionValue;
  final List<InstructionModel>? instructions;

  final ActionModel? action;
  final EventModel? event;

  final PlayerIndex? playerIndex;

  final PlayerDevice? device;

  InstructionModel? parent;

  Iterable<DeviceModel>? _deviceModels;

  InstructionModel({
    required this.playerIndex,
    required this.executionType,
    this.instructions,
    this.device,
    int? excutionValue,
    this.action,
    this.event,
  })  : assert(
          // if one time, then excution value should not be provided,
          // and will be set to 0, else it should be provided
          executionType == InstructionExecutionType.oneTime ||
              executionType == InstructionExecutionType.gameEnder ||
              excutionValue != null,
        ),
        excutionValue = excutionValue ?? 1;

  Future<bool> execute(WidgetRef ref, InstructionModel? p) async {
    // we wanna reset the saved device model, as we dont have
    // a deep copy of [InstructionModel].
    // the problem here is that we're giving a list of instructions
    // to the [GameModel] to execute, and the [GameModel] will execute
    // the same list more than once according to its own logic.
    // however, as this object does not have deep copy logic,
    // we need to reset variables each time.
    // DYNAMIC_GAME_TODO: implement deep copy logic
    _deviceModels = null;

    parent = p;

    return await _executeByType(ref);
  }

  Future<bool> _executeOnce(WidgetRef ref) async {
    await action?.execute(ref, this);

    await event?.execute(ref, this);

    if (instructions != null && instructions!.isNotEmpty) {
      for (final ins in instructions!) {
        await ins.execute(ref, this);
      }
    }

    return true;
  }

  /// {@macro cp.InstructionExecutionType}
  Future<bool> _executeByType(WidgetRef ref) async {
    void _setEnded() => ref.read(gameProv.notifier).setEnded();

    switch (executionType) {
      case InstructionExecutionType.repeat:
        {
          for (var i = 0; i < excutionValue; i++) {
            await _executeOnce(ref);
          }
          _setEnded();
          break;
        }

      case InstructionExecutionType.duration:
        {
          final dur = Duration(seconds: excutionValue);

          var durIsOver = false;

          Timer(
            dur,
            () {
              durIsOver = true;
            },
          );

          while (!durIsOver) {
            await _executeOnce(ref);
          }

          _setEnded();

          break;
        }

      case InstructionExecutionType.gameEnder:
        {
          if (instructions != null && instructions!.isNotEmpty) {
            await Future.any(instructions!.map(
              (e) => e.execute(ref, null),
            ));
          }
          break;
        }

      default:
        {
          await _executeOnce(ref);
          break;
        }
    }

    return true;
  }

  PlayerModel? getPlayer(WidgetRef ref) {
    final game = ref.read(gameProv);

    final idx = playerIndex?.index;

    final players = game?.players;

    if (idx == null ||
        players == null ||
        players.isEmpty ||
        idx < 0 ||
        idx >= players.length) {
      assert(false, 'Player not found');
      return null;
    }

    return players[idx];
  }

  String? playerId(WidgetRef ref) {
    return getPlayer(ref)?.id;
  }

  Iterable<DeviceModel>? getDevices(WidgetRef ref) {
    if (_deviceModels != null) {
      return _deviceModels;
    }

    Iterable<DeviceModel>? ret(Iterable<DeviceModel>? d) {
      _deviceModels = d;
      return d

          // we dont wanna save the parent's device
          ??
          parent?.getDevices(ref);
    }

    Iterable<DeviceModel>? retNull() => ret(null);

    if (device == null) {
      return retNull();
    }

    final d = device!;

    final devices = getPlayer(ref)?.devs;

    if (devices == null || devices.isEmpty) {
      return retNull();
    }

    if (device == PlayerDevice.random) {
      final idx = Xrandom().nextInt(devices.length);
      return ret([devices[idx]]);
    }
    final idx = d.index;

    if (idx < 0 || idx >= devices.length) {
      return retNull();
    }

    return ret([devices[d.index]]);
  }

  String? getColor(WidgetRef ref, ColorIndex idx) {
    return getPlayer(ref)?.getColor(idx);
  }

  factory InstructionModel.fromJson(Map<String, dynamic> json) =>
      _$InstructionModelFromJson(json);
  Map<String, dynamic> toJson() => _$InstructionModelToJson(this);
}
