import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'note.dart';
part 'melody.freezed.dart';
part 'melody.g.dart';

@freezed
class Melody with _$Melody {
  const factory Melody({
    @JsonKey(name: 'melodyId') String? melodyId,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'notes') List<Note>? notes,
     @JsonKey(name: 'title') String? title,
     @JsonKey(name: 'isRelease') bool? isRelease,
     @JsonKey(name: 'createdAt') String? createdAt,
     @JsonKey(name: 'updatedAt') String? updatedAt
  }) = _Melody;

  factory Melody.fromJson(Map<String, Object?> json) => _$MelodyFromJson(json);
}
