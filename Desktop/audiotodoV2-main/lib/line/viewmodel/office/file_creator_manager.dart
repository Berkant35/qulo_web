import 'dart:io';

import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/office/i_office_manager.dart';
import 'package:audiotodo/line/viewmodel/office/pdf_templates/basic_pdf_template.dart';
import 'package:audiotodo/line/viewmodel/office/word_templates/basic_word_template.dart';
import 'package:audiotodo/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utilities/helper/office/ofice_file_configs.dart';

typedef OfficeFileAttributeMap = Map<String, dynamic>;

class PdfOfficeManager extends StateNotifier<OfficeFileAttributeMap>
    implements IOfficeManager {
  PdfOfficeManager(OfficeFileAttributeMap state)
      : super(OfficeFilesAttributeMap.defaultPdfAttribute);

  File? currentPdfFile;
  File? currentWordFile;

  /// TODO YOU SHOULD ADD LOCAL STORAGE
  void setAttributeState(String key, bool val) {
    OfficeFileAttributeMap pdfAttributeMap = state;
    pdfAttributeMap.update(key, (value) => val);
    state = pdfAttributeMap;
  }

  Future<void> createPdfFileAndShow(WidgetRef ref) async {
    final instanceTemplate = BasicPdfTemplate.instance;
    await instanceTemplate.createDocument(ref);
    await instanceTemplate.createFileByFormatPdf(ref).then((file) async {
      currentPdfFile = file;
      //final isFileOpened = await OpenFilex.open(currentPdfFile?.path);
      //logger.i("Open File: $isFileOpened");

      NavigationService.instance
          .navigateToPage(path: NavigationConstants.pdfViewAndSharePage);
    });
  }

  Future<void> createWordFileAndShow(WidgetRef ref) async {
    final instanceTemplate = BasicWordTemplate();
    await instanceTemplate.createDocument(ref);
    await instanceTemplate.createContentOfDocx(ref).then((file) async {
      currentWordFile = file;
      final isFileOpened = await OpenFilex.open(currentWordFile?.path);
      logger.i("Open File: $isFileOpened");
      final result = await Share.shareXFiles([XFile(currentWordFile!.path)]);
      //Share file
    });
  }

  @override
  Future<bool> saveFormat(
      Map<String, dynamic> officeAttributes, OfficesType officesType) {
    // TODO: implement saveFormat
    throw UnimplementedError();
  }

  @override
  Future<bool> shareToFile() {
    // TODO: implement shareToFile
    throw UnimplementedError();
  }
}
