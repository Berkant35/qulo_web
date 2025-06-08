import 'package:dio/dio.dart';

extension InterceptorExtension on Interceptor {
  
  
  Future<void> retryRequest(
    Dio dio, {
    required DioException error,
    required ErrorInterceptorHandler handler,
  }) async {
    dio.options.baseUrl = error.requestOptions.baseUrl;

    /// If the request is a FormData, we need to create a new FormData object to avoid the error:
    late FormData existingFormData;
    dynamic anotherData;
    if (error.requestOptions.data is FormData) {
      existingFormData = error.requestOptions.data;
      anotherData = FormData();
      for (var field in existingFormData.fields) {
        (anotherData as FormData).fields.add(MapEntry(field.key, field.value));
      }
    } else {
      anotherData = error.requestOptions.data;
    }

    Response<Map<String, dynamic>> response = await dio.request(
      error.requestOptions.path,
      data: anotherData,
      queryParameters: error.requestOptions.queryParameters,
      options: Options(
        method: error.requestOptions.method,
        headers: error.requestOptions.headers,
      ),
    );

    return handler.resolve(response);
  }
}
