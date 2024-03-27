// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bl_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlItem _$BlItemFromJson(Map<String, dynamic> json) {
  return BlItem(
    companyId: json['id_angka'] as String,
    nama: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    satuan: json['satuan'] as String,
    realisasi: json['realisasi'] as String,
    kota: json['kota'] as String,
    propinsi: json['propinsi'] as String,
    jenisBantuan: json['jenis_bantuan'] as String,
    cluster: json['cluster_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
    sektorId: json['sektor_id'] as String,
    sektorBumn: json['sektor_bumn'] as String,
    kodeKategori: json['kode_kategori'] as int,
    lat: json['lat'] as String,
    lng: json['lng'] as String,
  );
}
