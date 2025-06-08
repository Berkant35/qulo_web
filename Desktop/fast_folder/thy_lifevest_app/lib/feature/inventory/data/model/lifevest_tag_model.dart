import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';
import 'package:thy_lifevest_app/feature/inventory/data/param/inventory_item_entity.dart';
import 'package:thy_lifevest_app/feature/reader/bloc/state/reader_state.dart';

part 'lifevest_tag_model.freezed.dart';

/// THY Lifevest Tag verilerini tutan model sınıfı
/// tag_info.dart'taki TagData sınıfının Clean Architecture Freezed versiyonu
/// Kurallara uygun: Freezed, Extension method, AppColors kullanımı
@freezed
abstract class LifevestTagModel with _$LifevestTagModel {
  const LifevestTagModel._();

  const factory LifevestTagModel({
    /// EPC hex değeri - zorunlu field
    required String epcHex,

    /// TID hex değeri
    String? tid,

    /// EPC'den çıkarılan üretici bilgisi (Manufacturer)
    String? eMfr,

    /// EPC'den çıkarılan seri numarası (Serial)
    String? eSer,

    /// EPC'den çıkarılan parça numarası (Part Number)
    String? ePno,

    /// EPC'den çıkarılan sequence numarası
    String? eSeq,

    /// EPC construct değeri
    int? eConst,

    /// EPC filter değeri
    int? eFilterValue,

    /// User memory hex değeri
    String? userHex,

    /// User memory'den çıkarılan üretici bilgisi
    String? uMfr,

    /// User memory'den çıkarılan seri numarası
    String? uSer,

    /// User memory'den çıkarılan parça numarası
    String? uPno,

    /// User memory'den çıkarılan sequence numarası
    String? uSeq,

    /// User memory'den çıkarılan üretim tarihi (YYYYMMDD formatında)
    String? uDmf,

    /// User memory'den çıkarılan son kullanma tarihi (YYYYMMDD formatında)
    String? uExp,

    /// User memory'den çıkarılan diğer bilgiler
    String? uOther,
    
    @Default(false) bool isRequestDone
  }) = _LifevestTagModel;

  // ===========================================
  // TARİH İŞLEME METODLARİ
  // ===========================================

