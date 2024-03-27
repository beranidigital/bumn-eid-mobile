import 'dart:convert';

class HorBarChart {
  int value;
  String title;
  int totalValue;
  HorBarChart({
    this.value,
    this.title,
    this.totalValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'title': title,
      'totalValue': totalValue,
    };
  }

  factory HorBarChart.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HorBarChart(
      value: map['value'],
      title: map['title'],
      totalValue: map['totalValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HorBarChart.fromJson(String source) =>
      HorBarChart.fromMap(json.decode(source));
}
