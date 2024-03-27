// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anggaran.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Anggaran _$AnggaranFromJson(Map<String, dynamic> json) {
  return Anggaran(
    companyName: json['nama_lengkap'] as String,
    companyId: json['id_angka'] as String,
    tahun: json['tahun'] as int,
    realisasi: json['realisasi'] as String,
    jenisAkun: json['jenis_akun'] as String,
    rencana: json['rencana'] as String,
  );
}
