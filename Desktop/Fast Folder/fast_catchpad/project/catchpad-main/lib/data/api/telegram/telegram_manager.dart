


import 'package:catchpad/data/api/telegram/telegram_base.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TelegramManager extends TelegramBase {

  /// You can call [customDio] in this class.
  /// because inherited from [TelegramBase] and also
  /// TelegramBase inherited from [NetworkBase]

  static TelegramManager? _instance;

  static TelegramManager? get instance {
    _instance ??= TelegramManager._();
    return _instance;
  }
  TelegramManager._();


  @override
  Future<void> sendDashboardBugReport(String telegramMessage,WidgetRef ref) async {
    // TODO: implement sendDashboardBugReport
  }

  @override
  Future<void> sendMobileReportMessage(String telegramMessage,WidgetRef ref) async {
        try{

          var data = FormData.fromMap({
            "text": telegramMessage,
            "parse_mode":'HTML',
            'chat_id': dotenv.env['TELEGRAM_MOBILE_REPORT_CHAT_ID']!
          },);

          final response = await customDio.post(
            '${customDio.options.baseUrl}${dotenv.env['TELEGRAM_TOKEN_AT_URL']!}/sendMessage',
            options: Options(
                method: 'POST'
            ),
            data: data
          );

        } on Exception catch (e) {
          logger.e(e.toString());
        }
  }

  @override
  Future<void> sendIGAMobilePeriodicallyReport(String telegramMessage, WidgetRef ref) async {
     try{

       var data = FormData.fromMap({
         "text": telegramMessage,
         "parse_mode":'HTML',
         'chat_id': dotenv.env['TELEGRAM_IGA_PERIODIC_REPORT']!
       },);

       final response = await customDio.post(
           '${customDio.options.baseUrl}${dotenv.env['TELEGRAM_TOKEN_AT_URL']!}/sendMessage',
           options: Options(
               method: 'POST'
           ),
           data: data
       );

     } on Exception catch (e) {
       logger.e(e.toString());
     }
  }

}




