// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jumlah_mitra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JumlahMitra _$JumlahMitraFromJson(Map<String, dynamic> json) {
  return JumlahMitra(
    sektorUsaha: json['sektor_usaha'] as String,
    tahun: json['tahun'] as int,
    totalMitra: json['total_mitra'] as int,
    jumlah: json['jumlah'] as String,
  );
}

Map<String, dynamic> _$JumlahMitraToJson(JumlahMitra instance) =>
    <String, dynamic>{
      'sektor_usaha': instance.sektorUsaha,
      'tahun': instance.tahun,
      'total_mitra': instance.totalMitra,
      'jumlah': instance.jumlah,
    };
