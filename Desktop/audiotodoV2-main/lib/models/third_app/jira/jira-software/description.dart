import 'package:freezed_annotation/freezed_annotation.dart';
import 'content.dart';
part 'description.freezed.dart';
part 'description.g.dart';

@freezed
class Description with _$Description {
  const factory Description({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'version') int? version,
    @JsonKey(name: 'content') List<Content>? content,
  }) = _Description;

  factory Description.fromJson(Map<String, Object?> json) =>
      _$DescriptionFromJson(json);
}
