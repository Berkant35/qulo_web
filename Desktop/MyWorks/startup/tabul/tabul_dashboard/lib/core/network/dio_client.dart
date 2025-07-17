import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

/// Dio HTTP client wrapper
/// Interceptor'lar ve error handling ile kapsamlı HTTP client
class DioClient {
  late final Dio _dio;

  DioClient(Dio dio) {
    _dio = dio;
    _setupBaseOptions();
    _setupInterceptors();
  }

  /// Base options setup
  void _setupBaseOptions() {
    _dio.options = BaseOptions(
      baseUrl: AppConstants.getEnvironmentUrl(),
      connectTimeout: Duration(seconds: AppConstants.connectionTimeout),
      receiveTimeout: Duration(seconds: AppConstants.receiveTimeout),
      sendTimeout: Duration(seconds: AppConstants.sendTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
    );
  }

  /// Interceptor setup
  void _setupInterceptors() {
    _dio.interceptors.addAll([
      _getLoggerInterceptor(),
      _getErrorInterceptor(),
      _getAuthInterceptor(),
    ]);
  }

  /// Logger interceptor
  Interceptor _getLoggerInterceptor() {
    return LogInterceptor(
      request: AppConstants.shouldShowDebugLogs,
      requestHeader: AppConstants.shouldShowDebugLogs,
      requestBody: AppConstants.shouldShowDebugLogs,
      responseHeader: AppConstants.shouldShowDebugLogs,
      responseBody: AppConstants.shouldShowDebugLogs,
      error: true,
      logPrint: (object) {
        if (AppConstants.shouldShowDebugLogs) {
          print('[DioClient] $object');
        }
      },
    );
  }

  /// Error interceptor
  Interceptor _getErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        // Handle different types of errors
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.sendTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          // Timeout errors
          handler.next(DioException(
            requestOptions: error.requestOptions,
            error: 'Connection timeout',
            type: DioExceptionType.connectionTimeout,
          ));
        } else if (error.type == DioExceptionType.connectionError) {
          // Network errors
          handler.next(DioException(
            requestOptions: error.requestOptions,
            error: 'Network error',
            type: DioExceptionType.connectionError,
          ));
        } else {
          handler.next(error);
        }
      },
    );
  }

  /// Auth interceptor
  Interceptor _getAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        // final token = await _getAuthToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        handler.next(options);
      },
      onError: (error, handler) async {
        // Handle auth errors (401)
        if (error.response?.statusCode == 401) {
          // Try to refresh token
          // final refreshed = await _refreshToken();
          // if (refreshed) {
          //   // Retry the request
          //   final clonedRequest = await _dio.request(
          //     error.requestOptions.path,
          //     options: Options(
          //       method: error.requestOptions.method,
          //       headers: error.requestOptions.headers,
          //     ),
          //     data: error.requestOptions.data,
          //     queryParameters: error.requestOptions.queryParameters,
          //   );
          //   handler.resolve(clonedRequest);
          // } else {
          //   handler.next(error);
          // }
        } else {
          handler.next(error);
        }
      },
    );
  }

  // ==================== HTTP METHODS ====================

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Download file
  Future<Response> download(
    String path,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await _dio.download(
      path,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
    );
  }

  /// Upload file
  Future<Response<T>> upload<T>(
    String path,
    FormData data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }

  // ==================== UTILITY METHODS ====================

  /// Update base URL
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Add custom header
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  /// Remove header
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  /// Clear all headers
  void clearHeaders() {
    _dio.options.headers.clear();
  }

  /// Set auth token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Clear auth token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// Get dio instance (for advanced usage)
  Dio get dio => _dio;
}
