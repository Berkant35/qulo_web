// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_find_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryFindState {

 UIStateStatus get status; InventoryFindStatus get findStatus; Failure? get failure;
/// Create a copy of InventoryFindState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryFindStateCopyWith<InventoryFindState> get copyWith => _$InventoryFindStateCopyWithImpl<InventoryFindState>(this as InventoryFindState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryFindState&&(identical(other.status, status) || other.status == status)&&(identical(other.findStatus, findStatus) || other.findStatus == findStatus)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,findStatus,failure);

@override
String toString() {
  return 'InventoryFindState(status: $status, findStatus: $findStatus, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $InventoryFindStateCopyWith<$Res>  {
  factory $InventoryFindStateCopyWith(InventoryFindState value, $Res Function(InventoryFindState) _then) = _$InventoryFindStateCopyWithImpl;
@useResult
$Res call({
 UIStateStatus status, InventoryFindStatus findStatus, Failure? failure
});




}
/// @nodoc
class _$InventoryFindStateCopyWithImpl<$Res>
    implements $InventoryFindStateCopyWith<$Res> {
  _$InventoryFindStateCopyWithImpl(this._self, this._then);

  final InventoryFindState _self;
  final $Res Function(InventoryFindState) _then;

/// Create a copy of InventoryFindState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? findStatus = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,findStatus: null == findStatus ? _self.findStatus : findStatus // ignore: cast_nullable_to_non_nullable
as InventoryFindStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// @nodoc


class _InventoryFindState extends InventoryFindState {
  const _InventoryFindState({this.status = UIStateStatus.idle, this.findStatus = InventoryFindStatus.idle, this.failure}): super._();
  

@override@JsonKey() final  UIStateStatus status;
@override@JsonKey() final  InventoryFindStatus findStatus;
@override final  Failure? failure;

/// Create a copy of InventoryFindState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryFindStateCopyWith<_InventoryFindState> get copyWith => __$InventoryFindStateCopyWithImpl<_InventoryFindState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryFindState&&(identical(other.status, status) || other.status == status)&&(identical(other.findStatus, findStatus) || other.findStatus == findStatus)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,findStatus,failure);

@override
String toString() {
  return 'InventoryFindState(status: $status, findStatus: $findStatus, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$InventoryFindStateCopyWith<$Res> implements $InventoryFindStateCopyWith<$Res> {
  factory _$InventoryFindStateCopyWith(_InventoryFindState value, $Res Function(_InventoryFindState) _then) = __$InventoryFindStateCopyWithImpl;
@override @useResult
$Res call({
 UIStateStatus status, InventoryFindStatus findStatus, Failure? failure
});




}
/// @nodoc
class __$InventoryFindStateCopyWithImpl<$Res>
    implements _$InventoryFindStateCopyWith<$Res> {
  __$InventoryFindStateCopyWithImpl(this._self, this._then);

  final _InventoryFindState _self;
  final $Res Function(_InventoryFindState) _then;

/// Create a copy of InventoryFindState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? findStatus = null,Object? failure = freezed,}) {
  return _then(_InventoryFindState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,findStatus: null == findStatus ? _self.findStatus : findStatus // ignore: cast_nullable_to_non_nullable
as InventoryFindStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
