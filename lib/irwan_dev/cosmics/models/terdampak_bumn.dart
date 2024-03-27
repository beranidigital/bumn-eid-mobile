import 'dart:convert';

class TerdampakBumn {
  String bumn_id;
  String bumn_name;
  int total;
  TerdampakBumn({
    this.bumn_id,
    this.bumn_name,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'bumn_id': bumn_id,
      'bumn_name': bumn_name,
      'total': total,
    };
  }

  factory TerdampakBumn.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TerdampakBumn(
      bumn_id: map['bumn_id'],
      bumn_name: map['bumn_name'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TerdampakBumn.fromJson(String source) =>
      TerdampakBumn.fromMap(json.decode(source));
}
