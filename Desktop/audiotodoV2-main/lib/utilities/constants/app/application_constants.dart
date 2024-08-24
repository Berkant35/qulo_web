import '../../../generated/l10n.dart';

class ApplicationConstants {
  static const customFontFamily = "Poppins";
  static const appTitle = "AudioToDo";


}









class ThirdTodoAppConstants{
  //Click Up
  static const clickUpMapKey = 'clickUp';
  static const clickUpName = 'ClickUp';
  //Slack
  static const slackKey = 'slack';
  static const slackName = 'Slack';
  static const jiraKey = 'jira';
  static const jiraName = 'Jira';
  static const jiraSoftwareKey = 'jira-software';
  static const jiraSoftwareName = 'Jira-Software';
  static const pdfKey = 'mc-pdf';
  static const pdfName = 'PDF';
  static const docKey = 'mc-docx';
  static const docxName = 'Word';
}



class ErrorTexts {
  static const errorSaveToLocal =
      'Error when record to local on phone! (SaveToLocalWithMeedId)';
  static const errorNotFoundMeetId =
      'Not found file by that meetId! (getFileWithMeedId)';
  static const errorDeleteMeetAllFailed = 'Deletion failed! (deleteAllFiles)';
  static const errorDeleteMeetByIdFailed = 'Deletion failed! (deleteMeetId)';
  static const errorGetApplicationLanguageFromLocaleFailed = 'Deletion failed! (View Model Get Choosed Application Language)';
  static const errorUpdateApplicationLanguageFromLocaleFailed = 'Deletion failed! (View Model Update Choosed Application Language)';
  static const errorUpdateChoosedLocaleNameFromLocaleFailed = 'Deletion failed! (View Model Update Choosed Application Language)';


  //Dio Error Texts
  static const statusCodeFailed = "Status Code Not 200";
}
