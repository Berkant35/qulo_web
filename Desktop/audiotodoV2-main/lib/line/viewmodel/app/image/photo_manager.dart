import 'dart:io';

import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/app/image_picker_states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialog_shower/dialog/dialog_shower.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utilities/components/dialogs/basic_dialogs.dart';

class PhotoManagerNotifier extends StateNotifier<XFile?> {
  PhotoManagerNotifier(super.state);

  final FirebaseStorage _storage = FirebaseStorage.instance;

  late ImagePicker _picker;

  ImagePicker get picker => _picker;

  void initializeImagePicker() => _picker = ImagePicker();

  //Upload image with collection name company or profil png to Firebase
  void uploadImage(WidgetRef ref, String collectionName, String imageName) {}

  Future<void> getImageFromGalleryOrCamera(
      WidgetRef ref, TypeCameraOrGallery typeOfSelectionForImage) async {
    DialogShower.init(ref.context);


    initializeImagePicker();

    await ref
        .read(currentPermissionControllerManager.notifier)
        .giveGrantedToAllPermissionsGalleryAndCamera();

    final image = await picker.pickImage(
      source: typeOfSelectionForImage == TypeCameraOrGallery.camera
          ? ImageSource.camera
          : ImageSource.gallery,
    );

    //Crop image
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        cropStyle: CropStyle.circle,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          IOSUiSettings(
            title: 'Audiotodo',
          ),
        ],
      );

      if (croppedFile != null) {

        state = XFile(croppedFile.path);

        DialogShower shower = DialogShower()
          ..barrierDismissible = true

          ..barrierColor = Colors.transparent
          ..show(const Padding(
            padding:  EdgeInsets.all(8.0),
            child:  CircularProgressIndicator(),
          ));

        final downloadLink = await getPhotoLink(ref);
        logger.d("Download link: $downloadLink");
        final isSaved = await ref
            .read(authManager.notifier)
            .updateProfilePhoto(downloadLink, ref);

        shower.dismiss();
        shower.remove();

        if (isSaved) {

          logger.d("Photo saved successfully");
          BasicDialogs.successfullySavedDialog(ref);
        } else {


          logger.d("Photo not saved");
          BasicDialogs.failSaveDialog(ref);
        }
      } else {
        //Show error message
        logger.d("User canceled the cropping process");
      }
    }
  }

  //Get photo link after upload current file to firebase_storage
  Future<String> getPhotoLink(WidgetRef ref) async {
    Reference storageRef = _storage
        .ref()
        .child("users")
        .child(ref.read(authManager)!.userId!)
        .child("profile/${state!.name}");
    UploadTask downloadUrl = storageRef.putFile(File(state!.path));
    await downloadUrl.whenComplete(() => null);
    return await storageRef.getDownloadURL();
  }
}
