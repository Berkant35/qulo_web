// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseTodoModelImpl _$$ResponseTodoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ResponseTodoModelImpl(
      meetId: json['meet_id'] as String? ?? "",
      language: json['language'] as String?,
      meetPureText: json['meet_pure_text'] as String?,
      meetSuggestedTitle: json['meet_suggested_title'] as String?,
      meetContentSummarize: json['meet_content_summarize'] as String?,
      recognizePersonNames: (json['recognize_person_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      todos: (json['todos'] as List<dynamic>?)
          ?.map((e) => ResponsePerTodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ResponseTodoModelImplToJson(
        _$ResponseTodoModelImpl instance) =>
    <String, dynamic>{
      'meet_id': instance.meetId,
      'language': instance.language,
      'meet_pure_text': instance.meetPureText,
      'meet_suggested_title': instance.meetSuggestedTitle,
      'meet_content_summarize': instance.meetContentSummarize,
      'recognize_person_names': instance.recognizePersonNames,
      'todos': instance.todos?.map((e) => e.toJson()).toList(),
    };
