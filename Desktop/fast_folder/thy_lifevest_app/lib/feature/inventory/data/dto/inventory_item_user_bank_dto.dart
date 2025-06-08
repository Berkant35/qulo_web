

import 'package:freezed_annotation/freezed_annotation.dart';
part 'inventory_item_user_bank_dto.freezed.dart';
part 'inventory_item_user_bank_dto.g.dart';

@freezed
abstract class InventoryItemUserBankDto with _$InventoryItemUserBankDto {
  const factory InventoryItemUserBankDto({
    @JsonKey(name: 'ID') String? id,
    @JsonKey(name: 'epc') String? epc,
    @JsonKey(name: 'tid') String? tid,
    @JsonKey(name: 'epc_mfr') String? epcMfr,
    @JsonKey(name: 'epc_ser') String? epcSer,
    @JsonKey(name: 'epc_pno') String? epcPno,
    @JsonKey(name: 'epc_seq') String? epcSeq,
    @JsonKey(name: 'epc_const') String? epcConst,
    @JsonKey(name: 'epc_filter_value') String? epcFilterValue,
    @JsonKey(name: 'user_data_hex') String? userDataHex,
    @JsonKey(name: 'user_mfr') String? userMfr,
    @JsonKey(name: 'user_ser') String? userSer,
    @JsonKey(name: 'user_pno') String? userPno,
    @JsonKey(name: 'user_seq') String? userSeq,
    @JsonKey(name: 'user_dmf') String? userDmf,
    @JsonKey(name: 'user_exp') String? userExp,
    @JsonKey(name: 'user_other') String? userOther,
    @JsonKey(name: 'date_dmf') String? dateDmf,
    @JsonKey(name: 'date_exp') String? dateExp,
    @JsonKey(name: 'record_date') String? recordDate,
    @JsonKey(name: 'record_user') String? recordUser,
  }) = _InventoryItemUserBankDto;

  factory InventoryItemUserBankDto.fromJson(Map<String, Object?> json) =>
      _$InventoryItemUserBankDtoFromJson(json);
}
