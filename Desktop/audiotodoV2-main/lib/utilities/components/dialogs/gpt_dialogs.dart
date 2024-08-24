


import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/constants/exceptions/dio_exceptions.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GptApiDialogs {

  static notResponseToDoModel(WidgetRef ref) => AwesomeDialog(
    context: ref.context,
    dialogType: DialogType.error,
    animType: AnimType.topSlide,
    title: S.current.something_went_wrong,
    desc: S.current.please_give_feed_back,
    btnCancelOnPress: () => CustomDioExceptions.handleDioExceptions(
        "GPT Response Fail", ref),
  ).show();

}