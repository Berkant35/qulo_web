

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'event_customer.freezed.dart';
part 'event_customer.g.dart';

@freezed
class EventCustomer with _$EventCustomer {
  const factory EventCustomer({
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'createdAt') String? createdAt,
  }) = _EventCustomer;

  factory EventCustomer.fromJson(Map<String, Object?> json) =>
      _$EventCustomerFromJson(json);
}
