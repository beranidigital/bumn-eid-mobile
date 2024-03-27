import 'dart:convert';

class FilterTalent {
  List<String> clusterFilter;
  List<String> kelasFilter;
  FilterTalent({
    this.clusterFilter,
    this.kelasFilter,
  });

  Map<String, dynamic> toMap() {
    return {
      'clusterFilter': clusterFilter,
      'kelasFilter': kelasFilter,
    };
  }

  factory FilterTalent.fromMap(Map<String, dynamic> map) {
    return FilterTalent(
      clusterFilter: List<String>.from(map['clusterFilter']),
      kelasFilter: List<String>.from(map['kelasFilter']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterTalent.fromJson(String source) =>
      FilterTalent.fromMap(json.decode(source));
}
