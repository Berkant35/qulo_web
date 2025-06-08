// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bluetooth_communication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppBluetoothCommunicationState {

 UIStateStatus get status; Failure? get failure;// Services & Characteristics Discovery
 List<BluetoothService> get discoveredServices; Map<String, BluetoothCharacteristic> get availableCharacteristics;// Notification Management
 Map<String, bool> get notificationStates; Map<String, StreamSubscription> get notificationStreams;// Reader Specific Characteristics (THY Lifevest)
 BluetoothCharacteristic? get readerDataCharacteristic; BluetoothCharacteristic? get readerControlCharacteristic; BluetoothCharacteristic? get readerStatusCharacteristic; BluetoothCharacteristic? get readerConfigCharacteristic;// Communication Data
 Map<String, List<int>> get lastReceivedData; bool get isInitialized; bool get isReaderReady;// Connection Status
 BluetoothDevice? get connectedDevice;
/// Create a copy of AppBluetoothCommunicationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBluetoothCommunicationStateCopyWith<AppBluetoothCommunicationState> get copyWith => _$AppBluetoothCommunicationStateCopyWithImpl<AppBluetoothCommunicationState>(this as AppBluetoothCommunicationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBluetoothCommunicationState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.discoveredServices, discoveredServices)&&const DeepCollectionEquality().equals(other.availableCharacteristics, availableCharacteristics)&&const DeepCollectionEquality().equals(other.notificationStates, notificationStates)&&const DeepCollectionEquality().equals(other.notificationStreams, notificationStreams)&&(identical(other.readerDataCharacteristic, readerDataCharacteristic) || other.readerDataCharacteristic == readerDataCharacteristic)&&(identical(other.readerControlCharacteristic, readerControlCharacteristic) || other.readerControlCharacteristic == readerControlCharacteristic)&&(identical(other.readerStatusCharacteristic, readerStatusCharacteristic) || other.readerStatusCharacteristic == readerStatusCharacteristic)&&(identical(other.readerConfigCharacteristic, readerConfigCharacteristic) || other.readerConfigCharacteristic == readerConfigCharacteristic)&&const DeepCollectionEquality().equals(other.lastReceivedData, lastReceivedData)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.isReaderReady, isReaderReady) || other.isReaderReady == isReaderReady)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,const DeepCollectionEquality().hash(discoveredServices),const DeepCollectionEquality().hash(availableCharacteristics),const DeepCollectionEquality().hash(notificationStates),const DeepCollectionEquality().hash(notificationStreams),readerDataCharacteristic,readerControlCharacteristic,readerStatusCharacteristic,readerConfigCharacteristic,const DeepCollectionEquality().hash(lastReceivedData),isInitialized,isReaderReady,connectedDevice);

@override
String toString() {
  return 'AppBluetoothCommunicationState(status: $status, failure: $failure, discoveredServices: $discoveredServices, availableCharacteristics: $availableCharacteristics, notificationStates: $notificationStates, notificationStreams: $notificationStreams, readerDataCharacteristic: $readerDataCharacteristic, readerControlCharacteristic: $readerControlCharacteristic, readerStatusCharacteristic: $readerStatusCharacteristic, readerConfigCharacteristic: $readerConfigCharacteristic, lastReceivedData: $lastReceivedData, isInitialized: $isInitialized, isReaderReady: $isReaderReady, connectedDevice: $connectedDevice)';
}


}

/// @nodoc
abstract mixin class $AppBluetoothCommunicationStateCopyWith<$Res>  {
  factory $AppBluetoothCommunicationStateCopyWith(AppBluetoothCommunicationState value, $Res Function(AppBluetoothCommunicationState) _then) = _$AppBluetoothCommunicationStateCopyWithImpl;
@useResult
$Res call({
 UIStateStatus status, Failure? failure, List<BluetoothService> discoveredServices, Map<String, BluetoothCharacteristic> availableCharacteristics, Map<String, bool> notificationStates, Map<String, StreamSubscription> notificationStreams, BluetoothCharacteristic? readerDataCharacteristic, BluetoothCharacteristic? readerControlCharacteristic, BluetoothCharacteristic? readerStatusCharacteristic, BluetoothCharacteristic? readerConfigCharacteristic, Map<String, List<int>> lastReceivedData, bool isInitialized, bool isReaderReady, BluetoothDevice? connectedDevice
});




}
/// @nodoc
class _$AppBluetoothCommunicationStateCopyWithImpl<$Res>
    implements $AppBluetoothCommunicationStateCopyWith<$Res> {
  _$AppBluetoothCommunicationStateCopyWithImpl(this._self, this._then);

  final AppBluetoothCommunicationState _self;
  final $Res Function(AppBluetoothCommunicationState) _then;

/// Create a copy of AppBluetoothCommunicationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? failure = freezed,Object? discoveredServices = null,Object? availableCharacteristics = null,Object? notificationStates = null,Object? notificationStreams = null,Object? readerDataCharacteristic = freezed,Object? readerControlCharacteristic = freezed,Object? readerStatusCharacteristic = freezed,Object? readerConfigCharacteristic = freezed,Object? lastReceivedData = null,Object? isInitialized = null,Object? isReaderReady = null,Object? connectedDevice = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,discoveredServices: null == discoveredServices ? _self.discoveredServices : discoveredServices // ignore: cast_nullable_to_non_nullable
as List<BluetoothService>,availableCharacteristics: null == availableCharacteristics ? _self.availableCharacteristics : availableCharacteristics // ignore: cast_nullable_to_non_nullable
as Map<String, BluetoothCharacteristic>,notificationStates: null == notificationStates ? _self.notificationStates : notificationStates // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,notificationStreams: null == notificationStreams ? _self.notificationStreams : notificationStreams // ignore: cast_nullable_to_non_nullable
as Map<String, StreamSubscription>,readerDataCharacteristic: freezed == readerDataCharacteristic ? _self.readerDataCharacteristic : readerDataCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,readerControlCharacteristic: freezed == readerControlCharacteristic ? _self.readerControlCharacteristic : readerControlCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,readerStatusCharacteristic: freezed == readerStatusCharacteristic ? _self.readerStatusCharacteristic : readerStatusCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,readerConfigCharacteristic: freezed == readerConfigCharacteristic ? _self.readerConfigCharacteristic : readerConfigCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,lastReceivedData: null == lastReceivedData ? _self.lastReceivedData : lastReceivedData // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,isReaderReady: null == isReaderReady ? _self.isReaderReady : isReaderReady // ignore: cast_nullable_to_non_nullable
as bool,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as BluetoothDevice?,
  ));
}

}


