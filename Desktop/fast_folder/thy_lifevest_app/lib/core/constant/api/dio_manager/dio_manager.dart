import 'dart:io';

import 'package:dio/dio.dart';

import 'interceptor/refresh_interceptor.dart';

class DioManager {
  /// Get Dio instance
  static Dio getDio() {
    Dio dio = Dio();

    dio.options.baseUrl = "https://cirfid.ilgazi.com";

    dio.options.headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "platform": Platform.operatingSystem,
      "X-Client-Version": Platform.operatingSystem,
    };

    dio.options.validateStatus = (status) => status! < 500 && status != 401;

    dio.options.responseType = ResponseType.plain;

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        error: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
      ),
    );

    // dio.interceptors.add(RefreshTokenInterceptor(dio: dio));

    return dio;
  }
}
