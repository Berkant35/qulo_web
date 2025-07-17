import '../../domain/entities/entities.dart';

class ChartDataModel extends ChartData {
  const ChartDataModel({
    required super.label,
    required super.value,
    super.timestamp,
    super.color,
  });

  factory ChartDataModel.fromJson(Map<String, dynamic> json) {
    return ChartDataModel(
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
      color: json['color'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'timestamp': timestamp?.toIso8601String(),
      'color': color,
    };
  }

  factory ChartDataModel.fromEntity(ChartData entity) {
    return ChartDataModel(
      label: entity.label,
      value: entity.value,
      timestamp: entity.timestamp,
      color: entity.color,
    );
  }
}

class ChartSeriesModel extends ChartSeries {
  const ChartSeriesModel({
    required super.name,
    required super.data,
    super.color,
    super.type,
  });

  factory ChartSeriesModel.fromJson(Map<String, dynamic> json) {
    return ChartSeriesModel(
      name: json['name'] as String,
      data: (json['data'] as List)
          .map((e) => ChartDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      color: json['color'] as String?,
      type: ChartType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ChartType.line,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'data': data.map((e) => ChartDataModel.fromEntity(e).toJson()).toList(),
      'color': color,
      'type': type.name,
    };
  }

  factory ChartSeriesModel.fromEntity(ChartSeries entity) {
    return ChartSeriesModel(
      name: entity.name,
      data: entity.data,
      color: entity.color,
      type: entity.type,
    );
  }
}
