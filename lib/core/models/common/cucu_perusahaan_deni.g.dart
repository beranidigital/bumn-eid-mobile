// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cucu_perusahaan_deni.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CucuPerusahaanDeni _$CucuPerusahaanDeniFromJson(Map<String, dynamic> json) {
  return CucuPerusahaanDeni(
    id: json['id_angka'] as String,
    cucu: json['nama_cucu'] as String,
    anak: json['nama_anak'] as String,
    jumlahPejabat: json['jumlah_pejabat'] as int,
  );
}

Map<String, dynamic> _$CucuPerusahaanDeniToJson(CucuPerusahaanDeni instance) =>
    <String, dynamic>{
      'id_angka': instance.id,
      'nama_cucu': instance.cucu,
      'nama_anak': instance.anak,
      'jumlah_pejabat': instance.jumlahPejabat,
    };
