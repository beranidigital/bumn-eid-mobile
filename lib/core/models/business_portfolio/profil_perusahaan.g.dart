// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profil_perusahaan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilPerusahaan _$ProfilPerusahaanFromJson(Map<String, dynamic> json) {
  return ProfilPerusahaan(
    id: json['id_angka'] as String,
    nama: json['nama_perusahaan'] as String,
    apsSector: json['aps_sector'] as String,
    beiSector: json['bei_sector'] as String,
    apsSubSector: json['aps_subsector'] as String,
    beiSubSector: json['bei_subsector'] as String,
    alamat: json['alamat'] as String,
    telepon: json['telepon'] as String,
    fax: json['faximile'] as String,
    website: json['website'] as String,
    bidangUsaha: json['bidang_usaha'] as String,
    isu: json['isu'] as String,
    group: json['groupbumn'] as String,
    logo: json['logobumn'] as String,
    max: json['max'] as String,
    cluster: json['cluster'] as String,
    wamen: json['wamen'] as String,
    excel: json['perusahaan_excel'] as String,
    sahamPemerintah: json['saham_pemerintah'] as String,
    sahamPublik: json['saham_publik'] as String,
    sektorId: json['sektor_id'] as String,
    sektorBps: json['sektor_bps'] as String,
    bisnisProses: json['proses_bisnis'] as String,
    namaPendek: json['nama_pendek'] as String,
    kelasBumn: json['kelas_bumn'] as int,
  );
}

Map<String, dynamic> _$ProfilPerusahaanToJson(ProfilPerusahaan instance) =>
    <String, dynamic>{
      'id_angka': instance.id,
      'nama_perusahaan': instance.nama,
      'aps_sector': instance.apsSector,
      'bei_sector': instance.beiSector,
      'aps_subsector': instance.apsSubSector,
      'bei_subsector': instance.beiSubSector,
      'alamat': instance.alamat,
      'telepon': instance.telepon,
      'faximile': instance.fax,
      'website': instance.website,
      'bidang_usaha': instance.bidangUsaha,
      'isu': instance.isu,
      'groupbumn': instance.group,
      'logobumn': instance.logo,
      'max': instance.max,
      'cluster': instance.cluster,
      'wamen': instance.wamen,
      'perusahaan_excel': instance.excel,
      'saham_pemerintah': instance.sahamPemerintah,
      'saham_publik': instance.sahamPublik,
      'sektor_id': instance.sektorId,
      'sektor_bps': instance.sektorBps,
      'proses_bisnis': instance.bisnisProses,
      'nama_pendek': instance.namaPendek,
      'kelas_bumn': instance.kelasBumn,
    };
