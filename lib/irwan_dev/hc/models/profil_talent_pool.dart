import 'dart:convert';

class BiodataProfileTalent {
  int id;
  String jabatan;
  String nik;
  String nama;
  String busnm;
  String kategori;
  String id_angka;
  String status;
  String kriteria;
  String catatan;
  String catatan_lain;
  BiodataProfileTalent({
    this.id,
    this.jabatan,
    this.nik,
    this.nama,
    this.busnm,
    this.kategori,
    this.id_angka,
    this.status,
    this.kriteria,
    this.catatan,
    this.catatan_lain,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jabatan': jabatan,
      'nik': nik,
      'nama': nama,
      'busnm': busnm,
      'kategori': kategori,
      'id_angka': id_angka,
      'status': status,
      'kriteria': kriteria,
      'catatan': catatan,
      'catatan_lain': catatan_lain,
    };
  }

  factory BiodataProfileTalent.fromMap(Map<String, dynamic> map) {
    return BiodataProfileTalent(
      id: map['id'],
      jabatan: map['jabatan'],
      nik: map['nik'],
      nama: map['nama'],
      busnm: map['busnm'],
      kategori: map['kategori'],
      id_angka: map['id_angka'],
      status: map['status'],
      kriteria: map['kriteria'],
      catatan: map['catatan'],
      catatan_lain: map['catatan_lain'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BiodataProfileTalent.fromJson(String source) =>
      BiodataProfileTalent.fromMap(json.decode(source));
}

class PersonalProfilTalent {
  String id;
  String nama;
  String gelar;
  String nik;
  String ttl;
  String jk;
  String agama;
  String jabatan;
  String alamat;
  String hp;
  String email;
  String npwp;
  String sosmed;
  String created_at;
  String kategori;
  String tempat_lahir;
  String tanggal_lahir;
  PersonalProfilTalent({
    this.id,
    this.nama,
    this.gelar,
    this.nik,
    this.ttl,
    this.jk,
    this.agama,
    this.jabatan,
    this.alamat,
    this.hp,
    this.email,
    this.npwp,
    this.sosmed,
    this.created_at,
    this.kategori,
    this.tempat_lahir,
    this.tanggal_lahir,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'gelar': gelar,
      'nik': nik,
      'ttl': ttl,
      'jk': jk,
      'agama': agama,
      'jabatan': jabatan,
      'alamat': alamat,
      'hp': hp,
      'email': email,
      'npwp': npwp,
      'sosmed': sosmed,
      'created_at': created_at,
      'kategori': kategori,
      'tempat_lahir': tempat_lahir,
      'tanggal_lahir': tanggal_lahir,
    };
  }

  factory PersonalProfilTalent.fromMap(Map<String, dynamic> map) {
    return PersonalProfilTalent(
      id: map['id'],
      nama: map['nama'],
      gelar: map['gelar'],
      nik: map['nik'],
      ttl: map['ttl'],
      jk: map['jk'],
      agama: map['agama'],
      jabatan: map['jabatan'],
      alamat: map['alamat'],
      hp: map['hp'],
      email: map['email'],
      npwp: map['npwp'],
      sosmed: map['sosmed'],
      created_at: map['created_at'],
      kategori: map['kategori'],
      tempat_lahir: map['tempat_lahir'],
      tanggal_lahir: map['tanggal_lahir'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalProfilTalent.fromJson(String source) =>
      PersonalProfilTalent.fromMap(json.decode(source));
}

class PendidikanProfilTalent {
  String nik;
  String JENJANG;
  String INSTANSI;
  String LULUS;
  String KOTANEGARA;
  String PENGHARGAAN;
  String JURUSAN;
  PendidikanProfilTalent({
    this.nik,
    this.JENJANG,
    this.INSTANSI,
    this.LULUS,
    this.KOTANEGARA,
    this.PENGHARGAAN,
    this.JURUSAN,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'JENJANG': JENJANG,
      'INSTANSI': INSTANSI,
      'LULUS': LULUS,
      'KOTANEGARA': KOTANEGARA,
      'PENGHARGAAN': PENGHARGAAN,
      'JURUSAN': JURUSAN,
    };
  }

  factory PendidikanProfilTalent.fromMap(Map<String, dynamic> map) {
    return PendidikanProfilTalent(
      nik: map['nik'],
      JENJANG: map['JENJANG'],
      INSTANSI: map['INSTANSI'],
      LULUS: map['LULUS'],
      KOTANEGARA: map['KOTANEGARA'],
      PENGHARGAAN: map['PENGHARGAAN'],
      JURUSAN: map['JURUSAN'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PendidikanProfilTalent.fromJson(String source) =>
      PendidikanProfilTalent.fromMap(json.decode(source));
}

class RiwayatJabatanProfilTalent {
  String nik;
  String JABATAN;
  String URAIAN;
  String WAKTU;
  String PERUSAHAAN;
  String MULAI;
  String AKHIR;
  RiwayatJabatanProfilTalent({
    this.nik,
    this.JABATAN,
    this.URAIAN,
    this.WAKTU,
    this.PERUSAHAAN,
    this.MULAI,
    this.AKHIR,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'JABATAN': JABATAN,
      'URAIAN': URAIAN,
      'WAKTU': WAKTU,
      'PERUSAHAAN': PERUSAHAAN,
      'MULAI': MULAI,
      'AKHIR': AKHIR,
    };
  }

  factory RiwayatJabatanProfilTalent.fromMap(Map<String, dynamic> map) {
    return RiwayatJabatanProfilTalent(
      nik: map['nik'],
      JABATAN: map['JABATAN'],
      URAIAN: map['URAIAN'],
      WAKTU: map['WAKTU'],
      PERUSAHAAN: map['PERUSAHAAN'],
      MULAI: map['MULAI'],
      AKHIR: map['AKHIR'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RiwayatJabatanProfilTalent.fromJson(String source) =>
      RiwayatJabatanProfilTalent.fromMap(json.decode(source));
}

class PenghargaanProfiltalent {
  String nik;
  String JENIS_PENGHARGAAN;
  String TINGKAT;
  String DIBERIKAN;
  String TAHUN;
  PenghargaanProfiltalent({
    this.nik,
    this.JENIS_PENGHARGAAN,
    this.TINGKAT,
    this.DIBERIKAN,
    this.TAHUN,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'JENIS_PENGHARGAAN': JENIS_PENGHARGAAN,
      'TINGKAT': TINGKAT,
      'DIBERIKAN': DIBERIKAN,
      'TAHUN': TAHUN,
    };
  }

  factory PenghargaanProfiltalent.fromMap(Map<String, dynamic> map) {
    return PenghargaanProfiltalent(
      nik: map['nik'],
      JENIS_PENGHARGAAN: map['JENIS_PENGHARGAAN'],
      TINGKAT: map['TINGKAT'],
      DIBERIKAN: map['DIBERIKAN'],
      TAHUN: map['TAHUN'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PenghargaanProfiltalent.fromJson(String source) =>
      PenghargaanProfiltalent.fromMap(json.decode(source));
}

class PeminatanProfilTalent {
  String nik;
  String POSISI;
  String LAINNYA;
  PeminatanProfilTalent({
    this.nik,
    this.POSISI,
    this.LAINNYA,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'POSISI': POSISI,
      'LAINNYA': LAINNYA,
    };
  }

  factory PeminatanProfilTalent.fromMap(Map<String, dynamic> map) {
    return PeminatanProfilTalent(
      nik: map['nik'],
      POSISI: map['POSISI'],
      LAINNYA: map['LAINNYA'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PeminatanProfilTalent.fromJson(String source) =>
      PeminatanProfilTalent.fromMap(json.decode(source));
}

class FotoProfilTalent {
  String nik;
  String path_foto;
  String type;
  FotoProfilTalent({
    this.nik,
    this.path_foto,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'path_foto': path_foto,
      'type': type,
    };
  }

  factory FotoProfilTalent.fromMap(Map<String, dynamic> map) {
    return FotoProfilTalent(
      nik: map['nik'],
      path_foto: map['path_foto'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FotoProfilTalent.fromJson(String source) =>
      FotoProfilTalent.fromMap(json.decode(source));
}

class SummaryProfiltalent {
  String nik;
  String SUMMARY;
  String INTEREST;
  SummaryProfiltalent({
    this.nik,
    this.SUMMARY,
    this.INTEREST,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'SUMMARY': SUMMARY,
      'INTEREST': INTEREST,
    };
  }

  factory SummaryProfiltalent.fromMap(Map<String, dynamic> map) {
    return SummaryProfiltalent(
      nik: map['nik'],
      SUMMARY: map['SUMMARY'],
      INTEREST: map['INTEREST'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryProfiltalent.fromJson(String source) =>
      SummaryProfiltalent.fromMap(json.decode(source));
}

class ProfileTalentPool {
  BiodataProfileTalent biodata;
  PersonalProfilTalent personal;
  List<SummaryProfiltalent> summary;
  List<PendidikanProfilTalent> pendidikan;
  List<FotoProfilTalent> foto;
  List<RiwayatJabatanProfilTalent> riwayatjabatan;
  List<PenghargaanProfiltalent> penghargaan;
  List<PeminatanProfilTalent> peminatan;
  ProfileTalentPool({
    this.biodata,
    this.personal,
    this.summary,
    this.pendidikan,
    this.foto,
    this.riwayatjabatan,
    this.penghargaan,
    this.peminatan,
  });

  Map<String, dynamic> toMap() {
    return {
      'biodata': biodata.toMap(),
      'personal': personal.toMap(),
      'summary': summary?.map((x) => x.toMap())?.toList(),
      'pendidikan': pendidikan?.map((x) => x.toMap())?.toList(),
      'foto': foto?.map((x) => x.toMap())?.toList(),
      'riwayatjabatan': riwayatjabatan?.map((x) => x.toMap())?.toList(),
      'penghargaan': penghargaan?.map((x) => x.toMap())?.toList(),
      'peminatan': peminatan?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ProfileTalentPool.fromMap(Map<String, dynamic> map) {
    return ProfileTalentPool(
      biodata: BiodataProfileTalent.fromMap(map['biodata']),
      personal: PersonalProfilTalent.fromMap(map['personal']),
      summary: List<SummaryProfiltalent>.from(
          map['summary']?.map((x) => SummaryProfiltalent.fromMap(x))),
      pendidikan: List<PendidikanProfilTalent>.from(
          map['pendidikan']?.map((x) => PendidikanProfilTalent.fromMap(x))),
      foto: List<FotoProfilTalent>.from(
          map['foto']?.map((x) => FotoProfilTalent.fromMap(x))),
      riwayatjabatan: List<RiwayatJabatanProfilTalent>.from(
          map['riwayatjabatan']
              ?.map((x) => RiwayatJabatanProfilTalent.fromMap(x))),
      penghargaan: List<PenghargaanProfiltalent>.from(
          map['penghargaan']?.map((x) => PenghargaanProfiltalent.fromMap(x))),
      peminatan: List<PeminatanProfilTalent>.from(
          map['peminatan']?.map((x) => PeminatanProfilTalent.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileTalentPool.fromJson(String source) =>
      ProfileTalentPool.fromMap(json.decode(source));
}
