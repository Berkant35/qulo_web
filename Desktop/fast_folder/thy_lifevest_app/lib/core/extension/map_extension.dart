extension MapNullRemover on Map<String, Object?> {
  Map<String, Object> removeNulls() {
    final Map<String, Object> nonNullMap = {};
    forEach((key, value) {
      if (value != null) {
        nonNullMap[key] = value;
      }
    });
    return nonNullMap;
  }
}
