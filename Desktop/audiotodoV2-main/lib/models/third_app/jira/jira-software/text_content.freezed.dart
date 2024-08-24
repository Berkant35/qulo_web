// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TextContent _$TextContentFromJson(Map<String, dynamic> json) {
  return _TextContent.fromJson(json);
}

/// @nodoc
mixin _$TextContent {
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String? get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextContentCopyWith<TextContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextContentCopyWith<$Res> {
  factory $TextContentCopyWith(
          TextContent value, $Res Function(TextContent) then) =
      _$TextContentCopyWithImpl<$Res, TextContent>;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'text') String? text});
}

/// @nodoc
class _$TextContentCopyWithImpl<$Res, $Val extends TextContent>
    implements $TextContentCopyWith<$Res> {
  _$TextContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextContentImplCopyWith<$Res>
    implements $TextContentCopyWith<$Res> {
  factory _$$TextContentImplCopyWith(
          _$TextContentImpl value, $Res Function(_$TextContentImpl) then) =
      __$$TextContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'text') String? text});
}

/// @nodoc
class __$$TextContentImplCopyWithImpl<$Res>
    extends _$TextContentCopyWithImpl<$Res, _$TextContentImpl>
    implements _$$TextContentImplCopyWith<$Res> {
  __$$TextContentImplCopyWithImpl(
      _$TextContentImpl _value, $Res Function(_$TextContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? text = freezed,
  }) {
    return _then(_$TextContentImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextContentImpl implements _TextContent {
  const _$TextContentImpl(
      {@JsonKey(name: 'type') this.type, @JsonKey(name: 'text') this.text});

  factory _$TextContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextContentImplFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'text')
  final String? text;

  @override
  String toString() {
    return 'TextContent(type: $type, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextContentImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextContentImplCopyWith<_$TextContentImpl> get copyWith =>
      __$$TextContentImplCopyWithImpl<_$TextContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TextContentImplToJson(
      this,
    );
  }
}

abstract class _TextContent implements TextContent {
  const factory _TextContent(
      {@JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'text') final String? text}) = _$TextContentImpl;

  factory _TextContent.fromJson(Map<String, dynamic> json) =
      _$TextContentImpl.fromJson;

  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'text')
  String? get text;
  @override
  @JsonKey(ignore: true)
  _$$TextContentImplCopyWith<_$TextContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
