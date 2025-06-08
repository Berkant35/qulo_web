// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bluetooth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppBluetoothState {

 UIStateStatus get status; Failure? get failure; BluetoothAdapterState? get adapterState; BluetoothDevice? get connectedDevice; String? get connectedDeviceName; BluetoothDevice? get byLocaleDevice; String? get byLocaleDeviceName; BluetoothConnectionState? get bleConnectionState; dynamic get isScanByFlutterBluePlus; List<ScanResult> get discoveredScanResults;
/// Create a copy of AppBluetoothState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBluetoothStateCopyWith<AppBluetoothState> get copyWith => _$AppBluetoothStateCopyWithImpl<AppBluetoothState>(this as AppBluetoothState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBluetoothState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.adapterState, adapterState) || other.adapterState == adapterState)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.connectedDeviceName, connectedDeviceName) || other.connectedDeviceName == connectedDeviceName)&&(identical(other.byLocaleDevice, byLocaleDevice) || other.byLocaleDevice == byLocaleDevice)&&(identical(other.byLocaleDeviceName, byLocaleDeviceName) || other.byLocaleDeviceName == byLocaleDeviceName)&&(identical(other.bleConnectionState, bleConnectionState) || other.bleConnectionState == bleConnectionState)&&const DeepCollectionEquality().equals(other.isScanByFlutterBluePlus, isScanByFlutterBluePlus)&&const DeepCollectionEquality().equals(other.discoveredScanResults, discoveredScanResults));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,adapterState,connectedDevice,connectedDeviceName,byLocaleDevice,byLocaleDeviceName,bleConnectionState,const DeepCollectionEquality().hash(isScanByFlutterBluePlus),const DeepCollectionEquality().hash(discoveredScanResults));

@override
String toString() {
  return 'AppBluetoothState(status: $status, failure: $failure, adapterState: $adapterState, connectedDevice: $connectedDevice, connectedDeviceName: $connectedDeviceName, byLocaleDevice: $byLocaleDevice, byLocaleDeviceName: $byLocaleDeviceName, bleConnectionState: $bleConnectionState, isScanByFlutterBluePlus: $isScanByFlutterBluePlus, discoveredScanResults: $discoveredScanResults)';
}


}

/// @nodoc
abstract mixin class $AppBluetoothStateCopyWith<$Res>  {
  factory $AppBluetoothStateCopyWith(AppBluetoothState value, $Res Function(AppBluetoothState) _then) = _$AppBluetoothStateCopyWithImpl;
@useResult
$Res call({
 UIStateStatus status, Failure? failure, BluetoothAdapterState? adapterState, BluetoothDevice? connectedDevice, String? connectedDeviceName, BluetoothDevice? byLocaleDevice, String? byLocaleDeviceName, BluetoothConnectionState? bleConnectionState, dynamic isScanByFlutterBluePlus, List<ScanResult> discoveredScanResults
});




}
/// @nodoc
class _$AppBluetoothStateCopyWithImpl<$Res>
    implements $AppBluetoothStateCopyWith<$Res> {
  _$AppBluetoothStateCopyWithImpl(this._self, this._then);

  final AppBluetoothState _self;
  final $Res Function(AppBluetoothState) _then;

/// Create a copy of AppBluetoothState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? failure = freezed,Object? adapterState = freezed,Object? connectedDevice = freezed,Object? connectedDeviceName = freezed,Object? byLocaleDevice = freezed,Object? byLocaleDeviceName = freezed,Object? bleConnectionState = freezed,Object? isScanByFlutterBluePlus = freezed,Object? discoveredScanResults = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,adapterState: freezed == adapterState ? _self.adapterState : adapterState // ignore: cast_nullable_to_non_nullable
as BluetoothAdapterState?,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as BluetoothDevice?,connectedDeviceName: freezed == connectedDeviceName ? _self.connectedDeviceName : connectedDeviceName // ignore: cast_nullable_to_non_nullable
as String?,byLocaleDevice: freezed == byLocaleDevice ? _self.byLocaleDevice : byLocaleDevice // ignore: cast_nullable_to_non_nullable
as BluetoothDevice?,byLocaleDeviceName: freezed == byLocaleDeviceName ? _self.byLocaleDeviceName : byLocaleDeviceName // ignore: cast_nullable_to_non_nullable
as String?,bleConnectionState: freezed == bleConnectionState ? _self.bleConnectionState : bleConnectionState // ignore: cast_nullable_to_non_nullable
as BluetoothConnectionState?,isScanByFlutterBluePlus: freezed == isScanByFlutterBluePlus ? _self.isScanByFlutterBluePlus : isScanByFlutterBluePlus // ignore: cast_nullable_to_non_nullable
as dynamic,discoveredScanResults: null == discoveredScanResults ? _self.discoveredScanResults : discoveredScanResults // ignore: cast_nullable_to_non_nullable
as List<ScanResult>,
  ));
}

}


/// @nodoc


