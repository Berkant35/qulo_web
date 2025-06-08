// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReaderState {

 UIStateStatus get status; Failure? get failure;// Connection durumu
 bool get isConnected; bool get isReconnecting; String? get connectedDeviceAddress;// Inventory durumu
 bool get isInventoryRunning; List<ReaderTag> get discoveredTags; int get remainingTagsInBuffer; bool get waitingTagBuffer;// Reader ayarları
 ReaderSettings get settings;// Button events
 int get buttonClickCount; bool get lastButtonWasDoubleClick;// Son okunan data
 Map<String, List<int>>? get lastReceivedData;// Find mode
 bool get isFindMode; String? get findTargetEpc;// Work state
 ReaderWorkState get workState;
/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderStateCopyWith<ReaderState> get copyWith => _$ReaderStateCopyWithImpl<ReaderState>(this as ReaderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.isReconnecting, isReconnecting) || other.isReconnecting == isReconnecting)&&(identical(other.connectedDeviceAddress, connectedDeviceAddress) || other.connectedDeviceAddress == connectedDeviceAddress)&&(identical(other.isInventoryRunning, isInventoryRunning) || other.isInventoryRunning == isInventoryRunning)&&const DeepCollectionEquality().equals(other.discoveredTags, discoveredTags)&&(identical(other.remainingTagsInBuffer, remainingTagsInBuffer) || other.remainingTagsInBuffer == remainingTagsInBuffer)&&(identical(other.waitingTagBuffer, waitingTagBuffer) || other.waitingTagBuffer == waitingTagBuffer)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.buttonClickCount, buttonClickCount) || other.buttonClickCount == buttonClickCount)&&(identical(other.lastButtonWasDoubleClick, lastButtonWasDoubleClick) || other.lastButtonWasDoubleClick == lastButtonWasDoubleClick)&&const DeepCollectionEquality().equals(other.lastReceivedData, lastReceivedData)&&(identical(other.isFindMode, isFindMode) || other.isFindMode == isFindMode)&&(identical(other.findTargetEpc, findTargetEpc) || other.findTargetEpc == findTargetEpc)&&(identical(other.workState, workState) || other.workState == workState));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,isConnected,isReconnecting,connectedDeviceAddress,isInventoryRunning,const DeepCollectionEquality().hash(discoveredTags),remainingTagsInBuffer,waitingTagBuffer,settings,buttonClickCount,lastButtonWasDoubleClick,const DeepCollectionEquality().hash(lastReceivedData),isFindMode,findTargetEpc,workState);

@override
String toString() {
  return 'ReaderState(status: $status, failure: $failure, isConnected: $isConnected, isReconnecting: $isReconnecting, connectedDeviceAddress: $connectedDeviceAddress, isInventoryRunning: $isInventoryRunning, discoveredTags: $discoveredTags, remainingTagsInBuffer: $remainingTagsInBuffer, waitingTagBuffer: $waitingTagBuffer, settings: $settings, buttonClickCount: $buttonClickCount, lastButtonWasDoubleClick: $lastButtonWasDoubleClick, lastReceivedData: $lastReceivedData, isFindMode: $isFindMode, findTargetEpc: $findTargetEpc, workState: $workState)';
}


}

