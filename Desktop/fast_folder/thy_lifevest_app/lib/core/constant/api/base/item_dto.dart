import 'error_dto.dart';

class ItemDto<T> {
  final T? data;
  final String? message;
  final bool status;
  final int? code;
  final List<ErrorDto>? errors;

  const ItemDto({
    required this.data,
    required this.message,
    required this.status,
    this.code,
    this.errors,
  });

  factory ItemDto.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ItemDto<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'] as String?,
      status: json['status'] as bool,
      code: json['code'] as int?,
      errors:
          json['errors'] != null
              ? (json['errors'] as List)
                  .map((e) => ErrorDto.fromJson(e))
                  .toList()
              : null,
    );
  }
}
