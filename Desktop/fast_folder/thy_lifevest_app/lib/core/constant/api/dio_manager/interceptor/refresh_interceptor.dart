import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:thy_lifevest_app/core/constant/api/dio_manager/interceptor/extension/interceptor_extension.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio dio;

  RefreshTokenInterceptor({required this.dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      try {
        return await retryRequest(dio, error: err, handler: handler);
      } catch (e) {
        //TODO: Handle specific exceptions if needed
      }
    } else {
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: Response(
            requestOptions: err.requestOptions,
            statusCode: HttpStatus.internalServerError,
          ),
          message: AppStrings.somethingWentWrongDescription,
        ),
      );
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Request: ${options.method} ${options.path}');
    super.onRequest(options, handler);
  }
}
