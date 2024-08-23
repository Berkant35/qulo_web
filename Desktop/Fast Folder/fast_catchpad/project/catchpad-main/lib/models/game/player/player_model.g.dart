// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayerModel _$$_PlayerModelFromJson(Map<String, dynamic> json) =>
    _$_PlayerModel(
      id: json['id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String?,
      user: _userFromJson(json['user']),
      colors: json['colors'] == null
          ? const []
          : _colorsFromJson(json['colors'] as List),
      devices: json['devices'] == null
          ? const []
          : _devicesFromJson(json['devices'] as List),
    );

Map<String, dynamic> _$$_PlayerModelToJson(_$_PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'name': instance.name,
      'user': _userToJson(instance.user),
      'colors': _colorsToJson(instance.colors),
      'devices': _devicesToJson(instance.devices),
    };
