// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pk_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PkItem _$PkItemFromJson(Map<String, dynamic> json) {
  return PkItem(
    companyId: json['id_angka'] as String,
    nama: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    satuan: json['satuan'] as String,
    lancar: json['lancar'] as String,
    kurangLancar: json['kurang_lancar'] as String,
    diragukan: json['diragukan'] as String,
    macet: json['macet'] as String,
    kota: json['kota'] as String,
    realisasi: json['realisasi'] as String,
    propinsi: json['propinsi'] as String,
    sektorUsaha: json['sektor_usaha'] as String,
    cluster: json['cluster_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
    sektorId: json['sektor_id'] as String,
    sektorBumn: json['sektor_bumn'] as String,
    kodeKategori: json['kode_kategori'] as int,
    lat: json['lat'] as String,
    lng: json['lng'] as String,
  );
}
