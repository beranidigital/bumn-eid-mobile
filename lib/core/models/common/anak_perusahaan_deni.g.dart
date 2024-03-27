// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anak_perusahaan_deni.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnakPerusahaanDeni _$AnakPerusahaanDeniFromJson(Map<String, dynamic> json) {
  return AnakPerusahaanDeni(
    id: json['id_angka'] as String,
    induk: json['nama_induk'] as String,
    anak: json['nama_anak'] as String,
    jumlahPejabat: json['jumlah_pejabat'] as int,
  );
}

Map<String, dynamic> _$AnakPerusahaanDeniToJson(AnakPerusahaanDeni instance) =>
    <String, dynamic>{
      'id_angka': instance.id,
      'nama_induk': instance.induk,
      'nama_anak': instance.anak,
      'jumlah_pejabat': instance.jumlahPejabat,
    };
