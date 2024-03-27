import 'dart:convert';

class ParimeterProvinsi {
  int provinsi_id;
  String provinsi;
  int total_perimeter;
  ParimeterProvinsi({
    this.provinsi_id,
    this.provinsi,
    this.total_perimeter,
  });

  Map<String, dynamic> toMap() {
    return {
      'provinsi_id': provinsi_id,
      'provinsi': provinsi,
      'total_perimeter': total_perimeter,
    };
  }

  factory ParimeterProvinsi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ParimeterProvinsi(
      provinsi_id: map['provinsi_id'],
      provinsi: map['provinsi'],
      total_perimeter: map['total_perimeter'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParimeterProvinsi.fromJson(String source) =>
      ParimeterProvinsi.fromMap(json.decode(source));
}
