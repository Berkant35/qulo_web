

import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/office/file_creator_manager.dart';

enum PdfAttribute {
  session_title,
  session_description,
  session_summary,
  session_contributors,
  session_detect_todo_list,
  session_owner_company_logo,
  session_date,
  session_time,
}

class OfficeFilesAttributeMap {
  static OfficeFileAttributeMap defaultPdfAttribute = {
    PdfAttribute.session_title.name: true,
    PdfAttribute.session_description.name: true,
    PdfAttribute.session_summary.name: true,
    PdfAttribute.session_contributors.name: true,
    PdfAttribute.session_detect_todo_list.name: true,
    PdfAttribute.session_owner_company_logo.name: true,
    PdfAttribute.session_date.name: true,
    PdfAttribute.session_time.name: true,
  };

  static OfficeFileAttributeMap defaultPdfAttributeTexts = {
    PdfAttribute.session_title.name: S.current.office_pdf_attribute_title,
    PdfAttribute.session_description.name: S.current.office_pdf_attribute_description,
    PdfAttribute.session_summary.name: S.current.office_pdf_attribute_summary,
    PdfAttribute.session_contributors.name: S.current.office_pdf_attribute_contributors,
    PdfAttribute.session_detect_todo_list.name: S.current.office_pdf_attribute_detected_todos,
    PdfAttribute.session_owner_company_logo.name: S.current.office_pdf_attribute_owner_logo,
    PdfAttribute.session_date.name: S.current.office_pdf_attribute_session_date,
    PdfAttribute.session_time.name: S.current.office_pdf_attribute_session_time,
  };
}