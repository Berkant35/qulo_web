import '../../domain/entities/entities.dart';

class MetricCardModel extends MetricCard {
  const MetricCardModel({
    required super.title,
    required super.value,
    super.subtitle,
    super.percentage,
    super.isPositive,
    required super.iconName,
    super.unit,
  });

  factory MetricCardModel.fromJson(Map<String, dynamic> json) {
    return MetricCardModel(
      title: json['title'] as String,
      value: json['value'] as String,
      subtitle: json['subtitle'] as String?,
      percentage: json['percentage']?.toDouble(),
      isPositive: json['isPositive'] as bool? ?? true,
      iconName: json['iconName'] as String,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'subtitle': subtitle,
      'percentage': percentage,
      'isPositive': isPositive,
      'iconName': iconName,
      'unit': unit,
    };
  }

  factory MetricCardModel.fromEntity(MetricCard entity) {
    return MetricCardModel(
      title: entity.title,
      value: entity.value,
      subtitle: entity.subtitle,
      percentage: entity.percentage,
      isPositive: entity.isPositive,
      iconName: entity.iconName,
      unit: entity.unit,
    );
  }
}
