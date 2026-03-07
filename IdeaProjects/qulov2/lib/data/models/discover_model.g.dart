// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscoverResponse _$DiscoverResponseFromJson(Map<String, dynamic> json) =>
    DiscoverResponse(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => ProfileCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      hasMore: json['has_more'] as bool,
    );

Map<String, dynamic> _$DiscoverResponseToJson(DiscoverResponse instance) =>
    <String, dynamic>{
      'cards': instance.cards,
      'page': instance.page,
      'has_more': instance.hasMore,
    };

ProfileCardModel _$ProfileCardModelFromJson(Map<String, dynamic> json) =>
    ProfileCardModel(
      userId: json['user_id'] as String,
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
      city: json['city'] as String?,
      bio: json['bio'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      distanceKm: (json['distance_km'] as num).toDouble(),
      questionCount: (json['question_count'] as num).toInt(),
      profileCompletion: (json['profile_completion'] as num?)?.toInt() ?? 0,
      isBoosted: json['is_boosted'] as bool? ?? false,
    );

Map<String, dynamic> _$ProfileCardModelToJson(ProfileCardModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'age': instance.age,
      'city': instance.city,
      'bio': instance.bio,
      'photos': instance.photos,
      'distance_km': instance.distanceKm,
      'question_count': instance.questionCount,
      'profile_completion': instance.profileCompletion,
      'is_boosted': instance.isBoosted,
    };

SwipeResponse _$SwipeResponseFromJson(Map<String, dynamic> json) =>
    SwipeResponse(matched: json['matched'] as bool);

Map<String, dynamic> _$SwipeResponseToJson(SwipeResponse instance) =>
    <String, dynamic>{'matched': instance.matched};
