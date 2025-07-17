class ChartData {
  final String label;
  final double value;
  final DateTime? timestamp;
  final String? color;

  const ChartData({
    required this.label,
    required this.value,
    this.timestamp,
    this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChartData &&
        other.label == label &&
        other.value == value &&
        other.timestamp == timestamp &&
        other.color == color;
  }

  @override
  int get hashCode {
    return Object.hash(label, value, timestamp, color);
  }

  @override
  String toString() {
    return 'ChartData(label: $label, value: $value, timestamp: $timestamp, color: $color)';
  }
}

class ChartSeries {
  final String name;
  final List<ChartData> data;
  final String? color;
  final ChartType type;

  const ChartSeries({
    required this.name,
    required this.data,
    this.color,
    this.type = ChartType.line,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChartSeries &&
        other.name == name &&
        other.data == data &&
        other.color == color &&
        other.type == type;
  }

  @override
  int get hashCode {
    return Object.hash(name, data, color, type);
  }

  @override
  String toString() {
    return 'ChartSeries(name: $name, data: $data, color: $color, type: $type)';
  }
}

enum ChartType {
  line,
  bar,
  pie,
  area,
  scatter,
}
