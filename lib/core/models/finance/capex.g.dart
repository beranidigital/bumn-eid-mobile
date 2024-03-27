// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Capex _$CapexFromJson(Map<String, dynamic> json) {
  return Capex(
    id: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as String,
    jumlah: json['jumlah'] as String,
    periodeNama: json['periode_nama'] as String,
    satuan: json['satuan'] as String,
    cluster: json['cluster_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
  );
}