/// @nodoc
abstract mixin class $ReaderStateCopyWith<$Res>  {
  factory $ReaderStateCopyWith(ReaderState value, $Res Function(ReaderState) _then) = _$ReaderStateCopyWithImpl;
@useResult
$Res call({
 UIStateStatus status, Failure? failure, bool isConnected, bool isReconnecting, String? connectedDeviceAddress, bool isInventoryRunning, List<ReaderTag> discoveredTags, int remainingTagsInBuffer, bool waitingTagBuffer, ReaderSettings settings, int buttonClickCount, bool lastButtonWasDoubleClick, Map<String, List<int>>? lastReceivedData, bool isFindMode, String? findTargetEpc, ReaderWorkState workState
});


$ReaderSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$ReaderStateCopyWithImpl<$Res>
    implements $ReaderStateCopyWith<$Res> {
  _$ReaderStateCopyWithImpl(this._self, this._then);

  final ReaderState _self;
  final $Res Function(ReaderState) _then;

/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? failure = freezed,Object? isConnected = null,Object? isReconnecting = null,Object? connectedDeviceAddress = freezed,Object? isInventoryRunning = null,Object? discoveredTags = null,Object? remainingTagsInBuffer = null,Object? waitingTagBuffer = null,Object? settings = null,Object? buttonClickCount = null,Object? lastButtonWasDoubleClick = null,Object? lastReceivedData = freezed,Object? isFindMode = null,Object? findTargetEpc = freezed,Object? workState = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,isReconnecting: null == isReconnecting ? _self.isReconnecting : isReconnecting // ignore: cast_nullable_to_non_nullable
as bool,connectedDeviceAddress: freezed == connectedDeviceAddress ? _self.connectedDeviceAddress : connectedDeviceAddress // ignore: cast_nullable_to_non_nullable
as String?,isInventoryRunning: null == isInventoryRunning ? _self.isInventoryRunning : isInventoryRunning // ignore: cast_nullable_to_non_nullable
as bool,discoveredTags: null == discoveredTags ? _self.discoveredTags : discoveredTags // ignore: cast_nullable_to_non_nullable
as List<ReaderTag>,remainingTagsInBuffer: null == remainingTagsInBuffer ? _self.remainingTagsInBuffer : remainingTagsInBuffer // ignore: cast_nullable_to_non_nullable
as int,waitingTagBuffer: null == waitingTagBuffer ? _self.waitingTagBuffer : waitingTagBuffer // ignore: cast_nullable_to_non_nullable
as bool,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ReaderSettings,buttonClickCount: null == buttonClickCount ? _self.buttonClickCount : buttonClickCount // ignore: cast_nullable_to_non_nullable
as int,lastButtonWasDoubleClick: null == lastButtonWasDoubleClick ? _self.lastButtonWasDoubleClick : lastButtonWasDoubleClick // ignore: cast_nullable_to_non_nullable
as bool,lastReceivedData: freezed == lastReceivedData ? _self.lastReceivedData : lastReceivedData // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>?,isFindMode: null == isFindMode ? _self.isFindMode : isFindMode // ignore: cast_nullable_to_non_nullable
as bool,findTargetEpc: freezed == findTargetEpc ? _self.findTargetEpc : findTargetEpc // ignore: cast_nullable_to_non_nullable
as String?,workState: null == workState ? _self.workState : workState // ignore: cast_nullable_to_non_nullable
as ReaderWorkState,
  ));
}
/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReaderSettingsCopyWith<$Res> get settings {
  
  return $ReaderSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// @nodoc


class _ReaderState extends ReaderState {
  const _ReaderState({this.status = UIStateStatus.idle, this.failure, this.isConnected = false, this.isReconnecting = false, this.connectedDeviceAddress, this.isInventoryRunning = false, final  List<ReaderTag> discoveredTags = const [], this.remainingTagsInBuffer = 0, this.waitingTagBuffer = false, this.settings = const ReaderSettings(), this.buttonClickCount = 0, this.lastButtonWasDoubleClick = false, final  Map<String, List<int>>? lastReceivedData, this.isFindMode = false, this.findTargetEpc, this.workState = ReaderWorkState.idle}): _discoveredTags = discoveredTags,_lastReceivedData = lastReceivedData,super._();
  

@override@JsonKey() final  UIStateStatus status;
@override final  Failure? failure;
// Connection durumu
@override@JsonKey() final  bool isConnected;
@override@JsonKey() final  bool isReconnecting;
@override final  String? connectedDeviceAddress;
// Inventory durumu
@override@JsonKey() final  bool isInventoryRunning;
 final  List<ReaderTag> _discoveredTags;
@override@JsonKey() List<ReaderTag> get discoveredTags {
  if (_discoveredTags is EqualUnmodifiableListView) return _discoveredTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveredTags);
}

@override@JsonKey() final  int remainingTagsInBuffer;
@override@JsonKey() final  bool waitingTagBuffer;
// Reader ayarları
@override@JsonKey() final  ReaderSettings settings;
// Button events
@override@JsonKey() final  int buttonClickCount;
@override@JsonKey() final  bool lastButtonWasDoubleClick;
// Son okunan data
 final  Map<String, List<int>>? _lastReceivedData;
// Son okunan data
@override Map<String, List<int>>? get lastReceivedData {
  final value = _lastReceivedData;
  if (value == null) return null;
  if (_lastReceivedData is EqualUnmodifiableMapView) return _lastReceivedData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Find mode
@override@JsonKey() final  bool isFindMode;
@override final  String? findTargetEpc;
// Work state
@override@JsonKey() final  ReaderWorkState workState;

/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderStateCopyWith<_ReaderState> get copyWith => __$ReaderStateCopyWithImpl<_ReaderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.isReconnecting, isReconnecting) || other.isReconnecting == isReconnecting)&&(identical(other.connectedDeviceAddress, connectedDeviceAddress) || other.connectedDeviceAddress == connectedDeviceAddress)&&(identical(other.isInventoryRunning, isInventoryRunning) || other.isInventoryRunning == isInventoryRunning)&&const DeepCollectionEquality().equals(other._discoveredTags, _discoveredTags)&&(identical(other.remainingTagsInBuffer, remainingTagsInBuffer) || other.remainingTagsInBuffer == remainingTagsInBuffer)&&(identical(other.waitingTagBuffer, waitingTagBuffer) || other.waitingTagBuffer == waitingTagBuffer)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.buttonClickCount, buttonClickCount) || other.buttonClickCount == buttonClickCount)&&(identical(other.lastButtonWasDoubleClick, lastButtonWasDoubleClick) || other.lastButtonWasDoubleClick == lastButtonWasDoubleClick)&&const DeepCollectionEquality().equals(other._lastReceivedData, _lastReceivedData)&&(identical(other.isFindMode, isFindMode) || other.isFindMode == isFindMode)&&(identical(other.findTargetEpc, findTargetEpc) || other.findTargetEpc == findTargetEpc)&&(identical(other.workState, workState) || other.workState == workState));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,isConnected,isReconnecting,connectedDeviceAddress,isInventoryRunning,const DeepCollectionEquality().hash(_discoveredTags),remainingTagsInBuffer,waitingTagBuffer,settings,buttonClickCount,lastButtonWasDoubleClick,const DeepCollectionEquality().hash(_lastReceivedData),isFindMode,findTargetEpc,workState);

