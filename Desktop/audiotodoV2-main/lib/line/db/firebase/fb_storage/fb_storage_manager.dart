import 'dart:io';
import 'dart:typed_data';

import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/exceptions/firebase_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fb_storage_base.dart';

final class FirebaseStorageManager extends StorageFirebaseBase {
  ///You can upload file with this function.And return download link.
  ///Its will be called from when user want listen record [path] this
  ///path should be to be meaningful [file] this current record file
  @override
  Future<String?> getFileLink(File? file, String path, WidgetRef ref) async {
    try {
      final firebaseStorageRef = storage.ref(file?.path);
      if (file?.path != null) {
        UploadTask uploadTask =
            firebaseStorageRef.putFile(file!, metadata(file.path));

        TaskSnapshot taskSnapshot = await Future.value(uploadTask);

        var createdUrlForSound = await taskSnapshot.ref.getDownloadURL();

        return createdUrlForSound;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      logger.e("Error:${e.message}");
      FirebaseExceptions.handleFirebaseException(
          e.message ?? FirebaseExceptions.undefined, ref);
      return null;
    }
  }

  /// This function saves the specified [data] as a file with the
  /// given [name] and [type] extension. It returns the local path of the
  /// saved file.
  @override
  Future<File> saveFile(
      ByteData data, String name, String type, WidgetRef ref) async {
    var path = await localPath; //<-- See the function below
    final buffer = data.buffer;
    // Write the file to the local storage path
    return File('$path/$name.m4a').writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  Future<bool> deleteFileFromFirebase(String path, WidgetRef ref) async {
    try {
      await storage.refFromURL(path).delete();
      return true;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException("", ref);
      return false;
    }
  }
}
