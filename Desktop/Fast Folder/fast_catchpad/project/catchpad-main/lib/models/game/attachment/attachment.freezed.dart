// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
mixin _$Attachment {
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  Uint8List? get bytes => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  /// this will stay here temporarily,
  /// and we may move it later.
  GameAudioType? get audioType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) then) =
      _$AttachmentCopyWithImpl<$Res, Attachment>;
  @useResult
  $Res call(
      {String? url,
      @JsonKey(ignore: true) Uint8List? bytes,
      String filePath,
      String fileName,
      String id,
      GameAudioType? audioType});
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res, $Val extends Attachment>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? bytes = freezed,
    Object? filePath = null,
    Object? fileName = null,
    Object? id = null,
    Object? audioType = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      audioType: freezed == audioType
          ? _value.audioType
          : audioType // ignore: cast_nullable_to_non_nullable
              as GameAudioType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttachmentCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$$_AttachmentCopyWith(
          _$_Attachment value, $Res Function(_$_Attachment) then) =
      __$$_AttachmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? url,
      @JsonKey(ignore: true) Uint8List? bytes,
      String filePath,
      String fileName,
      String id,
      GameAudioType? audioType});
}

/// @nodoc
class __$$_AttachmentCopyWithImpl<$Res>
    extends _$AttachmentCopyWithImpl<$Res, _$_Attachment>
    implements _$$_AttachmentCopyWith<$Res> {
  __$$_AttachmentCopyWithImpl(
      _$_Attachment _value, $Res Function(_$_Attachment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? bytes = freezed,
    Object? filePath = null,
    Object? fileName = null,
    Object? id = null,
    Object? audioType = freezed,
  }) {
    return _then(_$_Attachment(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      audioType: freezed == audioType
          ? _value.audioType
          : audioType // ignore: cast_nullable_to_non_nullable
              as GameAudioType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Attachment extends _Attachment {
  const _$_Attachment(
      {this.url,
      @JsonKey(ignore: true) this.bytes,
      required this.filePath,
      required this.fileName,
      required this.id,
      this.audioType})
      : super._();

  factory _$_Attachment.fromJson(Map<String, dynamic> json) =>
      _$$_AttachmentFromJson(json);

  @override
  final String? url;
  @override
  @JsonKey(ignore: true)
  final Uint8List? bytes;
  @override
  final String filePath;
  @override
  final String fileName;
  @override
  final String id;

  /// this will stay here temporarily,
  /// and we may move it later.
  @override
  final GameAudioType? audioType;

  @override
  String toString() {
    return 'Attachment(url: $url, bytes: $bytes, filePath: $filePath, fileName: $fileName, id: $id, audioType: $audioType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Attachment &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other.bytes, bytes) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.audioType, audioType) ||
                other.audioType == audioType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      url,
      const DeepCollectionEquality().hash(bytes),
      filePath,
      fileName,
      id,
      audioType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttachmentCopyWith<_$_Attachment> get copyWith =>
      __$$_AttachmentCopyWithImpl<_$_Attachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttachmentToJson(
      this,
    );
  }
}

abstract class _Attachment extends Attachment {
  const factory _Attachment(
      {final String? url,
      @JsonKey(ignore: true) final Uint8List? bytes,
      required final String filePath,
      required final String fileName,
      required final String id,
      final GameAudioType? audioType}) = _$_Attachment;
  const _Attachment._() : super._();

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$_Attachment.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  Uint8List? get bytes;
  @override
  String get filePath;
  @override
  String get fileName;
  @override
  String get id;
  @override

  /// this will stay here temporarily,
  /// and we may move it later.
  GameAudioType? get audioType;
  @override
  @JsonKey(ignore: true)
  _$$_AttachmentCopyWith<_$_Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}