@override
String toString() {
  return 'ReaderState(status: $status, failure: $failure, isConnected: $isConnected, isReconnecting: $isReconnecting, connectedDeviceAddress: $connectedDeviceAddress, isInventoryRunning: $isInventoryRunning, discoveredTags: $discoveredTags, remainingTagsInBuffer: $remainingTagsInBuffer, waitingTagBuffer: $waitingTagBuffer, settings: $settings, buttonClickCount: $buttonClickCount, lastButtonWasDoubleClick: $lastButtonWasDoubleClick, lastReceivedData: $lastReceivedData, isFindMode: $isFindMode, findTargetEpc: $findTargetEpc, workState: $workState)';
}


}

/// @nodoc
abstract mixin class _$ReaderStateCopyWith<$Res> implements $ReaderStateCopyWith<$Res> {
  factory _$ReaderStateCopyWith(_ReaderState value, $Res Function(_ReaderState) _then) = __$ReaderStateCopyWithImpl;
@override @useResult
$Res call({
 UIStateStatus status, Failure? failure, bool isConnected, bool isReconnecting, String? connectedDeviceAddress, bool isInventoryRunning, List<ReaderTag> discoveredTags, int remainingTagsInBuffer, bool waitingTagBuffer, ReaderSettings settings, int buttonClickCount, bool lastButtonWasDoubleClick, Map<String, List<int>>? lastReceivedData, bool isFindMode, String? findTargetEpc, ReaderWorkState workState
});


@override $ReaderSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class __$ReaderStateCopyWithImpl<$Res>
    implements _$ReaderStateCopyWith<$Res> {
  __$ReaderStateCopyWithImpl(this._self, this._then);

  final _ReaderState _self;
  final $Res Function(_ReaderState) _then;

/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? failure = freezed,Object? isConnected = null,Object? isReconnecting = null,Object? connectedDeviceAddress = freezed,Object? isInventoryRunning = null,Object? discoveredTags = null,Object? remainingTagsInBuffer = null,Object? waitingTagBuffer = null,Object? settings = null,Object? buttonClickCount = null,Object? lastButtonWasDoubleClick = null,Object? lastReceivedData = freezed,Object? isFindMode = null,Object? findTargetEpc = freezed,Object? workState = null,}) {
  return _then(_ReaderState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,isReconnecting: null == isReconnecting ? _self.isReconnecting : isReconnecting // ignore: cast_nullable_to_non_nullable
as bool,connectedDeviceAddress: freezed == connectedDeviceAddress ? _self.connectedDeviceAddress : connectedDeviceAddress // ignore: cast_nullable_to_non_nullable
as String?,isInventoryRunning: null == isInventoryRunning ? _self.isInventoryRunning : isInventoryRunning // ignore: cast_nullable_to_non_nullable
as bool,discoveredTags: null == discoveredTags ? _self._discoveredTags : discoveredTags // ignore: cast_nullable_to_non_nullable
as List<ReaderTag>,remainingTagsInBuffer: null == remainingTagsInBuffer ? _self.remainingTagsInBuffer : remainingTagsInBuffer // ignore: cast_nullable_to_non_nullable
as int,waitingTagBuffer: null == waitingTagBuffer ? _self.waitingTagBuffer : waitingTagBuffer // ignore: cast_nullable_to_non_nullable
as bool,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ReaderSettings,buttonClickCount: null == buttonClickCount ? _self.buttonClickCount : buttonClickCount // ignore: cast_nullable_to_non_nullable
as int,lastButtonWasDoubleClick: null == lastButtonWasDoubleClick ? _self.lastButtonWasDoubleClick : lastButtonWasDoubleClick // ignore: cast_nullable_to_non_nullable
as bool,lastReceivedData: freezed == lastReceivedData ? _self._lastReceivedData : lastReceivedData // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>?,isFindMode: null == isFindMode ? _self.isFindMode : isFindMode // ignore: cast_nullable_to_non_nullable
as bool,findTargetEpc: freezed == findTargetEpc ? _self.findTargetEpc : findTargetEpc // ignore: cast_nullable_to_non_nullable
as String?,workState: null == workState ? _self.workState : workState // ignore: cast_nullable_to_non_nullable
as ReaderWorkState,
  ));
}

