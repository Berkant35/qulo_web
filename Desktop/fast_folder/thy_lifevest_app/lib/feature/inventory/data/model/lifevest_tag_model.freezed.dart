// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lifevest_tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LifevestTagModel {

/// EPC hex değeri - zorunlu field
 String get epcHex;/// TID hex değeri
 String? get tid;/// EPC'den çıkarılan üretici bilgisi (Manufacturer)
 String? get eMfr;/// EPC'den çıkarılan seri numarası (Serial)
 String? get eSer;/// EPC'den çıkarılan parça numarası (Part Number)
 String? get ePno;/// EPC'den çıkarılan sequence numarası
 String? get eSeq;/// EPC construct değeri
 int? get eConst;/// EPC filter değeri
 int? get eFilterValue;/// User memory hex değeri
 String? get userHex;/// User memory'den çıkarılan üretici bilgisi
 String? get uMfr;/// User memory'den çıkarılan seri numarası
 String? get uSer;/// User memory'den çıkarılan parça numarası
 String? get uPno;/// User memory'den çıkarılan sequence numarası
 String? get uSeq;/// User memory'den çıkarılan üretim tarihi (YYYYMMDD formatında)
 String? get uDmf;/// User memory'den çıkarılan son kullanma tarihi (YYYYMMDD formatında)
 String? get uExp;/// User memory'den çıkarılan diğer bilgiler
 String? get uOther; bool get isRequestDone;
/// Create a copy of LifevestTagModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LifevestTagModelCopyWith<LifevestTagModel> get copyWith => _$LifevestTagModelCopyWithImpl<LifevestTagModel>(this as LifevestTagModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LifevestTagModel&&(identical(other.epcHex, epcHex) || other.epcHex == epcHex)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.eMfr, eMfr) || other.eMfr == eMfr)&&(identical(other.eSer, eSer) || other.eSer == eSer)&&(identical(other.ePno, ePno) || other.ePno == ePno)&&(identical(other.eSeq, eSeq) || other.eSeq == eSeq)&&(identical(other.eConst, eConst) || other.eConst == eConst)&&(identical(other.eFilterValue, eFilterValue) || other.eFilterValue == eFilterValue)&&(identical(other.userHex, userHex) || other.userHex == userHex)&&(identical(other.uMfr, uMfr) || other.uMfr == uMfr)&&(identical(other.uSer, uSer) || other.uSer == uSer)&&(identical(other.uPno, uPno) || other.uPno == uPno)&&(identical(other.uSeq, uSeq) || other.uSeq == uSeq)&&(identical(other.uDmf, uDmf) || other.uDmf == uDmf)&&(identical(other.uExp, uExp) || other.uExp == uExp)&&(identical(other.uOther, uOther) || other.uOther == uOther)&&(identical(other.isRequestDone, isRequestDone) || other.isRequestDone == isRequestDone));
}


@override
int get hashCode => Object.hash(runtimeType,epcHex,tid,eMfr,eSer,ePno,eSeq,eConst,eFilterValue,userHex,uMfr,uSer,uPno,uSeq,uDmf,uExp,uOther,isRequestDone);

@override
String toString() {
  return 'LifevestTagModel(epcHex: $epcHex, tid: $tid, eMfr: $eMfr, eSer: $eSer, ePno: $ePno, eSeq: $eSeq, eConst: $eConst, eFilterValue: $eFilterValue, userHex: $userHex, uMfr: $uMfr, uSer: $uSer, uPno: $uPno, uSeq: $uSeq, uDmf: $uDmf, uExp: $uExp, uOther: $uOther, isRequestDone: $isRequestDone)';
}


}

