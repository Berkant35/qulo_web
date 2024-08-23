import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// https://docs.quickemailverification.com/email-verification-api/verify-an-email-address
// response model and for more information

class EmailVerificationService {
  final apiKey = dotenv.env['EMAIL_VERIFICATION_API_KEY'];

  Future<bool> verifyEmail(String email) async {
    final url =
        'https://api.quickemailverification.com/v1/verify?email=$email&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final isValid = responseData['result'] == 'valid' ? true : false;
        print('result: ${responseData['result']}');
        return isValid;
      } else {
        throw Exception('Failed to verify email');
      }
    } catch (e) {
      throw Exception('Failed to verify email');
    }
  }
}
