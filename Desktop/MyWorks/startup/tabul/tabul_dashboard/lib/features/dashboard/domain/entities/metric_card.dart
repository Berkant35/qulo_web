class MetricCard {
  final String title;
  final String value;
  final String? subtitle;
  final double? percentage;
  final bool isPositive;
  final String iconName;
  final String? unit;

  const MetricCard({
    required this.title,
    required this.value,
    this.subtitle,
    this.percentage,
    this.isPositive = true,
    required this.iconName,
    this.unit,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetricCard &&
        other.title == title &&
        other.value == value &&
        other.subtitle == subtitle &&
        other.percentage == percentage &&
        other.isPositive == isPositive &&
        other.iconName == iconName &&
        other.unit == unit;
  }

  @override
  int get hashCode {
    return Object.hash(
      title,
      value,
      subtitle,
      percentage,
      isPositive,
      iconName,
      unit,
    );
  }

  @override
  String toString() {
    return 'MetricCard(title: $title, value: $value, subtitle: $subtitle, percentage: $percentage, isPositive: $isPositive, iconName: $iconName, unit: $unit)';
  }
}
