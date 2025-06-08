// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryContentState {

 InventoryContentFilters get selectedFilter; String? get accessToken; List<LifevestTagModel> get waitingToSendLifevestTags; List<LifevestTagModel> get lifevestTags;
/// Create a copy of InventoryContentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryContentStateCopyWith<InventoryContentState> get copyWith => _$InventoryContentStateCopyWithImpl<InventoryContentState>(this as InventoryContentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryContentState&&(identical(other.selectedFilter, selectedFilter) || other.selectedFilter == selectedFilter)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&const DeepCollectionEquality().equals(other.waitingToSendLifevestTags, waitingToSendLifevestTags)&&const DeepCollectionEquality().equals(other.lifevestTags, lifevestTags));
}


@override
int get hashCode => Object.hash(runtimeType,selectedFilter,accessToken,const DeepCollectionEquality().hash(waitingToSendLifevestTags),const DeepCollectionEquality().hash(lifevestTags));

@override
String toString() {
  return 'InventoryContentState(selectedFilter: $selectedFilter, accessToken: $accessToken, waitingToSendLifevestTags: $waitingToSendLifevestTags, lifevestTags: $lifevestTags)';
}


}

/// @nodoc
abstract mixin class $InventoryContentStateCopyWith<$Res>  {
  factory $InventoryContentStateCopyWith(InventoryContentState value, $Res Function(InventoryContentState) _then) = _$InventoryContentStateCopyWithImpl;
@useResult
$Res call({
 InventoryContentFilters selectedFilter, String? accessToken, List<LifevestTagModel> waitingToSendLifevestTags, List<LifevestTagModel> lifevestTags
});




}
/// @nodoc
class _$InventoryContentStateCopyWithImpl<$Res>
    implements $InventoryContentStateCopyWith<$Res> {
  _$InventoryContentStateCopyWithImpl(this._self, this._then);

  final InventoryContentState _self;
  final $Res Function(InventoryContentState) _then;

/// Create a copy of InventoryContentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedFilter = null,Object? accessToken = freezed,Object? waitingToSendLifevestTags = null,Object? lifevestTags = null,}) {
  return _then(_self.copyWith(
selectedFilter: null == selectedFilter ? _self.selectedFilter : selectedFilter // ignore: cast_nullable_to_non_nullable
as InventoryContentFilters,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,waitingToSendLifevestTags: null == waitingToSendLifevestTags ? _self.waitingToSendLifevestTags : waitingToSendLifevestTags // ignore: cast_nullable_to_non_nullable
as List<LifevestTagModel>,lifevestTags: null == lifevestTags ? _self.lifevestTags : lifevestTags // ignore: cast_nullable_to_non_nullable
as List<LifevestTagModel>,
  ));
}

}


/// @nodoc


class _InventoryContentState extends InventoryContentState {
  const _InventoryContentState({this.selectedFilter = InventoryContentFilters.all, this.accessToken, final  List<LifevestTagModel> waitingToSendLifevestTags = const [], final  List<LifevestTagModel> lifevestTags = const []}): _waitingToSendLifevestTags = waitingToSendLifevestTags,_lifevestTags = lifevestTags,super._();
  

@override@JsonKey() final  InventoryContentFilters selectedFilter;
@override final  String? accessToken;
 final  List<LifevestTagModel> _waitingToSendLifevestTags;
@override@JsonKey() List<LifevestTagModel> get waitingToSendLifevestTags {
  if (_waitingToSendLifevestTags is EqualUnmodifiableListView) return _waitingToSendLifevestTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waitingToSendLifevestTags);
}

 final  List<LifevestTagModel> _lifevestTags;
@override@JsonKey() List<LifevestTagModel> get lifevestTags {
  if (_lifevestTags is EqualUnmodifiableListView) return _lifevestTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lifevestTags);
}


/// Create a copy of InventoryContentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryContentStateCopyWith<_InventoryContentState> get copyWith => __$InventoryContentStateCopyWithImpl<_InventoryContentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryContentState&&(identical(other.selectedFilter, selectedFilter) || other.selectedFilter == selectedFilter)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&const DeepCollectionEquality().equals(other._waitingToSendLifevestTags, _waitingToSendLifevestTags)&&const DeepCollectionEquality().equals(other._lifevestTags, _lifevestTags));
}


@override
int get hashCode => Object.hash(runtimeType,selectedFilter,accessToken,const DeepCollectionEquality().hash(_waitingToSendLifevestTags),const DeepCollectionEquality().hash(_lifevestTags));

@override
String toString() {
  return 'InventoryContentState(selectedFilter: $selectedFilter, accessToken: $accessToken, waitingToSendLifevestTags: $waitingToSendLifevestTags, lifevestTags: $lifevestTags)';
}


}

/// @nodoc
abstract mixin class _$InventoryContentStateCopyWith<$Res> implements $InventoryContentStateCopyWith<$Res> {
  factory _$InventoryContentStateCopyWith(_InventoryContentState value, $Res Function(_InventoryContentState) _then) = __$InventoryContentStateCopyWithImpl;
@override @useResult
$Res call({
 InventoryContentFilters selectedFilter, String? accessToken, List<LifevestTagModel> waitingToSendLifevestTags, List<LifevestTagModel> lifevestTags
});




}
/// @nodoc
class __$InventoryContentStateCopyWithImpl<$Res>
    implements _$InventoryContentStateCopyWith<$Res> {
  __$InventoryContentStateCopyWithImpl(this._self, this._then);

  final _InventoryContentState _self;
  final $Res Function(_InventoryContentState) _then;

/// Create a copy of InventoryContentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedFilter = null,Object? accessToken = freezed,Object? waitingToSendLifevestTags = null,Object? lifevestTags = null,}) {
  return _then(_InventoryContentState(
selectedFilter: null == selectedFilter ? _self.selectedFilter : selectedFilter // ignore: cast_nullable_to_non_nullable
as InventoryContentFilters,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,waitingToSendLifevestTags: null == waitingToSendLifevestTags ? _self._waitingToSendLifevestTags : waitingToSendLifevestTags // ignore: cast_nullable_to_non_nullable
as List<LifevestTagModel>,lifevestTags: null == lifevestTags ? _self._lifevestTags : lifevestTags // ignore: cast_nullable_to_non_nullable
as List<LifevestTagModel>,
  ));
}


}

// dart format on
