// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_software_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JiraSoftwareProjectImpl _$$JiraSoftwareProjectImplFromJson(
        Map<String, dynamic> json) =>
    _$JiraSoftwareProjectImpl(
      expand: json['expand'] as String?,
      self: json['self'] as String?,
      id: json['id'] as String?,
      key: json['key'] as String?,
      name: json['name'] as String?,
      avatarUrls: json['avatarUrls'] == null
          ? null
          : AvatarUrls.fromJson(json['avatarUrls'] as Map<String, dynamic>),
      projectTypeKey: json['projectTypeKey'] as String?,
      simplified: json['simplified'] as bool?,
      style: json['style'] as String?,
      isPrivate: json['isPrivate'] as bool?,
      entityId: json['entityId'] as String?,
      uuid: json['uuid'] as String?,
    );

Map<String, dynamic> _$$JiraSoftwareProjectImplToJson(
        _$JiraSoftwareProjectImpl instance) =>
    <String, dynamic>{
      'expand': instance.expand,
      'self': instance.self,
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'avatarUrls': instance.avatarUrls?.toJson(),
      'projectTypeKey': instance.projectTypeKey,
      'simplified': instance.simplified,
      'style': instance.style,
      'isPrivate': instance.isPrivate,
      'entityId': instance.entityId,
      'uuid': instance.uuid,
    };

_$AvatarUrlsImpl _$$AvatarUrlsImplFromJson(Map<String, dynamic> json) =>
    _$AvatarUrlsImpl(
      s48x48: json['48x48'] as String?,
      s24x24: json['24x24'] as String?,
      s16x16: json['16x16'] as String?,
      s32x32: json['32x32'] as String?,
    );

Map<String, dynamic> _$$AvatarUrlsImplToJson(_$AvatarUrlsImpl instance) =>
    <String, dynamic>{
      '48x48': instance.s48x48,
      '24x24': instance.s24x24,
      '16x16': instance.s16x16,
      '32x32': instance.s32x32,
    };
