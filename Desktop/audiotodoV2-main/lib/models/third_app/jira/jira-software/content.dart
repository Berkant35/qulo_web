import 'package:audiotodo/models/third_app/jira/jira-software/text_content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'content.freezed.dart';
part 'content.g.dart';

@freezed
class Content with _$Content {
  const factory Content({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'content') List<TextContent>? content,
  }) = _Content;

  factory Content.fromJson(Map<String, Object?> json) =>
      _$ContentFromJson(json);
}
