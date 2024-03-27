import 'dart:convert';

class TerdampakKabupaten {
  int kabupaten_id;
  String kabupaten;
  int total;
  TerdampakKabupaten({
    this.kabupaten_id,
    this.kabupaten,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'kabupaten_id': kabupaten_id,
      'kabupaten': kabupaten,
      'total': total,
    };
  }

  factory TerdampakKabupaten.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TerdampakKabupaten(
      kabupaten_id: map['kabupaten_id'],
      kabupaten: map['kabupaten'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TerdampakKabupaten.fromJson(String source) =>
      TerdampakKabupaten.fromMap(json.decode(source));
}
