import 'package:audiotodo/line/db/firebase/fb_db/fb_db_manager.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/contact_us_problems.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HerokuManagerControlNotifier extends StateNotifier<bool> {
  HerokuManagerControlNotifier(bool state) : super(false);
  final _dataBase = FirebaseDbManager();

  void changState(val) => state = val;

  Future<bool> contactUs(String email, String message, ProblemType problemType,
      WidgetRef ref) async {
    return await _dataBase.contactUs(email, message, problemType, ref);
  }
}