/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReaderSettingsCopyWith<$Res> get settings {
  
  return $ReaderSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

/// @nodoc
mixin _$ReaderTag {

 String? get pc; int? get epcLen; String? get epc; String? get tid; String? get userData; int? get userDataOffset; int? get userDataSize; double? get rssi; int? get antenna; DateTime? get readTime;
/// Create a copy of ReaderTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderTagCopyWith<ReaderTag> get copyWith => _$ReaderTagCopyWithImpl<ReaderTag>(this as ReaderTag, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderTag&&(identical(other.pc, pc) || other.pc == pc)&&(identical(other.epcLen, epcLen) || other.epcLen == epcLen)&&(identical(other.epc, epc) || other.epc == epc)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.userDataOffset, userDataOffset) || other.userDataOffset == userDataOffset)&&(identical(other.userDataSize, userDataSize) || other.userDataSize == userDataSize)&&(identical(other.rssi, rssi) || other.rssi == rssi)&&(identical(other.antenna, antenna) || other.antenna == antenna)&&(identical(other.readTime, readTime) || other.readTime == readTime));
}


@override
int get hashCode => Object.hash(runtimeType,pc,epcLen,epc,tid,userData,userDataOffset,userDataSize,rssi,antenna,readTime);

@override
String toString() {
  return 'ReaderTag(pc: $pc, epcLen: $epcLen, epc: $epc, tid: $tid, userData: $userData, userDataOffset: $userDataOffset, userDataSize: $userDataSize, rssi: $rssi, antenna: $antenna, readTime: $readTime)';
}


}

