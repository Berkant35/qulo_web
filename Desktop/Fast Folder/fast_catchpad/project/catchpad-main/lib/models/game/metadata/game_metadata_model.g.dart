// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameMetaDataModel _$$_GameMetaDataModelFromJson(Map<String, dynamic> json) =>
    _$_GameMetaDataModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      primaryScoreString: json['primaryScoreString'] as String?,
      earnings: (json['earnings'] as List<dynamic>)
          .map((e) => $enumDecode(_$GameEarningEnumMap, e))
          .toList(),
      tag: $enumDecode(_$GameTagEnumMap, json['tag']),
      isContainOnIga: json['isContainOnIga'] as bool? ?? false,
      inGameIgaHeader: json['inGameIgaHeader'] as String?,
      badgeType:
          $enumDecodeNullable(_$GameBadgeTypesEnumMap, json['badgeType']) ??
              GameBadgeTypes.none,
      categories: (json['categories'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$GameCategoryEnumMap, k), e as int?),
      ),
      playerCount:
          NumRange.fromJson(json['playerCount'] as Map<String, dynamic>),
      gamePadCount: json['gamePadCount'] == null
          ? null
          : NumRange.fromJson(json['gamePadCount'] as Map<String, dynamic>),
      padCount: NumRange.fromJson(json['padCount'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : NumRange.fromJson(json['duration'] as Map<String, dynamic>),
      delay: json['delay'] == null
          ? null
          : NumRange.fromJson(json['delay'] as Map<String, dynamic>),
      distance: json['distance'] == null
          ? null
          : NumRange.fromJson(json['distance'] as Map<String, dynamic>),
      timeout: json['timeout'] == null
          ? null
          : NumRange.fromJson(json['timeout'] as Map<String, dynamic>),
      radius: json['radius'] == null
          ? null
          : NumRange.fromJson(json['radius'] as Map<String, dynamic>),
      vibrationRadius: json['vibrationRadius'] == null
          ? null
          : NumRange.fromJson(json['vibrationRadius'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameMetaDataModelToJson(
        _$_GameMetaDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'primaryScoreString': instance.primaryScoreString,
      'earnings':
          instance.earnings.map((e) => _$GameEarningEnumMap[e]!).toList(),
      'tag': _$GameTagEnumMap[instance.tag]!,
      'isContainOnIga': instance.isContainOnIga,
      'inGameIgaHeader': instance.inGameIgaHeader,
      'badgeType': _$GameBadgeTypesEnumMap[instance.badgeType]!,
      'categories': instance.categories
          .map((k, e) => MapEntry(_$GameCategoryEnumMap[k]!, e)),
      'playerCount': instance.playerCount.toJson(),
      'gamePadCount': instance.gamePadCount?.toJson(),
      'padCount': instance.padCount.toJson(),
      'duration': instance.duration?.toJson(),
      'delay': instance.delay?.toJson(),
      'distance': instance.distance?.toJson(),
      'timeout': instance.timeout?.toJson(),
      'radius': instance.radius?.toJson(),
      'vibrationRadius': instance.vibrationRadius?.toJson(),
    };

const _$GameEarningEnumMap = {
  GameEarning.focus: 'focus',
  GameEarning.resistance: 'resistance',
  GameEarning.decision_making: 'decision_making',
  GameEarning.reaction_speed: 'reaction_speed',
  GameEarning.neural_priming: 'neural_priming',
  GameEarning.peripheral_vision: 'peripheral_vision',
  GameEarning.competitive_spirit: 'competitive_spirit',
  GameEarning.auditory_reaction: 'auditory_reaction',
  GameEarning.visual_memory: 'visual_memory',
  GameEarning.team_spirit: 'team_spirit',
  GameEarning.memory: 'memory',
  GameEarning.emotional: 'emotional',
  GameEarning.visual: 'visual',
  GameEarning.condition: 'condition',
  GameEarning.intelligence: 'intelligence',
  GameEarning.agility: 'agility',
  GameEarning.teamWork: 'teamWork',
  GameEarning.reflex: 'reflex',
  GameEarning.numeral: 'numeral',
  GameEarning.auditory: 'auditory',
  GameEarning.auditoryIntelligence: 'auditoryIntelligence',
  GameEarning.grossMotor: 'grossMotor',
  GameEarning.drama: 'drama',
  GameEarning.balance: 'balance',
  GameEarning.sync: 'sync',
  GameEarning.coordination: 'coordination',
  GameEarning.muscleDev: 'muscleDev',
  GameEarning.speed: 'speed',
  GameEarning.competition: 'competition',
  GameEarning.strength: 'strength',
  GameEarning.exercise: 'exercise',
  GameEarning.music: 'music',
  GameEarning.knowledge: 'knowledge',
};

const _$GameTagEnumMap = {
  GameTag.focus: 'focus',
  GameTag.resistance: 'resistance',
  GameTag.memory: 'memory',
  GameTag.emotional: 'emotional',
  GameTag.visual: 'visual',
  GameTag.condition: 'condition',
  GameTag.intelligence: 'intelligence',
  GameTag.agility: 'agility',
  GameTag.teamWork: 'teamWork',
  GameTag.reflex: 'reflex',
  GameTag.numeral: 'numeral',
  GameTag.auditory: 'auditory',
  GameTag.grossMotor: 'grossMotor',
  GameTag.drama: 'drama',
  GameTag.balance: 'balance',
  GameTag.strength: 'strength',
  GameTag.exercise: 'exercise',
  GameTag.speed: 'speed',
  GameTag.music: 'music',
  GameTag.knowledge: 'knowledge',
};

const _$GameBadgeTypesEnumMap = {
  GameBadgeTypes.beta: 'beta',
  GameBadgeTypes.none: 'none',
};

const _$GameCategoryEnumMap = {
  GameCategory.sports: 'sports',
  GameCategory.test: 'test',
  GameCategory.edu: 'edu',
  GameCategory.entertainment: 'entertainment',
  GameCategory.favorites: 'favorites',
  GameCategory.multiplayer: 'multiplayer',
};
