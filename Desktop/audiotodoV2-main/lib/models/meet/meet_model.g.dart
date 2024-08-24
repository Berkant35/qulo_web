// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetImpl _$$MeetImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['meetId'],
  );
  return _$MeetImpl(
    meetId: json['meetId'] as String?,
    meetTitle: json['meetTitle'] as String?,
    meetSubtitle: json['meetSubtitle'] as String?,
    meetCategory: json['meetCategory'] as String?,
    meetContent: json['meetContent'] as String?,
    meetLocaleFilePath: json['meetLocaleFilePath'] as String?,
    meetDueDate: json['meetDueDate'] as String?,
    createdAt: json['createdAt'] as String?,
    userId: json['userId'] as String?,
    createdPdfFile: json['createdPdfFile'] as bool? ?? false,
    createdWordFile: json['createdWordFile'] as bool? ?? false,
    recordTimeSecond: (json['recordTimeSecond'] as num?)?.toInt(),
    recordTimeMs: (json['recordTimeMs'] as num?)?.toInt(),
    contentWordCount: (json['contentWordCount'] as num?)?.toInt(),
    contentLetterCount: (json['contentLetterCount'] as num?)?.toInt(),
    likeRate: (json['likeRate'] as num?)?.toDouble(),
    soundFileLink: json['soundFileLink'] as String?,
    soundFileType: json['soundFileType'] as String?,
    lang: json['lang'] as String?,
    responseTodo: json['responseTodo'] == null
        ? null
        : ResponseTodoModel.fromJson(
            json['responseTodo'] as Map<String, dynamic>),
    createdDateTime: json['createdDateTime'] == null
        ? null
        : DateTime.parse(json['createdDateTime'] as String),
  );
}

Map<String, dynamic> _$$MeetImplToJson(_$MeetImpl instance) =>
    <String, dynamic>{
      'meetId': instance.meetId,
      'meetTitle': instance.meetTitle,
      'meetSubtitle': instance.meetSubtitle,
      'meetCategory': instance.meetCategory,
      'meetContent': instance.meetContent,
      'meetLocaleFilePath': instance.meetLocaleFilePath,
      'meetDueDate': instance.meetDueDate,
      'createdAt': instance.createdAt,
      'userId': instance.userId,
      'createdPdfFile': instance.createdPdfFile,
      'createdWordFile': instance.createdWordFile,
      'recordTimeSecond': instance.recordTimeSecond,
      'recordTimeMs': instance.recordTimeMs,
      'contentWordCount': instance.contentWordCount,
      'contentLetterCount': instance.contentLetterCount,
      'likeRate': instance.likeRate,
      'soundFileLink': instance.soundFileLink,
      'soundFileType': instance.soundFileType,
      'lang': instance.lang,
      'responseTodo': instance.responseTodo?.toJson(),
      'createdDateTime': instance.createdDateTime?.toIso8601String(),
    };
