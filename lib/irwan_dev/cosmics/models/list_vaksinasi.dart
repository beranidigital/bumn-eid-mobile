import 'dart:convert';

class ListVaksinasi {
  String bumn_id;
  String bumn_name;
  int total_pegawai_tervaksin;
  ListVaksinasi({
    this.bumn_id,
    this.bumn_name,
    this.total_pegawai_tervaksin,
  });

  Map<String, dynamic> toMap() {
    return {
      'bumn_id': bumn_id,
      'bumn_name': bumn_name,
      'total_pegawai_tervaksin': total_pegawai_tervaksin,
    };
  }

  factory ListVaksinasi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListVaksinasi(
      bumn_id: map['bumn_id'],
      bumn_name: map['bumn_name'],
      total_pegawai_tervaksin: map['total_pegawai_tervaksin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListVaksinasi.fromJson(String source) =>
      ListVaksinasi.fromMap(json.decode(source));
}
