import 'dart:convert';

class SummaryJenisKegiatan {
  String jenis_kegiatan;
  int total;
  SummaryJenisKegiatan({
    this.jenis_kegiatan,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'jenis_kegiatan': jenis_kegiatan,
      'total': total,
    };
  }

  factory SummaryJenisKegiatan.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SummaryJenisKegiatan(
      jenis_kegiatan: map['jenis_kegiatan'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryJenisKegiatan.fromJson(String source) =>
      SummaryJenisKegiatan.fromMap(json.decode(source));
}