/// @nodoc
abstract mixin class $ReaderTagCopyWith<$Res>  {
  factory $ReaderTagCopyWith(ReaderTag value, $Res Function(ReaderTag) _then) = _$ReaderTagCopyWithImpl;
@useResult
$Res call({
 String? pc, int? epcLen, String? epc, String? tid, String? userData, int? userDataOffset, int? userDataSize, double? rssi, int? antenna, DateTime? readTime
});




}
/// @nodoc
class _$ReaderTagCopyWithImpl<$Res>
    implements $ReaderTagCopyWith<$Res> {
  _$ReaderTagCopyWithImpl(this._self, this._then);

  final ReaderTag _self;
  final $Res Function(ReaderTag) _then;

/// Create a copy of ReaderTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pc = freezed,Object? epcLen = freezed,Object? epc = freezed,Object? tid = freezed,Object? userData = freezed,Object? userDataOffset = freezed,Object? userDataSize = freezed,Object? rssi = freezed,Object? antenna = freezed,Object? readTime = freezed,}) {
  return _then(_self.copyWith(
pc: freezed == pc ? _self.pc : pc // ignore: cast_nullable_to_non_nullable
as String?,epcLen: freezed == epcLen ? _self.epcLen : epcLen // ignore: cast_nullable_to_non_nullable
as int?,epc: freezed == epc ? _self.epc : epc // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as String?,userDataOffset: freezed == userDataOffset ? _self.userDataOffset : userDataOffset // ignore: cast_nullable_to_non_nullable
as int?,userDataSize: freezed == userDataSize ? _self.userDataSize : userDataSize // ignore: cast_nullable_to_non_nullable
as int?,rssi: freezed == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as double?,antenna: freezed == antenna ? _self.antenna : antenna // ignore: cast_nullable_to_non_nullable
as int?,readTime: freezed == readTime ? _self.readTime : readTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _ReaderTag extends ReaderTag {
  const _ReaderTag({this.pc, this.epcLen, this.epc, this.tid, this.userData, this.userDataOffset, this.userDataSize, this.rssi, this.antenna, this.readTime}): super._();
  

@override final  String? pc;
@override final  int? epcLen;
@override final  String? epc;
@override final  String? tid;
@override final  String? userData;
@override final  int? userDataOffset;
@override final  int? userDataSize;
@override final  double? rssi;
@override final  int? antenna;
@override final  DateTime? readTime;

/// Create a copy of ReaderTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderTagCopyWith<_ReaderTag> get copyWith => __$ReaderTagCopyWithImpl<_ReaderTag>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderTag&&(identical(other.pc, pc) || other.pc == pc)&&(identical(other.epcLen, epcLen) || other.epcLen == epcLen)&&(identical(other.epc, epc) || other.epc == epc)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.userDataOffset, userDataOffset) || other.userDataOffset == userDataOffset)&&(identical(other.userDataSize, userDataSize) || other.userDataSize == userDataSize)&&(identical(other.rssi, rssi) || other.rssi == rssi)&&(identical(other.antenna, antenna) || other.antenna == antenna)&&(identical(other.readTime, readTime) || other.readTime == readTime));
}


@override
int get hashCode => Object.hash(runtimeType,pc,epcLen,epc,tid,userData,userDataOffset,userDataSize,rssi,antenna,readTime);

@override
String toString() {
  return 'ReaderTag(pc: $pc, epcLen: $epcLen, epc: $epc, tid: $tid, userData: $userData, userDataOffset: $userDataOffset, userDataSize: $userDataSize, rssi: $rssi, antenna: $antenna, readTime: $readTime)';
}


}

/// @nodoc
abstract mixin class _$ReaderTagCopyWith<$Res> implements $ReaderTagCopyWith<$Res> {
  factory _$ReaderTagCopyWith(_ReaderTag value, $Res Function(_ReaderTag) _then) = __$ReaderTagCopyWithImpl;
@override @useResult
$Res call({
 String? pc, int? epcLen, String? epc, String? tid, String? userData, int? userDataOffset, int? userDataSize, double? rssi, int? antenna, DateTime? readTime
});




}
/// @nodoc
class __$ReaderTagCopyWithImpl<$Res>
    implements _$ReaderTagCopyWith<$Res> {
  __$ReaderTagCopyWithImpl(this._self, this._then);

  final _ReaderTag _self;
  final $Res Function(_ReaderTag) _then;

/// Create a copy of ReaderTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pc = freezed,Object? epcLen = freezed,Object? epc = freezed,Object? tid = freezed,Object? userData = freezed,Object? userDataOffset = freezed,Object? userDataSize = freezed,Object? rssi = freezed,Object? antenna = freezed,Object? readTime = freezed,}) {
  return _then(_ReaderTag(
pc: freezed == pc ? _self.pc : pc // ignore: cast_nullable_to_non_nullable
as String?,epcLen: freezed == epcLen ? _self.epcLen : epcLen // ignore: cast_nullable_to_non_nullable
as int?,epc: freezed == epc ? _self.epc : epc // ignore: cast_nullable_to_non_nullable
as String?,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as String?,userDataOffset: freezed == userDataOffset ? _self.userDataOffset : userDataOffset // ignore: cast_nullable_to_non_nullable
as int?,userDataSize: freezed == userDataSize ? _self.userDataSize : userDataSize // ignore: cast_nullable_to_non_nullable
as int?,rssi: freezed == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as double?,antenna: freezed == antenna ? _self.antenna : antenna // ignore: cast_nullable_to_non_nullable
as int?,readTime: freezed == readTime ? _self.readTime : readTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ReaderSettings {

 int get readPower; int get writePower; bool get buzzerEnabled; ReaderInventoryMode? get inventoryMode;
/// Create a copy of ReaderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderSettingsCopyWith<ReaderSettings> get copyWith => _$ReaderSettingsCopyWithImpl<ReaderSettings>(this as ReaderSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderSettings&&(identical(other.readPower, readPower) || other.readPower == readPower)&&(identical(other.writePower, writePower) || other.writePower == writePower)&&(identical(other.buzzerEnabled, buzzerEnabled) || other.buzzerEnabled == buzzerEnabled)&&(identical(other.inventoryMode, inventoryMode) || other.inventoryMode == inventoryMode));
}


@override
int get hashCode => Object.hash(runtimeType,readPower,writePower,buzzerEnabled,inventoryMode);

@override
String toString() {
  return 'ReaderSettings(readPower: $readPower, writePower: $writePower, buzzerEnabled: $buzzerEnabled, inventoryMode: $inventoryMode)';
}


}

/// @nodoc
abstract mixin class $ReaderSettingsCopyWith<$Res>  {
  factory $ReaderSettingsCopyWith(ReaderSettings value, $Res Function(ReaderSettings) _then) = _$ReaderSettingsCopyWithImpl;
@useResult
$Res call({
 int readPower, int writePower, bool buzzerEnabled, ReaderInventoryMode? inventoryMode
});


$ReaderInventoryModeCopyWith<$Res>? get inventoryMode;

}
/// @nodoc
class _$ReaderSettingsCopyWithImpl<$Res>
    implements $ReaderSettingsCopyWith<$Res> {
  _$ReaderSettingsCopyWithImpl(this._self, this._then);

  final ReaderSettings _self;
  final $Res Function(ReaderSettings) _then;

/// Create a copy of ReaderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? readPower = null,Object? writePower = null,Object? buzzerEnabled = null,Object? inventoryMode = freezed,}) {
  return _then(_self.copyWith(
readPower: null == readPower ? _self.readPower : readPower // ignore: cast_nullable_to_non_nullable
as int,writePower: null == writePower ? _self.writePower : writePower // ignore: cast_nullable_to_non_nullable
as int,buzzerEnabled: null == buzzerEnabled ? _self.buzzerEnabled : buzzerEnabled // ignore: cast_nullable_to_non_nullable
as bool,inventoryMode: freezed == inventoryMode ? _self.inventoryMode : inventoryMode // ignore: cast_nullable_to_non_nullable
as ReaderInventoryMode?,
  ));
}
/// Create a copy of ReaderSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReaderInventoryModeCopyWith<$Res>? get inventoryMode {
    if (_self.inventoryMode == null) {
    return null;
  }

  return $ReaderInventoryModeCopyWith<$Res>(_self.inventoryMode!, (value) {
    return _then(_self.copyWith(inventoryMode: value));
  });
}
}


/// @nodoc


class _ReaderSettings implements ReaderSettings {
  const _ReaderSettings({this.readPower = 2000, this.writePower = 2000, this.buzzerEnabled = false, this.inventoryMode});
  

@override@JsonKey() final  int readPower;
@override@JsonKey() final  int writePower;
@override@JsonKey() final  bool buzzerEnabled;
@override final  ReaderInventoryMode? inventoryMode;

/// Create a copy of ReaderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderSettingsCopyWith<_ReaderSettings> get copyWith => __$ReaderSettingsCopyWithImpl<_ReaderSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderSettings&&(identical(other.readPower, readPower) || other.readPower == readPower)&&(identical(other.writePower, writePower) || other.writePower == writePower)&&(identical(other.buzzerEnabled, buzzerEnabled) || other.buzzerEnabled == buzzerEnabled)&&(identical(other.inventoryMode, inventoryMode) || other.inventoryMode == inventoryMode));
}


@override
int get hashCode => Object.hash(runtimeType,readPower,writePower,buzzerEnabled,inventoryMode);

@override
String toString() {
  return 'ReaderSettings(readPower: $readPower, writePower: $writePower, buzzerEnabled: $buzzerEnabled, inventoryMode: $inventoryMode)';
}


}

/// @nodoc
abstract mixin class _$ReaderSettingsCopyWith<$Res> implements $ReaderSettingsCopyWith<$Res> {
  factory _$ReaderSettingsCopyWith(_ReaderSettings value, $Res Function(_ReaderSettings) _then) = __$ReaderSettingsCopyWithImpl;
@override @useResult
$Res call({
 int readPower, int writePower, bool buzzerEnabled, ReaderInventoryMode? inventoryMode
});


@override $ReaderInventoryModeCopyWith<$Res>? get inventoryMode;

}
/// @nodoc
class __$ReaderSettingsCopyWithImpl<$Res>
    implements _$ReaderSettingsCopyWith<$Res> {
  __$ReaderSettingsCopyWithImpl(this._self, this._then);

  final _ReaderSettings _self;
  final $Res Function(_ReaderSettings) _then;

/// Create a copy of ReaderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? readPower = null,Object? writePower = null,Object? buzzerEnabled = null,Object? inventoryMode = freezed,}) {
  return _then(_ReaderSettings(
readPower: null == readPower ? _self.readPower : readPower // ignore: cast_nullable_to_non_nullable
as int,writePower: null == writePower ? _self.writePower : writePower // ignore: cast_nullable_to_non_nullable
as int,buzzerEnabled: null == buzzerEnabled ? _self.buzzerEnabled : buzzerEnabled // ignore: cast_nullable_to_non_nullable
as bool,inventoryMode: freezed == inventoryMode ? _self.inventoryMode : inventoryMode // ignore: cast_nullable_to_non_nullable
as ReaderInventoryMode?,
  ));
}

/// Create a copy of ReaderSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReaderInventoryModeCopyWith<$Res>? get inventoryMode {
    if (_self.inventoryMode == null) {
    return null;
  }

  return $ReaderInventoryModeCopyWith<$Res>(_self.inventoryMode!, (value) {
    return _then(_self.copyWith(inventoryMode: value));
  });
}
}

