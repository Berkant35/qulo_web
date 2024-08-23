import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'product_error_log.freezed.dart';
part 'product_error_log.g.dart';

@freezed
class ProductErrorLog with _$ProductErrorLog {
  const factory ProductErrorLog({
    @JsonKey(name: 'productId') required String productId,
    @JsonKey(name: 'accInitError') required bool accInitError,
    @JsonKey(name: 'dstInitError') required bool dstInitError,
    @JsonKey(name: 'noBatOrOvpError') required bool noBatOrOvpError,
    @JsonKey(name: 'lowBatVoltageError') required bool lowBatVoltageError,
    @JsonKey(name: 'unKnownCounter') required int unKnownCounter,
    @JsonKey(name: 'serialNumber') required String serialNumber,
    @JsonKey(name: 'productOwner') required String productOwner,
    @JsonKey(name: 'productOwnerId') required String productOwnerId,
  }) = _ProductErrorLog;

  factory ProductErrorLog.fromJson(Map<String, Object?> json) =>
      _$ProductErrorLogFromJson(json);
}