/// @nodoc


class _AppBluetoothCommunicationState extends AppBluetoothCommunicationState {
  const _AppBluetoothCommunicationState({this.status = UIStateStatus.idle, this.failure, final  List<BluetoothService> discoveredServices = const [], final  Map<String, BluetoothCharacteristic> availableCharacteristics = const {}, final  Map<String, bool> notificationStates = const {}, final  Map<String, StreamSubscription> notificationStreams = const {}, this.readerDataCharacteristic, this.readerControlCharacteristic, this.readerStatusCharacteristic, this.readerConfigCharacteristic, final  Map<String, List<int>> lastReceivedData = const {}, this.isInitialized = false, this.isReaderReady = false, this.connectedDevice}): _discoveredServices = discoveredServices,_availableCharacteristics = availableCharacteristics,_notificationStates = notificationStates,_notificationStreams = notificationStreams,_lastReceivedData = lastReceivedData,super._();
  

@override@JsonKey() final  UIStateStatus status;
@override final  Failure? failure;
// Services & Characteristics Discovery
 final  List<BluetoothService> _discoveredServices;
// Services & Characteristics Discovery
@override@JsonKey() List<BluetoothService> get discoveredServices {
  if (_discoveredServices is EqualUnmodifiableListView) return _discoveredServices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveredServices);
}

 final  Map<String, BluetoothCharacteristic> _availableCharacteristics;
@override@JsonKey() Map<String, BluetoothCharacteristic> get availableCharacteristics {
  if (_availableCharacteristics is EqualUnmodifiableMapView) return _availableCharacteristics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_availableCharacteristics);
}

// Notification Management
 final  Map<String, bool> _notificationStates;
// Notification Management
@override@JsonKey() Map<String, bool> get notificationStates {
  if (_notificationStates is EqualUnmodifiableMapView) return _notificationStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_notificationStates);
}

 final  Map<String, StreamSubscription> _notificationStreams;
@override@JsonKey() Map<String, StreamSubscription> get notificationStreams {
  if (_notificationStreams is EqualUnmodifiableMapView) return _notificationStreams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_notificationStreams);
}

// Reader Specific Characteristics (THY Lifevest)
@override final  BluetoothCharacteristic? readerDataCharacteristic;
@override final  BluetoothCharacteristic? readerControlCharacteristic;
@override final  BluetoothCharacteristic? readerStatusCharacteristic;
@override final  BluetoothCharacteristic? readerConfigCharacteristic;
// Communication Data
 final  Map<String, List<int>> _lastReceivedData;
// Communication Data
@override@JsonKey() Map<String, List<int>> get lastReceivedData {
  if (_lastReceivedData is EqualUnmodifiableMapView) return _lastReceivedData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lastReceivedData);
}

@override@JsonKey() final  bool isInitialized;
@override@JsonKey() final  bool isReaderReady;
// Connection Status
@override final  BluetoothDevice? connectedDevice;

