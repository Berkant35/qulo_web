import 'dart:convert';

import 'package:catchpad/models/emb/iga/traces/iga_trace_game_model.dart';
import 'package:catchpad/models/emb/iga/traces/iga_trace_meta_model.dart';
import 'package:catchpad/models/emb/iga/traces/iga_trace_pre_model.dart';
import 'package:catchpad/models/emb/iga/traces/iga_trace_result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'iga_register_trace_model.dart';
part 'iga_trace_model.freezed.dart';
part 'iga_trace_model.g.dart';

@freezed
class IgaTraceModel with _$IgaTraceModel {
  const factory IgaTraceModel({
    @JsonKey(name: 'traceId') String? traceId,
    @JsonKey(name: 'createdAt') String? createdAt,

    @JsonKey(name: 'igaMetaTrace') @Default(null) IgaMetaTraceModel? igaMetaTraceModel,
    @JsonKey(name: 'igaPreTrace') @Default(null) IgaPreTraceModel? igaPreTraceModel,
    @JsonKey(name: 'igaGameTrace') @Default(null) IgaGameTraceModel? igaGameTraceModel,
    @JsonKey(name: 'igaResultTrace') @Default(null) IgaResultTraceModel? igaResultTraceModel,
    @JsonKey(name: 'igaRegisterTrace') @Default(null) IgaRegisterTraceModel? igaRegisterTraceModel,

  }) = _IgaTraceModel;

  factory IgaTraceModel.fromJson(Map<String, Object?> json) =>
      _$IgaTraceModelFromJson(json);
}
