// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_by_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConnectionByCustomer _$$_ConnectionByCustomerFromJson(
        Map<String, dynamic> json) =>
    _$_ConnectionByCustomer(
      customerEmail: json['customer_email'] as String?,
      customerId: json['customer_id'] as String?,
      anyConnectionBefore: json['any_connection_before'] as bool?,
      connectionLogs: (json['connection_logs'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, ConnectionLog.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_ConnectionByCustomerToJson(
        _$_ConnectionByCustomer instance) =>
    <String, dynamic>{
      'customer_email': instance.customerEmail,
      'customer_id': instance.customerId,
      'any_connection_before': instance.anyConnectionBefore,
      'connection_logs':
          instance.connectionLogs?.map((k, e) => MapEntry(k, e.toJson())),
    };
