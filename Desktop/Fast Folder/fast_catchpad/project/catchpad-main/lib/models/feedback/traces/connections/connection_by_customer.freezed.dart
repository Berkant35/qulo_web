// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'connection_by_customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConnectionByCustomer _$ConnectionByCustomerFromJson(Map<String, dynamic> json) {
  return _ConnectionByCustomer.fromJson(json);
}

/// @nodoc
mixin _$ConnectionByCustomer {
  @JsonKey(name: 'customer_email')
  String? get customerEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'any_connection_before')
  bool? get anyConnectionBefore => throw _privateConstructorUsedError;
  @JsonKey(name: 'connection_logs')
  Map<String, ConnectionLog>? get connectionLogs =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectionByCustomerCopyWith<ConnectionByCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionByCustomerCopyWith<$Res> {
  factory $ConnectionByCustomerCopyWith(ConnectionByCustomer value,
          $Res Function(ConnectionByCustomer) then) =
      _$ConnectionByCustomerCopyWithImpl<$Res, ConnectionByCustomer>;
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_email') String? customerEmail,
      @JsonKey(name: 'customer_id') String? customerId,
      @JsonKey(name: 'any_connection_before') bool? anyConnectionBefore,
      @JsonKey(name: 'connection_logs')
      Map<String, ConnectionLog>? connectionLogs});
}

/// @nodoc
class _$ConnectionByCustomerCopyWithImpl<$Res,
        $Val extends ConnectionByCustomer>
    implements $ConnectionByCustomerCopyWith<$Res> {
  _$ConnectionByCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerEmail = freezed,
    Object? customerId = freezed,
    Object? anyConnectionBefore = freezed,
    Object? connectionLogs = freezed,
  }) {
    return _then(_value.copyWith(
      customerEmail: freezed == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      anyConnectionBefore: freezed == anyConnectionBefore
          ? _value.anyConnectionBefore
          : anyConnectionBefore // ignore: cast_nullable_to_non_nullable
              as bool?,
      connectionLogs: freezed == connectionLogs
          ? _value.connectionLogs
          : connectionLogs // ignore: cast_nullable_to_non_nullable
              as Map<String, ConnectionLog>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConnectionByCustomerCopyWith<$Res>
    implements $ConnectionByCustomerCopyWith<$Res> {
  factory _$$_ConnectionByCustomerCopyWith(_$_ConnectionByCustomer value,
          $Res Function(_$_ConnectionByCustomer) then) =
      __$$_ConnectionByCustomerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'customer_email') String? customerEmail,
      @JsonKey(name: 'customer_id') String? customerId,
      @JsonKey(name: 'any_connection_before') bool? anyConnectionBefore,
      @JsonKey(name: 'connection_logs')
      Map<String, ConnectionLog>? connectionLogs});
}

/// @nodoc
class __$$_ConnectionByCustomerCopyWithImpl<$Res>
    extends _$ConnectionByCustomerCopyWithImpl<$Res, _$_ConnectionByCustomer>
    implements _$$_ConnectionByCustomerCopyWith<$Res> {
  __$$_ConnectionByCustomerCopyWithImpl(_$_ConnectionByCustomer _value,
      $Res Function(_$_ConnectionByCustomer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerEmail = freezed,
    Object? customerId = freezed,
    Object? anyConnectionBefore = freezed,
    Object? connectionLogs = freezed,
  }) {
    return _then(_$_ConnectionByCustomer(
      customerEmail: freezed == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      anyConnectionBefore: freezed == anyConnectionBefore
          ? _value.anyConnectionBefore
          : anyConnectionBefore // ignore: cast_nullable_to_non_nullable
              as bool?,
      connectionLogs: freezed == connectionLogs
          ? _value._connectionLogs
          : connectionLogs // ignore: cast_nullable_to_non_nullable
              as Map<String, ConnectionLog>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConnectionByCustomer
    with DiagnosticableTreeMixin
    implements _ConnectionByCustomer {
  const _$_ConnectionByCustomer(
      {@JsonKey(name: 'customer_email') this.customerEmail,
      @JsonKey(name: 'customer_id') this.customerId,
      @JsonKey(name: 'any_connection_before') this.anyConnectionBefore,
      @JsonKey(name: 'connection_logs')
      final Map<String, ConnectionLog>? connectionLogs})
      : _connectionLogs = connectionLogs;

  factory _$_ConnectionByCustomer.fromJson(Map<String, dynamic> json) =>
      _$$_ConnectionByCustomerFromJson(json);

  @override
  @JsonKey(name: 'customer_email')
  final String? customerEmail;
  @override
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @override
  @JsonKey(name: 'any_connection_before')
  final bool? anyConnectionBefore;
  final Map<String, ConnectionLog>? _connectionLogs;
  @override
  @JsonKey(name: 'connection_logs')
  Map<String, ConnectionLog>? get connectionLogs {
    final value = _connectionLogs;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConnectionByCustomer(customerEmail: $customerEmail, customerId: $customerId, anyConnectionBefore: $anyConnectionBefore, connectionLogs: $connectionLogs)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConnectionByCustomer'))
      ..add(DiagnosticsProperty('customerEmail', customerEmail))
      ..add(DiagnosticsProperty('customerId', customerId))
      ..add(DiagnosticsProperty('anyConnectionBefore', anyConnectionBefore))
      ..add(DiagnosticsProperty('connectionLogs', connectionLogs));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectionByCustomer &&
            (identical(other.customerEmail, customerEmail) ||
                other.customerEmail == customerEmail) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.anyConnectionBefore, anyConnectionBefore) ||
                other.anyConnectionBefore == anyConnectionBefore) &&
            const DeepCollectionEquality()
                .equals(other._connectionLogs, _connectionLogs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      customerEmail,
      customerId,
      anyConnectionBefore,
      const DeepCollectionEquality().hash(_connectionLogs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConnectionByCustomerCopyWith<_$_ConnectionByCustomer> get copyWith =>
      __$$_ConnectionByCustomerCopyWithImpl<_$_ConnectionByCustomer>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConnectionByCustomerToJson(
      this,
    );
  }
}

abstract class _ConnectionByCustomer implements ConnectionByCustomer {
  const factory _ConnectionByCustomer(
      {@JsonKey(name: 'customer_email') final String? customerEmail,
      @JsonKey(name: 'customer_id') final String? customerId,
      @JsonKey(name: 'any_connection_before') final bool? anyConnectionBefore,
      @JsonKey(name: 'connection_logs')
      final Map<String, ConnectionLog>?
          connectionLogs}) = _$_ConnectionByCustomer;

  factory _ConnectionByCustomer.fromJson(Map<String, dynamic> json) =
      _$_ConnectionByCustomer.fromJson;

  @override
  @JsonKey(name: 'customer_email')
  String? get customerEmail;
  @override
  @JsonKey(name: 'customer_id')
  String? get customerId;
  @override
  @JsonKey(name: 'any_connection_before')
  bool? get anyConnectionBefore;
  @override
  @JsonKey(name: 'connection_logs')
  Map<String, ConnectionLog>? get connectionLogs;
  @override
  @JsonKey(ignore: true)
  _$$_ConnectionByCustomerCopyWith<_$_ConnectionByCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}
