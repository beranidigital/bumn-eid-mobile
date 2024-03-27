// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_kelas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidKelas _$CovidKelasFromJson(Map<String, dynamic> json) {
  return CovidKelas(
    jumlah: json['jumlah'] as int,
    kelasBumn: json['kelas_bumn'] as String,
    totalBumn: json['total_bumn'] as int,
  );
}

Map<String, dynamic> _$CovidKelasToJson(CovidKelas instance) =>
    <String, dynamic>{
      'kelas_bumn': instance.kelasBumn,
      'total_bumn': instance.totalBumn,
      'jumlah': instance.jumlah,
    };