class _AppBluetoothState extends AppBluetoothState {
  const _AppBluetoothState({this.status = UIStateStatus.idle, this.failure, this.adapterState, this.connectedDevice, this.connectedDeviceName, this.byLocaleDevice, this.byLocaleDeviceName, this.bleConnectionState, this.isScanByFlutterBluePlus = false, final  List<ScanResult> discoveredScanResults = const []}): _discoveredScanResults = discoveredScanResults,super._();
  

@override@JsonKey() final  UIStateStatus status;
@override final  Failure? failure;
@override final  BluetoothAdapterState? adapterState;
@override final  BluetoothDevice? connectedDevice;
@override final  String? connectedDeviceName;
@override final  BluetoothDevice? byLocaleDevice;
@override final  String? byLocaleDeviceName;
@override final  BluetoothConnectionState? bleConnectionState;
@override@JsonKey() final  dynamic isScanByFlutterBluePlus;
 final  List<ScanResult> _discoveredScanResults;
@override@JsonKey() List<ScanResult> get discoveredScanResults {
  if (_discoveredScanResults is EqualUnmodifiableListView) return _discoveredScanResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveredScanResults);
}


/// Create a copy of AppBluetoothState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppBluetoothStateCopyWith<_AppBluetoothState> get copyWith => __$AppBluetoothStateCopyWithImpl<_AppBluetoothState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppBluetoothState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.adapterState, adapterState) || other.adapterState == adapterState)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.connectedDeviceName, connectedDeviceName) || other.connectedDeviceName == connectedDeviceName)&&(identical(other.byLocaleDevice, byLocaleDevice) || other.byLocaleDevice == byLocaleDevice)&&(identical(other.byLocaleDeviceName, byLocaleDeviceName) || other.byLocaleDeviceName == byLocaleDeviceName)&&(identical(other.bleConnectionState, bleConnectionState) || other.bleConnectionState == bleConnectionState)&&const DeepCollectionEquality().equals(other.isScanByFlutterBluePlus, isScanByFlutterBluePlus)&&const DeepCollectionEquality().equals(other._discoveredScanResults, _discoveredScanResults));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,adapterState,connectedDevice,connectedDeviceName,byLocaleDevice,byLocaleDeviceName,bleConnectionState,const DeepCollectionEquality().hash(isScanByFlutterBluePlus),const DeepCollectionEquality().hash(_discoveredScanResults));

@override
String toString() {
  return 'AppBluetoothState(status: $status, failure: $failure, adapterState: $adapterState, connectedDevice: $connectedDevice, connectedDeviceName: $connectedDeviceName, byLocaleDevice: $byLocaleDevice, byLocaleDeviceName: $byLocaleDeviceName, bleConnectionState: $bleConnectionState, isScanByFlutterBluePlus: $isScanByFlutterBluePlus, discoveredScanResults: $discoveredScanResults)';
}


}

/// @nodoc
abstract mixin class _$AppBluetoothStateCopyWith<$Res> implements $AppBluetoothStateCopyWith<$Res> {
  factory _$AppBluetoothStateCopyWith(_AppBluetoothState value, $Res Function(_AppBluetoothState) _then) = __$AppBluetoothStateCopyWithImpl;
@override @useResult
$Res call({
 UIStateStatus status, Failure? failure, BluetoothAdapterState? adapterState, BluetoothDevice? connectedDevice, String? connectedDeviceName, BluetoothDevice? byLocaleDevice, String? byLocaleDeviceName, BluetoothConnectionState? bleConnectionState, dynamic isScanByFlutterBluePlus, List<ScanResult> discoveredScanResults
});




}
/// @nodoc
class __$AppBluetoothStateCopyWithImpl<$Res>
    implements _$AppBluetoothStateCopyWith<$Res> {
  __$AppBluetoothStateCopyWithImpl(this._self, this._then);

  final _AppBluetoothState _self;
  final $Res Function(_AppBluetoothState) _then;

/// Create a copy of AppBluetoothState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? failure = freezed,Object? adapterState = freezed,Object? connectedDevice = freezed,Object? connectedDeviceName = freezed,Object? byLocaleDevice = freezed,Object? byLocaleDeviceName = freezed,Object? bleConnectionState = freezed,Object? isScanByFlutterBluePlus = freezed,Object? discoveredScanResults = null,}) {
  return _then(_AppBluetoothState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,adapterState: freezed == adapterState ? _self.adapterState : adapterState // ignore: cast_nullable_to_non_nullable
as BluetoothAdapterState?,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as BluetoothDevice?,connectedDeviceName: freezed == connectedDeviceName ? _self.connectedDeviceName : connectedDeviceName // ignore: cast_nullable_to_non_nullable
as String?,byLocaleDevice: freezed == byLocaleDevice ? _self.byLocaleDevice : byLocaleDevice // ignore: cast_nullable_to_non_nullable
as BluetoothDevice?,byLocaleDeviceName: freezed == byLocaleDeviceName ? _self.byLocaleDeviceName : byLocaleDeviceName // ignore: cast_nullable_to_non_nullable
as String?,bleConnectionState: freezed == bleConnectionState ? _self.bleConnectionState : bleConnectionState // ignore: cast_nullable_to_non_nullable
as BluetoothConnectionState?,isScanByFlutterBluePlus: freezed == isScanByFlutterBluePlus ? _self.isScanByFlutterBluePlus : isScanByFlutterBluePlus // ignore: cast_nullable_to_non_nullable
as dynamic,discoveredScanResults: null == discoveredScanResults ? _self._discoveredScanResults : discoveredScanResults // ignore: cast_nullable_to_non_nullable
as List<ScanResult>,
  ));
}


}

// dart format on
