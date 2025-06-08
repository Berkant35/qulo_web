// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item_user_bank_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InventoryItemUserBankDto _$InventoryItemUserBankDtoFromJson(
  Map<String, dynamic> json,
) => _InventoryItemUserBankDto(
  id: json['ID'] as String?,
  epc: json['epc'] as String?,
  tid: json['tid'] as String?,
  epcMfr: json['epc_mfr'] as String?,
  epcSer: json['epc_ser'] as String?,
  epcPno: json['epc_pno'] as String?,
  epcSeq: json['epc_seq'] as String?,
  epcConst: json['epc_const'] as String?,
  epcFilterValue: json['epc_filter_value'] as String?,
  userDataHex: json['user_data_hex'] as String?,
  userMfr: json['user_mfr'] as String?,
  userSer: json['user_ser'] as String?,
  userPno: json['user_pno'] as String?,
  userSeq: json['user_seq'] as String?,
  userDmf: json['user_dmf'] as String?,
  userExp: json['user_exp'] as String?,
  userOther: json['user_other'] as String?,
  dateDmf: json['date_dmf'] as String?,
  dateExp: json['date_exp'] as String?,
  recordDate: json['record_date'] as String?,
  recordUser: json['record_user'] as String?,
);

Map<String, dynamic> _$InventoryItemUserBankDtoToJson(
  _InventoryItemUserBankDto instance,
) => <String, dynamic>{
  'ID': instance.id,
  'epc': instance.epc,
  'tid': instance.tid,
  'epc_mfr': instance.epcMfr,
  'epc_ser': instance.epcSer,
  'epc_pno': instance.epcPno,
  'epc_seq': instance.epcSeq,
  'epc_const': instance.epcConst,
  'epc_filter_value': instance.epcFilterValue,
  'user_data_hex': instance.userDataHex,
  'user_mfr': instance.userMfr,
  'user_ser': instance.userSer,
  'user_pno': instance.userPno,
  'user_seq': instance.userSeq,
  'user_dmf': instance.userDmf,
  'user_exp': instance.userExp,
  'user_other': instance.userOther,
  'date_dmf': instance.dateDmf,
  'date_exp': instance.dateExp,
  'record_date': instance.recordDate,
  'record_user': instance.recordUser,
};
