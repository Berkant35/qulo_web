



import 'package:catchpad/data/api/network_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class TelegramBase extends NetworkBase {

  Future<void> sendMobileReportMessage(String telegramMessage,WidgetRef ref);
  Future<void> sendDashboardBugReport(String telegramMessage,WidgetRef ref);

  Future<void> sendIGAMobilePeriodicallyReport(String telegramMessage,WidgetRef ref);
}