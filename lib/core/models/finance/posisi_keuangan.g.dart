// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posisi_keuangan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosisiKeuangan _$PosisiKeuanganFromJson(Map<String, dynamic> json) {
  return PosisiKeuangan(
    id: json['id_angka'] as String,
    namaPerusahaan: json['nama_lengkap'] as String,
    tahun: json['tahun'] as int,
    jumlah: json['jumlah'] as String,
    satuan: json['satuan'] as String,
    cluster: json['cluster_bumn'] as String,
    sektor: json['sektor_bumn'] as String,
    periodeNama: json['periode_nama'] as String,
  );
}
