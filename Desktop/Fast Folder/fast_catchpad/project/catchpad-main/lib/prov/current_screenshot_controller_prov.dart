import 'dart:io';

import 'package:catchpad/prov/game_result_prov.dart';
import 'package:catchpad/ui/widgets/cp_bottom_sheet.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class CurrentShareControllerManager
    extends StateNotifier<ScreenshotController> {
  CurrentShareControllerManager(ScreenshotController state)
      : super(ScreenshotController());

  ///This file when you want share screenshot,
  ///this parameter fill up with ss that captured image file.
  File? _file;
  File? _pngFileForPdf;

  ///This method initialize [ScreenshotController] and set it to [state].
  Future<void> initialize(
      WidgetRef ref, ScreenshotController controller) async {
    state = controller;
  }

  ///TR Burdaki fonksiyon bize sonuçlardan bir docx sayfası oluşturmamızı sağlar
  ///EN This function allows us to create a docx page from the results
  Future<void> createPdf(
      WidgetRef ref, Map<String, Map<String, String?>> resultMaps,
      {required String reviewText}) async {
    final Directory appDocumentsDir = await getTemporaryDirectory();

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String fileName = '$timestamp.pdf';
    final String filePath = '${appDocumentsDir.path}/$fileName';

    final File file = File(filePath);
    // Create the file if it doesn't exist
    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    final pdf = pw.Document();

    final gameResults = ref.read(gameResultProv);
    final page = await gameResults?.toPdfPage(ref,
        inst: L10n.inst(ref.context),
        resultMaps: resultMaps,
        reviewText: reviewText);
    if (page != null) pdf.addPage(page);

    //save to file
    await file.writeAsBytes(await pdf.save());
    _file = file;
    //share file
    await sharePlusAction(ref);
  }

  Future<void> createExcel(
      WidgetRef ref, Map<String, Map<String, String?>> resultMaps,
      {required String reviewText}) async {
    final Directory appDocumentsDir = await getTemporaryDirectory();

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String fileName = '$timestamp.xlsx';
    final String filePath = '${appDocumentsDir.path}/$fileName';

    final File file = File(filePath);
    // Create the file if it doesn't exist
    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    final gameResults = ref.read(gameResultProv);

    final excel = await gameResults?.toExcel(ref,
        inst: L10n.inst(ref.context),
        resultMaps: resultMaps,
        reviewText: reviewText);

    if (excel != null) {
      await file.writeAsBytes(excel.save(fileName: fileName) ?? []);
    }

    _file = file;

    //share file
    await sharePlusAction(ref);
  }

  Future<Uint8List?> capturedScreenShot(
      WidgetRef ref, BuildContext context) async {
    return await state
        .capture(delay: Duration.zero)
        .then((capturedImage) async {
      await _setFile(capturedImage, ref, isSecondFileForPdf: true);
      return _pngFileForPdf?.readAsBytesSync();
    });
  }

  ///This method capture current screen and fill up [_file] parameter.
  Future<void> captureCurrentResultAndFillCurrentFile(
      WidgetRef ref, BuildContext context) async {
    //.capture(delay: const Duration(milliseconds: 10))

    state
        .capture(delay: const Duration(milliseconds: 10))
        .then((capturedImage) async {
      logger.i("Captured Image: $capturedImage");
      //set captured image to file
      await _setFile(capturedImage, ref).then((value) {
        //show bottom sheet that captured image
        _showBottomSheetScreenShotThatCaptured(ref, context);
      });
    }).catchError((onError) {
      logger.w("On Error: $onError");

      //TODO: Show error dialog

      CustomDialogs.failed(ref, "", "");
    });
  }

  _showBottomSheetScreenShotThatCaptured(WidgetRef ref, BuildContext context) {
    assert(_file != null, "File is null");
    CustomDialogs.screenShotShare(ref, ScreenShotBottomSheet(file: _file!));
  }

  ///This method share current screenshot.
  Future<void> sharePlusAction(WidgetRef ref) async {
    final xFile = XFile(_file!.path);

    final result = await Share.shareXFiles([xFile]);

    if (result.status == ShareResultStatus.success) {
      debugPrint('Thank you for sharing the picture!');
    }
  }

  ///Set File With Image UInt8List
  Future<void> _setFile(Uint8List? capturedImage, WidgetRef ref,
      {bool isSecondFileForPdf = false}) async {
    final Directory appDocumentsDir = await getTemporaryDirectory();

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String fileName = '$timestamp.png';

    if (!isSecondFileForPdf) {
      _file = await File('${appDocumentsDir.path}/$fileName')
          .create(recursive: true);

      await _file!
          .writeAsBytes(capturedImage!.buffer.asInt8List(
              capturedImage.offsetInBytes, capturedImage.lengthInBytes))
          .whenComplete(() => logger.i("Completed!"));
    } else {
      _pngFileForPdf = await File('${appDocumentsDir.path}/$fileName')
          .create(recursive: true);

      await _pngFileForPdf!
          .writeAsBytes(capturedImage!.buffer.asInt8List(
              capturedImage.offsetInBytes, capturedImage.lengthInBytes))
          .whenComplete(() => logger.i("Completed!"));
    }

    return;
  }

  Future<void> disposeState(WidgetRef ref) async {
    await _file?.delete(recursive: true);
    _file = null;
  }

  File? get file => _file;
}
