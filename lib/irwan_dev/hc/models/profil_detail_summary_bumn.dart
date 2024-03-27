import 'dart:convert';

import 'package:bumn_eid/irwan_dev/hc/models/hc_main_page.dart';

class UsiaGender {
  String jenis_kelamin;
  int total;
  UsiaGender({
    this.jenis_kelamin,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'jenis_kelamin': jenis_kelamin,
      'total': total,
    };
  }

  factory UsiaGender.fromMap(Map<String, dynamic> map) {
    return UsiaGender(
      jenis_kelamin: map['jenis_kelamin'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsiaGender.fromJson(String source) =>
      UsiaGender.fromMap(json.decode(source));
}

class PersebaranUsiaProfilBUMN {
  List<UsiaGender> under_30;
  List<UsiaGender> between_30_39;
  List<UsiaGender> between_40_49;
  List<UsiaGender> above_50;
  PersebaranUsiaProfilBUMN({
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

  factory PersebaranUsiaProfilBUMN.fromMap(Map<String, dynamic> map) {
    return PersebaranUsiaProfilBUMN(
      under_30: List<UsiaGender>.from(
          map['under_30']?.map((x) => UsiaGender.fromMap(x))),
      between_30_39: List<UsiaGender>.from(
          map['between_30_39']?.map((x) => UsiaGender.fromMap(x))),
      between_40_49: List<UsiaGender>.from(
          map['between_40_49']?.map((x) => UsiaGender.fromMap(x))),
      above_50: List<UsiaGender>.from(
          map['above_50']?.map((x) => UsiaGender.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersebaranUsiaProfilBUMN.fromJson(String source) =>
      PersebaranUsiaProfilBUMN.fromMap(json.decode(source));
}

class KelompokUsiaProfilBUMN {
  int under_30;
  int between_30_39;
  int between_40_49;
  int above_50;
  KelompokUsiaProfilBUMN({
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

  factory KelompokUsiaProfilBUMN.fromMap(Map<String, dynamic> map) {
    return KelompokUsiaProfilBUMN(
      under_30: map['under_30'],
      between_30_39: map['between_30_39'],
      between_40_49: map['between_40_49'],
      above_50: map['above_50'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KelompokUsiaProfilBUMN.fromJson(String source) =>
      KelompokUsiaProfilBUMN.fromMap(json.decode(source));
}

class TingkatPendidikanProfilBUM {
  String nama;
  int total;
  TingkatPendidikanProfilBUM({
    this.nama,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'total': total,
    };
  }

  factory TingkatPendidikanProfilBUM.fromMap(Map<String, dynamic> map) {
    return TingkatPendidikanProfilBUM(
      nama: map['nama'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TingkatPendidikanProfilBUM.fromJson(String source) =>
      TingkatPendidikanProfilBUM.fromMap(json.decode(source));
}

class TopSukuProfilBUMN {
  String suku;
  int total;
  TopSukuProfilBUMN({
    this.suku,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'suku': suku,
      'total': total,
    };
  }

  factory TopSukuProfilBUMN.fromMap(Map<String, dynamic> map) {
    return TopSukuProfilBUMN(
      suku: map['suku'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TopSukuProfilBUMN.fromJson(String source) =>
      TopSukuProfilBUMN.fromMap(json.decode(source));
}

class GolDarProfilBUMN {
  String golongan_darah;
  int total;
  GolDarProfilBUMN({
    this.golongan_darah,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'golongan_darah': golongan_darah,
      'total': total,
    };
  }

  factory GolDarProfilBUMN.fromMap(Map<String, dynamic> map) {
    return GolDarProfilBUMN(
      golongan_darah: map['golongan_darah'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GolDarProfilBUMN.fromJson(String source) =>
      GolDarProfilBUMN.fromMap(json.decode(source));
}

class SummaryProfilBUMN {
  int total_perusahaan;
  int total_anggaran_hc;
  int total_karyawan_hc;
  int total_boc;
  int total_bod;
  int total_bod_minus_1;
  KetPersebaranUsiaGender persebaran_usia_gender;
  List<UsiaGender> gender_perusahaan;
  KelompokUsiaProfilBUMN kelompok_usia;
  List<TingkatPendidikanProfilBUM> tingkat_pendidikan;
  List<TopSukuProfilBUMN> top10_suku;
  List<GolDarProfilBUMN> golongan_darah;
  SummaryProfilBUMN({
    this.total_perusahaan,
    this.total_anggaran_hc,
    this.total_karyawan_hc,
    this.total_boc,
    this.total_bod,
    this.total_bod_minus_1,
    this.persebaran_usia_gender,
    this.gender_perusahaan,
    this.kelompok_usia,
    this.tingkat_pendidikan,
    this.top10_suku,
    this.golongan_darah,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_perusahaan': total_perusahaan,
      'total_anggaran_hc': total_anggaran_hc,
      'total_karyawan_hc': total_karyawan_hc,
      'total_boc': total_boc,
      'total_bod': total_bod,
      'total_bod_minus_1': total_bod_minus_1,
      'persebaran_usia_gender': persebaran_usia_gender.toMap(),
      'gender_perusahaan': gender_perusahaan?.map((x) => x.toMap())?.toList(),
      'kelompok_usia': kelompok_usia.toMap(),
      'tingkat_pendidikan': tingkat_pendidikan?.map((x) => x.toMap())?.toList(),
      'top10_suku': top10_suku?.map((x) => x.toMap())?.toList(),
      'golongan_darah': golongan_darah?.map((x) => x.toMap())?.toList(),
    };
  }

  factory SummaryProfilBUMN.fromMap(Map<String, dynamic> map) {
    return SummaryProfilBUMN(
      total_perusahaan: map['total_perusahaan'],
      total_anggaran_hc: map['total_anggaran_hc'],
      total_karyawan_hc: map['total_karyawan_hc'],
      total_boc: map['total_boc'],
      total_bod: map['total_bod'],
      total_bod_minus_1: map['total_bod_minus_1'],
      persebaran_usia_gender:
          KetPersebaranUsiaGender.fromMap(map['persebaran_usia_gender']),
      gender_perusahaan: List<UsiaGender>.from(
          map['gender_perusahaan']?.map((x) => UsiaGender.fromMap(x))),
      kelompok_usia: KelompokUsiaProfilBUMN.fromMap(map['kelompok_usia']),
      tingkat_pendidikan: List<TingkatPendidikanProfilBUM>.from(
          map['tingkat_pendidikan']
              ?.map((x) => TingkatPendidikanProfilBUM.fromMap(x))),
      top10_suku: List<TopSukuProfilBUMN>.from(
          map['top10_suku']?.map((x) => TopSukuProfilBUMN.fromMap(x))),
      golongan_darah: List<GolDarProfilBUMN>.from(
          map['golongan_darah']?.map((x) => GolDarProfilBUMN.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryProfilBUMN.fromJson(String source) =>
      SummaryProfilBUMN.fromMap(json.decode(source));
}
