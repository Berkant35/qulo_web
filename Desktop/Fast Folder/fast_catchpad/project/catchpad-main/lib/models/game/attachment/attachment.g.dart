// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Attachment _$$_AttachmentFromJson(Map<String, dynamic> json) =>
    _$_Attachment(
      url: json['url'] as String?,
      filePath: json['filePath'] as String,
      fileName: json['fileName'] as String,
      id: json['id'] as String,
      audioType: $enumDecodeNullable(_$GameAudioTypeEnumMap, json['audioType']),
    );

Map<String, dynamic> _$$_AttachmentToJson(_$_Attachment instance) =>
    <String, dynamic>{
      'url': instance.url,
      'filePath': instance.filePath,
      'fileName': instance.fileName,
      'id': instance.id,
      'audioType': _$GameAudioTypeEnumMap[instance.audioType],
    };

const _$GameAudioTypeEnumMap = {
  GameAudioType.music: 'music',
  GameAudioType.soundEffect: 'soundEffect',
  GameAudioType.gameAudio: 'gameAudio',
  GameAudioType.force: 'force',
};
