// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionModel _$ActionModelFromJson(Map<String, dynamic> json) => ActionModel(
      type: $enumDecode(_$ActionTypeEnumMap, json['type']),
      value: json['value'] as String?,
      valueType: json['valueType'] as String?,
    );

Map<String, dynamic> _$ActionModelToJson(ActionModel instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'value': instance.value,
      'valueType': instance.valueType,
    };

const _$ActionTypeEnumMap = {
  ActionType.led: 'led',
  ActionType.ledOff: 'led_off',
  ActionType.increaseScore: 'increase_score',
  ActionType.startTimer: 'start_timer',
  ActionType.endTimer: 'end_timer',
};
