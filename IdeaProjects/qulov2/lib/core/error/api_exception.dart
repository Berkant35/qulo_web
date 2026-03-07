class ApiException implements Exception {
  final String code;
  final dynamic params;
  final int? statusCode;

  const ApiException({
    required this.code,
    this.params,
    this.statusCode,
  });

  factory ApiException.fromResponse(
      Map<String, dynamic> data, int? statusCode) {
    final error = data['error'] as Map<String, dynamic>?;
    if (error != null) {
      return ApiException(
        code: error['code'] as String? ?? 'SERVER_ERROR',
        params: error['params'],
        statusCode: statusCode,
      );
    }
    return ApiException(code: 'SERVER_ERROR', statusCode: statusCode);
  }

  @override
  String toString() => 'ApiException($code)';
}
