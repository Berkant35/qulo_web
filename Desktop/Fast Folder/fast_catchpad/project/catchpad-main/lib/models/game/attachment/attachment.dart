// ignore_for_file: invalid_annotation_target

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/game/game_audio_type.dart';

export '../../enums/game/game_audio_type.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

typedef AttList = List<Attachment>;
typedef AttSet = Set<Attachment>;

@freezed
class Attachment with _$Attachment {
  const Attachment._();

  const factory Attachment({
    String? url,
    @JsonKey(ignore: true) Uint8List? bytes,
    required String filePath,
    required String fileName,
    required String id,

    /// this will stay here temporarily,
    /// and we may move it later.
    GameAudioType? audioType,
  }) = _Attachment;

  factory Attachment.asset({
    required String assetPath,
    required String assetName,
  }) {
    return Attachment(
      filePath: assetPath,
      fileName: assetName,
      id: generateId(),
    );
  }

  factory Attachment.music({
    required String assetPath,
    required String assetName,
  }) {
    return Attachment(
      filePath: assetPath,
      fileName: assetName,
      id: generateId(),
      audioType: GameAudioType.music,
    );
  }

  factory Attachment.soundEffect({
    required String assetPath,
    required String assetName,
  }) {
    return Attachment(
      filePath: assetPath,
      fileName: assetName,
      id: generateId(),
      audioType: GameAudioType.soundEffect,
    );
  }

  factory Attachment.gameAudio({
    required String assetPath,
    required String assetName,
  }) {
    return Attachment(
      filePath: assetPath,
      fileName: assetName,
      id: generateId(),
      audioType: GameAudioType.gameAudio,
    );
  }

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  // @JsonKey(name: 'image_url')
  // // String? url;

  // // @JsonKey(ignore: true)
  // // Uint8List? bytes;

  // // @JsonKey(ignore: true)
  // // late String _fileName;

  // // String get fileName => [_fileName, 'png'].join('.');

  // // String get id => _fileName;

  // // static int _id = 0;

  // Attachment({
  //   this.url,
  //   this.bytes,
  //   String? id,
  // }) : _fileName = id ?? Attachment.generateFileName();

  // Attachment.fromUrl(String url) : this(url: url);
  // Attachment.fromBytes(Uint8List bytes) : this(bytes: bytes);
  // Attachment.fromPlatformFile(PlatformFile pl) : this.fromBytes(pl.bytes!);

  // factory Attachment.fromFire(DocumentSnapshot document) => Attachment.fromJson(
  //       document.id,
  //       document.data() as Map<String, dynamic>,
  //     );

  // factory Attachment.fromJson(String id, Map<String, dynamic> json) =>
  //     _$AttachmentFromJson(json).._fileName = id;

  // Map<String, dynamic> toJson() => _$AttachmentToJson(this);

  // bool get urlIsEmpty => url == null;
  // bool get bytesIsEmpty => bytes == null;
  // bool get isEmpty => urlIsEmpty && bytesIsEmpty;

  static String generateId() =>
      DateTime.now().millisecondsSinceEpoch.toString();
}
