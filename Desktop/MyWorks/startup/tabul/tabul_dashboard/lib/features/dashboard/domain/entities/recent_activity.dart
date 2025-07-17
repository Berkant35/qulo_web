class RecentActivity {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final ActivityType type;
  final String? iconName;
  final String? actionUrl;

  const RecentActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    this.iconName,
    this.actionUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecentActivity &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.timestamp == timestamp &&
        other.type == type &&
        other.iconName == iconName &&
        other.actionUrl == actionUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      timestamp,
      type,
      iconName,
      actionUrl,
    );
  }

  @override
  String toString() {
    return 'RecentActivity(id: $id, title: $title, description: $description, timestamp: $timestamp, type: $type, iconName: $iconName, actionUrl: $actionUrl)';
  }
}

enum ActivityType {
  user,
  system,
  order,
  payment,
  notification,
  error,
  success,
  warning,
  info,
}
