import 'dart:convert';

class DetailBUMNTalent {
  int id_talenta;
  String nama_lengkap;
  String bumn_name;
  int periode;
  String jabatan;
  int sisa_pensiun_dalam_hari;
  int sisa_pensiun_tanggal_tahun;
  int sisa_pensiun_tanggal_bulan;
  DetailBUMNTalent({
    this.id_talenta,
    this.nama_lengkap,
    this.bumn_name,
    this.periode,
    this.jabatan,
    this.sisa_pensiun_dalam_hari,
    this.sisa_pensiun_tanggal_tahun,
    this.sisa_pensiun_tanggal_bulan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_talenta': id_talenta,
      'nama_lengkap': nama_lengkap,
      'bumn_name': bumn_name,
      'periode': periode,
      'jabatan': jabatan,
      'sisa_pensiun_dalam_hari': sisa_pensiun_dalam_hari,
      'sisa_pensiun_tanggal_tahun': sisa_pensiun_tanggal_tahun,
      'sisa_pensiun_tanggal_bulan': sisa_pensiun_tanggal_bulan,
    };
  }

  factory DetailBUMNTalent.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DetailBUMNTalent(
      id_talenta: map['id_talenta'],
      nama_lengkap: map['nama_lengkap'],
      bumn_name: map['bumn_name'],
      periode: map['periode'],
      jabatan: map['jabatan'],
      sisa_pensiun_dalam_hari: map['sisa_pensiun_dalam_hari'],
      sisa_pensiun_tanggal_tahun: map['sisa_pensiun_tanggal_tahun'],
      sisa_pensiun_tanggal_bulan: map['sisa_pensiun_tanggal_bulan'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailBUMNTalent.fromJson(String source) =>
      DetailBUMNTalent.fromMap(json.decode(source));
}
