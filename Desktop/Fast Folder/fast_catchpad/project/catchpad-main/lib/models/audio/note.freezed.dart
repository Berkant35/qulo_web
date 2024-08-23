// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Note _$NoteFromJson(Map<String, dynamic> json) {
  return _Note.fromJson(json);
}

/// @nodoc
mixin _$Note {
  @JsonKey(name: 'duration')
  num? get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'durationTicks')
  num? get durationTicks => throw _privateConstructorUsedError;
  @JsonKey(name: 'midi')
  num? get midi => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'ticks')
  num? get ticks => throw _privateConstructorUsedError;
  @JsonKey(name: 'time')
  num? get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'velocity')
  num? get velocity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res, Note>;
  @useResult
  $Res call(
      {@JsonKey(name: 'duration') num? duration,
      @JsonKey(name: 'durationTicks') num? durationTicks,
      @JsonKey(name: 'midi') num? midi,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'ticks') num? ticks,
      @JsonKey(name: 'time') num? time,
      @JsonKey(name: 'velocity') num? velocity});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res, $Val extends Note>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = freezed,
    Object? durationTicks = freezed,
    Object? midi = freezed,
    Object? name = freezed,
    Object? ticks = freezed,
    Object? time = freezed,
    Object? velocity = freezed,
  }) {
    return _then(_value.copyWith(
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as num?,
      durationTicks: freezed == durationTicks
          ? _value.durationTicks
          : durationTicks // ignore: cast_nullable_to_non_nullable
              as num?,
      midi: freezed == midi
          ? _value.midi
          : midi // ignore: cast_nullable_to_non_nullable
              as num?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      ticks: freezed == ticks
          ? _value.ticks
          : ticks // ignore: cast_nullable_to_non_nullable
              as num?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as num?,
      velocity: freezed == velocity
          ? _value.velocity
          : velocity // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$$_NoteCopyWith(_$_Note value, $Res Function(_$_Note) then) =
      __$$_NoteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'duration') num? duration,
      @JsonKey(name: 'durationTicks') num? durationTicks,
      @JsonKey(name: 'midi') num? midi,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'ticks') num? ticks,
      @JsonKey(name: 'time') num? time,
      @JsonKey(name: 'velocity') num? velocity});
}

/// @nodoc
class __$$_NoteCopyWithImpl<$Res> extends _$NoteCopyWithImpl<$Res, _$_Note>
    implements _$$_NoteCopyWith<$Res> {
  __$$_NoteCopyWithImpl(_$_Note _value, $Res Function(_$_Note) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = freezed,
    Object? durationTicks = freezed,
    Object? midi = freezed,
    Object? name = freezed,
    Object? ticks = freezed,
    Object? time = freezed,
    Object? velocity = freezed,
  }) {
    return _then(_$_Note(
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as num?,
      durationTicks: freezed == durationTicks
          ? _value.durationTicks
          : durationTicks // ignore: cast_nullable_to_non_nullable
              as num?,
      midi: freezed == midi
          ? _value.midi
          : midi // ignore: cast_nullable_to_non_nullable
              as num?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      ticks: freezed == ticks
          ? _value.ticks
          : ticks // ignore: cast_nullable_to_non_nullable
              as num?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as num?,
      velocity: freezed == velocity
          ? _value.velocity
          : velocity // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Note with DiagnosticableTreeMixin implements _Note {
  const _$_Note(
      {@JsonKey(name: 'duration') this.duration,
      @JsonKey(name: 'durationTicks') this.durationTicks,
      @JsonKey(name: 'midi') this.midi,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'ticks') this.ticks,
      @JsonKey(name: 'time') this.time,
      @JsonKey(name: 'velocity') this.velocity});

  factory _$_Note.fromJson(Map<String, dynamic> json) => _$$_NoteFromJson(json);

  @override
  @JsonKey(name: 'duration')
  final num? duration;
  @override
  @JsonKey(name: 'durationTicks')
  final num? durationTicks;
  @override
  @JsonKey(name: 'midi')
  final num? midi;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'ticks')
  final num? ticks;
  @override
  @JsonKey(name: 'time')
  final num? time;
  @override
  @JsonKey(name: 'velocity')
  final num? velocity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Note(duration: $duration, durationTicks: $durationTicks, midi: $midi, name: $name, ticks: $ticks, time: $time, velocity: $velocity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Note'))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('durationTicks', durationTicks))
      ..add(DiagnosticsProperty('midi', midi))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('ticks', ticks))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('velocity', velocity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Note &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.durationTicks, durationTicks) ||
                other.durationTicks == durationTicks) &&
            (identical(other.midi, midi) || other.midi == midi) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ticks, ticks) || other.ticks == ticks) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.velocity, velocity) ||
                other.velocity == velocity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, duration, durationTicks, midi, name, ticks, time, velocity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteCopyWith<_$_Note> get copyWith =>
      __$$_NoteCopyWithImpl<_$_Note>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoteToJson(
      this,
    );
  }
}

abstract class _Note implements Note {
  const factory _Note(
      {@JsonKey(name: 'duration') final num? duration,
      @JsonKey(name: 'durationTicks') final num? durationTicks,
      @JsonKey(name: 'midi') final num? midi,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'ticks') final num? ticks,
      @JsonKey(name: 'time') final num? time,
      @JsonKey(name: 'velocity') final num? velocity}) = _$_Note;

  factory _Note.fromJson(Map<String, dynamic> json) = _$_Note.fromJson;

  @override
  @JsonKey(name: 'duration')
  num? get duration;
  @override
  @JsonKey(name: 'durationTicks')
  num? get durationTicks;
  @override
  @JsonKey(name: 'midi')
  num? get midi;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'ticks')
  num? get ticks;
  @override
  @JsonKey(name: 'time')
  num? get time;
  @override
  @JsonKey(name: 'velocity')
  num? get velocity;
  @override
  @JsonKey(ignore: true)
  _$$_NoteCopyWith<_$_Note> get copyWith => throw _privateConstructorUsedError;
}
