// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Description _$DescriptionFromJson(Map<String, dynamic> json) {
  return _Description.fromJson(json);
}

/// @nodoc
mixin _$Description {
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'version')
  int? get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  List<Content>? get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DescriptionCopyWith<Description> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DescriptionCopyWith<$Res> {
  factory $DescriptionCopyWith(
          Description value, $Res Function(Description) then) =
      _$DescriptionCopyWithImpl<$Res, Description>;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'version') int? version,
      @JsonKey(name: 'content') List<Content>? content});
}

/// @nodoc
class _$DescriptionCopyWithImpl<$Res, $Val extends Description>
    implements $DescriptionCopyWith<$Res> {
  _$DescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? version = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Content>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DescriptionImplCopyWith<$Res>
    implements $DescriptionCopyWith<$Res> {
  factory _$$DescriptionImplCopyWith(
          _$DescriptionImpl value, $Res Function(_$DescriptionImpl) then) =
      __$$DescriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'version') int? version,
      @JsonKey(name: 'content') List<Content>? content});
}

/// @nodoc
class __$$DescriptionImplCopyWithImpl<$Res>
    extends _$DescriptionCopyWithImpl<$Res, _$DescriptionImpl>
    implements _$$DescriptionImplCopyWith<$Res> {
  __$$DescriptionImplCopyWithImpl(
      _$DescriptionImpl _value, $Res Function(_$DescriptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? version = freezed,
    Object? content = freezed,
  }) {
    return _then(_$DescriptionImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Content>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DescriptionImpl implements _Description {
  const _$DescriptionImpl(
      {@JsonKey(name: 'type') this.type,
      @JsonKey(name: 'version') this.version,
      @JsonKey(name: 'content') final List<Content>? content})
      : _content = content;

  factory _$DescriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DescriptionImplFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'version')
  final int? version;
  final List<Content>? _content;
  @override
  @JsonKey(name: 'content')
  List<Content>? get content {
    final value = _content;
    if (value == null) return null;
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Description(type: $type, version: $version, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DescriptionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._content, _content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, version,
      const DeepCollectionEquality().hash(_content));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DescriptionImplCopyWith<_$DescriptionImpl> get copyWith =>
      __$$DescriptionImplCopyWithImpl<_$DescriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DescriptionImplToJson(
      this,
    );
  }
}

abstract class _Description implements Description {
  const factory _Description(
          {@JsonKey(name: 'type') final String? type,
          @JsonKey(name: 'version') final int? version,
          @JsonKey(name: 'content') final List<Content>? content}) =
      _$DescriptionImpl;

  factory _Description.fromJson(Map<String, dynamic> json) =
      _$DescriptionImpl.fromJson;

  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'version')
  int? get version;
  @override
  @JsonKey(name: 'content')
  List<Content>? get content;
  @override
  @JsonKey(ignore: true)
  _$$DescriptionImplCopyWith<_$DescriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
