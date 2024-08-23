import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    @JsonKey(name: 'duration') num? duration,
    @JsonKey(name: 'durationTicks') num? durationTicks,
    @JsonKey(name: 'midi') num? midi,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'ticks') num? ticks,
    @JsonKey(name: 'time') num? time,
    @JsonKey(name: 'velocity') num? velocity,
  }) = _Note;

  factory Note.fromJson(Map<String, Object?> json) => _$NoteFromJson(json);
}
