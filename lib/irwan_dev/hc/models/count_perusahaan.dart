import 'dart:convert';

class CountPerusahaan {
  int induk;
  int anak;
  int cucu;
  CountPerusahaan({
    this.induk,
    this.anak,
    this.cucu,
  });

  Map<String, dynamic> toMap() {
    return {
      'induk': induk,
      'anak': anak,
      'cucu': cucu,
    };
  }

  factory CountPerusahaan.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CountPerusahaan(
      induk: map['induk'],
      anak: map['anak'],
      cucu: map['cucu'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CountPerusahaan.fromJson(String source) =>
      CountPerusahaan.fromMap(json.decode(source));
}
