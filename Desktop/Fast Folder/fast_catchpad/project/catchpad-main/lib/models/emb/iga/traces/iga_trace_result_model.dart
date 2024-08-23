



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iga_trace_result_model.freezed.dart';
part 'iga_trace_result_model.g.dart';

@freezed
class IgaResultTraceModel with _$IgaResultTraceModel {
  const factory IgaResultTraceModel({
    // we collect is user enter register page and registered
    @JsonKey(name: 'traceId') String? traceId,
    @JsonKey(name: 'isEnterRegistered') bool? isEnterRegistered,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'endTime') String? endTime,
    // track how much time spent in app 
    @JsonKey(name: 'passedTime') int? passedTime,

  }) = _IgaResultTraceModel;

  factory IgaResultTraceModel.fromJson(Map<String, Object?> json) =>
      _$IgaResultTraceModelFromJson(json);
}
