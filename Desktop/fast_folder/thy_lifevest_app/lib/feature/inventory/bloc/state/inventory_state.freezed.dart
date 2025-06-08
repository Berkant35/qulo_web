// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryState {

 UIStateStatus get status; Failure? get failure; LifevestTagMap get lifevestTags;// Inventory durumu
 bool get isInventoryRunning; List<ReaderTag> get discoveredTags; int get totalTagCount;// Ekran state'i
 bool get isLoading; String? get statusMessage; String? get connectedReaderName;
/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryStateCopyWith<InventoryState> get copyWith => _$InventoryStateCopyWithImpl<InventoryState>(this as InventoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.lifevestTags, lifevestTags)&&(identical(other.isInventoryRunning, isInventoryRunning) || other.isInventoryRunning == isInventoryRunning)&&const DeepCollectionEquality().equals(other.discoveredTags, discoveredTags)&&(identical(other.totalTagCount, totalTagCount) || other.totalTagCount == totalTagCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.connectedReaderName, connectedReaderName) || other.connectedReaderName == connectedReaderName));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,const DeepCollectionEquality().hash(lifevestTags),isInventoryRunning,const DeepCollectionEquality().hash(discoveredTags),totalTagCount,isLoading,statusMessage,connectedReaderName);

@override
String toString() {
  return 'InventoryState(status: $status, failure: $failure, lifevestTags: $lifevestTags, isInventoryRunning: $isInventoryRunning, discoveredTags: $discoveredTags, totalTagCount: $totalTagCount, isLoading: $isLoading, statusMessage: $statusMessage, connectedReaderName: $connectedReaderName)';
}


}

/// @nodoc
abstract mixin class $InventoryStateCopyWith<$Res>  {
  factory $InventoryStateCopyWith(InventoryState value, $Res Function(InventoryState) _then) = _$InventoryStateCopyWithImpl;
@useResult
$Res call({
 UIStateStatus status, Failure? failure, LifevestTagMap lifevestTags, bool isInventoryRunning, List<ReaderTag> discoveredTags, int totalTagCount, bool isLoading, String? statusMessage, String? connectedReaderName
});




}
/// @nodoc
class _$InventoryStateCopyWithImpl<$Res>
    implements $InventoryStateCopyWith<$Res> {
  _$InventoryStateCopyWithImpl(this._self, this._then);

  final InventoryState _self;
  final $Res Function(InventoryState) _then;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? failure = freezed,Object? lifevestTags = null,Object? isInventoryRunning = null,Object? discoveredTags = null,Object? totalTagCount = null,Object? isLoading = null,Object? statusMessage = freezed,Object? connectedReaderName = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,lifevestTags: null == lifevestTags ? _self.lifevestTags : lifevestTags // ignore: cast_nullable_to_non_nullable
as LifevestTagMap,isInventoryRunning: null == isInventoryRunning ? _self.isInventoryRunning : isInventoryRunning // ignore: cast_nullable_to_non_nullable
as bool,discoveredTags: null == discoveredTags ? _self.discoveredTags : discoveredTags // ignore: cast_nullable_to_non_nullable
as List<ReaderTag>,totalTagCount: null == totalTagCount ? _self.totalTagCount : totalTagCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,connectedReaderName: freezed == connectedReaderName ? _self.connectedReaderName : connectedReaderName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _InventoryState extends InventoryState {
  const _InventoryState({this.status = UIStateStatus.idle, this.failure, final  LifevestTagMap lifevestTags = const {}, this.isInventoryRunning = false, final  List<ReaderTag> discoveredTags = const [], this.totalTagCount = 0, this.isLoading = false, this.statusMessage, this.connectedReaderName}): _lifevestTags = lifevestTags,_discoveredTags = discoveredTags,super._();
  

@override@JsonKey() final  UIStateStatus status;
@override final  Failure? failure;
 final  LifevestTagMap _lifevestTags;
@override@JsonKey() LifevestTagMap get lifevestTags {
  if (_lifevestTags is EqualUnmodifiableMapView) return _lifevestTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lifevestTags);
}

// Inventory durumu
@override@JsonKey() final  bool isInventoryRunning;
 final  List<ReaderTag> _discoveredTags;
@override@JsonKey() List<ReaderTag> get discoveredTags {
  if (_discoveredTags is EqualUnmodifiableListView) return _discoveredTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveredTags);
}

@override@JsonKey() final  int totalTagCount;
// Ekran state'i
@override@JsonKey() final  bool isLoading;
@override final  String? statusMessage;
@override final  String? connectedReaderName;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryStateCopyWith<_InventoryState> get copyWith => __$InventoryStateCopyWithImpl<_InventoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._lifevestTags, _lifevestTags)&&(identical(other.isInventoryRunning, isInventoryRunning) || other.isInventoryRunning == isInventoryRunning)&&const DeepCollectionEquality().equals(other._discoveredTags, _discoveredTags)&&(identical(other.totalTagCount, totalTagCount) || other.totalTagCount == totalTagCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.connectedReaderName, connectedReaderName) || other.connectedReaderName == connectedReaderName));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,const DeepCollectionEquality().hash(_lifevestTags),isInventoryRunning,const DeepCollectionEquality().hash(_discoveredTags),totalTagCount,isLoading,statusMessage,connectedReaderName);

@override
String toString() {
  return 'InventoryState(status: $status, failure: $failure, lifevestTags: $lifevestTags, isInventoryRunning: $isInventoryRunning, discoveredTags: $discoveredTags, totalTagCount: $totalTagCount, isLoading: $isLoading, statusMessage: $statusMessage, connectedReaderName: $connectedReaderName)';
}


}

/// @nodoc
abstract mixin class _$InventoryStateCopyWith<$Res> implements $InventoryStateCopyWith<$Res> {
  factory _$InventoryStateCopyWith(_InventoryState value, $Res Function(_InventoryState) _then) = __$InventoryStateCopyWithImpl;
@override @useResult
$Res call({
 UIStateStatus status, Failure? failure, LifevestTagMap lifevestTags, bool isInventoryRunning, List<ReaderTag> discoveredTags, int totalTagCount, bool isLoading, String? statusMessage, String? connectedReaderName
});




}
/// @nodoc
class __$InventoryStateCopyWithImpl<$Res>
    implements _$InventoryStateCopyWith<$Res> {
  __$InventoryStateCopyWithImpl(this._self, this._then);

  final _InventoryState _self;
  final $Res Function(_InventoryState) _then;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? failure = freezed,Object? lifevestTags = null,Object? isInventoryRunning = null,Object? discoveredTags = null,Object? totalTagCount = null,Object? isLoading = null,Object? statusMessage = freezed,Object? connectedReaderName = freezed,}) {
  return _then(_InventoryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,lifevestTags: null == lifevestTags ? _self._lifevestTags : lifevestTags // ignore: cast_nullable_to_non_nullable
as LifevestTagMap,isInventoryRunning: null == isInventoryRunning ? _self.isInventoryRunning : isInventoryRunning // ignore: cast_nullable_to_non_nullable
as bool,discoveredTags: null == discoveredTags ? _self._discoveredTags : discoveredTags // ignore: cast_nullable_to_non_nullable
as List<ReaderTag>,totalTagCount: null == totalTagCount ? _self.totalTagCount : totalTagCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,connectedReaderName: freezed == connectedReaderName ? _self.connectedReaderName : connectedReaderName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
