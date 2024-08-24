import 'dart:convert';

import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Configs {


  static const periodicTimerWithSec = 50;
  static const mainPageDurationTime = 1500;
  static const startVolumeSound = 100.0;
  static const noOfSamples = 100;


}


class RequestConfigs {
  static const clickUpApiBaseUrl = 'https://api.clickup.com/api/v2/';

  //TODO DOT ENV UZERINDEN KONULACAK
  static  Map<String, dynamic> customHeaders = {
    'headers': {
      'content-type': 'application/json',
      dotenv.env['GPT_API_HEADER_KEY'] : dotenv.env['GPT_API_KEY'],
      dotenv.env['GPT_API_HEADER_HOST'] : dotenv.env['GPT_API_HOST_VALUE'],
    },
  };


  static Map<String,dynamic> getWithTokenHeader(WidgetRef ref,String todoAppKey) {
    Map<String,dynamic> headerWithToken = {
      'Content-Type': 'application/json',
      'Connection' : 'keep-alive',
      'Accept-Encoding' : 'gzip, deflate, br',
      'Accept' : '*/*',
      'Authorization' : ref.read(authManager)!.todoPlatformTokens![todoAppKey]
    };
    return  headerWithToken;
  }


  static Map<String,dynamic> getWithTokenHeaderForJiraSoftware(WidgetRef ref,String jiraSoftwareDomain,String jiraSoftwareApiKey){
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${ref.read(authManager)!.todoPlatformTokens![jiraSoftwareDomain]}:${ref.read(authManager)!.todoPlatformTokens![jiraSoftwareApiKey]}'))}';
    Map<String,dynamic> headerWithToken = {
      'Content-Type': 'application/json',
      'authorization' : basicAuth
    };

    return headerWithToken;
  }

}