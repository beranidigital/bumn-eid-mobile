import 'dart:convert';

class TerdampakProvinsi {
  int provinsi_id;
  String provinsi;
  int total;
  TerdampakProvinsi({
    this.provinsi_id,
    this.provinsi,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'provinsi_id': provinsi_id,
      'provinsi': provinsi,
      'total': total,
    };
  }

  factory TerdampakProvinsi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TerdampakProvinsi(
      provinsi_id: map['provinsi_id'],
      provinsi: map['provinsi'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TerdampakProvinsi.fromJson(String source) =>
      TerdampakProvinsi.fromMap(json.decode(source));
}
