import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'dart:typed_data';

extension ListExtension<T> on List<T>? {
  List<T> get getValueOrDefault => this ?? [];

  int get itemCount => this?.length ?? 0;

  bool get isNullOrEmpty => this == null || (this ?? []).isEmpty;

  bool get isNotEmpty => !isNullOrEmpty;

  bool get isZero => itemCount == 0;

  bool get isAllTrue =>
      (this as List<bool>).every((element) => element.isEquals(true));

  bool get isAnyTrue =>
      (this as List<bool>).any((element) => element.isEquals(true));
}

extension SafeListAccess<T> on List<T>? {
  T? safeElementAt(int index) {
    if (isNull) return null;
    if (index < 0 || index >= getValueOrDefault.length) return null;
    return getValueOrDefault[index];
  }

  int? indexWhereOrNull(bool Function(T) test) {
    if (isNull) return null;
    return (this?.indexWhere(test)).isEquals(-1)
        ? null
        : this?.indexWhere(test);
  }
}

extension StringListExtension on List<String>? {
  bool get isAllEmpty =>
      (this as List<String>).every((element) => element.isEmpty);

  bool get isAnyEmpty =>
      (this as List<String>).any((element) => element.isEmpty);
}

/// List extension metodları (Non-nullable version)
extension ListExtensionNonNull<T> on List<T> {
  /// Extension metodları
  List<T> get copy => List<T>.from(this);

  /// Listeyi belirtilen boyutlarda chunk'lara böler
  List<List<T>> chunkedBySize(int chunkSize) {
    if (chunkSize <= 0) throw ArgumentError('Chunk size must be positive');

    final List<List<T>> chunks = [];
    for (int i = 0; i < length; i += chunkSize) {
      final int end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }
}

/// Uint8List için özel extension metodları
extension Uint8ListExtension on Uint8List {
  /// Byte array'i hex string'e çevirir
  String toHex() {
    return map(
      (byte) => byte.toRadixString(16).padLeft(2, '0'),
    ).join().toUpperCase();
  }

  /// Uint8List'i belirtilen boyutlarda chunk'lara böler
  List<Uint8List> chunkedBySize(int chunkSize) {
    if (chunkSize <= 0) throw ArgumentError('Chunk size must be positive');

    final List<Uint8List> chunks = [];
    for (int i = 0; i < length; i += chunkSize) {
      final int end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }
}
