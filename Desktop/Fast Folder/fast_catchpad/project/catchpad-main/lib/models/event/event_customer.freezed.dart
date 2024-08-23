// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'event_customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventCustomer _$EventCustomerFromJson(Map<String, dynamic> json) {
  return _EventCustomer.fromJson(json);
}

/// @nodoc
mixin _$EventCustomer {
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCustomerCopyWith<EventCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCustomerCopyWith<$Res> {
  factory $EventCustomerCopyWith(
          EventCustomer value, $Res Function(EventCustomer) then) =
      _$EventCustomerCopyWithImpl<$Res, EventCustomer>;
  @useResult
  $Res call(
      {@JsonKey(name: 'email') String? email,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'createdAt') String? createdAt});
}

/// @nodoc
class _$EventCustomerCopyWithImpl<$Res, $Val extends EventCustomer>
    implements $EventCustomerCopyWith<$Res> {
  _$EventCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? username = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventCustomerCopyWith<$Res>
    implements $EventCustomerCopyWith<$Res> {
  factory _$$_EventCustomerCopyWith(
          _$_EventCustomer value, $Res Function(_$_EventCustomer) then) =
      __$$_EventCustomerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'email') String? email,
      @JsonKey(name: 'phone') String? phone,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'createdAt') String? createdAt});
}

/// @nodoc
class __$$_EventCustomerCopyWithImpl<$Res>
    extends _$EventCustomerCopyWithImpl<$Res, _$_EventCustomer>
    implements _$$_EventCustomerCopyWith<$Res> {
  __$$_EventCustomerCopyWithImpl(
      _$_EventCustomer _value, $Res Function(_$_EventCustomer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? username = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_EventCustomer(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventCustomer with DiagnosticableTreeMixin implements _EventCustomer {
  const _$_EventCustomer(
      {@JsonKey(name: 'email') this.email,
      @JsonKey(name: 'phone') this.phone,
      @JsonKey(name: 'username') this.username,
      @JsonKey(name: 'createdAt') this.createdAt});

  factory _$_EventCustomer.fromJson(Map<String, dynamic> json) =>
      _$$_EventCustomerFromJson(json);

  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'phone')
  final String? phone;
  @override
  @JsonKey(name: 'username')
  final String? username;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EventCustomer(email: $email, phone: $phone, username: $username, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EventCustomer'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventCustomer &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, phone, username, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCustomerCopyWith<_$_EventCustomer> get copyWith =>
      __$$_EventCustomerCopyWithImpl<_$_EventCustomer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventCustomerToJson(
      this,
    );
  }
}

abstract class _EventCustomer implements EventCustomer {
  const factory _EventCustomer(
      {@JsonKey(name: 'email') final String? email,
      @JsonKey(name: 'phone') final String? phone,
      @JsonKey(name: 'username') final String? username,
      @JsonKey(name: 'createdAt') final String? createdAt}) = _$_EventCustomer;

  factory _EventCustomer.fromJson(Map<String, dynamic> json) =
      _$_EventCustomer.fromJson;

  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'phone')
  String? get phone;
  @override
  @JsonKey(name: 'username')
  String? get username;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_EventCustomerCopyWith<_$_EventCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}
