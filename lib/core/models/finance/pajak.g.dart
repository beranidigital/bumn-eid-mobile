// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pajak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pajak _$PajakFromJson(Map<String, dynamic> json) {
  return Pajak(
    id: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as String,
    jumlah: json['jumlah'] as int,
    satuan: json['satuan'] as String,
    cluster: json['cluster_bumn'] as String,
    wamen: json['wamen_bumn'] as String,
    periodeNama: json['periode_nama'] as String,
  );
}
