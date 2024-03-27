import 'dart:convert';

class ListCompanyTalentPool {
  String nama_lengkap;
  String nama_pendek;
  String kelas_bumn;
  String cluster_bumn;
  String wamen_bumn;
  String sektor_bumn;
  String id_angka;
  String bumn;
  int jumlah;
  int jumlah_color;
  ListCompanyTalentPool({
    this.nama_lengkap,
    this.nama_pendek,
    this.kelas_bumn,
    this.cluster_bumn,
    this.wamen_bumn,
    this.sektor_bumn,
    this.id_angka,
    this.bumn,
    this.jumlah,
    this.jumlah_color,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama_lengkap': nama_lengkap,
      'nama_pendek': nama_pendek,
      'kelas_bumn': kelas_bumn,
      'cluster_bumn': cluster_bumn,
      'wamen_bumn': wamen_bumn,
      'sektor_bumn': sektor_bumn,
      'id_angka': id_angka,
      'bumn': bumn,
      'jumlah': jumlah,
      'jumlah_color': jumlah_color,
    };
  }

  factory ListCompanyTalentPool.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListCompanyTalentPool(
      nama_lengkap: map['nama_lengkap'],
      nama_pendek: map['nama_pendek'],
      kelas_bumn: map['kelas_bumn'],
      cluster_bumn: map['cluster_bumn'],
      wamen_bumn: map['wamen_bumn'],
      sektor_bumn: map['sektor_bumn'],
      id_angka: map['id_angka'],
      bumn: map['bumn'],
      jumlah: map['jumlah'],
      jumlah_color: map['jumlah_color'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListCompanyTalentPool.fromJson(String source) =>
      ListCompanyTalentPool.fromMap(json.decode(source));
}
