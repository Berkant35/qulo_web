part of 'locale_base.dart';

class LocaleManager extends LocaleBase implements LocaleMeetBase {
  ///Save File To Local. Why you need this function. If user when look to current
  ///review and then user decide cancel There will be no need send gpt api
  ///on current meet and we will save money both firebase and api costs.
  @override
  Future<bool> saveToLocalWithMeedId(
      File? file, String meetId, WidgetRef ref) async {
    final filesBox = await Hive.openLazyBox(BoxHiveKeys.meetFileId.name);

    try {
      if (filesBox.containsKey(meetId)) {
        return true;
      }

      //logger.i("Put: $meetId");

      await filesBox.put(meetId, Uint8List.fromList(file!.readAsBytesSync()));

      final intByteList = await filesBox.get(meetId);

      assert(
          intByteList.runtimeType.toString() == LocaleBase.byteListTypeString);

      return filesBox.keys.contains(meetId);
    } catch (e) {
      logger.e("Error Message:$e");
      filesBox.close();
      return false;
    } finally {
      filesBox.close();
    }
  }

  @override
  Future<File?> getFileWithMeedId(String meetId, WidgetRef ref) async {
    // Open the Hive lazy box for storing files
    final filesBox = await Hive.openLazyBox(BoxHiveKeys.meetFileId.name);

    try {
      // Check if the provided meetId exists in the filesBox
      if (!filesBox.keys.contains(meetId)) {
        // If meetId doesn't exist, handle the exception and return null
        RecordExceptions.handleRecordException("Meet Id:$meetId", ref,
            title: ErrorTexts.errorNotFoundMeetId);
        return null;
      }

      // Retrieve the byteList associated with the meetId
      final byteList = await filesBox.get(meetId);

      // Check if the byteList has the expected type
      if (byteList.runtimeType.toString() == LocaleBase.byteListTypeString) {
        // Create a temporary sound file with a unique name based on the meetId
        final path = ref
            .read(currentRecorderControllerManager.notifier)
            .getPathOfFileByMeetId(ref, meetId);

        File savedSoundFile = File(path);

        // Write the byteList data to the savedSoundFile
        savedSoundFile.writeAsBytesSync(byteList);

        return savedSoundFile;
      }

      return null;
    } catch (e) {
      // Handle any exceptions that occur during the process and log an error
      RecordExceptions.handleRecordException(e.toString(), ref,
          title: ErrorTexts.errorNotFoundMeetId);
    } finally {
      // Close the filesBox after usage
      filesBox.close();
    }
    return null;
  }

  @override
  Future<void> deleteMeetId(String meetId, WidgetRef ref) async {
    // Open the Hive lazy box for storing files
    final filesBox = await Hive.openLazyBox(BoxHiveKeys.meetFileId.name);

    try {
      // Delete the file associated with the provided meetId from the filesBox
      await filesBox.delete(meetId).then((value) {
        // Call a helper function to log the result of the deletion
        forLogRecord(filesBox, meetId);
      });
    } catch (e) {
      // Handle any exceptions that occur during the deletion process and log an error
      RecordExceptions.handleRecordException(e.toString(), ref,
          title: ErrorTexts.errorDeleteMeetByIdFailed);
    } finally {
      // Close the filesBox after usage
      filesBox.close();
    }
  }

  @override
  Future<void> deleteAllFiles(WidgetRef ref) async {
    // Open the Hive lazy box for storing files
    final filesBox = await Hive.openLazyBox(BoxHiveKeys.meetFileId.name);
    try {
      // Iterate over all meetIds in the filesBox and delete the associated files
      for (var meetId in filesBox.keys) {
        await filesBox.delete(meetId).then((value) {
          // Call a helper function to log the result of each deletion
          forLogRecord(filesBox, meetId);
        });
      }
    } catch (e) {
      // Handle any exceptions that occur during the deletion process and log an error
      RecordExceptions.handleRecordException(e.toString(), ref,
          title: ErrorTexts.errorDeleteMeetAllFailed);
    } finally {
      // Close the filesBox after usage
      filesBox.close();
    }
  }

  void forLogRecord(LazyBox<dynamic> filesBox, meetId) {
    // Check if the meetId was successfully deleted from the filesBox
    if (!filesBox.keys.contains(meetId)) {
      logger.d(
          "MeetID: $meetId deleted!"); // Log a debug message indicating successful deletion
    } else {
      logger.w(
          "Delete Failed!"); // Log a warning message indicating deletion failure
    }
  }
}
