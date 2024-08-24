import 'package:freezed_annotation/freezed_annotation.dart';
part 'issuetype.freezed.dart';
part 'issuetype.g.dart';

@freezed
class Issuetype with _$Issuetype {
  const factory Issuetype({
    @JsonKey(name: 'name') String? name,
  }) = _Issuetype;

  factory Issuetype.fromJson(Map<String, Object?> json) =>
      _$IssuetypeFromJson(json);
}
