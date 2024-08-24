import 'dart:io';

import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/line/viewmodel/office/word_templates/word_template_manager.dart';
import 'package:audiotodo/main.dart';
import 'package:docx_template/docx_template.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class BasicWordTemplate extends IWordTemplateManager {
  DocxTemplate? _docxTemplate;

  DocxTemplate get docxTemplate => _docxTemplate!;

  File? _wordFile;

  File get wordFile => _wordFile!;

  /// Use for list element of docx file [PlainContent]

  @override
  Future<void> createDocument(WidgetRef ref) async {
    try {
      // Belge dizinini al
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDirectory.path;

      // Dosya adını oluştur
      String fileName = DateTime.now().toIso8601String();
      String path = "$appDocPath/ses.docx";
      logger.i(path);
      // .docx dosyasını oluştur
      final fileByCurrentMeetingInfo = await File(
          path).create(recursive: true);

      // Dosyanın var olup olmadığını kontrol et
      if (!await fileByCurrentMeetingInfo.exists()) {
        throw Exception("DOCX file does not exist at path: ${fileByCurrentMeetingInfo.path}");
      }

      // Dosyanın okunabilir olduğunu kontrol et
      final byteList =  fileByCurrentMeetingInfo.readAsBytesSync();
      fileByCurrentMeetingInfo.writeAsBytes(byteList);


      // DOCX dosyasını şablon olarak oku
      _docxTemplate = await DocxTemplate.fromBytes(byteList);
    } catch (e) {
      print("Failed to create document: $e");
      // Hatanın ayrıntılarını loglayın veya kullanıcıya bildirin
    }
  }


  @override
  Future<File> createContentOfDocx(WidgetRef ref) async {
    Content content = Content();

    content.add(PlainContent("Hello World"));

    final docx = await _docxTemplate!.generate(content);
    wordFile.writeAsBytes(docx ?? []);
    return wordFile;
  }

  @override
  void definePageCount(String allTexts, WidgetRef ref) {
    // TODO: implement definePageCount
  }

  @override
  void setTemplateLogic(WidgetRef ref) {
    // TODO: implement setTemplateLogic
  }
}