/// @nodoc
abstract mixin class $LifevestTagModelCopyWith<$Res>  {
  factory $LifevestTagModelCopyWith(LifevestTagModel value, $Res Function(LifevestTagModel) _then) = _$LifevestTagModelCopyWithImpl;
@useResult
$Res call({
 String epcHex, String? tid, String? eMfr, String? eSer, String? ePno, String? eSeq, int? eConst, int? eFilterValue, String? userHex, String? uMfr, String? uSer, String? uPno, String? uSeq, String? uDmf, String? uExp, String? uOther, bool isRequestDone
});




}
/// @nodoc
class _$LifevestTagModelCopyWithImpl<$Res>
    implements $LifevestTagModelCopyWith<$Res> {
  _$LifevestTagModelCopyWithImpl(this._self, this._then);

  final LifevestTagModel _self;
  final $Res Function(LifevestTagModel) _then;

/// Create a copy of LifevestTagModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? epcHex = null,Object? tid = freezed,Object? eMfr = freezed,Object? eSer = freezed,Object? ePno = freezed,Object? eSeq = freezed,Object? eConst = freezed,Object? eFilterValue = freezed,Object? userHex = freezed,Object? uMfr = freezed,Object? uSer = freezed,Object? uPno = freezed,Object? uSeq = freezed,Object? uDmf = freezed,Object? uExp = freezed,Object? uOther = freezed,Object? isRequestDone = null,}) {
  return _then(_self.copyWith(
epcHex: null == epcHex ? _self.epcHex : epcHex // ignore: cast_nullable_to_non_nullable
as String,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,eMfr: freezed == eMfr ? _self.eMfr : eMfr // ignore: cast_nullable_to_non_nullable
as String?,eSer: freezed == eSer ? _self.eSer : eSer // ignore: cast_nullable_to_non_nullable
as String?,ePno: freezed == ePno ? _self.ePno : ePno // ignore: cast_nullable_to_non_nullable
as String?,eSeq: freezed == eSeq ? _self.eSeq : eSeq // ignore: cast_nullable_to_non_nullable
as String?,eConst: freezed == eConst ? _self.eConst : eConst // ignore: cast_nullable_to_non_nullable
as int?,eFilterValue: freezed == eFilterValue ? _self.eFilterValue : eFilterValue // ignore: cast_nullable_to_non_nullable
as int?,userHex: freezed == userHex ? _self.userHex : userHex // ignore: cast_nullable_to_non_nullable
as String?,uMfr: freezed == uMfr ? _self.uMfr : uMfr // ignore: cast_nullable_to_non_nullable
as String?,uSer: freezed == uSer ? _self.uSer : uSer // ignore: cast_nullable_to_non_nullable
as String?,uPno: freezed == uPno ? _self.uPno : uPno // ignore: cast_nullable_to_non_nullable
as String?,uSeq: freezed == uSeq ? _self.uSeq : uSeq // ignore: cast_nullable_to_non_nullable
as String?,uDmf: freezed == uDmf ? _self.uDmf : uDmf // ignore: cast_nullable_to_non_nullable
as String?,uExp: freezed == uExp ? _self.uExp : uExp // ignore: cast_nullable_to_non_nullable
as String?,uOther: freezed == uOther ? _self.uOther : uOther // ignore: cast_nullable_to_non_nullable
as String?,isRequestDone: null == isRequestDone ? _self.isRequestDone : isRequestDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _LifevestTagModel extends LifevestTagModel {
  const _LifevestTagModel({required this.epcHex, this.tid, this.eMfr, this.eSer, this.ePno, this.eSeq, this.eConst, this.eFilterValue, this.userHex, this.uMfr, this.uSer, this.uPno, this.uSeq, this.uDmf, this.uExp, this.uOther, this.isRequestDone = false}): super._();
  

/// EPC hex değeri - zorunlu field
@override final  String epcHex;
/// TID hex değeri
@override final  String? tid;
/// EPC'den çıkarılan üretici bilgisi (Manufacturer)
@override final  String? eMfr;
/// EPC'den çıkarılan seri numarası (Serial)
@override final  String? eSer;
/// EPC'den çıkarılan parça numarası (Part Number)
@override final  String? ePno;
/// EPC'den çıkarılan sequence numarası
@override final  String? eSeq;
/// EPC construct değeri
@override final  int? eConst;
/// EPC filter değeri
@override final  int? eFilterValue;
/// User memory hex değeri
@override final  String? userHex;
/// User memory'den çıkarılan üretici bilgisi
@override final  String? uMfr;
/// User memory'den çıkarılan seri numarası
@override final  String? uSer;
/// User memory'den çıkarılan parça numarası
@override final  String? uPno;
/// User memory'den çıkarılan sequence numarası
@override final  String? uSeq;
/// User memory'den çıkarılan üretim tarihi (YYYYMMDD formatında)
@override final  String? uDmf;
/// User memory'den çıkarılan son kullanma tarihi (YYYYMMDD formatında)
@override final  String? uExp;
/// User memory'den çıkarılan diğer bilgiler
@override final  String? uOther;
@override@JsonKey() final  bool isRequestDone;

/// Create a copy of LifevestTagModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LifevestTagModelCopyWith<_LifevestTagModel> get copyWith => __$LifevestTagModelCopyWithImpl<_LifevestTagModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LifevestTagModel&&(identical(other.epcHex, epcHex) || other.epcHex == epcHex)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.eMfr, eMfr) || other.eMfr == eMfr)&&(identical(other.eSer, eSer) || other.eSer == eSer)&&(identical(other.ePno, ePno) || other.ePno == ePno)&&(identical(other.eSeq, eSeq) || other.eSeq == eSeq)&&(identical(other.eConst, eConst) || other.eConst == eConst)&&(identical(other.eFilterValue, eFilterValue) || other.eFilterValue == eFilterValue)&&(identical(other.userHex, userHex) || other.userHex == userHex)&&(identical(other.uMfr, uMfr) || other.uMfr == uMfr)&&(identical(other.uSer, uSer) || other.uSer == uSer)&&(identical(other.uPno, uPno) || other.uPno == uPno)&&(identical(other.uSeq, uSeq) || other.uSeq == uSeq)&&(identical(other.uDmf, uDmf) || other.uDmf == uDmf)&&(identical(other.uExp, uExp) || other.uExp == uExp)&&(identical(other.uOther, uOther) || other.uOther == uOther)&&(identical(other.isRequestDone, isRequestDone) || other.isRequestDone == isRequestDone));
}


@override
int get hashCode => Object.hash(runtimeType,epcHex,tid,eMfr,eSer,ePno,eSeq,eConst,eFilterValue,userHex,uMfr,uSer,uPno,uSeq,uDmf,uExp,uOther,isRequestDone);

@override
String toString() {
  return 'LifevestTagModel(epcHex: $epcHex, tid: $tid, eMfr: $eMfr, eSer: $eSer, ePno: $ePno, eSeq: $eSeq, eConst: $eConst, eFilterValue: $eFilterValue, userHex: $userHex, uMfr: $uMfr, uSer: $uSer, uPno: $uPno, uSeq: $uSeq, uDmf: $uDmf, uExp: $uExp, uOther: $uOther, isRequestDone: $isRequestDone)';
}


}

/// @nodoc
abstract mixin class _$LifevestTagModelCopyWith<$Res> implements $LifevestTagModelCopyWith<$Res> {
  factory _$LifevestTagModelCopyWith(_LifevestTagModel value, $Res Function(_LifevestTagModel) _then) = __$LifevestTagModelCopyWithImpl;
@override @useResult
$Res call({
 String epcHex, String? tid, String? eMfr, String? eSer, String? ePno, String? eSeq, int? eConst, int? eFilterValue, String? userHex, String? uMfr, String? uSer, String? uPno, String? uSeq, String? uDmf, String? uExp, String? uOther, bool isRequestDone
});




}
/// @nodoc
class __$LifevestTagModelCopyWithImpl<$Res>
    implements _$LifevestTagModelCopyWith<$Res> {
  __$LifevestTagModelCopyWithImpl(this._self, this._then);

  final _LifevestTagModel _self;
  final $Res Function(_LifevestTagModel) _then;

/// Create a copy of LifevestTagModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? epcHex = null,Object? tid = freezed,Object? eMfr = freezed,Object? eSer = freezed,Object? ePno = freezed,Object? eSeq = freezed,Object? eConst = freezed,Object? eFilterValue = freezed,Object? userHex = freezed,Object? uMfr = freezed,Object? uSer = freezed,Object? uPno = freezed,Object? uSeq = freezed,Object? uDmf = freezed,Object? uExp = freezed,Object? uOther = freezed,Object? isRequestDone = null,}) {
  return _then(_LifevestTagModel(
epcHex: null == epcHex ? _self.epcHex : epcHex // ignore: cast_nullable_to_non_nullable
as String,tid: freezed == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String?,eMfr: freezed == eMfr ? _self.eMfr : eMfr // ignore: cast_nullable_to_non_nullable
as String?,eSer: freezed == eSer ? _self.eSer : eSer // ignore: cast_nullable_to_non_nullable
as String?,ePno: freezed == ePno ? _self.ePno : ePno // ignore: cast_nullable_to_non_nullable
as String?,eSeq: freezed == eSeq ? _self.eSeq : eSeq // ignore: cast_nullable_to_non_nullable
as String?,eConst: freezed == eConst ? _self.eConst : eConst // ignore: cast_nullable_to_non_nullable
as int?,eFilterValue: freezed == eFilterValue ? _self.eFilterValue : eFilterValue // ignore: cast_nullable_to_non_nullable
as int?,userHex: freezed == userHex ? _self.userHex : userHex // ignore: cast_nullable_to_non_nullable
as String?,uMfr: freezed == uMfr ? _self.uMfr : uMfr // ignore: cast_nullable_to_non_nullable
as String?,uSer: freezed == uSer ? _self.uSer : uSer // ignore: cast_nullable_to_non_nullable
as String?,uPno: freezed == uPno ? _self.uPno : uPno // ignore: cast_nullable_to_non_nullable
as String?,uSeq: freezed == uSeq ? _self.uSeq : uSeq // ignore: cast_nullable_to_non_nullable
as String?,uDmf: freezed == uDmf ? _self.uDmf : uDmf // ignore: cast_nullable_to_non_nullable
as String?,uExp: freezed == uExp ? _self.uExp : uExp // ignore: cast_nullable_to_non_nullable
as String?,uOther: freezed == uOther ? _self.uOther : uOther // ignore: cast_nullable_to_non_nullable
as String?,isRequestDone: null == isRequestDone ? _self.isRequestDone : isRequestDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
