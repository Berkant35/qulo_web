// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_time_tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommandTimeTracker _$$_CommandTimeTrackerFromJson(
        Map<String, dynamic> json) =>
    _$_CommandTimeTracker(
      senTime: json['senTime'] as int? ?? 0,
      actionOfReceiverTime: json['actionOfReceiverTime'] as int?,
      elapsedTime: json['elapsedTime'] as int?,
      turnCount: json['turnCount'] as int? ?? 0,
    );

Map<String, dynamic> _$$_CommandTimeTrackerToJson(
        _$_CommandTimeTracker instance) =>
    <String, dynamic>{
      'senTime': instance.senTime,
      'actionOfReceiverTime': instance.actionOfReceiverTime,
      'elapsedTime': instance.elapsedTime,
      'turnCount': instance.turnCount,
    };
