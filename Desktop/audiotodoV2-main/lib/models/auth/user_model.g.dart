// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String?,
      email: json['email'] as String? ?? "",
      userName: json['userName'] as String? ?? "",
      surName: json['surName'] as String? ?? "",
      companyName: json['companyName'] as String? ?? "",
      companyCountry: json['companyCountry'] as String? ?? "",
      companyCity: json['companyCity'] as String? ?? "",
      companyId: json['companyId'] as String? ?? "",
      platform: json['platform'] as String?,
      lastSignIn: json['lastSignIn'] as String?,
      photoUrl: json['photoUrl'] as String? ?? "",
      planDetail: json['planDetail'] as String? ?? "",
      currentSubscriptionExpirationDate:
          json['currentSubscriptionExpirationDate'] as String?,
      planType: $enumDecodeNullable(_$PlanTypeEnumMap, json['planType']) ??
          PlanType.none,
      totalRecreateCount: (json['totalRecreateCount'] as num?)?.toInt() ?? 0,
      usedRecordSeconds: (json['usedRecordSeconds'] as num?)?.toInt() ?? 0,
      totalRecordSeconds: (json['totalRecordSeconds'] as num?)?.toInt() ?? 0,
      firstEnter: json['firstEnter'] as bool? ?? false,
      pushToken: json['pushToken'] as String? ?? "",
      friendIdList: (json['friendIdList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      todoPlatformTokens:
          (json['todoPlatformTokens'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const {},
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'userName': instance.userName,
      'surName': instance.surName,
      'companyName': instance.companyName,
      'companyCountry': instance.companyCountry,
      'companyCity': instance.companyCity,
      'companyId': instance.companyId,
      'platform': instance.platform,
      'lastSignIn': instance.lastSignIn,
      'photoUrl': instance.photoUrl,
      'planDetail': instance.planDetail,
      'currentSubscriptionExpirationDate':
          instance.currentSubscriptionExpirationDate,
      'planType': _$PlanTypeEnumMap[instance.planType]!,
      'totalRecreateCount': instance.totalRecreateCount,
      'usedRecordSeconds': instance.usedRecordSeconds,
      'totalRecordSeconds': instance.totalRecordSeconds,
      'firstEnter': instance.firstEnter,
      'pushToken': instance.pushToken,
      'friendIdList': instance.friendIdList,
      'todoPlatformTokens': instance.todoPlatformTokens,
    };

const _$PlanTypeEnumMap = {
  PlanType.none: 'none',
  PlanType.basic: 'basic',
  PlanType.trial: 'trial',
  PlanType.pro: 'pro',
};