  /// Üretim tarihini DateTime olarak döndürür
  /// uDmf string'ini YYYYMMDD formatından DateTime'a çevirir
  /// Extension method kullanarak null check yapar
  DateTime? get dmfDate {
    if (uDmf.isNull || uDmf!.length < 8) return null;
    try {
      final year = int.parse(uDmf!.substring(0, 4));
      final month = int.parse(uDmf!.substring(4, 6));
      final day = int.parse(uDmf!.substring(6, 8));
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  /// Son kullanma tarihini DateTime olarak döndürür
  /// uExp string'ini YYYYMMDD formatından DateTime'a çevirir
  /// Extension method kullanarak null check yapar
  DateTime? get expDate {
    if (uExp.isNull || uExp!.length < 8) return null;
    try {
      final year = int.parse(uExp!.substring(0, 4));
      final month = int.parse(uExp!.substring(4, 6));
      final day = int.parse(uExp!.substring(6, 8));
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  /// Son kullanma tarihi durumunu kontrol eder
  /// 0: Tarihi geçmiş (kırmızı)
  /// 1: 180 günden az kalmış (turuncu)
  /// 2: 180 günden fazla kalmış (yeşil)
  /// AppColors ile uyumlu status değerleri
  int get expiryStatus {
    final exp = expDate;
    if (exp.isNull) return 0; // Extension method ile null check

    final now = DateTime.now();
    final diffDays = exp!.difference(now).inDays;

    if (exp.isBefore(now)) {
      return 0; // Tarihi geçmiş
    } else if (diffDays <= 180) {
      return 1; // 180 günden az kalmış
    } else {
      return 2; // 180 günden fazla kalmış
    }
  }

  /// Son kullanma durumuna göre THY marka renklerini döndürür
  /// AppColors kullanımı - kurallara uygun
  Color get expiryStatusColor {
    switch (expiryStatus) {
      case 0:
        return AppColors.red200; // Süresi geçmiş
      case 1:
        return AppColors.warning; // 180 günden az kalmış
      case 2:
        return AppColors.success; // 180 günden fazla
      default:
        return AppColors.gray500; // Bilinmiyor
    }
  }

  // ===========================================
  // DOĞRULAMA ÖZELLİKLERİ
  // ===========================================

  /// Tag'in geçerli olup olmadığını kontrol eder
  /// Geçerli: Son kullanma tarihi var ve 180 günden fazla
  /// Extension method ile null check yapılır
  bool get isValid {
    if (expDate.isNull) return false;
    final now = DateTime.now();
    return expDate!.isAfter(now) && expDate!.difference(now).inDays > 180;
  }

  /// Tag'in son kullanma tarihinin yaklaştığını kontrol eder
  /// Yaklaşan: Son kullanma tarihi var, geçmemiş ama 180 günden az
  /// Extension method ile validation
  bool get isNearExpiry {
    if (expDate.isNull) return false;
    final now = DateTime.now();
    return expDate!.isAfter(now) && expDate!.difference(now).inDays <= 180;
  }

  /// Tag'in süresinin geçip geçmediğini kontrol eder
  /// Extension method ile null safety
  bool get isExpired {
    if (expDate.isNull) return false;
    final now = DateTime.now();
    return expDate!.isBefore(now) || expDate!.isAtSameMomentAs(now);
  }

  /// Tag'in tam veri setine sahip olup olmadığını kontrol eder
  /// Extension method kullanarak validation
  bool get hasCompleteData {
    return epcHex.isNotEmpty && eMfr.isNotNull && uMfr.isNotNull && uExp.isNotNull;
  }

  /// Tag'in lifevest olup olmadığını kontrol eder
  /// MFR field'larından kontrol edilir
  /// Extension method ile string validation
  bool get isLifevestTag {
    return (eMfr?.isNotEmpty.isEquals(true) ?? false) || (uMfr?.isNotEmpty.isEquals(true) ?? false);
  }

  // ===========================================
  // GÖRÜNTÜLEME YARDIMCILARI - UI Metinleri İngilizce
  // ===========================================

  /// Görüntüleme için formatlanmış üretim tarihi
  /// Null durumunda default değer döner
  String get formattedDmfDate {
    final date = dmfDate;
    if (date.isNull) return '-';
    return '${date!.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Görüntüleme için formatlanmış son kullanma tarihi
  /// Null durumunda default değer döner
  String get formattedExpDate {
    final date = expDate;
    if (date.isNull) return '-';
    return '${date!.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Görüntüleme için durum metni
  /// UI metinleri İngilizce (kurallara uygun) - AppStrings kullanımı
  String get statusText {
    switch (expiryStatus) {
      case 0:
        return AppStrings.tagExpired; // UI metni İngilizce
      case 1:
        return AppStrings.tagExpiringSoon; // UI metni İngilizce
      case 2:
        return AppStrings.tagValid; // UI metni İngilizce
      default:
        return AppStrings.tagUnknown; // UI metni İngilizce
    }
  }

  /// Kısa durum gösterimi için renk kodu
  /// AppColors ile uyumlu hex renk değeri
  String get statusColorHex {
    return '#${expiryStatusColor.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// Tag özet bilgisi - debugging için
  /// Türkçe açıklama, İngilizce data
  String get debugInfo {
    return 'LifevestTag{epc: $epcHex, valid: $isValid, expires: $formattedExpDate, status: $statusText}';
  }

  static fromDecodeEpcMap(Map<String, dynamic> decodeMap, ReaderTag tag) {
    return LifevestTagModel(
      epcHex: tag.epc.getValueOrDefault,
      tid: tag.tid,
      eMfr: decodeMap['MFR'],
      eSer: decodeMap['SER'],
      ePno: decodeMap['PNO'],
      eSeq: decodeMap['SEQ'],
      eConst: decodeMap['construct'],
      eFilterValue: decodeMap['filter_value'],
      userHex: null,
      uMfr: null,
      uSer: null,
      uPno: null,
      uSeq: null,
      uDmf: null,
      uExp: null,
      uOther: null,
    );
  }

  InventoryItemEntity get toInventoryItem => InventoryItemEntity(epc: epcHex);
}
