// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'melody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Melody _$$_MelodyFromJson(Map<String, dynamic> json) => _$_Melody(
      melodyId: json['melodyId'] as String?,
      type: json['type'] as String?,
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      isRelease: json['isRelease'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_MelodyToJson(_$_Melody instance) => <String, dynamic>{
      'melodyId': instance.melodyId,
      'type': instance.type,
      'notes': instance.notes?.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'isRelease': instance.isRelease,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
