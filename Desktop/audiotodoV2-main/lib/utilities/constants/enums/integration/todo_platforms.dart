enum TodoPlatforms {
  clickUp,
  slack,
  jira,
  jiraSoftware,
  jiraSoftwareDomain,
  none;

  ///Text to [TodoPlatforms] enum
  static TodoPlatforms? fromString(String? value) {
    if (value == null) {
      return none;
    }
    return TodoPlatforms.values.firstWhere(
        (e) => e.toString().toLowerCase() == value.toLowerCase(),
        orElse: () => none);
  }
}
