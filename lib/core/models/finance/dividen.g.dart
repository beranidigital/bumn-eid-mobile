// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dividen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dividen _$DividenFromJson(Map<String, dynamic> json) {
  return Dividen(
    id: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as String,
    jumlah: json['jumlah'] as String,
    satuan: json['satuan'] as String,
    cluster: json['cluster_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
    periodeNama: json['periode_nama'] as String,
  );
}