/// Create a copy of AppBluetoothCommunicationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppBluetoothCommunicationStateCopyWith<_AppBluetoothCommunicationState> get copyWith => __$AppBluetoothCommunicationStateCopyWithImpl<_AppBluetoothCommunicationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppBluetoothCommunicationState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._discoveredServices, _discoveredServices)&&const DeepCollectionEquality().equals(other._availableCharacteristics, _availableCharacteristics)&&const DeepCollectionEquality().equals(other._notificationStates, _notificationStates)&&const DeepCollectionEquality().equals(other._notificationStreams, _notificationStreams)&&(identical(other.readerDataCharacteristic, readerDataCharacteristic) || other.readerDataCharacteristic == readerDataCharacteristic)&&(identical(other.readerControlCharacteristic, readerControlCharacteristic) || other.readerControlCharacteristic == readerControlCharacteristic)&&(identical(other.readerStatusCharacteristic, readerStatusCharacteristic) || other.readerStatusCharacteristic == readerStatusCharacteristic)&&(identical(other.readerConfigCharacteristic, readerConfigCharacteristic) || other.readerConfigCharacteristic == readerConfigCharacteristic)&&const DeepCollectionEquality().equals(other._lastReceivedData, _lastReceivedData)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.isReaderReady, isReaderReady) || other.isReaderReady == isReaderReady)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,const DeepCollectionEquality().hash(_discoveredServices),const DeepCollectionEquality().hash(_availableCharacteristics),const DeepCollectionEquality().hash(_notificationStates),const DeepCollectionEquality().hash(_notificationStreams),readerDataCharacteristic,readerControlCharacteristic,readerStatusCharacteristic,readerConfigCharacteristic,const DeepCollectionEquality().hash(_lastReceivedData),isInitialized,isReaderReady,connectedDevice);

@override
String toString() {
  return 'AppBluetoothCommunicationState(status: $status, failure: $failure, discoveredServices: $discoveredServices, availableCharacteristics: $availableCharacteristics, notificationStates: $notificationStates, notificationStreams: $notificationStreams, readerDataCharacteristic: $readerDataCharacteristic, readerControlCharacteristic: $readerControlCharacteristic, readerStatusCharacteristic: $readerStatusCharacteristic, readerConfigCharacteristic: $readerConfigCharacteristic, lastReceivedData: $lastReceivedData, isInitialized: $isInitialized, isReaderReady: $isReaderReady, connectedDevice: $connectedDevice)';
}


}

/// @nodoc
abstract mixin class _$AppBluetoothCommunicationStateCopyWith<$Res> implements $AppBluetoothCommunicationStateCopyWith<$Res> {
  factory _$AppBluetoothCommunicationStateCopyWith(_AppBluetoothCommunicationState value, $Res Function(_AppBluetoothCommunicationState) _then) = __$AppBluetoothCommunicationStateCopyWithImpl;
@override @useResult
$Res call({
 UIStateStatus status, Failure? failure, List<BluetoothService> discoveredServices, Map<String, BluetoothCharacteristic> availableCharacteristics, Map<String, bool> notificationStates, Map<String, StreamSubscription> notificationStreams, BluetoothCharacteristic? readerDataCharacteristic, BluetoothCharacteristic? readerControlCharacteristic, BluetoothCharacteristic? readerStatusCharacteristic, BluetoothCharacteristic? readerConfigCharacteristic, Map<String, List<int>> lastReceivedData, bool isInitialized, bool isReaderReady, BluetoothDevice? connectedDevice
});




}
/// @nodoc
class __$AppBluetoothCommunicationStateCopyWithImpl<$Res>
    implements _$AppBluetoothCommunicationStateCopyWith<$Res> {
  __$AppBluetoothCommunicationStateCopyWithImpl(this._self, this._then);

  final _AppBluetoothCommunicationState _self;
  final $Res Function(_AppBluetoothCommunicationState) _then;

/// Create a copy of AppBluetoothCommunicationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? failure = freezed,Object? discoveredServices = null,Object? availableCharacteristics = null,Object? notificationStates = null,Object? notificationStreams = null,Object? readerDataCharacteristic = freezed,Object? readerControlCharacteristic = freezed,Object? readerStatusCharacteristic = freezed,Object? readerConfigCharacteristic = freezed,Object? lastReceivedData = null,Object? isInitialized = null,Object? isReaderReady = null,Object? connectedDevice = freezed,}) {
  return _then(_AppBluetoothCommunicationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,discoveredServices: null == discoveredServices ? _self._discoveredServices : discoveredServices // ignore: cast_nullable_to_non_nullable
as List<BluetoothService>,availableCharacteristics: null == availableCharacteristics ? _self._availableCharacteristics : availableCharacteristics // ignore: cast_nullable_to_non_nullable
as Map<String, BluetoothCharacteristic>,notificationStates: null == notificationStates ? _self._notificationStates : notificationStates // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,notificationStreams: null == notificationStreams ? _self._notificationStreams : notificationStreams // ignore: cast_nullable_to_non_nullable
as Map<String, StreamSubscription>,readerDataCharacteristic: freezed == readerDataCharacteristic ? _self.readerDataCharacteristic : readerDataCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,readerControlCharacteristic: freezed == readerControlCharacteristic ? _self.readerControlCharacteristic : readerControlCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,readerStatusCharacteristic: freezed == readerStatusCharacteristic ? _self.readerStatusCharacteristic : readerStatusCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,readerConfigCharacteristic: freezed == readerConfigCharacteristic ? _self.readerConfigCharacteristic : readerConfigCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic?,lastReceivedData: null == lastReceivedData ? _self._lastReceivedData : lastReceivedData // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,isReaderReady: null == isReaderReady ? _self.isReaderReady : isReaderReady // ignore: cast_nullable_to_non_nullable
as bool,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as BluetoothDevice?,
  ));
}


}

// dart format on
