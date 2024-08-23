// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'num_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Range _$$_RangeFromJson(Map<String, dynamic> json) => _$_Range(
      min: json['min'] as int,
      max: json['max'] as int,
      def: json['def'] as int?,
      step: json['step'] as int? ?? NumRange._defStep,
    );

Map<String, dynamic> _$$_RangeToJson(_$_Range instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'def': instance.def,
      'step': instance.step,
    };
