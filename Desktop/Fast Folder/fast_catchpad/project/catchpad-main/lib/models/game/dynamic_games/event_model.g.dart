// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => InstructionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'type': _$EventTypeEnumMap[instance.type]!,
      'instructions': instance.instructions.map((e) => e.toJson()).toList(),
    };

const _$EventTypeEnumMap = {
  EventType.touch: 'touch',
};
