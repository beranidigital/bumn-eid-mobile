// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_jumlah_pegawai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryJumlahPegawai _$SummaryJumlahPegawaiFromJson(Map<String, dynamic> json) {
  return SummaryJumlahPegawai(
    totalPegawai: json['total_pegawai'] as int,
    jenisKelamin: (json['jenis_kelamin'] as List)
        ?.map((e) =>
            e == null ? null : JenisKelamin.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SummaryJumlahPegawaiToJson(
        SummaryJumlahPegawai instance) =>
    <String, dynamic>{
      'total_pegawai': instance.totalPegawai,
      'jenis_kelamin': instance.jenisKelamin,
    };
