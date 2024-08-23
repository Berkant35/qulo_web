import 'package:freezed_annotation/freezed_annotation.dart';

part 'iga_trace_game_model.freezed.dart';
part 'iga_trace_game_model.g.dart';

@freezed
class IgaGameTraceModel with _$IgaGameTraceModel {
  const factory IgaGameTraceModel(
    // we track users selections game setup
      { @JsonKey(name: 'traceId') String? traceId,
        @JsonKey(name: 'selectedColors') List<String>? selectedColors,
        @JsonKey(name: 'createdAt') String? createdAt,
        @JsonKey(name: 'endTime') String? endTime,
        @JsonKey(name: 'gameId') String? gameId
        // @JsonKey(name: 'clickCount') @Default(0) int counter
      }
      ) =
  _IgaGameTraceModel;

  factory IgaGameTraceModel.fromJson(Map<String, Object?> json) =>
      _$IgaGameTraceModelFromJson(json);
}
