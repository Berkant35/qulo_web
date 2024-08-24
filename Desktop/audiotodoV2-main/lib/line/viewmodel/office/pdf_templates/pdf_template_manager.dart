import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

abstract class IPDFTemplateManager {
  PdfPageFormat forceFormat = PdfPageFormat.a4;
  PageTheme pageTheme = const PageTheme();
  void createDocument(WidgetRef ref);

  void definePageCount(String allTexts,WidgetRef ref);

  //void createPages(String allTexts,WidgetRef ref);

  void setTemplateLogic(WidgetRef ref);

  Future<File> createFileByFormatPdf(WidgetRef ref);

  File getPdf(WidgetRef ref);
}
