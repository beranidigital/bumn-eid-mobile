import 'dart:convert';

import 'package:bumn_eid/irwan_dev/hc/models/detail_bumn_talent.dart';

class KetRelasiPerusahaan {
  String id_angka;
  String bumn_name;
  KetRelasiPerusahaan({
    this.id_angka,
    this.bumn_name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_angka': id_angka,
      'bumn_name': bumn_name,
    };
  }

  factory KetRelasiPerusahaan.fromMap(Map<String, dynamic> map) {
    return KetRelasiPerusahaan(
      id_angka: map['id_angka'],
      bumn_name: map['bumn_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KetRelasiPerusahaan.fromJson(String source) =>
      KetRelasiPerusahaan.fromMap(json.decode(source));
}

class RelasiPerusahaanProfilBUMN {
  int level_perusahaan;
  List<KetRelasiPerusahaan> daftar_induk;
  List<KetRelasiPerusahaan> daftar_anak;
  List<KetRelasiPerusahaan> daftar_cucu;
  RelasiPerusahaanProfilBUMN({
    this.level_perusahaan,
    this.daftar_induk,
    this.daftar_anak,
    this.daftar_cucu,
  });

  Map<String, dynamic> toMap() {
    return {
      'level_perusahaan': level_perusahaan,
      'daftar_induk': daftar_induk?.map((x) => x.toMap())?.toList(),
      'daftar_anak': daftar_anak?.map((x) => x.toMap())?.toList(),
      'daftar_cucu': daftar_cucu?.map((x) => x.toMap())?.toList(),
    };
  }

  factory RelasiPerusahaanProfilBUMN.fromMap(Map<String, dynamic> map) {
    return RelasiPerusahaanProfilBUMN(
      level_perusahaan: map['level_perusahaan'],
      daftar_induk: List<KetRelasiPerusahaan>.from(
          map['daftar_induk']?.map((x) => KetRelasiPerusahaan.fromMap(x))),
      daftar_anak: List<KetRelasiPerusahaan>.from(
          map['daftar_anak']?.map((x) => KetRelasiPerusahaan.fromMap(x))),
      daftar_cucu: List<KetRelasiPerusahaan>.from(
          map['daftar_cucu']?.map((x) => KetRelasiPerusahaan.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RelasiPerusahaanProfilBUMN.fromJson(String source) =>
      RelasiPerusahaanProfilBUMN.fromMap(json.decode(source));
}

class DetailProfilBUMN {
  RelasiPerusahaanProfilBUMN relasi_perusahaan;
  List<DetailBUMNTalent> daftar_komisaris;
  List<DetailBUMNTalent> daftar_direksi;
  DetailProfilBUMN({
    this.relasi_perusahaan,
    this.daftar_komisaris,
    this.daftar_direksi,
  });

  Map<String, dynamic> toMap() {
    return {
      'relasi_perusahaan': relasi_perusahaan.toMap(),
      'daftar_komisaris': daftar_komisaris?.map((x) => x.toMap())?.toList(),
      'daftar_direksi': daftar_direksi?.map((x) => x.toMap())?.toList(),
    };
  }

  factory DetailProfilBUMN.fromMap(Map<String, dynamic> map) {
    return DetailProfilBUMN(
      relasi_perusahaan:
          RelasiPerusahaanProfilBUMN.fromMap(map['relasi_perusahaan']),
      daftar_komisaris: List<DetailBUMNTalent>.from(
          map['daftar_komisaris']?.map((x) => DetailBUMNTalent.fromMap(x))),
      daftar_direksi: List<DetailBUMNTalent>.from(
          map['daftar_direksi']?.map((x) => DetailBUMNTalent.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailProfilBUMN.fromJson(String source) =>
      DetailProfilBUMN.fromMap(json.decode(source));
}
