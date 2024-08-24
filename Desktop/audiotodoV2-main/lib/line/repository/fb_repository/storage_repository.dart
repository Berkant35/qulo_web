import 'dart:io';

import 'dart:typed_data';

import 'package:audiotodo/line/db/firebase/fb_storage/fb_storage_base.dart';
import 'package:audiotodo/line/db/firebase/fb_storage/fb_storage_manager.dart';
import 'package:audiotodo/line/db/local/locale_base.dart';
import 'package:flutter_riverpod/src/consumer.dart';

class StorageRepository extends StorageFirebaseBase  {
  final _fbStorageLayer = FirebaseStorageManager();
  final _localStorageLayer = LocaleManager();

  @override
  Future<String?> getFileLink(File? file, String path, WidgetRef ref) async {
    return await _fbStorageLayer.getFileLink(file, path, ref);
  }

  @override
  Future<File> saveFile(
      ByteData data, String name, String type, WidgetRef ref) async {
    // Maybe firstly save to local for last meeting if we when push any record
    throw UnimplementedError();
  }

  Future<bool> saveFileToLocal(File? file, String meetId, WidgetRef ref) async {
    return await _localStorageLayer.saveToLocalWithMeedId(file, meetId, ref);
  }

  Future<File?> getFileFromLocal(String meetId, WidgetRef ref) async {
    return await _localStorageLayer.getFileWithMeedId(meetId, ref);
  }

  deleteAllFiles(WidgetRef ref) {
    _localStorageLayer.deleteAllFiles(ref);
  }

  @override
  Future<bool> deleteFileFromFirebase(String path, WidgetRef ref) async {
    return _fbStorageLayer.deleteFileFromFirebase(path, ref);
  }

}
