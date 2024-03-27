// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kinerja_perusahaan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KinerjaPerusahaan _$KinerjaPerusahaanFromJson(Map<String, dynamic> json) {
  return KinerjaPerusahaan(
    id: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    jumlah: json['jumlah'] as String,
    satuan: json['satuan'] as String,
    jenisAkun: json['jenis_akun'] as String,
    clusterBumn: json['cluster_bumn'] as String,
    wamenBumn: json['wamen_bumn'] as String,
    category: json['kategori'] as String,
  );
}

Map<String, dynamic> _$KinerjaPerusahaanToJson(KinerjaPerusahaan instance) =>
    <String, dynamic>{
      'id_angka': instance.id,
      'nama_lengkap': instance.namaPerusahaan,
      'tahun': instance.tahun,
      'jumlah': instance.jumlah,
      'satuan': instance.satuan,
      'jenis_akun': instance.jenisAkun,
      'cluster_bumn': instance.clusterBumn,
      'wamen_bumn': instance.wamenBumn,
      'kategori': instance.category,
    };
