import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

abstract class StorageFirebaseBase {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  SettableMetadata metadata(String path) => SettableMetadata(
        contentType: 'audio/aac',
        customMetadata: {'picked-file-path': path},
      );

  FirebaseStorage get storage => _storage;

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> saveFile(ByteData data, String name, String type, WidgetRef ref);

  Future<String?> getFileLink(File? file, String path, WidgetRef ref);

  Future<bool> deleteFileFromFirebase(String path, WidgetRef ref);
}
