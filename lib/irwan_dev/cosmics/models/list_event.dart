import 'dart:convert';

class ListEvent {
  int id;
  int id_kegiatan;
  String nama_kegiatan;
  int id_jenis_kegiatan;
  String jenis_kegiatan;
  String deskripsi;
  String tanggal;
  String file_1;
  String file_1_thumb;
  String file_2;
  String file_2_thumb;
  bool checklist_dampak;
  String bulan_kegiatan;
  String persen_dampak;
  String persen_dampak_keseluruhan;
  String bumn_id;
  String bumn_name;
  String cluster_bumn;
  String wamen_bumn;
  String kelas_bumn;
  String event_date_insert;
  String event_date_update;
  ListEvent({
    this.id,
    this.id_kegiatan,
    this.nama_kegiatan,
    this.id_jenis_kegiatan,
    this.jenis_kegiatan,
    this.deskripsi,
    this.tanggal,
    this.file_1,
    this.file_1_thumb,
    this.file_2,
    this.file_2_thumb,
    this.checklist_dampak,
    this.bulan_kegiatan,
    this.persen_dampak,
    this.persen_dampak_keseluruhan,
    this.bumn_id,
    this.bumn_name,
    this.cluster_bumn,
    this.wamen_bumn,
    this.kelas_bumn,
    this.event_date_insert,
    this.event_date_update,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_kegiatan': id_kegiatan,
      'nama_kegiatan': nama_kegiatan,
      'id_jenis_kegiatan': id_jenis_kegiatan,
      'jenis_kegiatan': jenis_kegiatan,
      'deskripsi': deskripsi,
      'tanggal': tanggal,
      'file_1': file_1,
      'file_1_thumb': file_1_thumb,
      'file_2': file_2,
      'file_2_thumb': file_2_thumb,
      'checklist_dampak': checklist_dampak,
      'bulan_kegiatan': bulan_kegiatan,
      'persen_dampak': persen_dampak,
      'persen_dampak_keseluruhan': persen_dampak_keseluruhan,
      'bumn_id': bumn_id,
      'bumn_name': bumn_name,
      'cluster_bumn': cluster_bumn,
      'wamen_bumn': wamen_bumn,
      'kelas_bumn': kelas_bumn,
      'event_date_insert': event_date_insert,
      'event_date_update': event_date_update,
    };
  }

  factory ListEvent.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListEvent(
      id: map['id'],
      id_kegiatan: map['id_kegiatan'],
      nama_kegiatan: map['nama_kegiatan'],
      id_jenis_kegiatan: map['id_jenis_kegiatan'],
      jenis_kegiatan: map['jenis_kegiatan'],
      deskripsi: map['deskripsi'],
      tanggal: map['tanggal'],
      file_1: map['file_1'],
      file_1_thumb: map['file_1_thumb'],
      file_2: map['file_2'],
      file_2_thumb: map['file_2_thumb'],
      checklist_dampak: map['checklist_dampak'],
      bulan_kegiatan: map['bulan_kegiatan'],
      persen_dampak: map['persen_dampak'],
      persen_dampak_keseluruhan: map['persen_dampak_keseluruhan'],
      bumn_id: map['bumn_id'],
      bumn_name: map['bumn_name'],
      cluster_bumn: map['cluster_bumn'],
      wamen_bumn: map['wamen_bumn'],
      kelas_bumn: map['kelas_bumn'],
      event_date_insert: map['event_date_insert'],
      event_date_update: map['event_date_update'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListEvent.fromJson(String source) =>
      ListEvent.fromMap(json.decode(source));
}
