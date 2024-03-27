import 'dart:convert';

class DirkomPEN {
  int id;
  String id_angka;
  String nama_pejabat;
  String jabatan;
  String sk_jabat;
  String tgl_mulaijabat;
  String tgl_akhirjabat;
  String dirkom;
  String created_at;
  String updated_at;
  DirkomPEN({
    this.id,
    this.id_angka,
    this.nama_pejabat,
    this.jabatan,
    this.sk_jabat,
    this.tgl_mulaijabat,
    this.tgl_akhirjabat,
    this.dirkom,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_angka': id_angka,
      'nama_pejabat': nama_pejabat,
      'jabatan': jabatan,
      'sk_jabat': sk_jabat,
      'tgl_mulaijabat': tgl_mulaijabat,
      'tgl_akhirjabat': tgl_akhirjabat,
      'dirkom': dirkom,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory DirkomPEN.fromMap(Map<String, dynamic> map) {
    return DirkomPEN(
      id: map['id'],
      id_angka: map['id_angka'],
      nama_pejabat: map['nama_pejabat'],
      jabatan: map['jabatan'],
      sk_jabat: map['sk_jabat'],
      tgl_mulaijabat: map['tgl_mulaijabat'],
      tgl_akhirjabat: map['tgl_akhirjabat'],
      dirkom: map['dirkom'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DirkomPEN.fromJson(String source) =>
      DirkomPEN.fromMap(json.decode(source));
}
