import 'dart:convert';

class BiodataProfil {
  int id;
  String nama_lengkap;
  String jenis_kelamin;
  String nik;
  String npwp;
  String email;
  String nomor_hp;
  String alamat;
  String suku;
  String gol_darah;
  String tempat_lahir;
  String tanggal_lahir;
  String gelar;
  String created_at;
  String updated_at;
  BiodataProfil({
    this.id,
    this.nama_lengkap,
    this.jenis_kelamin,
    this.nik,
    this.npwp,
    this.email,
    this.nomor_hp,
    this.alamat,
    this.suku,
    this.gol_darah,
    this.tempat_lahir,
    this.tanggal_lahir,
    this.gelar,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_lengkap': nama_lengkap,
      'jenis_kelamin': jenis_kelamin,
      'nik': nik,
      'npwp': npwp,
      'email': email,
      'nomor_hp': nomor_hp,
      'alamat': alamat,
      'suku': suku,
      'gol_darah': gol_darah,
      'tempat_lahir': tempat_lahir,
      'tanggal_lahir': tanggal_lahir,
      'gelar': gelar,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory BiodataProfil.fromMap(Map<String, dynamic> map) {
    return BiodataProfil(
      id: map['id'],
      nama_lengkap: map['nama_lengkap'],
      jenis_kelamin: map['jenis_kelamin'],
      nik: map['nik'],
      npwp: map['npwp'],
      email: map['email'],
      nomor_hp: map['nomor_hp'],
      alamat: map['alamat'],
      suku: map['suku'],
      gol_darah: map['gol_darah'],
      tempat_lahir: map['tempat_lahir'],
      tanggal_lahir: map['tanggal_lahir'],
      gelar: map['gelar'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BiodataProfil.fromJson(String source) =>
      BiodataProfil.fromMap(json.decode(source));
}

class MasajabatProfil {
  int id;
  String id_angka;
  int id_talenta;
  String jabatan;
  String nomor;
  String tanggal_awal;
  String tanggal_akhir;
  String instansi;
  String asal_instansi;
  int periode;
  String tanggal_sk;
  String kategori_pangkat;
  String aktifpejabat;
  String created_at;
  String updated_at;
  MasajabatProfil({
    this.id,
    this.id_angka,
    this.id_talenta,
    this.jabatan,
    this.nomor,
    this.tanggal_awal,
    this.tanggal_akhir,
    this.instansi,
    this.asal_instansi,
    this.periode,
    this.tanggal_sk,
    this.kategori_pangkat,
    this.aktifpejabat,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_angka': id_angka,
      'id_talenta': id_talenta,
      'jabatan': jabatan,
      'nomor': nomor,
      'tanggal_awal': tanggal_awal,
      'tanggal_akhir': tanggal_akhir,
      'instansi': instansi,
      'asal_instansi': asal_instansi,
      'periode': periode,
      'tanggal_sk': tanggal_sk,
      'kategori_pangkat': kategori_pangkat,
      'aktifpejabat': aktifpejabat,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory MasajabatProfil.fromMap(Map<String, dynamic> map) {
    return MasajabatProfil(
      id: map['id'],
      id_angka: map['id_angka'],
      id_talenta: map['id_talenta'],
      jabatan: map['jabatan'],
      nomor: map['nomor'],
      tanggal_awal: map['tanggal_awal'],
      tanggal_akhir: map['tanggal_akhir'],
      instansi: map['instansi'],
      asal_instansi: map['asal_instansi'],
      periode: map['periode'],
      tanggal_sk: map['tanggal_sk'],
      kategori_pangkat: map['kategori_pangkat'],
      aktifpejabat: map['aktifpejabat'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MasajabatProfil.fromJson(String source) =>
      MasajabatProfil.fromMap(json.decode(source));
}

class PendidikanProfil {
  int id;
  int id_talenta;
  int id_jenjang_pendidikan;
  String perguruan_tinggi;
  String penjurusan;
  String kota;
  String negara;
  String penghargaan;
  int tahun;
  int id_universitas;
  int id_kota;
  String nama;
  String created_at;
  String updated_at;
  PendidikanProfil({
    this.id,
    this.id_talenta,
    this.id_jenjang_pendidikan,
    this.perguruan_tinggi,
    this.penjurusan,
    this.kota,
    this.negara,
    this.penghargaan,
    this.tahun,
    this.id_universitas,
    this.id_kota,
    this.nama,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'id_jenjang_pendidikan': id_jenjang_pendidikan,
      'perguruan_tinggi': perguruan_tinggi,
      'penjurusan': penjurusan,
      'kota': kota,
      'negara': negara,
      'penghargaan': penghargaan,
      'tahun': tahun,
      'id_universitas': id_universitas,
      'id_kota': id_kota,
      'nama': nama,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory PendidikanProfil.fromMap(Map<String, dynamic> map) {
    return PendidikanProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      id_jenjang_pendidikan: map['id_jenjang_pendidikan'],
      perguruan_tinggi: map['perguruan_tinggi'],
      penjurusan: map['penjurusan'],
      kota: map['kota'],
      negara: map['negara'],
      penghargaan: map['penghargaan'],
      tahun: map['tahun'],
      id_universitas: map['id_universitas'],
      id_kota: map['id_kota'],
      nama: map['nama'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PendidikanProfil.fromJson(String source) =>
      PendidikanProfil.fromMap(json.decode(source));
}

class PelatihanProfil {
  int id;
  int id_talenta;
  String pengembangan_kompetensi;
  int lama_hari;
  String kota;
  String penyelenggara;
  String nomor_sertifikasi;
  String jenis_diklat;
  int id_kota;
  String created_at;
  String updated_at;
  PelatihanProfil({
    this.id,
    this.id_talenta,
    this.pengembangan_kompetensi,
    this.lama_hari,
    this.kota,
    this.penyelenggara,
    this.nomor_sertifikasi,
    this.jenis_diklat,
    this.id_kota,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'pengembangan_kompetensi': pengembangan_kompetensi,
      'lama_hari': lama_hari,
      'kota': kota,
      'penyelenggara': penyelenggara,
      'nomor_sertifikasi': nomor_sertifikasi,
      'jenis_diklat': jenis_diklat,
      'id_kota': id_kota,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory PelatihanProfil.fromMap(Map<String, dynamic> map) {
    return PelatihanProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      pengembangan_kompetensi: map['pengembangan_kompetensi'],
      lama_hari: map['lama_hari'],
      kota: map['kota'],
      penyelenggara: map['penyelenggara'],
      nomor_sertifikasi: map['nomor_sertifikasi'],
      jenis_diklat: map['jenis_diklat'],
      id_kota: map['id_kota'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PelatihanProfil.fromJson(String source) =>
      PelatihanProfil.fromMap(json.decode(source));
}

class JabatanLainProfil {
  int id;
  int id_talenta;
  String penugasan;
  String tupoksi;
  String tanggal_awal;
  String tanggal_akhir;
  String instansi;
  String created_at;
  String updated_at;
  JabatanLainProfil({
    this.id,
    this.id_talenta,
    this.penugasan,
    this.tupoksi,
    this.tanggal_awal,
    this.tanggal_akhir,
    this.instansi,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'penugasan': penugasan,
      'tupoksi': tupoksi,
      'tanggal_awal': tanggal_awal,
      'tanggal_akhir': tanggal_akhir,
      'instansi': instansi,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory JabatanLainProfil.fromMap(Map<String, dynamic> map) {
    return JabatanLainProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      penugasan: map['penugasan'],
      tupoksi: map['tupoksi'],
      tanggal_awal: map['tanggal_awal'],
      tanggal_akhir: map['tanggal_akhir'],
      instansi: map['instansi'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JabatanLainProfil.fromJson(String source) =>
      JabatanLainProfil.fromMap(json.decode(source));
}

class KeluargaProfil {
  int id;
  int id_talenta;
  String nama;
  String tempat_lahir;
  String tanggal_lahir;
  String tanggal_menikah;
  String pekerjaan;
  String keterangan;
  String hubungan_keluarga;
  String jenis_kelamin;
  int id_kota;
  String created_at;
  String updated_at;
  KeluargaProfil({
    this.id,
    this.id_talenta,
    this.nama,
    this.tempat_lahir,
    this.tanggal_lahir,
    this.tanggal_menikah,
    this.pekerjaan,
    this.keterangan,
    this.hubungan_keluarga,
    this.jenis_kelamin,
    this.id_kota,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'nama': nama,
      'tempat_lahir': tempat_lahir,
      'tanggal_lahir': tanggal_lahir,
      'tanggal_menikah': tanggal_menikah,
      'pekerjaan': pekerjaan,
      'keterangan': keterangan,
      'hubungan_keluarga': hubungan_keluarga,
      'jenis_kelamin': jenis_kelamin,
      'id_kota': id_kota,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory KeluargaProfil.fromMap(Map<String, dynamic> map) {
    return KeluargaProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      nama: map['nama'],
      tempat_lahir: map['tempat_lahir'],
      tanggal_lahir: map['tanggal_lahir'],
      tanggal_menikah: map['tanggal_menikah'],
      pekerjaan: map['pekerjaan'],
      keterangan: map['keterangan'],
      hubungan_keluarga: map['hubungan_keluarga'],
      jenis_kelamin: map['jenis_kelamin'],
      id_kota: map['id_kota'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KeluargaProfil.fromJson(String source) =>
      KeluargaProfil.fromMap(json.decode(source));
}

class KeahlianProfil {
  int id;
  int id_talenta;
  int id_keahlian;
  String jenis_keahlian;
  String deskripsi;
  String created_at;
  String updated_at;
  KeahlianProfil({
    this.id,
    this.id_talenta,
    this.id_keahlian,
    this.jenis_keahlian,
    this.deskripsi,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'id_keahlian': id_keahlian,
      'jenis_keahlian': jenis_keahlian,
      'deskripsi': deskripsi,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory KeahlianProfil.fromMap(Map<String, dynamic> map) {
    return KeahlianProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      id_keahlian: map['id_keahlian'],
      jenis_keahlian: map['jenis_keahlian'],
      deskripsi: map['deskripsi'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KeahlianProfil.fromJson(String source) =>
      KeahlianProfil.fromMap(json.decode(source));
}

class InterestProfil {
  int id;
  int id_talenta;
  String ekonomi;
  String leadership;
  String sosial;
  String created_at;
  String updated_at;
  InterestProfil({
    this.id,
    this.id_talenta,
    this.ekonomi,
    this.leadership,
    this.sosial,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'ekonomi': ekonomi,
      'leadership': leadership,
      'sosial': sosial,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory InterestProfil.fromMap(Map<String, dynamic> map) {
    return InterestProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      ekonomi: map['ekonomi'],
      leadership: map['leadership'],
      sosial: map['sosial'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestProfil.fromJson(String source) =>
      InterestProfil.fromMap(json.decode(source));
}

class OrganisasiFormalProfil {
  int id;
  int id_talenta;
  String nama_organisasi;
  String jabatan;
  String kegiatan_organisasi;
  String tanggal_awal;
  String tanggal_akhir;
  String created_at;
  String updated_at;
  OrganisasiFormalProfil({
    this.id,
    this.id_talenta,
    this.nama_organisasi,
    this.jabatan,
    this.kegiatan_organisasi,
    this.tanggal_awal,
    this.tanggal_akhir,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'nama_organisasi': nama_organisasi,
      'jabatan': jabatan,
      'kegiatan_organisasi': kegiatan_organisasi,
      'tanggal_awal': tanggal_awal,
      'tanggal_akhir': tanggal_akhir,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory OrganisasiFormalProfil.fromMap(Map<String, dynamic> map) {
    return OrganisasiFormalProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      nama_organisasi: map['nama_organisasi'],
      jabatan: map['jabatan'],
      kegiatan_organisasi: map['kegiatan_organisasi'],
      tanggal_awal: map['tanggal_awal'],
      tanggal_akhir: map['tanggal_akhir'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganisasiFormalProfil.fromJson(String source) =>
      OrganisasiFormalProfil.fromMap(json.decode(source));
}

class PenghargaanProfil {
  int id;
  int id_talenta;
  String jenis_penghargaan;
  String tingkat;
  String pemberi_penghargaan;
  int tahun;
  String created_at;
  String updated_at;
  PenghargaanProfil({
    this.id,
    this.id_talenta,
    this.jenis_penghargaan,
    this.tingkat,
    this.pemberi_penghargaan,
    this.tahun,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'jenis_penghargaan': jenis_penghargaan,
      'tingkat': tingkat,
      'pemberi_penghargaan': pemberi_penghargaan,
      'tahun': tahun,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory PenghargaanProfil.fromMap(Map<String, dynamic> map) {
    return PenghargaanProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      jenis_penghargaan: map['jenis_penghargaan'],
      tingkat: map['tingkat'],
      pemberi_penghargaan: map['pemberi_penghargaan'],
      tahun: map['tahun'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PenghargaanProfil.fromJson(String source) =>
      PenghargaanProfil.fromMap(json.decode(source));
}

class PajakProfil {
  int id;
  int id_talenta;
  String file_name;
  int tahun;
  String created_at;
  String updated_at;
  PajakProfil({
    this.id,
    this.id_talenta,
    this.file_name,
    this.tahun,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'file_name': file_name,
      'tahun': tahun,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory PajakProfil.fromMap(Map<String, dynamic> map) {
    return PajakProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      file_name: map['file_name'],
      tahun: map['tahun'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PajakProfil.fromJson(String source) =>
      PajakProfil.fromMap(json.decode(source));
}

class SummaryProfil {
  int id;
  int id_talenta;
  String kompetensi;
  String kepribadian;
  String created_at;
  String updated_at;
  SummaryProfil({
    this.id,
    this.id_talenta,
    this.kompetensi,
    this.kepribadian,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'kompetensi': kompetensi,
      'kepribadian': kepribadian,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory SummaryProfil.fromMap(Map<String, dynamic> map) {
    return SummaryProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      kompetensi: map['kompetensi'],
      kepribadian: map['kepribadian'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryProfil.fromJson(String source) =>
      SummaryProfil.fromMap(json.decode(source));
}

class KaryaIlmiahProfil {
  int id;
  int id_talenta;
  String judul;
  String media_publikasi;
  int tahun;
  String created_at;
  String updated_at;
  KaryaIlmiahProfil({
    this.id,
    this.id_talenta,
    this.judul,
    this.media_publikasi,
    this.tahun,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'judul': judul,
      'media_publikasi': media_publikasi,
      'tahun': tahun,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory KaryaIlmiahProfil.fromMap(Map<String, dynamic> map) {
    return KaryaIlmiahProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      judul: map['judul'],
      media_publikasi: map['media_publikasi'],
      tahun: map['tahun'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KaryaIlmiahProfil.fromJson(String source) =>
      KaryaIlmiahProfil.fromMap(json.decode(source));
}

class PengalamanLainProfil {
  int id;
  int id_talenta;
  String acara;
  String penyelenggara;
  int periode;
  String lokasi;
  String peserta;
  String created_at;
  String updated_at;
  PengalamanLainProfil({
    this.id,
    this.id_talenta,
    this.acara,
    this.penyelenggara,
    this.periode,
    this.lokasi,
    this.peserta,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'acara': acara,
      'penyelenggara': penyelenggara,
      'periode': periode,
      'lokasi': lokasi,
      'peserta': peserta,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory PengalamanLainProfil.fromMap(Map<String, dynamic> map) {
    return PengalamanLainProfil(
      id: map['id'],
      id_talenta: map['id_talenta'],
      acara: map['acara'],
      penyelenggara: map['penyelenggara'],
      periode: map['periode'],
      lokasi: map['lokasi'],
      peserta: map['peserta'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PengalamanLainProfil.fromJson(String source) =>
      PengalamanLainProfil.fromMap(json.decode(source));
}

class OrganisasiNonFormal {
  int id;
  int id_talenta;
  String nama_organisasi;
  String jabatan;
  String kegiatan_organisasi;
  String tanggal_awal;
  String tanggal_akhir;
  String created_at;
  String updated_at;
  OrganisasiNonFormal({
    this.id,
    this.id_talenta,
    this.nama_organisasi,
    this.jabatan,
    this.kegiatan_organisasi,
    this.tanggal_awal,
    this.tanggal_akhir,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_talenta': id_talenta,
      'nama_organisasi': nama_organisasi,
      'jabatan': jabatan,
      'kegiatan_organisasi': kegiatan_organisasi,
      'tanggal_awal': tanggal_awal,
      'tanggal_akhir': tanggal_akhir,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory OrganisasiNonFormal.fromMap(Map<String, dynamic> map) {
    return OrganisasiNonFormal(
      id: map['id'],
      id_talenta: map['id_talenta'],
      nama_organisasi: map['nama_organisasi'],
      jabatan: map['jabatan'],
      kegiatan_organisasi: map['kegiatan_organisasi'],
      tanggal_awal: map['tanggal_awal'],
      tanggal_akhir: map['tanggal_akhir'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganisasiNonFormal.fromJson(String source) =>
      OrganisasiNonFormal.fromMap(json.decode(source));
}

class ProfilPejabatModel {
  BiodataProfil biodata;
  List<MasajabatProfil> masajabat;
  List<PendidikanProfil> pendidikan;
  List<PelatihanProfil> pelatihan;
  List<JabatanLainProfil> jabatanlain;
  List<KeahlianProfil> keahlian;
  List<InterestProfil> interest;
  List<OrganisasiFormalProfil> organisasiformal;
  List<OrganisasiNonFormal> organisasinonformal;
  List<PenghargaanProfil> penghargaan;
  List<KaryaIlmiahProfil> karyailmiah;
  List<PengalamanLainProfil> pengalamanlain;
  List<KeluargaProfil> keluarga;
  List<SummaryProfil> summary;
  List<PajakProfil> pajak;
  ProfilPejabatModel({
    this.biodata,
    this.masajabat,
    this.pendidikan,
    this.pelatihan,
    this.jabatanlain,
    this.keahlian,
    this.interest,
    this.organisasiformal,
    this.organisasinonformal,
    this.penghargaan,
    this.karyailmiah,
    this.pengalamanlain,
    this.keluarga,
    this.summary,
    this.pajak,
  });

  Map<String, dynamic> toMap() {
    return {
      'biodata': biodata.toMap(),
      'masajabat': masajabat?.map((x) => x.toMap())?.toList(),
      'pendidikan': pendidikan?.map((x) => x.toMap())?.toList(),
      'pelatihan': pelatihan?.map((x) => x.toMap())?.toList(),
      'jabatanlain': jabatanlain?.map((x) => x.toMap())?.toList(),
      'keahlian': keahlian?.map((x) => x.toMap())?.toList(),
      'interest': interest?.map((x) => x.toMap())?.toList(),
      'organisasiformal': organisasiformal?.map((x) => x.toMap())?.toList(),
      'organisasinonformal':
          organisasinonformal?.map((x) => x.toMap())?.toList(),
      'penghargaan': penghargaan?.map((x) => x.toMap())?.toList(),
      'karyailmiah': karyailmiah?.map((x) => x.toMap())?.toList(),
      'pengalamanlain': pengalamanlain?.map((x) => x.toMap())?.toList(),
      'keluarga': keluarga?.map((x) => x.toMap())?.toList(),
      'summary': summary?.map((x) => x.toMap())?.toList(),
      'pajak': pajak?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ProfilPejabatModel.fromMap(Map<String, dynamic> map) {
    return ProfilPejabatModel(
      biodata: BiodataProfil.fromMap(map['biodata']),
      masajabat: List<MasajabatProfil>.from(
          map['masajabat']?.map((x) => MasajabatProfil.fromMap(x))),
      pendidikan: List<PendidikanProfil>.from(
          map['pendidikan']?.map((x) => PendidikanProfil.fromMap(x))),
      pelatihan: List<PelatihanProfil>.from(
          map['pelatihan']?.map((x) => PelatihanProfil.fromMap(x))),
      jabatanlain: List<JabatanLainProfil>.from(
          map['jabatanlain']?.map((x) => JabatanLainProfil.fromMap(x))),
      keahlian: List<KeahlianProfil>.from(
          map['keahlian']?.map((x) => KeahlianProfil.fromMap(x))),
      interest: List<InterestProfil>.from(
          map['interest']?.map((x) => InterestProfil.fromMap(x))),
      organisasiformal: List<OrganisasiFormalProfil>.from(
          map['organisasiformal']
              ?.map((x) => OrganisasiFormalProfil.fromMap(x))),
      organisasinonformal: List<OrganisasiNonFormal>.from(
          map['organisasinonformal']
              ?.map((x) => OrganisasiNonFormal.fromMap(x))),
      penghargaan: List<PenghargaanProfil>.from(
          map['penghargaan']?.map((x) => PenghargaanProfil.fromMap(x))),
      karyailmiah: List<KaryaIlmiahProfil>.from(
          map['karyailmiah']?.map((x) => KaryaIlmiahProfil.fromMap(x))),
      pengalamanlain: List<PengalamanLainProfil>.from(
          map['pengalamanlain']?.map((x) => PengalamanLainProfil.fromMap(x))),
      keluarga: List<KeluargaProfil>.from(
          map['keluarga']?.map((x) => KeluargaProfil.fromMap(x))),
      summary: List<SummaryProfil>.from(
          map['summary']?.map((x) => SummaryProfil.fromMap(x))),
      pajak: List<PajakProfil>.from(
          map['pajak']?.map((x) => PajakProfil.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfilPejabatModel.fromJson(String source) =>
      ProfilPejabatModel.fromMap(json.decode(source));
}
