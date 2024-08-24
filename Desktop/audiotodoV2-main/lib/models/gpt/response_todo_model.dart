
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'response_todo_model.freezed.dart';
part 'response_todo_model.g.dart';


//TODO TODOS TO JSON NOT WORKING CREATING ONLY MODEL ITS NOT GOOD


@freezed
 class ResponseTodoModel with _$ResponseTodoModel {
  const factory ResponseTodoModel({
    @Default("")
    @JsonKey(name: 'meet_id') String meetId,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'meet_pure_text') String? meetPureText,
    @JsonKey(name: 'meet_suggested_title') String? meetSuggestedTitle,
    @JsonKey(name: 'meet_content_summarize') String? meetContentSummarize,
    @JsonKey(name: 'recognize_person_names') List<String>? recognizePersonNames,
    @JsonKey(name: 'todos') List<ResponsePerTodoModel>? todos,
  }) = _ResponseTodoModel;

  factory ResponseTodoModel.fromJson(Map<String, Object?> json) =>
      _$ResponseTodoModelFromJson(json);



}
