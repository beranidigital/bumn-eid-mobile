import 'dart:convert';

class DataListTalentPool {
  String nik;
  String id_angka;
  String nama;
  String bumn_name;
  String jabatan;
  String status;
  DataListTalentPool({
    this.nik,
    this.id_angka,
    this.nama,
    this.bumn_name,
    this.jabatan,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'id_angka': id_angka,
      'nama': nama,
      'bumn_name': bumn_name,
      'jabatan': jabatan,
      'status': status,
    };
  }

  factory DataListTalentPool.fromMap(Map<String, dynamic> map) {
    return DataListTalentPool(
      nik: map['nik'],
      id_angka: map['id_angka'],
      nama: map['nama'],
      bumn_name: map['bumn_name'],
      jabatan: map['jabatan'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DataListTalentPool.fromJson(String source) =>
      DataListTalentPool.fromMap(json.decode(source));
}

class ListTalentPool {
  List<DataListTalentPool> list;
  ListTalentPool({
    this.list,
  });

  Map<String, dynamic> toMap() {
    return {
      'list': list?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ListTalentPool.fromMap(Map<String, dynamic> map) {
    return ListTalentPool(
      list: List<DataListTalentPool>.from(
          map['list']?.map((x) => DataListTalentPool.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListTalentPool.fromJson(String source) =>
      ListTalentPool.fromMap(json.decode(source));
}
