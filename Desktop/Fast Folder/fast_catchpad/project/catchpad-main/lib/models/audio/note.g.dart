// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      duration: json['duration'] as num?,
      durationTicks: json['durationTicks'] as num?,
      midi: json['midi'] as num?,
      name: json['name'] as String?,
      ticks: json['ticks'] as num?,
      time: json['time'] as num?,
      velocity: json['velocity'] as num?,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'duration': instance.duration,
      'durationTicks': instance.durationTicks,
      'midi': instance.midi,
      'name': instance.name,
      'ticks': instance.ticks,
      'time': instance.time,
      'velocity': instance.velocity,
    };
