// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_match_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordMatchTimeImpl _$$WordMatchTimeImplFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['wordMatchTimeId', 'meetId'],
  );
  return _$WordMatchTimeImpl(
    wordMatchTimeId: json['wordMatchTimeId'] as String?,
    meetId: json['meetId'] as String?,
    contentWord: json['contentWord'] as String?,
    contentWords: (json['contentWords'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    timeMs: (json['timeMs'] as num?)?.toInt(),
    timeMin: (json['timeMin'] as num?)?.toInt(),
    timeSec: (json['timeSec'] as num?)?.toInt(),
    starTimePointWithMs: (json['starTimePointWithMs'] as num?)?.toInt(),
    endTimePointWithMs: (json['endTimePointWithMs'] as num?)?.toInt(),
    soundQuality: json['soundQuality'] as String?,
    backgroundNoiseLevel: json['backgroundNoiseLevel'] as String?,
  );
}

Map<String, dynamic> _$$WordMatchTimeImplToJson(_$WordMatchTimeImpl instance) =>
    <String, dynamic>{
      'wordMatchTimeId': instance.wordMatchTimeId,
      'meetId': instance.meetId,
      'contentWord': instance.contentWord,
      'contentWords': instance.contentWords,
      'timeMs': instance.timeMs,
      'timeMin': instance.timeMin,
      'timeSec': instance.timeSec,
      'starTimePointWithMs': instance.starTimePointWithMs,
      'endTimePointWithMs': instance.endTimePointWithMs,
      'soundQuality': instance.soundQuality,
      'backgroundNoiseLevel': instance.backgroundNoiseLevel,
    };
