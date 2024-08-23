// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'melody.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Melody _$MelodyFromJson(Map<String, dynamic> json) {
  return _Melody.fromJson(json);
}

/// @nodoc
mixin _$Melody {
  @JsonKey(name: 'melodyId')
  String? get melodyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes')
  List<Note>? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'isRelease')
  bool? get isRelease => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MelodyCopyWith<Melody> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MelodyCopyWith<$Res> {
  factory $MelodyCopyWith(Melody value, $Res Function(Melody) then) =
      _$MelodyCopyWithImpl<$Res, Melody>;
  @useResult
  $Res call(
      {@JsonKey(name: 'melodyId') String? melodyId,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'notes') List<Note>? notes,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'isRelease') bool? isRelease,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'updatedAt') String? updatedAt});
}

/// @nodoc
class _$MelodyCopyWithImpl<$Res, $Val extends Melody>
    implements $MelodyCopyWith<$Res> {
  _$MelodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? melodyId = freezed,
    Object? type = freezed,
    Object? notes = freezed,
    Object? title = freezed,
    Object? isRelease = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      melodyId: freezed == melodyId
          ? _value.melodyId
          : melodyId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<Note>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      isRelease: freezed == isRelease
          ? _value.isRelease
          : isRelease // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MelodyCopyWith<$Res> implements $MelodyCopyWith<$Res> {
  factory _$$_MelodyCopyWith(_$_Melody value, $Res Function(_$_Melody) then) =
      __$$_MelodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'melodyId') String? melodyId,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'notes') List<Note>? notes,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'isRelease') bool? isRelease,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'updatedAt') String? updatedAt});
}

/// @nodoc
class __$$_MelodyCopyWithImpl<$Res>
    extends _$MelodyCopyWithImpl<$Res, _$_Melody>
    implements _$$_MelodyCopyWith<$Res> {
  __$$_MelodyCopyWithImpl(_$_Melody _value, $Res Function(_$_Melody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? melodyId = freezed,
    Object? type = freezed,
    Object? notes = freezed,
    Object? title = freezed,
    Object? isRelease = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Melody(
      melodyId: freezed == melodyId
          ? _value.melodyId
          : melodyId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<Note>?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      isRelease: freezed == isRelease
          ? _value.isRelease
          : isRelease // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Melody with DiagnosticableTreeMixin implements _Melody {
  const _$_Melody(
      {@JsonKey(name: 'melodyId') this.melodyId,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'notes') final List<Note>? notes,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'isRelease') this.isRelease,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'updatedAt') this.updatedAt})
      : _notes = notes;

  factory _$_Melody.fromJson(Map<String, dynamic> json) =>
      _$$_MelodyFromJson(json);

  @override
  @JsonKey(name: 'melodyId')
  final String? melodyId;
  @override
  @JsonKey(name: 'type')
  final String? type;
  final List<Note>? _notes;
  @override
  @JsonKey(name: 'notes')
  List<Note>? get notes {
    final value = _notes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'isRelease')
  final bool? isRelease;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Melody(melodyId: $melodyId, type: $type, notes: $notes, title: $title, isRelease: $isRelease, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Melody'))
      ..add(DiagnosticsProperty('melodyId', melodyId))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('isRelease', isRelease))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Melody &&
            (identical(other.melodyId, melodyId) ||
                other.melodyId == melodyId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isRelease, isRelease) ||
                other.isRelease == isRelease) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      melodyId,
      type,
      const DeepCollectionEquality().hash(_notes),
      title,
      isRelease,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MelodyCopyWith<_$_Melody> get copyWith =>
      __$$_MelodyCopyWithImpl<_$_Melody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MelodyToJson(
      this,
    );
  }
}

abstract class _Melody implements Melody {
  const factory _Melody(
      {@JsonKey(name: 'melodyId') final String? melodyId,
      @JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'notes') final List<Note>? notes,
      @JsonKey(name: 'title') final String? title,
      @JsonKey(name: 'isRelease') final bool? isRelease,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'updatedAt') final String? updatedAt}) = _$_Melody;

  factory _Melody.fromJson(Map<String, dynamic> json) = _$_Melody.fromJson;

  @override
  @JsonKey(name: 'melodyId')
  String? get melodyId;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'notes')
  List<Note>? get notes;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'isRelease')
  bool? get isRelease;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_MelodyCopyWith<_$_Melody> get copyWith =>
      throw _privateConstructorUsedError;
}
