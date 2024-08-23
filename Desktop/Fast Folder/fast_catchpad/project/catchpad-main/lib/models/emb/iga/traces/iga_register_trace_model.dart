import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iga_register_trace_model.freezed.dart';
part 'iga_register_trace_model.g.dart';

@freezed
class IgaRegisterTraceModel with _$IgaRegisterTraceModel {
  const factory IgaRegisterTraceModel({
    
    @JsonKey(name: 'traceId') String? traceId,
    @JsonKey(name: 'endTime') String? endTime,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'passedTime') int? passedTime,
    @JsonKey(name: 'igaUserId') String? igaUserId,
    @JsonKey(name: 'isRegistered') bool? isRegistered,
  }) = _IgaRegisterTraceModel;

  factory IgaRegisterTraceModel.fromJson(Map<String, Object?> json) =>
      _$IgaRegisterTraceModelFromJson(json);
}
