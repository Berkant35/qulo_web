import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iga_trace_pre_model.freezed.dart';
part 'iga_trace_pre_model.g.dart';

@freezed
class IgaPreTraceModel with _$IgaPreTraceModel {
  const factory IgaPreTraceModel({
    // we track user how much time spent in app.
    // select which lang, mode, playerMode, passedTime and is play game
    @JsonKey(name: 'traceId') String? traceId,
    @JsonKey(name: 'selectLanguage') String? selectLanguage,
    @JsonKey(name: 'selectPlayer') String? selectPlayer,
    @JsonKey(name: 'selectMode') String? selectMode,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'endTime') String? endTime,
    @JsonKey(name: 'passedTime') int? passedTime,
    @JsonKey(name: 'isEnterGame') bool? isEnterGame,
  }) = _IgaPreTraceModel;

  factory IgaPreTraceModel.fromJson(Map<String, Object?> json) =>
      _$IgaPreTraceModelFromJson(json);
}
