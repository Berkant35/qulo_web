import '../../domain/entities/entities.dart';

class RecentActivityModel extends RecentActivity {
  const RecentActivityModel({
    required super.id,
    required super.title,
    required super.description,
    required super.timestamp,
    required super.type,
    super.iconName,
    super.actionUrl,
  });

  factory RecentActivityModel.fromJson(Map<String, dynamic> json) {
    return RecentActivityModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: ActivityType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ActivityType.info,
      ),
      iconName: json['iconName'] as String?,
      actionUrl: json['actionUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'iconName': iconName,
      'actionUrl': actionUrl,
    };
  }

  factory RecentActivityModel.fromEntity(RecentActivity entity) {
    return RecentActivityModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      timestamp: entity.timestamp,
      type: entity.type,
      iconName: entity.iconName,
      actionUrl: entity.actionUrl,
    );
  }
}
