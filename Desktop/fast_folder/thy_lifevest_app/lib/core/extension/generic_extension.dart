extension GenericExtension<T> on T? {
  bool get isNull => this == null;

  bool get isNotNull => this != null;

  String? get toNullString => isNull ? null : toString();

  bool isEquals(T? other) {
    return this == other;
  }
}
