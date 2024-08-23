import 'package:freezed_annotation/freezed_annotation.dart';
part 'iga_trace_meta_model.freezed.dart';
part 'iga_trace_meta_model.g.dart';

@freezed
class IgaMetaTraceModel with _$IgaMetaTraceModel {
  const factory IgaMetaTraceModel({
    // we collect all devices infos about connected status, location and tablet info
    @JsonKey(name: 'traceId') String? traceId,

    @JsonKey(name: 'connectedDevices') @Default([]) List<String> connectedDevices,

    @JsonKey(name: 'tabletInfo')  @Default({}) Map<String,dynamic> phoneInformation,
    @JsonKey(name: 'locationInformation') @Default({}) Map<String,dynamic> locationInformation,
  }) = _IgaMetaTraceModel;

  factory IgaMetaTraceModel.fromJson(Map<String, Object?> json) =>
      _$IgaMetaTraceModelFromJson(json);
}
