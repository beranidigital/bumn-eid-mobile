import 'dart:convert';

class ParimeterBumn {
  String bumn_id;
  String bumn_name;
  int total_perimeter;
  ParimeterBumn({
    this.bumn_id,
    this.bumn_name,
    this.total_perimeter,
  });

  Map<String, dynamic> toMap() {
    return {
      'bumn_id': bumn_id,
      'bumn_name': bumn_name,
      'total_perimeter': total_perimeter,
    };
  }

  factory ParimeterBumn.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ParimeterBumn(
      bumn_id: map['bumn_id'],
      bumn_name: map['bumn_name'],
      total_perimeter: map['total_perimeter'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParimeterBumn.fromJson(String source) =>
      ParimeterBumn.fromMap(json.decode(source));
}
