class ListDto<T> {
  final List<T>? data;
  final String? message;
  final bool status;
  final String? errorCode;

  const ListDto({
    required this.data,
    required this.message,
    required this.status,
    this.errorCode,
  });

  factory ListDto.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ListDto<T>(
      data:
          json['data'] != null
              ? (json['data'] as List<dynamic>)
                  .map((e) => fromJsonT(e))
                  .toList()
              : null,
      message: json['message'] as String?,
      status: json['status'] as bool,
      errorCode: json['errorCode'] as String?,
    );
  }
}
