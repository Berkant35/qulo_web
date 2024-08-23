import 'package:flutter/foundation.dart';
import '../connections/connection_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'connection_by_customer.freezed.dart';
part 'connection_by_customer.g.dart';

typedef ConnectionMapLog = Map<String,ConnectionLog>;

@freezed
class ConnectionByCustomer with _$ConnectionByCustomer {
  const factory ConnectionByCustomer({
    @JsonKey(name: 'customer_email') String? customerEmail,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'any_connection_before') bool? anyConnectionBefore,
    @JsonKey(name: 'connection_logs') ConnectionMapLog? connectionLogs,
  }) = _ConnectionByCustomer;

  factory ConnectionByCustomer.fromJson(Map<String, Object?> json) =>
      _$ConnectionByCustomerFromJson(json);
}
