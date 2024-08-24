import 'package:freezed_annotation/freezed_annotation.dart';
import 'text_content.dart';
part 'text_content.freezed.dart';
part 'text_content.g.dart';


@freezed
class TextContent with _$TextContent {
  const factory TextContent({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'text') String? text,
  }) = _TextContent;

  factory TextContent.fromJson(Map<String, Object?> json) =>
      _$TextContentFromJson(json);
}
