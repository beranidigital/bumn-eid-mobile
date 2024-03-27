import 'dart:convert';

class KetPerusahaan {
  int total;
  int total_karyawan;
  int boc;
  int bod;
  KetPerusahaan({
    this.total,
    this.total_karyawan,
    this.boc,
    this.bod,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'total_karyawan': total_karyawan,
      'boc': boc,
      'bod': bod,
    };
  }

  factory KetPerusahaan.fromMap(Map<String, dynamic> map) {
    return KetPerusahaan(
      total: map['total'],
      total_karyawan: map['total_karyawan'],
      boc: map['boc'],
      bod: map['bod'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KetPerusahaan.fromJson(String source) =>
      KetPerusahaan.fromMap(json.decode(source));
}

class KetTalentPool {
  int total_talent;
  int selected;
  int nominated;
  int eligible;
  int ready;
  int bod_minus_1;
  KetTalentPool({
    this.total_talent,
    this.selected,
    this.nominated,
    this.eligible,
    this.ready,
    this.bod_minus_1,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_talent': total_talent,
      'selected': selected,
      'nominated': nominated,
      'eligible': eligible,
      'ready': ready,
      'bod_minus_1': bod_minus_1,
    };
  }

  factory KetTalentPool.fromMap(Map<String, dynamic> map) {
    return KetTalentPool(
      total_talent: map['total_talent'],
      selected: map['selected'],
      nominated: map['nominated'],
      eligible: map['eligible'],
      ready: map['ready'],
      bod_minus_1: map['bod_minus_1'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KetTalentPool.fromJson(String source) =>
      KetTalentPool.fromMap(json.decode(source));
}

class KetSummary {
  int total_perusahaan;
  int total_anggaran;
  int total_karyawan;
  int total_boc;
  int total_bod;
  int total_bod_minus_1;
  KetSummary({
    this.total_perusahaan,
    this.total_anggaran,
    this.total_karyawan,
    this.total_boc,
    this.total_bod,
    this.total_bod_minus_1,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_perusahaan': total_perusahaan,
      'total_anggaran': total_anggaran,
      'total_karyawan': total_karyawan,
      'total_boc': total_boc,
      'total_bod': total_bod,
      'total_bod_minus_1': total_bod_minus_1,
    };
  }

  factory KetSummary.fromMap(Map<String, dynamic> map) {
    return KetSummary(
      total_perusahaan: map['total_perusahaan'],
      total_anggaran: map['total_anggaran'],
      total_karyawan: map['total_karyawan'],
      total_boc: map['total_boc'],
      total_bod: map['total_bod'],
      total_bod_minus_1: map['total_bod_minus_1'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KetSummary.fromJson(String source) =>
      KetSummary.fromMap(json.decode(source));
}

class KetJenisKelamin {
  String jenis_kelamin;
  int total;
  KetJenisKelamin({
    this.jenis_kelamin,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'jenis_kelamin': jenis_kelamin,
      'total': total,
    };
  }

  factory KetJenisKelamin.fromMap(Map<String, dynamic> map) {
    return KetJenisKelamin(
      jenis_kelamin: map['jenis_kelamin'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KetJenisKelamin.fromJson(String source) =>
      KetJenisKelamin.fromMap(json.decode(source));
}

class KetKelompokUsia {
  int under_30;
  int between_30_39;
  int between_40_49;
  int above_50;
  KetKelompokUsia({
    this.under_30,
    this.between_30_39,
    this.between_40_49,
    this.above_50,
  });

  Map<String, dynamic> toMap() {
    return {
      'under_30': under_30,
      'between_30_39': between_30_39,
      'between_40_49': between_40_49,
      'above_50': above_50,
    };
  }

  factory KetKelompokUsia.fromMap(Map<String, dynamic> map) {
    return KetKelompokUsia(
      under_30: map['under_30'],
      between_30_39: map['between_30_39'],
      between_40_49: map['between_40_49'],
      above_50: map['above_50'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KetKelompokUsia.fromJson(String source) =>
      KetKelompokUsia.fromMap(json.decode(source));
}

class KetStatusKaryawan {
  String kategori_pangkat;
  int total;
  KetStatusKaryawan({
    this.kategori_pangkat,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'kategori_pangkat': kategori_pangkat,
      'total': total,
    };
  }

  factory KetStatusKaryawan.fromMap(Map<String, dynamic> map) {
    return KetStatusKaryawan(
      kategori_pangkat: map['kategori_pangkat'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KetStatusKaryawan.fromJson(String source) =>
      KetStatusKaryawan.fromMap(json.decode(source));
}

class KetPersebaranUsiaGender {
  List<KetJenisKelamin> under_30;
  List<KetJenisKelamin> between_30_39;
  List<KetJenisKelamin> between_40_49;
  List<KetJenisKelamin> above_50;
  KetPersebaranUsiaGender({
    this.under_30,
    this.between_30_39,
    this.between_40_49,
    this.above_50,
  });

  Map<String, dynamic> toMap() {
    return {
      'under_30': under_30?.map((x) => x.toMap())?.toList(),
      'between_30_39': between_30_39?.map((x) => x.toMap())?.toList(),
      'between_40_49': between_40_49?.map((x) => x.toMap())?.toList(),
      'above_50': above_50?.map((x) => x.toMap())?.toList(),
    };
  }

  factory KetPersebaranUsiaGender.fromMap(Map<String, dynamic> map) {
    return KetPersebaranUsiaGender(
      under_30: List<KetJenisKelamin>.from(
          map['under_30']?.map((x) => KetJenisKelamin.fromMap(x))),
      between_30_39: List<KetJenisKelamin>.from(
          map['between_30_39']?.map((x) => KetJenisKelamin.fromMap(x))),
      between_40_49: List<KetJenisKelamin>.from(
          map['between_40_49']?.map((x) => KetJenisKelamin.fromMap(x))),
      above_50: List<KetJenisKelamin>.from(
          map['above_50']?.map((x) => KetJenisKelamin.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory KetPersebaranUsiaGender.fromJson(String source) =>
      KetPersebaranUsiaGender.fromMap(json.decode(source));
}

class KetDahsboard {
  KetPerusahaan perusahaan_induk;
  KetPerusahaan perusahaan_anak;
  KetPerusahaan perusahaan_cucu;
  KetTalentPool talent_pool;
  KetDahsboard({
    this.perusahaan_induk,
    this.perusahaan_anak,
    this.perusahaan_cucu,
    this.talent_pool,
  });

  Map<String, dynamic> toMap() {
    return {
      'perusahaan_induk': perusahaan_induk.toMap(),
      'perusahaan_anak': perusahaan_anak.toMap(),
      'perusahaan_cucu': perusahaan_cucu.toMap(),
      'talent_pool': talent_pool.toMap(),
    };
  }

  factory KetDahsboard.fromMap(Map<String, dynamic> map) {
    return KetDahsboard(
      perusahaan_induk: KetPerusahaan.fromMap(map['perusahaan_induk']),
      perusahaan_anak: KetPerusahaan.fromMap(map['perusahaan_anak']),
      perusahaan_cucu: KetPerusahaan.fromMap(map['perusahaan_cucu']),
      talent_pool: KetTalentPool.fromMap(map['talent_pool']),
    );
  }

  String toJson() => json.encode(toMap());

  factory KetDahsboard.fromJson(String source) =>
      KetDahsboard.fromMap(json.decode(source));
}

class KetSummaryDashboard {
  KetSummary summary;
  KetPersebaranUsiaGender persebaran_usia_gender;
  List<KetJenisKelamin> gender_perusahaan_induk;
  KetKelompokUsia kelompok_usia;
  List<KetStatusKaryawan> status_karyawan;
  KetSummaryDashboard({
    this.summary,
    this.persebaran_usia_gender,
    this.gender_perusahaan_induk,
    this.kelompok_usia,
    this.status_karyawan,
  });

  Map<String, dynamic> toMap() {
    return {
      'summary': summary.toMap(),
      'persebaran_usia_gender': persebaran_usia_gender.toMap(),
      'gender_perusahaan_induk':
          gender_perusahaan_induk?.map((x) => x.toMap())?.toList(),
      'kelompok_usia': kelompok_usia.toMap(),
      'status_karyawan': status_karyawan?.map((x) => x.toMap())?.toList(),
    };
  }

  factory KetSummaryDashboard.fromMap(Map<String, dynamic> map) {
    return KetSummaryDashboard(
      summary: KetSummary.fromMap(map['summary']),
      persebaran_usia_gender:
          KetPersebaranUsiaGender.fromMap(map['persebaran_usia_gender']),
      gender_perusahaan_induk: List<KetJenisKelamin>.from(
          map['gender_perusahaan_induk']
              ?.map((x) => KetJenisKelamin.fromMap(x))),
      kelompok_usia: KetKelompokUsia.fromMap(map['kelompok_usia']),
      status_karyawan: List<KetStatusKaryawan>.from(
          map['status_karyawan']?.map((x) => KetStatusKaryawan.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory KetSummaryDashboard.fromJson(String source) =>
      KetSummaryDashboard.fromMap(json.decode(source));
}

class HCMainPage {
  KetDahsboard dahsboard;
  KetSummaryDashboard summary;
  HCMainPage({
    this.dahsboard,
    this.summary,
  });

  Map<String, dynamic> toMap() {
    return {
      'dahsboard': dahsboard.toMap(),
      'summary': summary.toMap(),
    };
  }

  factory HCMainPage.fromMap(Map<String, dynamic> map) {
    return HCMainPage(
      dahsboard: KetDahsboard.fromMap(map['dahsboard']),
      summary: KetSummaryDashboard.fromMap(map['summary']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HCMainPage.fromJson(String source) =>
      HCMainPage.fromMap(json.decode(source));
}
