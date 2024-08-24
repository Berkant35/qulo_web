import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/components/dialogs/basic_dialogs.dart';
import 'package:audiotodo/utilities/constants/exceptions/exception_base.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_dialog_shower/dialog/dialog_shower.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseExceptions extends ExceptionBase {
  static handlePurchaseExceptions(String errorMessage, WidgetRef ref,
      {String? subCollectionName,required DialogShower dialogShower}) {
    ExceptionBase.sendExceptionToServer("PurchaseExceptions", title: subCollectionName, description: errorMessage);

  }
}
