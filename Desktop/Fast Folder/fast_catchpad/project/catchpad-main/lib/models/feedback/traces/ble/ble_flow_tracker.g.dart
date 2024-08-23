// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_flow_tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BleFlowTracker _$$_BleFlowTrackerFromJson(Map<String, dynamic> json) =>
    _$_BleFlowTracker(
      bleFlowTrackerId: json['bleFlowTrackerId'] as String?,
      metaTrace: json['metaTrace'] == null
          ? null
          : MetaTrace.fromJson(json['metaTrace'] as Map<String, dynamic>),
      commandTimeTrackerList: (json['commandTimeTrackerList'] as List<dynamic>?)
              ?.map(
                  (e) => CommandTimeTracker.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CommandTimeTracker>[],
    );

Map<String, dynamic> _$$_BleFlowTrackerToJson(_$_BleFlowTracker instance) =>
    <String, dynamic>{
      'bleFlowTrackerId': instance.bleFlowTrackerId,
      'metaTrace': instance.metaTrace?.toJson(),
      'commandTimeTrackerList':
          instance.commandTimeTrackerList.map((e) => e.toJson()).toList(),
    };