/// @nodoc
mixin _$ReaderInventoryMode {

 ReaderInventoryBank get bank; int get userOffset; int get userLength;
/// Create a copy of ReaderInventoryMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderInventoryModeCopyWith<ReaderInventoryMode> get copyWith => _$ReaderInventoryModeCopyWithImpl<ReaderInventoryMode>(this as ReaderInventoryMode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderInventoryMode&&(identical(other.bank, bank) || other.bank == bank)&&(identical(other.userOffset, userOffset) || other.userOffset == userOffset)&&(identical(other.userLength, userLength) || other.userLength == userLength));
}


@override
int get hashCode => Object.hash(runtimeType,bank,userOffset,userLength);

@override
String toString() {
  return 'ReaderInventoryMode(bank: $bank, userOffset: $userOffset, userLength: $userLength)';
}


}

/// @nodoc
abstract mixin class $ReaderInventoryModeCopyWith<$Res>  {
  factory $ReaderInventoryModeCopyWith(ReaderInventoryMode value, $Res Function(ReaderInventoryMode) _then) = _$ReaderInventoryModeCopyWithImpl;
@useResult
$Res call({
 ReaderInventoryBank bank, int userOffset, int userLength
});




}
/// @nodoc
class _$ReaderInventoryModeCopyWithImpl<$Res>
    implements $ReaderInventoryModeCopyWith<$Res> {
  _$ReaderInventoryModeCopyWithImpl(this._self, this._then);

  final ReaderInventoryMode _self;
  final $Res Function(ReaderInventoryMode) _then;

/// Create a copy of ReaderInventoryMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bank = null,Object? userOffset = null,Object? userLength = null,}) {
  return _then(_self.copyWith(
bank: null == bank ? _self.bank : bank // ignore: cast_nullable_to_non_nullable
as ReaderInventoryBank,userOffset: null == userOffset ? _self.userOffset : userOffset // ignore: cast_nullable_to_non_nullable
as int,userLength: null == userLength ? _self.userLength : userLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _ReaderInventoryMode implements ReaderInventoryMode {
  const _ReaderInventoryMode({this.bank = ReaderInventoryBank.epc, this.userOffset = 0, this.userLength = 0});
  

@override@JsonKey() final  ReaderInventoryBank bank;
@override@JsonKey() final  int userOffset;
@override@JsonKey() final  int userLength;

/// Create a copy of ReaderInventoryMode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderInventoryModeCopyWith<_ReaderInventoryMode> get copyWith => __$ReaderInventoryModeCopyWithImpl<_ReaderInventoryMode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderInventoryMode&&(identical(other.bank, bank) || other.bank == bank)&&(identical(other.userOffset, userOffset) || other.userOffset == userOffset)&&(identical(other.userLength, userLength) || other.userLength == userLength));
}


@override
int get hashCode => Object.hash(runtimeType,bank,userOffset,userLength);

@override
String toString() {
  return 'ReaderInventoryMode(bank: $bank, userOffset: $userOffset, userLength: $userLength)';
}


}

/// @nodoc
abstract mixin class _$ReaderInventoryModeCopyWith<$Res> implements $ReaderInventoryModeCopyWith<$Res> {
  factory _$ReaderInventoryModeCopyWith(_ReaderInventoryMode value, $Res Function(_ReaderInventoryMode) _then) = __$ReaderInventoryModeCopyWithImpl;
@override @useResult
$Res call({
 ReaderInventoryBank bank, int userOffset, int userLength
});




}
/// @nodoc
class __$ReaderInventoryModeCopyWithImpl<$Res>
    implements _$ReaderInventoryModeCopyWith<$Res> {
  __$ReaderInventoryModeCopyWithImpl(this._self, this._then);

  final _ReaderInventoryMode _self;
  final $Res Function(_ReaderInventoryMode) _then;

/// Create a copy of ReaderInventoryMode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bank = null,Object? userOffset = null,Object? userLength = null,}) {
  return _then(_ReaderInventoryMode(
bank: null == bank ? _self.bank : bank // ignore: cast_nullable_to_non_nullable
as ReaderInventoryBank,userOffset: null == userOffset ? _self.userOffset : userOffset // ignore: cast_nullable_to_non_nullable
as int,userLength: null == userLength ? _self.userLength : userLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
