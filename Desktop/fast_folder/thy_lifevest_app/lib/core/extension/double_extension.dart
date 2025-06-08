import 'package:thy_lifevest_app/core/extension/num_extension.dart';

extension DoubleExtension on double? {
  String get toCurrency {
    final formattedValue = getValueOrDefault
        .toStringAsFixed(2)
        .replaceAll('.', ',')
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return "$formattedValue ₺";
  }

  String get toCurrencyTL {
    final formattedValue = getValueOrDefault
        .toStringAsFixed(2)
        .replaceAll('.', ',')
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return "$formattedValue TL";
  }

  String get toCurrencyWithoutDecimal {
    final formattedValue = getValueOrDefault
        .toStringAsFixed(2)
        .replaceAll(
          RegExp(r'(\.0*|(?<=\.\d)0*)$'),
          '',
        ) // Gereksiz sıfırları kaldır
        .replaceAll('.', ',')
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return "$formattedValue₺";
  }

  String get toFormattedDecimalWithoutCurrency {
    final formattedValue = getValueOrDefault
        .toStringAsFixed(2)
        .replaceAll('.', ',')
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return formattedValue;
  }

  String get justReplaceDot {
    return getValueOrDefault.toString().replaceAll('.', ',');
  }
}
