// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ebitda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ebitda _$EbitdaFromJson(Map<String, dynamic> json) {
  return Ebitda(
    id: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    jumlah: json['jumlah'] as int,
    satuan: json['satuan'] as String,
    cluster: json['cluster_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
    periodeNama: json['periode_nama'] as String,
  );
}
