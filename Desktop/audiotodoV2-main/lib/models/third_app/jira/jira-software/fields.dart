import 'package:freezed_annotation/freezed_annotation.dart';
import 'project.dart';
import 'description.dart';
import 'issuetype.dart';
part 'fields.freezed.dart';
part 'fields.g.dart';

@freezed
class Fields with _$Fields {
  const factory Fields({
    @JsonKey(name: 'project') Project? project,
    @JsonKey(name: 'summary') String? summary,
    @JsonKey(name: 'description') Description? description,
    @JsonKey(name: 'labels') List<String>? labels,
    @JsonKey(name: 'issuetype') Issuetype? issuetype,
    @JsonKey(name: 'customfield_10016') int? customfield10016,
  }) = _Fields;

  factory Fields.fromJson(Map<String, Object?> json) => _$FieldsFromJson(json);
}
