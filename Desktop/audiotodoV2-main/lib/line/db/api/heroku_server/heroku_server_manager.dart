import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/contact_us_problems.dart';
import 'package:flutter_riverpod/src/consumer.dart';

final class HerokuServerManager extends UserExperience {
  static HerokuServerManager? _instance;

  static HerokuServerManager? get instance {
    _instance ??= HerokuServerManager._();
    return _instance;
  }

  HerokuServerManager._();


  @override
  Future<bool> sendContactUsMail(WidgetRef ref, String message,
      ProblemType problemType, String email) async {
    try {


      final res = await customDio
          .post('${customDio.options.baseUrl}api/contactUs', data: {
        "email": email,
        "message": message,
        "problemType": problemType.name
      });
      logger.w("Response: ${res.data}");
    } catch (e) {
      logger.e(e.toString());
    }
    return true;
  }
}
