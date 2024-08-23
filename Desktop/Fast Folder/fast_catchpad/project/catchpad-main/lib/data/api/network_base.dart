import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:dio/dio.dart';


abstract class NetworkBase {

  late Dio _dio;

  Dio get customDio => _dio;


  late Map<String,dynamic> _headers;


  Map<String, dynamic> get headers => _headers;

  NetworkBase();

  /// Initializes the network with the given [baseUrl] and optional [headers].
  init(String baseUrl, Map<String, dynamic>? headers) {
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      validateStatus: (int? status) {
        return status != null;
        // return status != null && status >= 200 && status < 300;
      },
    );

    _dio = Dio(baseOptions);
    _dio.interceptors.addAll([
      ErrorInterceptor(),
    ]);

  }
}
class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;
    if (!isValid) {
      throw DioException.badResponse(
        statusCode: status!,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    super.onResponse(response, handler);
  }
}