// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructionModel _$InstructionModelFromJson(Map<String, dynamic> json) =>
    InstructionModel(
      playerIndex:
          $enumDecodeNullable(_$PlayerIndexEnumMap, json['playerIndex']),
      executionType:
          $enumDecode(_$InstructionExecutionTypeEnumMap, json['executionType']),
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((e) => InstructionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      device: $enumDecodeNullable(_$PlayerDeviceEnumMap, json['device']),
      excutionValue: json['excutionValue'] as int?,
      action: json['action'] == null
          ? null
          : ActionModel.fromJson(json['action'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : EventModel.fromJson(json['event'] as Map<String, dynamic>),
    )..parent = json['parent'] == null
        ? null
        : InstructionModel.fromJson(json['parent'] as Map<String, dynamic>);

Map<String, dynamic> _$InstructionModelToJson(InstructionModel instance) =>
    <String, dynamic>{
      'executionType':
          _$InstructionExecutionTypeEnumMap[instance.executionType]!,
      'excutionValue': instance.excutionValue,
      'instructions': instance.instructions?.map((e) => e.toJson()).toList(),
      'action': instance.action?.toJson(),
      'event': instance.event?.toJson(),
      'playerIndex': _$PlayerIndexEnumMap[instance.playerIndex],
      'device': _$PlayerDeviceEnumMap[instance.device],
      'parent': instance.parent?.toJson(),
    };

const _$PlayerIndexEnumMap = {
  PlayerIndex.first: 'first',
  PlayerIndex.second: 'second',
  PlayerIndex.third: 'third',
  PlayerIndex.fourth: 'fourth',
  PlayerIndex.fifth: 'fifth',
  PlayerIndex.sixth: 'sixth',
};

const _$InstructionExecutionTypeEnumMap = {
  InstructionExecutionType.gameEnder: 'game_ender',
  InstructionExecutionType.oneTime: 'one_time',
  InstructionExecutionType.duration: 'duration',
  InstructionExecutionType.repeat: 'repeat',
};

const _$PlayerDeviceEnumMap = {
  PlayerDevice.first: 'first',
  PlayerDevice.second: 'second',
  PlayerDevice.third: 'third',
  PlayerDevice.fourth: 'fourth',
  PlayerDevice.fifth: 'fifth',
  PlayerDevice.sixth: 'sixth',
  PlayerDevice.seventh: 'seventh',
  PlayerDevice.eighth: 'eighth',
  PlayerDevice.ninth: 'ninth',
  PlayerDevice.tenth: 'tenth',
  PlayerDevice.eleventh: 'eleventh',
  PlayerDevice.twelfth: 'twelfth',
  PlayerDevice.random: 'random',
  PlayerDevice.allExceptRandom: 'allExceptRandom',
};
