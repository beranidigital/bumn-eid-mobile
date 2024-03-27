// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pkbl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pkbl _$PkblFromJson(Map<String, dynamic> json) {
  return Pkbl(
    tahun: json['tahun'] as int,
    satuan: json['satuan'] as String,
    pkTersedia: json['pk_dana_tersedia'] as String,
    blTersedia: json['bl_dana_tersedia'] as String,
    pkTersalurkan: json['pk_penyaluran_dana'] as String,
    blTersalurkan: json['bl_penyaluran_dana'] as String,
  );
}
