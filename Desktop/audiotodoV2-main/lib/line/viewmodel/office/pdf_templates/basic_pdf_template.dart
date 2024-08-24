import 'dart:io';

import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/pdf_font_states.dart';
import 'package:audiotodo/utilities/constants/extensions/int_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/util_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../../models/meet/meet_model.dart';
import '../../../../utilities/helper/office/ofice_file_configs.dart';
import 'pdf_template_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicPdfTemplate extends IPDFTemplateManager {
  static final BasicPdfTemplate _instance = BasicPdfTemplate._init();

  static BasicPdfTemplate get instance => _instance;

  BasicPdfTemplate._init();

  late pw.Document pdf;
  late int pageCount;

  late File pdfFile;

  Map<int, pw.Page> pdfPagesMap = {};

  /*
  +------------------+      +------------------+      +------------------+
  |   createDocument |----->| definePageCount  |----->|    createPages   |
  +------------------+      +------------------+      +------------------+
  */
  Map<FontType, Font> fonts = {};

  Future<void> loadFont() async {
    for (var perFont in FontType.values) {
      final font = await perFont.loadFont();
      fonts.addAll({perFont: font});
    }
  }

  @override
  Future<void> createDocument(WidgetRef ref) async {
    pdf = pw.Document();
    final currentMeeting = ref.read(currentMeetControllerManager)!.meetContent ?? "";
    //Crete fonts for all latin characters Öö Uu Üü Iı İi
    await loadFont();
    definePageCount(currentMeeting, ref);
  }

  @override
  void definePageCount(String allTexts, WidgetRef ref) {

    var currentMeet = ref.watch(currentMeetControllerManager)!;
    currentMeet = currentMeet.copyWith(
        responseTodo: currentMeet.responseTodo!.copyWith(
            todos: ref.watch(tempTodoListState).toList()));


    final assignedPersons = ref.watch(tempTodoListState).distinct(by: (res)=>res.todoTitle);


    // logger.w(
    //     "Current Meet Todo Length: ${currentMeet.responseTodo!.todos!.length}");



    // logger.i(assignedPersons.toString());
    final content = currentMeet.meetContent ?? "No recognition word";

    final List<String> contentParts = [];

    int totalCharacter = content.length;
    int totalMaxCharacterForPage = 1000;
    int totalContentParts = totalCharacter ~/ totalMaxCharacterForPage;

    // 4 * 1000
    if (totalContentParts > 0) {
      for (int i = 0; i < totalContentParts; i++) {
        contentParts.add(content.substring(i, i + totalMaxCharacterForPage));
      }
      final lastCharacters = content.substring(
          totalContentParts, totalCharacter - totalContentParts);
      contentParts.add(lastCharacters);
    } else {
      contentParts.add(content.substring(0, content.length));
    }

    List<pw.Widget> pdfList = <pw.Widget>[
      if (currentMeet.meetTitle != null &&
          ref.read(officeFileManagerState)[PdfAttribute.session_title.name])
        pw.Text(currentMeet.meetTitle!,
            style: pw.TextStyle(font: fonts[FontType.black], fontSize: 24)),
      if (currentMeet.meetSubtitle != null &&
          ref.read(officeFileManagerState)[PdfAttribute.session_summary.name])
        pw.Text(ref.read(currentMeetControllerManager)!.meetSubtitle!,
            style: contentTextStyle()),
      if (currentMeet.meetTitle != null || currentMeet.meetSubtitle != null)
        beautifulDivider(),
      gap(),
      if (currentMeet.responseTodo != null &&
          currentMeet.responseTodo!.recognizePersonNames != null &&
          currentMeet.responseTodo!.recognizePersonNames!.isNotEmpty &&
          ref.read(officeFileManagerState)[PdfAttribute.session_contributors.name])
        pw.Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          pw.Text(S.current.office_pdf_attribute_contributors,
              style: titleTextStyle()),
          for (int i = 0;
              i < currentMeet.responseTodo!.recognizePersonNames!.length;
              i++)
            pw.Text(
                "\u2022 ${currentMeet.responseTodo!.recognizePersonNames![i]}",
                style: contentTextStyle()),
        ]),
      gap(),
      if (currentMeet.responseTodo != null &&
          currentMeet.responseTodo!.todos != null &&
          currentMeet.responseTodo!.todos!.isNotEmpty &&
          ref.read(officeFileManagerState)[PdfAttribute.session_detect_todo_list.name])
        pw.Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          pw.Text(S.current.office_pdf_attribute_detected_todos,
              style: titleTextStyle()),
          for (int i = 0; i < currentMeet.responseTodo!.todos!.length; i++)
            pw.Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              gap(),
              pw.Text(
                  " \u2022 ${currentMeet.responseTodo!.todos![i].todoTitle}",
                  style: titleTextStyle().copyWith(fontSize: 18)),
              pw.Text(" ${currentMeet.responseTodo!.todos![i].todoContent}",
                  style: contentTextStyle()),
              pw.Text(" ${currentMeet.responseTodo!.todos![i].tags}",
                  style: contentTextStyle()),
              if(assignedPersons.length>i)
              pw.Text(
                  " ${assignedPersons[i].assignedPersons ?? ""}",
                  style: contentTextStyle()),
            ]),
          beautifulDivider(),
        ]),
      gap(),
      if (currentMeet.createdDateTime != null &&
          ref.read(officeFileManagerState)[PdfAttribute.session_date.name])
        pw.Row(children: [
          pw.Text("${S.current.office_pdf_attribute_session_date}: ",
              style: titleTextStyle()),
          pw.Text(
              " ${currentMeet.createdDateTime!.toLocal().nowTimeTextddMMyyyyHHmm}",
              style: contentTextStyle()),
        ]),
      if (currentMeet.recordTimeSecond != null &&
          ref.read(officeFileManagerState)[PdfAttribute.session_time.name])
        pw.Row(children: [
          pw.Text("${S.current.office_pdf_attribute_session_time}: ",
              style: titleTextStyle()),
          pw.Text(
              " ${currentMeet.recordTimeSecond! <= 60 ?
              S.current.office_pdf_attribute_less_than_a_minute :
              ("${currentMeet.recordTimeSecond!.divideBySixty} ${S.current.minute}")}",
              style: contentTextStyle()),
        ]),
      pw.NewPage(),
      if (currentMeet.meetContent != null &&
          ref.read(officeFileManagerState)[PdfAttribute.session_description.name])
        pw.Text(S.current.office_pdf_attribute_description,
            style: titleTextStyle(),textAlign: TextAlign.justify),
      if (currentMeet.meetContent != null &&
          ref.read(officeFileManagerState)[PdfAttribute.session_description.name])
        for (int i = 0; i < contentParts.length; i++)
          pw.Text(contentParts[i], style: contentTextStyle(),overflow: TextOverflow.span,textAlign: TextAlign.justify),
      gap(),
    ];



    pdf.addPage(pw.MultiPage(
        pageFormat: forceFormat,
        maxPages: 3000,
        build: (Context context) => pdfList));
    //createPages(allTexts, ref);
  }

  pw.Divider beautifulDivider() {
    return pw.Divider(
        color: PdfColor.fromInt(CustomColors.primaryColor.value), thickness: 4);
  }

  pw.SizedBox gap() => pw.SizedBox(height: 24);

  pw.TextStyle contentTextStyle() {
    return pw.TextStyle(font: fonts[FontType.medium], fontSize: 18);
  }

  pw.TextStyle titleTextStyle() {
    return pw.TextStyle(font: fonts[FontType.bold], fontSize: 20);
  }

  /*@override
  void createPages(String allTexts, WidgetRef ref) {
    logger.i("Creating $pageCount page");
    for (int i = 0; i < pageCount; i++) {
      pdfPagesMap.addAll({
        i: (i == 0 || i == pageCount - 1)
            ? i == 0
            ? firstPage(ref)
            : lastPage(ref)
            : betweenPage(ref)
      });
      pdf.addPage(pdfPagesMap[i]!);
    }
  }*/

  pw.Page betweenPage(WidgetRef ref) {
    return pw.Page(
        pageFormat: forceFormat,
        build: (pw.Context context) {
          return pw.Column();
        });
  }

  pw.Page lastPage(WidgetRef ref) {
    return pw.Page(
        pageFormat: forceFormat,
        build: (pw.Context context) {
          return pw.Column();
        });
  }

  @override
  Future<File> createFileByFormatPdf(WidgetRef ref) async {
    final meetTitle = ref.read(currentMeetControllerManager)?.meetTitle;
    final fileName = meetTitle ?? DateTime.now().toIso8601String();
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    pdfFile = await File(
            "${appDocDirectory.path}/${fileName.toLowerCase().replaceAll(" ", "")}.pdf")
        .create(recursive: true);
    await pdfFile.writeAsBytes(await pdf.save());

    return pdfFile;
  }

  @override
  File getPdf(WidgetRef ref) {
    // TODO: implement getPdf
    throw UnimplementedError();
  }

  @override
  void setTemplateLogic(WidgetRef ref) {
    // TODO: implement setTemplateLogic
  }
}
